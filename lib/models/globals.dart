library my_prj.globals;

class Product{
  const Product({ this.id , this.imageName, this.name, this.price })
      : assert(imageName != null), assert(name != null), assert(price != null);
  final int id;
  final String imageName;
  final String name;
  final num price;
}

List<Product> cart = [];