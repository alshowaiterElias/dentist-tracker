import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/providers/supabase_provider.dart';
import '../../data/repositories/app_repository.dart';
import '../../services/connectivity_service.dart';

/// Bottom sheet for uploading files (camera, gallery, or document picker).
/// Handles both online and offline scenarios automatically.
class FileUploadSheet extends StatefulWidget {
  final String patientId;
  final String? treatmentId;
  final VoidCallback onUploaded;

  const FileUploadSheet({
    super.key,
    required this.patientId,
    this.treatmentId,
    required this.onUploaded,
  });

  static void show({
    required String patientId,
    String? treatmentId,
    required VoidCallback onUploaded,
  }) {
    Get.bottomSheet(
      FileUploadSheet(
        patientId: patientId,
        treatmentId: treatmentId,
        onUploaded: onUploaded,
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  @override
  State<FileUploadSheet> createState() => _FileUploadSheetState();
}

class _FileUploadSheetState extends State<FileUploadSheet> {
  final _repo = AppRepository();
  final _picker = ImagePicker();
  String _selectedCategory = 'other';
  bool _isUploading = false;

  final _categories = [
    {'key': 'xray', 'icon': Icons.image_search_rounded, 'label': 'xray'},
    {'key': 'report', 'icon': Icons.description_outlined, 'label': 'report'},
    {'key': 'scan', 'icon': Icons.document_scanner_outlined, 'label': 'scan'},
    {'key': 'other', 'icon': Icons.folder_outlined, 'label': 'other'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.lightBorder,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Title
          Text(
            'upload_file'.tr,
            style: AppTextStyles.headingMedium.copyWith(
              color: isDark ? AppColors.darkText : AppColors.lightText,
            ),
          ),
          const SizedBox(height: 20),

          // Category selector
          Text(
            'select_category'.tr,
            style: AppTextStyles.labelMedium.copyWith(
              color: isDark
                  ? AppColors.darkTextSecondary
                  : AppColors.lightTextSecondary,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _categories.map((c) {
              final isSelected = _selectedCategory == c['key'];
              return GestureDetector(
                onTap: () =>
                    setState(() => _selectedCategory = c['key'] as String),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 14,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary.withValues(alpha: 0.12)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primary
                          : (isDark
                                ? AppColors.darkBorder
                                : AppColors.lightBorder),
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        c['icon'] as IconData,
                        color: isSelected
                            ? AppColors.primary
                            : (isDark
                                  ? AppColors.darkTextTertiary
                                  : AppColors.lightTextTertiary),
                        size: 22,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        (c['label'] as String).tr,
                        style: AppTextStyles.labelSmall.copyWith(
                          color: isSelected
                              ? AppColors.primary
                              : (isDark
                                    ? AppColors.darkTextSecondary
                                    : AppColors.lightTextSecondary),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),

          // Upload progress indicator
          if (_isUploading) ...[
            LinearProgressIndicator(
              color: AppColors.primary,
              backgroundColor: AppColors.primary.withValues(alpha: 0.1),
            ),
            const SizedBox(height: 8),
            Text(
              'loading'.tr,
              style: AppTextStyles.bodySmall.copyWith(
                color: isDark
                    ? AppColors.darkTextSecondary
                    : AppColors.lightTextSecondary,
              ),
            ),
            const SizedBox(height: 24),
          ],

          // Source buttons
          if (!_isUploading) ...[
            Row(
              children: [
                Expanded(
                  child: _sourceButton(
                    Icons.camera_alt_rounded,
                    'camera'.tr,
                    AppColors.primary,
                    isDark,
                    () => _pickImage(ImageSource.camera),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _sourceButton(
                    Icons.photo_library_rounded,
                    'gallery'.tr,
                    AppColors.accent,
                    isDark,
                    () => _pickImage(ImageSource.gallery),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _sourceButton(
                    Icons.file_present_rounded,
                    'document'.tr,
                    AppColors.info,
                    isDark,
                    _pickDocument,
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _sourceButton(
    IconData icon,
    String label,
    Color color,
    bool isDark,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(label,
                style: AppTextStyles.labelSmall.copyWith(color: color)),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final image = await _picker.pickImage(
        source: source,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 80,
      );
      if (image != null) await _uploadFile(File(image.path), image.name);
    } catch (_) {
      _showError();
    }
  }

  Future<void> _pickDocument() async {
    try {
      final result = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png', 'webp'],
      );
      if (result != null && result.files.single.path != null) {
        await _uploadFile(
            File(result.files.single.path!), result.files.single.name);
      }
    } catch (_) {
      _showError();
    }
  }

  void _showError() => Get.snackbar('error'.tr, 'something_went_wrong'.tr,
      snackPosition: SnackPosition.BOTTOM);

  Future<void> _uploadFile(File file, String fileName) async {
    final size = await file.length();
    if (size > 10 * 1024 * 1024) {
      Get.snackbar('error'.tr, 'file_too_large'.tr,
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    setState(() => _isUploading = true);

    try {
      final userId = SupabaseProvider.userId!;
      final ext = p.extension(fileName).toLowerCase();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final storagePath =
          '$userId/${widget.patientId}/${timestamp}_$fileName';

      String fileType = 'document';
      if (['.jpg', '.jpeg', '.png', '.webp', '.heic'].contains(ext)) {
        fileType = 'image';
      } else if (ext == '.pdf') {
        fileType = 'pdf';
      }

      if (ConnectivityService.to.isOnline.value) {
        // ── Online: upload binary to Storage, then save DB record ──────
        await SupabaseProvider.storage.upload(storagePath, file);
        final fileUrl = SupabaseProvider.storage.getPublicUrl(storagePath);

        // createFileRecord online path → writes Supabase first, then caches
        await _repo.createFileRecord({
          'patient_id': widget.patientId,
          'treatment_id': widget.treatmentId,
          'dentist_id': userId,
          'file_name': fileName,
          'file_type': fileType,
          'file_url': fileUrl,
          'storage_path': storagePath,
          'file_size': size,
          'category': _selectedCategory,
        });

        Get.back();
        Get.snackbar('success'.tr, 'file_uploaded'.tr,
            snackPosition: SnackPosition.BOTTOM);
      } else {
        // ── Offline: copy file locally, queue upload for when back online
        final appDir = await getApplicationDocumentsDirectory();
        final pendingDir = Directory('${appDir.path}/pending_uploads');
        await pendingDir.create(recursive: true);

        // Copy with a unique name so the original path stays valid
        final localCopy =
            await file.copy('${pendingDir.path}/${const Uuid().v4()}$ext');

        // createFileRecord offline path: saves locally with empty fileUrl
        // and enqueues an upload_file op that includes local_path so
        // SyncService can upload the binary and update the URL.
        await _repo.createFileRecord({
          'patient_id': widget.patientId,
          'treatment_id': widget.treatmentId,
          'dentist_id': userId,
          'file_name': fileName,
          'file_type': fileType,
          'file_url': '', // will be updated after sync
          'storage_path': storagePath,
          'file_size': size,
          'category': _selectedCategory,
          'local_path': localCopy.path, // SyncService needs this
        });

        Get.back();
        Get.snackbar(
          'success'.tr,
          'File saved — will upload when back online',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 4),
        );
      }

      widget.onUploaded();
    } catch (_) {
      _showError();
    } finally {
      if (mounted) setState(() => _isUploading = false);
    }
  }
}
