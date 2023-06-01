class UniversityModel {
  final String alphaTwoCode;
  final String name;
  final List<String>? webPages;
  final String country;

  UniversityModel(
      {required this.alphaTwoCode,
      required this.name,
      required this.webPages,
      required this.country});

  factory UniversityModel.fromJson(Map data) {
    List<String> pages = [];
    data["web_pages"].forEach((element) {
      pages.add(element);
    });
    return UniversityModel(
        alphaTwoCode: data["alpha_two_code"],
        name: data["name"],
        webPages: pages,
        country: data["country"]);
  }
}
