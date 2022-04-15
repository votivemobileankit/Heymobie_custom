class AddonProductListBool {
  int pid;
  String productCode;
  String stock;
  String imageURL;
  String slug;
  String name;
  String price;
  String quantity;
  String unit;
  String description;
  String vendorId;
  String categoryId;
  String subCategoryId;
  int avgRating;
  bool ischecked;

  AddonProductListBool(
      {this.pid,
      this.productCode,
      this.stock,
      this.imageURL,
      this.slug,
      this.name,
      this.price,
      this.quantity,
      this.unit,
      this.description,
      this.vendorId,
      this.categoryId,
      this.subCategoryId,
      this.avgRating,
      this.ischecked});
}
