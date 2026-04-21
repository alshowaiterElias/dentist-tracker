import 'package:cached_network_image/cached_network_image.dart';
import 'package:dentist_tracker/app/data/repositories/app_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/loading_overlay.dart';
import '../../../core/widgets/file_upload_sheet.dart';
import '../../../core/widgets/image_viewer.dart';
import '../../../core/utils/formatters.dart';
import '../../../routes/app_routes.dart';
import '../controllers/patient_detail_controller.dart';

/// Tabbed patient detail view: Overview, Treatments, Medications, Files, Appointments.
class PatientDetailView extends StatefulWidget {
  const PatientDetailView({super.key});

  @override
  State<PatientDetailView> createState() => _PatientDetailViewState();
}

class _PatientDetailViewState extends State<PatientDetailView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PatientDetailController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(PatientDetailController());
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }

        final patient = controller.patient.value;
        if (patient == null) {
          return Center(child: Text('no_data'.tr));
        }

        return NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            // ─── Patient Header ────────────────────────────
            SliverAppBar(
              expandedHeight: 200,
              pinned: true,
              backgroundColor: isDark
                  ? AppColors.darkSurface
                  : AppColors.lightSurface,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: const BoxDecoration(
                    gradient: AppColors.primaryGradient,
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              // Avatar
                              Container(
                                width: 56,
                                height: 56,
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha: 0.3),
                                    width: 2,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    patient.fullName.isNotEmpty
                                        ? patient.fullName[0].toUpperCase()
                                        : '?',
                                    style: AppTextStyles.displaySmall.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      patient.fullName,
                                      style: AppTextStyles.headingLarge
                                          .copyWith(color: Colors.white),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.phone_outlined,
                                          size: 14,
                                          color: Colors.white70,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          patient.phone,
                                          style: AppTextStyles.bodySmall
                                              .copyWith(color: Colors.white70),
                                        ),
                                        if (patient.age != null) ...[
                                          const SizedBox(width: 16),
                                          const Icon(
                                            Icons.cake_outlined,
                                            size: 14,
                                            color: Colors.white70,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            '${patient.age} yrs',
                                            style: AppTextStyles.bodySmall
                                                .copyWith(
                                                  color: Colors.white70,
                                                ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.edit_outlined, color: Colors.white),
                  onPressed: () {
                    // TODO: Navigate to edit patient
                  },
                ),
              ],
            ),

            // ─── Financial Summary ────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: _buildFinancialRow(isDark),
              ),
            ),

            // ─── Tab Bar ──────────────────────────────────
            SliverPersistentHeader(
              pinned: true,
              delegate: _TabBarDelegate(
                TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  tabs: [
                    Tab(text: 'overview'.tr),
                    Tab(text: 'treatments'.tr),
                    Tab(text: 'medications'.tr),
                    Tab(text: 'files'.tr),
                    Tab(text: 'appointments'.tr),
                  ],
                ),
                isDark: isDark,
              ),
            ),
          ],
          body: TabBarView(
            controller: _tabController,
            children: [
              _buildOverviewTab(isDark),
              _buildTreatmentsTab(isDark),
              _buildMedicationsTab(isDark),
              _buildFilesTab(isDark),
              _buildAppointmentsTab(isDark),
            ],
          ),
        );
      }),
    );
  }

  // ─── Financial Summary Row ─────────────────────────────────
  Widget _buildFinancialRow(bool isDark) {
    return Row(
      children: [
        Expanded(
          child: _miniStat(
            label: 'total_cost'.tr,
            value: Formatters.currency(controller.totalCost),
            color: AppColors.info,
            isDark: isDark,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _miniStat(
            label: 'total_paid'.tr,
            value: Formatters.currency(controller.totalPaid),
            color: AppColors.success,
            isDark: isDark,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _miniStat(
            label: 'balance'.tr,
            value: Formatters.currency(controller.remainingBalance),
            color: controller.remainingBalance > 0
                ? AppColors.warning
                : AppColors.success,
            isDark: isDark,
          ),
        ),
      ],
    );
  }

  Widget _miniStat({
    required String label,
    required String value,
    required Color color,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.15)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: AppTextStyles.labelLarge.copyWith(color: color),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: AppTextStyles.caption.copyWith(
              color: isDark
                  ? AppColors.darkTextTertiary
                  : AppColors.lightTextTertiary,
            ),
          ),
        ],
      ),
    );
  }

  // ─── Overview Tab ──────────────────────────────────────────
  Widget _buildOverviewTab(bool isDark) {
    final patient = controller.patient.value!;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        if (patient.medicalStatus != null && patient.medicalStatus!.isNotEmpty)
          _infoRow(
            Icons.monitor_heart_outlined,
            'medical_status'.tr,
            patient.medicalStatus!,
            isDark,
          ),
        if (patient.condition != null && patient.condition!.isNotEmpty) ...[
          const SizedBox(height: 12),
          _infoRow(
            Icons.medical_information_outlined,
            'condition'.tr,
            patient.condition!,
            isDark,
          ),
        ],
        if (patient.notes != null && patient.notes!.isNotEmpty) ...[
          const SizedBox(height: 12),
          _infoRow(Icons.note_outlined, 'notes'.tr, patient.notes!, isDark),
        ],
        const SizedBox(height: 12),
        _infoRow(
          Icons.calendar_today_outlined,
          'next_appointment'.tr,
          controller.nextAppointment != null
              ? Formatters.dateShortEn(controller.nextAppointment!)
              : 'no_upcoming_appointment'.tr,
          isDark,
        ),
        const SizedBox(height: 24),
        // Quick action buttons
        Row(
          children: [
            Expanded(
              child: _quickAction(
                Icons.medical_services_outlined,
                'add_treatment'.tr,
                AppColors.primary,
                isDark,
                () => Get.toNamed(
                  AppRoutes.addTreatment,
                  arguments: {'patientId': patient.id},
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _quickAction(
                Icons.medication_outlined,
                'prescribe_medication'.tr,
                AppColors.accent,
                isDark,
                () => Get.toNamed(
                  AppRoutes.addMedication,
                  arguments: {'patientId': patient.id},
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _quickAction(
                Icons.calendar_month_rounded,
                'new_appointment'.tr,
                AppColors.info,
                isDark,
                () => Get.toNamed(
                  AppRoutes.addAppointment,
                  arguments: {'patientId': patient.id},
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _quickAction(
                Icons.upload_file_rounded,
                'upload_file'.tr,
                AppColors.success,
                isDark,
                () => FileUploadSheet.show(
                  patientId: patient.id,
                  onUploaded: () => controller.refresh(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _infoRow(IconData icon, String label, String value, bool isDark) {
    return AppCard(
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 20,
            color: isDark ? AppColors.primaryLight : AppColors.primary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: isDark
                        ? AppColors.darkTextTertiary
                        : AppColors.lightTextTertiary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: isDark ? AppColors.darkText : AppColors.lightText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _quickAction(
    IconData icon,
    String label,
    Color color,
    bool isDark,
    VoidCallback onTap,
  ) {
    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      child: Column(
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 8),
          Text(
            label,
            style: AppTextStyles.labelSmall.copyWith(
              color: isDark ? AppColors.darkText : AppColors.lightText,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  // ─── Treatments Tab ────────────────────────────────────────
  Widget _buildTreatmentsTab(bool isDark) {
    if (controller.treatments.isEmpty) {
      return EmptyState(
        icon: Icons.medical_services_outlined,
        title: 'no_treatments'.tr,
        actionLabel: 'add_treatment'.tr,
        onAction: () => Get.toNamed(
          AppRoutes.addTreatment,
          arguments: {'patientId': controller.patientId},
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: controller.treatments.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final t = controller.treatments[index];
        return AppCard(
          onTap: () => Get.toNamed(AppRoutes.treatmentDetail, arguments: t.id),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      t.procedureType,
                      style: AppTextStyles.labelLarge.copyWith(
                        color: isDark
                            ? AppColors.darkText
                            : AppColors.lightText,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: t.isCompleted
                          ? AppColors.success.withValues(alpha: 0.12)
                          : AppColors.warning.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      t.isCompleted ? 'completed'.tr : 'in_progress'.tr,
                      style: AppTextStyles.labelSmall.copyWith(
                        color: t.isCompleted
                            ? AppColors.success
                            : AppColors.warning,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    Formatters.currency(t.totalCost),
                    style: AppTextStyles.amountSmall.copyWith(
                      color: isDark ? AppColors.darkText : AppColors.lightText,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '• ${Formatters.dateShortEn(t.treatmentDate)}',
                    style: AppTextStyles.caption.copyWith(
                      color: isDark
                          ? AppColors.darkTextTertiary
                          : AppColors.lightTextTertiary,
                    ),
                  ),
                ],
              ),
              if (t.toothNumbers.isNotEmpty) ...[
                const SizedBox(height: 6),
                Wrap(
                  spacing: 4,
                  children: t.toothNumbers
                      .map(
                        (n) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: isDark
                                ? AppColors.darkCardElevated
                                : AppColors.lightCardElevated,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            '#$n',
                            style: AppTextStyles.caption.copyWith(
                              color: isDark
                                  ? AppColors.darkTextSecondary
                                  : AppColors.lightTextSecondary,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  // ─── Medications Tab ───────────────────────────────────────
  Widget _buildMedicationsTab(bool isDark) {
    if (controller.medications.isEmpty) {
      return EmptyState(
        icon: Icons.medication_outlined,
        title: 'no_medications'.tr,
        actionLabel: 'prescribe_medication'.tr,
        onAction: () => Get.toNamed(
          AppRoutes.addMedication,
          arguments: {'patientId': controller.patientId},
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: controller.medications.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final m = controller.medications[index];
        return AppCard(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.accent.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.medication_rounded,
                  color: AppColors.accent,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      m.medicationName,
                      style: AppTextStyles.labelLarge.copyWith(
                        color: isDark
                            ? AppColors.darkText
                            : AppColors.lightText,
                      ),
                    ),
                    if (m.dosage != null || m.frequency != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        [
                          m.dosage,
                          m.frequency,
                          m.duration,
                        ].where((e) => e != null && e.isNotEmpty).join(' • '),
                        style: AppTextStyles.bodySmall.copyWith(
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.lightTextSecondary,
                        ),
                      ),
                    ],
                    const SizedBox(height: 4),
                    Text(
                      Formatters.dateShortEn(m.prescribedDate),
                      style: AppTextStyles.caption.copyWith(
                        color: isDark
                            ? AppColors.darkTextTertiary
                            : AppColors.lightTextTertiary,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.delete_outline_rounded,
                  color: AppColors.error.withValues(alpha: 0.6),
                  size: 20,
                ),
                onPressed: () async {
                  final confirm = await Get.dialog<bool>(
                    AlertDialog(
                      title: Text('delete'.tr),
                      content: Text('are_you_sure'.tr),
                      actions: [
                        TextButton(
                          onPressed: () => Get.back(result: false),
                          child: Text('cancel'.tr),
                        ),
                        TextButton(
                          onPressed: () => Get.back(result: true),
                          child: Text(
                            'delete'.tr,
                            style: const TextStyle(color: AppColors.error),
                          ),
                        ),
                      ],
                    ),
                  );
                  if (confirm == true) {
                    await AppRepository().deleteMedication(m.id);
                    controller.refresh();
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // ─── Files Tab ─────────────────────────────────────────────
  Widget _buildFilesTab(bool isDark) {
    if (controller.files.isEmpty) {
      return EmptyState(
        icon: Icons.folder_outlined,
        title: 'no_files'.tr,
        actionLabel: 'upload_file'.tr,
        onAction: () => FileUploadSheet.show(
          patientId: controller.patientId!,
          onUploaded: () => controller.refresh(),
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.85,
      ),
      itemCount: controller.files.length,
      itemBuilder: (context, index) {
        final f = controller.files[index];
        return GestureDetector(
          onTap: () {
            if (f.isImage) {
              ImageViewerScreen.show(imageUrl: f.fileUrl, title: f.fileName);
            }
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // ── Background: image thumbnail or PDF placeholder ──
                if (f.isImage)
                  CachedNetworkImage(
                    imageUrl: f.fileUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: isDark
                          ? AppColors.darkCardElevated
                          : AppColors.lightCardElevated,
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                          strokeWidth: 2,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: isDark
                          ? AppColors.darkCardElevated
                          : AppColors.lightCardElevated,
                      child: const Center(
                        child: Icon(
                          Icons.broken_image_rounded,
                          color: AppColors.lightTextTertiary,
                          size: 36,
                        ),
                      ),
                    ),
                  )
                else
                  Container(
                    color: AppColors.error.withValues(alpha: 0.08),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.picture_as_pdf_rounded,
                            size: 48,
                            color: AppColors.error.withValues(alpha: 0.7),
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              f.fileName,
                              style: AppTextStyles.labelSmall.copyWith(
                                color: isDark
                                    ? AppColors.darkTextSecondary
                                    : AppColors.lightTextSecondary,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                // ── Gradient overlay at bottom for images ──
                if (f.isImage)
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(10, 24, 10, 10),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.7),
                          ],
                        ),
                      ),
                      child: Text(
                        f.fileName,
                        style: AppTextStyles.labelSmall.copyWith(
                          color: Colors.white,
                          shadows: [
                            const Shadow(color: Colors.black54, blurRadius: 4),
                          ],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),

                // ── Category badge (top-right) ──
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.55),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      f.category.tr,
                      style: AppTextStyles.caption.copyWith(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),

                // ── Tap ripple for images ──
                if (f.isImage)
                  Positioned.fill(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(14),
                        onTap: () => ImageViewerScreen.show(
                          imageUrl: f.fileUrl,
                          title: f.fileName,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ─── Appointments Tab ──────────────────────────────────────
  Widget _buildAppointmentsTab(bool isDark) {
    if (controller.appointments.isEmpty) {
      return EmptyState(
        icon: Icons.calendar_month_outlined,
        title: 'no_appointments'.tr,
        actionLabel: 'new_appointment'.tr,
        onAction: () => Get.toNamed(
          AppRoutes.addAppointment,
          arguments: {'patientId': controller.patientId},
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: controller.appointments.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final a = controller.appointments[index];
        Color statusColor;
        switch (a.status) {
          case 'completed':
            statusColor = AppColors.success;
            break;
          case 'no_show':
            statusColor = AppColors.error;
            break;
          default:
            statusColor = AppColors.info;
        }

        return AppCard(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${a.appointmentDate.day}',
                      style: AppTextStyles.labelLarge.copyWith(
                        color: statusColor,
                      ),
                    ),
                    Text(
                      Formatters.dateDayMonth(
                        a.appointmentDate,
                      ).split(' ').last,
                      style: AppTextStyles.caption.copyWith(color: statusColor),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      a.status.tr,
                      style: AppTextStyles.labelMedium.copyWith(
                        color: statusColor,
                      ),
                    ),
                    if (a.notes != null && a.notes!.isNotEmpty)
                      Text(
                        a.notes!,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.lightTextSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
              Text(
                Formatters.dateShortEn(a.appointmentDate),
                style: AppTextStyles.caption.copyWith(
                  color: isDark
                      ? AppColors.darkTextTertiary
                      : AppColors.lightTextTertiary,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ─── Tab Bar Delegate ──────────────────────────────────────────
class _TabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;
  final bool isDark;

  _TabBarDelegate(this.tabBar, {required this.isDark});

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: isDark ? AppColors.darkBg : AppColors.lightBg,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(_TabBarDelegate oldDelegate) => false;
}
