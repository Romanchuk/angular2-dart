class Address implements Comparable {
  String city = "";
  String street = "";

  Address(dynamic data){
    if (data != null) {
      this.city = data['city'] ?? "";
      this.street = data['street'] ?? "";
    }
  }


  factory Address.fromJson(Map<String, dynamic> data) =>
      new Address(data);

  @override
  int compareTo(Address other) {
    var cityCompResult = city.compareTo(other.city);
    if (cityCompResult != 0)
      return cityCompResult;
    return street.compareTo(other.street);
  }
}
