class AddonProductListBool {
  late int pid;
  late String productCode;
  late  String stock;
  late  String imageURL;
  late String slug;
  late String name;
  late  String price;
  late  String quantity;
  late  String unit;
  late String description;
  late  String vendorId;
  late String categoryId;
  late  String subCategoryId;
  late  int avgRating;
  late bool ischecked;

  AddonProductListBool(
      {required this.pid,
        required  this.productCode,
        required  this.stock,
        required  this.imageURL,
        required  this.slug,
        required this.name,
        required this.price,
        required  this.quantity,
        required this.unit,
        required this.description,
        required this.vendorId,
        required this.categoryId,
        required this.subCategoryId,
        required  this.avgRating,
        required  this.ischecked});
}
