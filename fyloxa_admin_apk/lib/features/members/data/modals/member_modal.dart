import '../../domain/entities/member.dart';

class MemberModel extends Member {
  const MemberModel({required super.id, required super.name, required super.phone, required super.plan});

  factory MemberModel.fromJson(Map<String, dynamic> json) {
    return MemberModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      plan: json['plan'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'phone': phone,
    'plan': plan,
  };
}