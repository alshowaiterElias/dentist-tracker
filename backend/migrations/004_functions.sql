-- ============================================================
-- Dentist Tracker — Database Functions
-- Migration 004: Reporting & financial helper functions
-- Run this in: Supabase Dashboard → SQL Editor
-- ============================================================

-- ─────────────────────────────────────────────────────────────
-- Function: Get financial summary for a dentist (all-time)
-- ─────────────────────────────────────────────────────────────
CREATE OR REPLACE FUNCTION public.get_financial_summary(p_dentist_id UUID)
RETURNS JSON AS $$
DECLARE
  result JSON;
BEGIN
  SELECT json_build_object(
    'total_income', COALESCE(SUM(t.total_cost), 0),
    'total_technician_cost', COALESCE(SUM(t.technician_cost), 0),
    'total_paid', COALESCE(
      (SELECT SUM(p.amount) FROM public.payments p WHERE p.dentist_id = p_dentist_id), 0
    ),
    'total_treatments', COUNT(t.id),
    'completed_treatments', COUNT(t.id) FILTER (WHERE t.status = 'completed'),
    'total_patients', (
      SELECT COUNT(DISTINCT pt.id)
      FROM public.patients pt
      WHERE pt.dentist_id = p_dentist_id AND pt.is_deleted = false
    )
  ) INTO result
  FROM public.treatments t
  WHERE t.dentist_id = p_dentist_id;

  RETURN result;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ─────────────────────────────────────────────────────────────
-- Function: Get monthly report for a dentist
-- ─────────────────────────────────────────────────────────────
CREATE OR REPLACE FUNCTION public.get_monthly_report(
  p_dentist_id UUID,
  p_year INTEGER,
  p_month INTEGER
)
RETURNS JSON AS $$
DECLARE
  result JSON;
  start_date DATE;
  end_date DATE;
BEGIN
  start_date := make_date(p_year, p_month, 1);
  end_date := (start_date + INTERVAL '1 month')::DATE;

  SELECT json_build_object(
    'total_revenue', COALESCE(SUM(t.total_cost), 0),
    'total_technician_cost', COALESCE(SUM(t.technician_cost), 0),
    'net_revenue', COALESCE(SUM(t.total_cost - t.technician_cost), 0),
    'amount_collected', COALESCE(
      (SELECT SUM(p.amount)
       FROM public.payments p
       WHERE p.dentist_id = p_dentist_id
         AND p.payment_date >= start_date
         AND p.payment_date < end_date), 0
    ),
    'completed_treatments', COUNT(t.id) FILTER (WHERE t.status = 'completed'),
    'total_treatments', COUNT(t.id),
    'total_appointments', (
      SELECT COUNT(a.id)
      FROM public.appointments a
      WHERE a.dentist_id = p_dentist_id
        AND a.appointment_date >= start_date
        AND a.appointment_date < end_date
    ),
    'no_show_count', (
      SELECT COUNT(a.id)
      FROM public.appointments a
      WHERE a.dentist_id = p_dentist_id
        AND a.appointment_date >= start_date
        AND a.appointment_date < end_date
        AND a.status = 'no_show'
    ),
    'new_patients', (
      SELECT COUNT(pt.id)
      FROM public.patients pt
      WHERE pt.dentist_id = p_dentist_id
        AND pt.is_deleted = false
        AND pt.created_at >= start_date
        AND pt.created_at < end_date
    )
  ) INTO result
  FROM public.treatments t
  WHERE t.dentist_id = p_dentist_id
    AND t.treatment_date >= start_date
    AND t.treatment_date < end_date;

  RETURN result;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ─────────────────────────────────────────────────────────────
-- Function: Get patient financial summary
-- ─────────────────────────────────────────────────────────────
CREATE OR REPLACE FUNCTION public.get_patient_financials(p_patient_id UUID)
RETURNS JSON AS $$
DECLARE
  result JSON;
BEGIN
  SELECT json_build_object(
    'total_cost', COALESCE(SUM(t.total_cost), 0),
    'total_paid', COALESCE(SUM(t.amount_paid), 0),
    'remaining_balance', COALESCE(SUM(t.total_cost - t.amount_paid), 0),
    'treatment_count', COUNT(t.id),
    'next_appointment', (
      SELECT MIN(a.appointment_date)
      FROM public.appointments a
      WHERE a.patient_id = p_patient_id
        AND a.appointment_date >= CURRENT_DATE
        AND a.status = 'scheduled'
    )
  ) INTO result
  FROM public.treatments t
  WHERE t.patient_id = p_patient_id;

  RETURN result;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ─────────────────────────────────────────────────────────────
-- Function: Update treatment amount_paid after payment insert
-- ─────────────────────────────────────────────────────────────
CREATE OR REPLACE FUNCTION public.update_treatment_amount_paid()
RETURNS TRIGGER AS $$
BEGIN
  UPDATE public.treatments
  SET amount_paid = (
    SELECT COALESCE(SUM(amount), 0)
    FROM public.payments
    WHERE treatment_id = NEW.treatment_id
  )
  WHERE id = NEW.treatment_id;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER payment_update_treatment
  AFTER INSERT OR DELETE ON public.payments
  FOR EACH ROW EXECUTE FUNCTION public.update_treatment_amount_paid();
