import 'dart:convert';

class SkateShop {
  List<Product> products;

  SkateShop({
    required this.products,
  });

  factory SkateShop.fromRawJson(String str) => SkateShop.fromJson(json.decode(str));

  factory SkateShop.fromJson(Map<String, dynamic> json) => SkateShop(
    products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
  );
}

class Product {
  int id;
  String title;
  String handle;
  String bodyHtml;
  DateTime publishedAt;
  DateTime createdAt;
  DateTime updatedAt;
  String vendor;
  ProductType productType;
  List<String> tags;
  List<Variant> variants;
  List<Image> images;
  List<Option> options;

  Product({
    required this.id,
    required this.title,
    required this.handle,
    required this.bodyHtml,
    required this.publishedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.vendor,
    required this.productType,
    required this.tags,
    required this.variants,
    required this.images,
    required this.options,
  });

  String overview() {
    final category = productTypeValues.reverse[productType]!.split(' - ').last;
    final price = variants.first.price;
    final stock = variants.any((v) => v.available) ? "Disponible ara mateix." : "Actualment esgotat.";

    return "El producte $title és de la marca $vendor, dins la categoria $category. Té un preu de $price \$. $stock";
  }

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    title: json["title"],
    handle: json["handle"],
    bodyHtml: json["body_html"],
    publishedAt: DateTime.parse(json["published_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    vendor: json["vendor"],
    productType: productTypeValues.map[json["product_type"]]!,
    tags: List<String>.from(json["tags"].map((x) => x)),
    variants: List<Variant>.from(json["variants"].map((x) => Variant.fromJson(x))),
    images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
    options: List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
  );
}

class Image {
  int id;
  DateTime createdAt;
  int position;
  DateTime updatedAt;
  int productId;
  List<int> variantIds;
  String src;
  int width;
  int height;
  dynamic alt;

  Image({
    required this.id,
    required this.createdAt,
    required this.position,
    required this.updatedAt,
    required this.productId,
    required this.variantIds,
    required this.src,
    required this.width,
    required this.height,
    this.alt,
  });

  factory Image.fromRawJson(String str) => Image.fromJson(json.decode(str));

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    id: json["id"],
    createdAt: DateTime.parse(json["created_at"]),
    position: json["position"],
    updatedAt: DateTime.parse(json["updated_at"]),
    productId: json["product_id"],
    variantIds: List<int>.from(json["variant_ids"].map((x) => x)),
    src: json["src"],
    width: json["width"],
    height: json["height"],
    alt: json["alt"],
  );
}

class Option {
  Name name;
  int position;
  List<String> values;

  Option({
    required this.name,
    required this.position,
    required this.values,
  });

  factory Option.fromRawJson(String str) => Option.fromJson(json.decode(str));

  factory Option.fromJson(Map<String, dynamic> json) => Option(
    name: nameValues.map[json["name"]]!,
    position: json["position"],
    values: List<String>.from(json["values"].map((x) => x)),
  );
}

enum Name {
  COLOR,
  SIZE,
  STYLE,
  TITLE
}

final nameValues = EnumValues({
  "Color": Name.COLOR,
  "Size": Name.SIZE,
  "Style": Name.STYLE,
  "Title": Name.TITLE
}
);

enum ProductType {
  SKATE_COMPLETES,
  SKATE_DECKS,
  SKATE_HELMETS_PADS,
  SKATE_PARTS_GRIP_TAPE,
  SKATE_PARTS_HARDWARE,
  SKATE_PARTS_TRUCKS,
  SKATE_PARTS_WHEELS,
  SKATE_SURFSKATES
}

final productTypeValues = EnumValues({
  "Skate - Completes": ProductType.SKATE_COMPLETES,
  "Skate - Decks": ProductType.SKATE_DECKS,
  "Skate - Helmets - Pads": ProductType.SKATE_HELMETS_PADS,
  "Skate - Parts - Grip Tape": ProductType.SKATE_PARTS_GRIP_TAPE,
  "Skate - Parts - Hardware": ProductType.SKATE_PARTS_HARDWARE,
  "Skate - Parts - Trucks": ProductType.SKATE_PARTS_TRUCKS,
  "Skate - Parts - Wheels": ProductType.SKATE_PARTS_WHEELS,
  "Skate - Surfskates": ProductType.SKATE_SURFSKATES
}
);

class Variant {
  int id;
  String title;
  String option1;
  String? option2;
  dynamic option3;
  String sku;
  bool requiresShipping;
  bool taxable;
  Image? featuredImage;
  bool available;
  String price;
  int grams;
  String? compareAtPrice;
  int position;
  int productId;
  DateTime createdAt;
  DateTime updatedAt;

  Variant({
    required this.id,
    required this.title,
    required this.option1,
    required this.option2,
    required this.option3,
    required this.sku,
    required this.requiresShipping,
    required this.taxable,
    required this.featuredImage,
    required this.available,
    required this.price,
    required this.grams,
    required this.compareAtPrice,
    required this.position,
    required this.productId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Variant.fromRawJson(String str) => Variant.fromJson(json.decode(str));

  factory Variant.fromJson(Map<String, dynamic> json) => Variant(
    id: json["id"],
    title: json["title"],
    option1: json["option1"],
    option2: json["option2"],
    option3: json["option3"],
    sku: json["sku"],
    requiresShipping: json["requires_shipping"],
    taxable: json["taxable"],
    featuredImage: json["featured_image"] == null ? null : Image.fromJson(json["featured_image"]),
    available: json["available"],
    price: json["price"],
    grams: json["grams"],
    compareAtPrice: json["compare_at_price"],
    position: json["position"],
    productId: json["product_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
