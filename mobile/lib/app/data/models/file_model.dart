class FileModel {
  final String id;
  final String patientId;
  final String? treatmentId;
  final String dentistId;
  final String fileName;
  final String fileType;
  final String fileUrl;
  final String storagePath;
  final int fileSize;
  final String category;
  final DateTime uploadedAt;

  FileModel({
    required this.id,
    required this.patientId,
    this.treatmentId,
    required this.dentistId,
    required this.fileName,
    required this.fileType,
    required this.fileUrl,
    required this.storagePath,
    this.fileSize = 0,
    this.category = 'other',
    DateTime? uploadedAt,
  }) : uploadedAt = uploadedAt ?? DateTime.now();

  bool get isImage =>
      fileType == 'image' ||
      fileType.startsWith('image/') ||
      fileName.toLowerCase().endsWith('.jpg') ||
      fileName.toLowerCase().endsWith('.jpeg') ||
      fileName.toLowerCase().endsWith('.png') ||
      fileName.toLowerCase().endsWith('.webp');

  bool get isPdf =>
      fileType == 'application/pdf' ||
      fileName.toLowerCase().endsWith('.pdf');

  /// File size in human-readable format
  String get fileSizeFormatted {
    if (fileSize < 1024) return '$fileSize B';
    if (fileSize < 1024 * 1024) {
      return '${(fileSize / 1024).toStringAsFixed(1)} KB';
    }
    return '${(fileSize / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  factory FileModel.fromJson(Map<String, dynamic> json) {
    return FileModel(
      id: json['id'] as String,
      patientId: json['patient_id'] as String,
      treatmentId: json['treatment_id'] as String?,
      dentistId: json['dentist_id'] as String,
      fileName: json['file_name'] as String? ?? '',
      fileType: json['file_type'] as String? ?? '',
      fileUrl: json['file_url'] as String? ?? '',
      storagePath: json['storage_path'] as String? ?? '',
      fileSize: json['file_size'] as int? ?? 0,
      category: json['category'] as String? ?? 'other',
      uploadedAt: json['uploaded_at'] != null
          ? DateTime.parse(json['uploaded_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'patient_id': patientId,
      'treatment_id': treatmentId,
      'dentist_id': dentistId,
      'file_name': fileName,
      'file_type': fileType,
      'file_url': fileUrl,
      'storage_path': storagePath,
      'file_size': fileSize,
      'category': category,
    };
  }

  FileModel copyWith({
    String? id,
    String? patientId,
    String? treatmentId,
    String? dentistId,
    String? fileName,
    String? fileType,
    String? fileUrl,
    String? storagePath,
    int? fileSize,
    String? category,
    DateTime? uploadedAt,
  }) {
    return FileModel(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      treatmentId: treatmentId ?? this.treatmentId,
      dentistId: dentistId ?? this.dentistId,
      fileName: fileName ?? this.fileName,
      fileType: fileType ?? this.fileType,
      fileUrl: fileUrl ?? this.fileUrl,
      storagePath: storagePath ?? this.storagePath,
      fileSize: fileSize ?? this.fileSize,
      category: category ?? this.category,
      uploadedAt: uploadedAt ?? this.uploadedAt,
    );
  }
}
