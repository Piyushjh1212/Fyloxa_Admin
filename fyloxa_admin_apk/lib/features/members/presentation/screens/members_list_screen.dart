import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injection_container.dart';
import '../block/members_bloc.dart';

class MembersListScreen extends StatelessWidget {
  const MembersListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MembersBloc>()..fetchMembers(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Members")),
        floatingActionButton: FloatingActionButton(
          onPressed: () => /* Yahan AddMemberScreen par route karenge */ null,
          child: const Icon(Icons.add),
        ),
        body: BlocBuilder<MembersBloc, MembersState>(
          builder: (context, state) {
            if (state is MembersLoading) return const Center(child: CircularProgressIndicator());
            if (state is MembersError) return Center(child: Text(state.message));
            if (state is MembersLoaded) {
              return ListView.builder(
                itemCount: state.members.length,
                itemBuilder: (context, index) {
                  final member = state.members[index];
                  return ListTile(
                    leading: CircleAvatar(child: Text(member.name[0])),
                    title: Text(member.name),
                    subtitle: Text("Plan: ${member.plan}"),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () { /* Detail Screen par jayein */ },
                  );
                },
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}