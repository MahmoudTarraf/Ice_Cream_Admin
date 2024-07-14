class OfferModel {
  final int id;
  final String image;
  final String title;
  final int oldPrice;
  final int newPrice;
  final String details;
  final String category;

  OfferModel({
    required this.id,
    required this.category,
    required this.details,
    required this.image,
    required this.title,
    required this.oldPrice,
    required this.newPrice,
  });
}

OfferModel thisOffer = OfferModel(
  id: 0,
  category: "",
  details: "",
  image: "",
  title: "",
  oldPrice: 0,
  newPrice: 0,
);
