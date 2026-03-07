class Offer {

  final String providerName;
  final String serviceName;
  final String description;
  final int price;
  final String category;
  final double rating;
  final int completedjobs;
  String status;

  Offer({
    required this.providerName,
    required this.serviceName,
    required this.description,
    required this.price,
    required this.category,
    required this.rating,
    required this.completedjobs,
    this.status = "pending",
  });

}