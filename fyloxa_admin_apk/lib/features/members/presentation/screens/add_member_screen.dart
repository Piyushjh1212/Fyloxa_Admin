import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../bloc/members_bloc.dart';
import '../../data/models/member_model.dart';

class AddMemberScreen extends StatelessWidget {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _planController = TextEditingController();

  AddMemberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add New Member")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomTextField(controller: _nameController, hintText: 'Member Name'),
            const SizedBox(height: 10),
            CustomTextField(controller: _phoneController, hintText: 'Phone Number'),
            const SizedBox(height: 10),
            CustomTextField(controller: _planController, hintText: 'Subscription Plan'),
            const SizedBox(height: 20),
            
            ElevatedButton(
              onPressed: () {
                final newMember = MemberModel(
                  id: DateTime.now().toString(), // Simple ID generator
                  name: _nameController.text,
                  phone: _phoneController.text,
                  plan: _planController.text,
                );
                
                // Bloc ko add event bhejna (Yahan aapko 'addMember' function Bloc mein add karna hoga)
                context.read<MembersBloc>().addMember(newMember);
              },
              child: const Text('Save Member'),
            ),
          ],
        ),
      ),
    );
  }
}