class Beer {
  final String name;
  final String tagline;
  final String firstBrewed;
  final String description;

  Beer(
      {required this.name,
      required this.tagline,
      required this.firstBrewed,
      required this.description});

  factory Beer.fromJson(Map<String, dynamic> json) {
    return Beer(
      name: json['name'],
      tagline: json['tagline'],
      firstBrewed: json['first_brewed'],
      description: json['description'],
    );
  }
}
