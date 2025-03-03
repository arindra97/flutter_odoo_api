/// The ResPartner class represents a partner entity with properties like name, email, phone, street,
/// city, and zip.
class ResPartner {
  int? id;
  final String name;
  final String email;
  final String phone;
  final String street;
  final String city;
  final String zip;

  ResPartner({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.street,
    required this.city,
    required this.zip,
  });

  factory ResPartner.fromJson(Map<String, dynamic> json) => ResPartner(
    id: json['id'],
    name: json['name'],
    email: json['email'] is String ? json['email'] : '',
    phone: json['phone'] is String ? json['phone'] : '',
    street: json['street'] is String ? json['street'] : '',
    city: json['city'] is String ? json['city'] : '',
    zip: json['zip'] is String ? json['zip'] : '',
  );
}
