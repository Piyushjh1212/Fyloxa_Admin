import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/gym_model.dart';
import '../block/gym_bloc.dart';
import '../block/gym_event.dart';
import '../block/gym_state.dart';

class PlanSelectionScreen extends StatefulWidget {
  final String gymName;
  final String ownerName;
  final String phone;
  final String openingDate;
  final double? latitude;
  final double? longitude;
  final String locationName;

  const PlanSelectionScreen({
    super.key,
    required this.gymName,
    required this.ownerName,
    required this.phone,
    required this.openingDate,
    this.latitude,
    this.longitude,
    required this.locationName,
  });

  @override
  State<PlanSelectionScreen> createState() => _PlanSelectionScreenState();
}

class _PlanSelectionScreenState extends State<PlanSelectionScreen> {
  final Color primaryColor = const Color(0xFF1E3A8A);
  final Color accentColor = const Color(0xFF10B981);
  final Color backgroundColor = const Color(0xFFF8FAFC);
  final Color textColor = const Color(0xFF0F172A);

  String selectedPlan = "Premium";

  void completeSetup() {
    // 1. Saara collected data model mein wrap kiya
    final request = GymSetupRequest(
      gymName: widget.gymName,
      ownerName: widget.ownerName,
      phone: widget.phone,
      openingDate: widget.openingDate,
      locationName: widget.locationName,
      latitude: widget.latitude,
      longitude: widget.longitude,
      subscriptionPlan: selectedPlan,
    );

    // 2. Bloc Event trigger kar diya
    context.read<GymBloc>().add(SubmitGymSetup(request));
  }

  void showMessage(String msg, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg, style: const TextStyle(fontWeight: FontWeight.w500)),
        backgroundColor: isError ? Colors.redAccent : accentColor,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GymBloc, GymState>(
      listener: (context, state) {
        if (state is GymSetupSuccess) {
          showMessage("Gym Setup Completed Successfully! 🎉");
          // TODO: Agle dashboard ya main screen par navigate karein
          // Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (route) => false);
        } else if (state is GymSetupFailure) {
          showMessage(state.error, isError: true);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            title: const Text("Choose Your Plan", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
            centerTitle: true,
            backgroundColor: primaryColor,
            elevation: 0,
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Select a Subscription", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: textColor)),
                        const SizedBox(height: 8),
                        Text("Choose the plan that best fits your gym's requirements.", style: TextStyle(fontSize: 14, color: textColor.withOpacity(0.6))),
                        const SizedBox(height: 32),
                        
                        _buildPlanCard("Basic", "₹999/mo", ["Manage up to 50 members", "Basic Analytics"], "Basic"),
                        const SizedBox(height: 16),
                        _buildPlanCard("Premium", "₹1,999/mo", ["Unlimited members", "Advanced Analytics"], "Premium", isPopular: true),
                        const SizedBox(height: 16),
                        _buildPlanCard("Ultimate", "₹3,999/mo", ["All Premium Features", "Biometric Setup"], "Ultimate"),
                      ],
                    ),
                  ),
                ),
                
                // Bottom Button with Loader Check
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: const BoxDecoration(color: Colors.white),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: state is GymSetupLoading ? null : completeSetup,
                      style: ElevatedButton.styleFrom(backgroundColor: primaryColor, foregroundColor: Colors.white),
                      child: state is GymSetupLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text("FINISH SETUP", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPlanCard(String title, String price, List<String> features, String planValue, {bool isPopular = false}) {
    bool isSelected = selectedPlan == planValue;
    return GestureDetector(
      onTap: () => setState(() => selectedPlan = planValue),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor.withOpacity(0.03) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: isSelected ? primaryColor : Colors.grey.withOpacity(0.2), width: isSelected ? 2 : 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isSelected ? primaryColor : textColor)),
                if (isPopular) Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: accentColor.withOpacity(0.1)), child: Text("POPULAR", style: TextStyle(color: accentColor, fontSize: 10)))
              ],
            ),
            const SizedBox(height: 8),
            Text(price, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: textColor)),
          ],
        ),
      ),
    );
  }
}