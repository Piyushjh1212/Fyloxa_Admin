import 'package:equatable/equatable.dart';

class Member extends Equatable {
  final String id;
  final String name;
  final String phone;
  final String plan;

  const Member({required this.id, required this.name, required this.phone, required this.plan});

  @override
  List<Object?> get props => [id, name, phone, plan];
}