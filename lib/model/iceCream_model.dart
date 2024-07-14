class IceCream {
  final int id;
  final String image;
  final String title;
  final int price;
  final String details;
  final String category;

  IceCream({
    required this.id,
    required this.category,
    required this.details,
    required this.image,
    required this.title,
    required this.price,
  });
}

IceCream thisIcecream = IceCream(
  id: 0,
  category: "",
  details: "",
  image: "",
  title: "",
  price: 0,
);
