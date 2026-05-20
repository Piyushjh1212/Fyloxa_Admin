class GymSetupRequest {
  final String gymName;
  final String ownerName;
  final String phone;
  final String openingDate;
  final String locationName;
  final double? latitude;
  final double? longitude;
  final String subscriptionPlan;

  GymSetupRequest({
    required this.gymName,
    required this.ownerName,
    required this.phone,
    required this.openingDate,
    required this.locationName,
    this.latitude,
    this.longitude,
    required this.subscriptionPlan,
  });

  Map<String, dynamic> toJson() {
    return {
      'gymName': gymName,
      'ownerName': ownerName,
      'phone': phone,
      'openingDate': openingDate,
      'locationName': locationName,
      'latitude': latitude,
      'longitude': longitude,
      'subscriptionPlan': subscriptionPlan,
    };
  }
}