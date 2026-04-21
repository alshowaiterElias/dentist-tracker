import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/loading_overlay.dart';
import '../../../routes/app_routes.dart';
import '../controllers/patient_list_controller.dart';

/// Patient list with search bar and premium patient cards.
class PatientListView extends GetView<PatientListController> {
  const PatientListView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // ─── Header + Search ────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'patients'.tr,
                        style: AppTextStyles.displaySmall.copyWith(
                          color: isDark
                              ? AppColors.darkText
                              : AppColors.lightText,
                        ),
                      ),
                      _buildPatientCount(isDark),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildSearchBar(isDark),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // ─── Patient List ───────────────────────────────
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value &&
                    controller.patients.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  );
                }

                if (controller.patients.isEmpty) {
                  return EmptyState(
                    icon: Icons.people_outline_rounded,
                    title: 'no_patients'.tr,
                    subtitle: 'no_patients_subtitle'.tr,
                    actionLabel: 'add_patient'.tr,
                    onAction: () => Get.toNamed(AppRoutes.addPatient),
                  );
                }

                return RefreshIndicator(
                  onRefresh: controller.loadPatients,
                  color: AppColors.primary,
                  child: ListView.separated(
                    padding: const EdgeInsets.fromLTRB(20, 4, 20, 100),
                    physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    itemCount: controller.patients.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final patient = controller.patients[index];
                      return _PatientCard(patient: patient, isDark: isDark);
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(AppRoutes.addPatient),
        child: const Icon(Icons.person_add_rounded),
      ),
    );
  }

  Widget _buildPatientCount(bool isDark) {
    return Obx(() => Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.primaryDark.withValues(alpha: 0.2)
                : AppColors.primarySurface,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            '${controller.patients.length}',
            style: AppTextStyles.labelMedium.copyWith(
              color: isDark ? AppColors.primaryLight : AppColors.primary,
            ),
          ),
        ));
  }

  Widget _buildSearchBar(bool isDark) {
    return TextField(
      controller: controller.searchController,
      onChanged: controller.onSearchChanged,
      style: AppTextStyles.bodyMedium.copyWith(
        color: isDark ? AppColors.darkText : AppColors.lightText,
      ),
      decoration: InputDecoration(
        hintText: 'search_patients'.tr,
        prefixIcon: Icon(
          Icons.search_rounded,
          color: isDark
              ? AppColors.darkTextTertiary
              : AppColors.lightTextTertiary,
        ),
        suffixIcon: Obx(() => controller.searchQuery.value.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.close_rounded, size: 20),
                onPressed: () {
                  controller.searchController.clear();
                  controller.onSearchChanged('');
                },
              )
            : const SizedBox.shrink()),
        filled: true,
        fillColor: isDark ? AppColors.darkCardElevated : AppColors.lightCardElevated,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
      ),
    );
  }
}

/// Premium patient card with avatar, info, and financial badge.
class _PatientCard extends StatelessWidget {
  final dynamic patient; // PatientModel
  final bool isDark;

  const _PatientCard({required this.patient, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: () => Get.toNamed(
        AppRoutes.patientDetail,
        arguments: patient.id,
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: Text(
                patient.fullName.isNotEmpty
                    ? patient.fullName[0].toUpperCase()
                    : '?',
                style: AppTextStyles.headingMedium.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  patient.fullName,
                  style: AppTextStyles.labelLarge.copyWith(
                    color: isDark ? AppColors.darkText : AppColors.lightText,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.phone_outlined,
                      size: 14,
                      color: isDark
                          ? AppColors.darkTextTertiary
                          : AppColors.lightTextTertiary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      patient.phone,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.lightTextSecondary,
                      ),
                    ),
                    if (patient.age != null) ...[
                      const SizedBox(width: 12),
                      Icon(
                        Icons.cake_outlined,
                        size: 14,
                        color: isDark
                            ? AppColors.darkTextTertiary
                            : AppColors.lightTextTertiary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${patient.age}',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.lightTextSecondary,
                        ),
                      ),
                    ],
                  ],
                ),
                if (patient.medicalStatus != null &&
                    patient.medicalStatus!.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppColors.darkCardElevated
                          : AppColors.lightCardElevated,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      patient.medicalStatus!,
                      style: AppTextStyles.labelSmall.copyWith(
                        color: isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.lightTextSecondary,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Arrow
          Icon(
            Icons.chevron_right_rounded,
            color: isDark
                ? AppColors.darkTextTertiary
                : AppColors.lightTextTertiary,
          ),
        ],
      ),
    );
  }
}
