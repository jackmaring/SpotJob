class Category {
  String name;
  List<String> subcategories;

  Category({this.name, this.subcategories});

  Category.fromJson(Map<String, dynamic> data)
      : this(
          name: data['name'],
          subcategories: data['subcategories'].cast<String>(),
        );

  Map<String, dynamic> toJson() => {
        'name': name,
        'subcategories': subcategories,
      };
}