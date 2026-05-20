import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/modals/repositories/member_repository_impl.dart';
import '../../domain/entities/member.dart';
import '../../data/modals/member_modal.dart';

// States
abstract class MembersState {}
class MembersInitial extends MembersState {}
class MembersLoading extends MembersState {}
class MembersLoaded extends MembersState {
  final List<Member> members;
  MembersLoaded(this.members);
}
class MembersError extends MembersState { final String message; MembersError(this.message); }

// Bloc
class MembersBloc extends Cubit<MembersState> {
  final MemberRepository repository;
  MembersBloc(this.repository) : super(MembersInitial());

  Future<void> fetchMembers() async {
    emit(MembersLoading());
    try {
      final members = await repository.getMembers();
      emit(MembersLoaded(members));
    } catch (e) {
      emit(MembersError("Members load nahi ho sake"));
    }
  }

  // MembersBloc class ke andar
  Future<void> addMember(MemberModel member) async {
    emit(MembersLoading());
    try {
      await repository.addMember(member);
      // Add hone ke baad list refresh kar lo
      fetchMembers(); 
    } catch (e) {
      emit(MembersError("Member add nahi ho saka"));
    }
}
}