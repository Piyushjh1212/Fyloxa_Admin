class Subscription {
  final String id;
  final String memberName;
  final String planName;
  final double amount;
  final DateTime expiryDate;

  Subscription({
    required this.id, 
    required this.memberName, 
    required this.planName, 
    required this.amount, 
    required this.expiryDate
  });
}