class ProfileModel {
  final String id;
  final String? email;
  final String? phone;
  final String fullName;
  final double revenuePercentage;
  final String preferredLanguage;
  final bool isActive;
  final DateTime createdAt;

  ProfileModel({
    required this.id,
    this.email,
    this.phone,
    required this.fullName,
    this.revenuePercentage = 100.0,
    this.preferredLanguage = 'en',
    this.isActive = true,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] as String,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      fullName: json['full_name'] as String? ?? '',
      revenuePercentage:
          (json['revenue_percentage'] as num?)?.toDouble() ?? 100.0,
      preferredLanguage: json['preferred_language'] as String? ?? 'en',
      isActive: json['is_active'] as bool? ?? true,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'phone': phone,
      'full_name': fullName,
      'revenue_percentage': revenuePercentage,
      'preferred_language': preferredLanguage,
      'is_active': isActive,
    };
  }

  ProfileModel copyWith({
    String? id,
    String? email,
    String? phone,
    String? fullName,
    double? revenuePercentage,
    String? preferredLanguage,
    bool? isActive,
    DateTime? createdAt,
  }) {
    return ProfileModel(
      id: id ?? this.id,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      fullName: fullName ?? this.fullName,
      revenuePercentage: revenuePercentage ?? this.revenuePercentage,
      preferredLanguage: preferredLanguage ?? this.preferredLanguage,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
