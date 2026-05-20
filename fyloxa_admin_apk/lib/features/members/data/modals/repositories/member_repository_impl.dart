import '../../../../../core/network/api_client.dart';
import '../member_modal.dart';

class MemberRepository {
  final ApiClient apiClient;
  MemberRepository(this.apiClient);

  Future<List<MemberModel>> getMembers() async {
    final response = await apiClient.dio.get('members');
    return (response.data as List).map((e) => MemberModel.fromJson(e)).toList();
  }

  Future<void> addMember(MemberModel member) async {
    await apiClient.dio.post('members', data: member.toJson());
  }
}