class VendorModel {
  String name;
  String email;
  String phone;
  String password;
  String shopName;
  String address;
  String category;
  bool isApproved;

  VendorModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    this.shopName = "",
    this.address = "",
    this.category = "",
    this.isApproved = false,
  });
}