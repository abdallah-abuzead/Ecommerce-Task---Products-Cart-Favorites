import 'package:abdallah_abuzead/components/pick_image_button.dart';
import 'package:abdallah_abuzead/components/spinner.dart';
import 'package:abdallah_abuzead/components/validation_error.dart';
import 'package:abdallah_abuzead/models/product.dart';
import 'package:abdallah_abuzead/models/product_data.dart';
import 'package:abdallah_abuzead/screens/products.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);
  static String id = 'add_product';

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ImagePicker picker = ImagePicker();
  late File file;
  var name, description, price, salePrice, stock;
  String pickedImagePath = '';
  String imageName = '';
  bool showImageError = false;

  bool isNumeric(String str) {
    return double.tryParse(str) != null;
  }

  Future showBottomSheet(context) async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(10),
          height: 130,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PickImageButton(
                btnText: 'From Camera',
                btnIcon: Icons.camera,
                onPressed: () async {
                  final XFile? pickedImage = await picker.pickImage(source: ImageSource.camera);
                  if (pickedImage != null) {
                    setState(() {
                      file = File(pickedImage.path);
                      pickedImagePath = pickedImage.path;
                    });
                    imageName = '${basename(pickedImage.path)}';
                  }
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: 10),
              PickImageButton(
                btnText: 'From Gallery',
                btnIcon: Icons.photo_outlined,
                onPressed: () async {
                  final XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
                  if (pickedImage != null) {
                    setState(() {
                      file = File(pickedImage.path);
                      pickedImagePath = pickedImage.path;
                    });
                    imageName = '${basename(pickedImage.path)}';
                  }
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void addProduct(BuildContext context) async {
    setState(() {
      showImageError = imageName == '';
    });
    var formData = formKey.currentState;
    if (imageName != '') {
      if (formData!.validate()) {
        formData.save();
        showSpinner(context);
        Directory appDocDir = await getApplicationDocumentsDirectory();
        await file.copy('${appDocDir.path}/$imageName');
        Provider.of<ProductData>(context, listen: false).addProduct(
          Product(
            name: name,
            description: description,
            price: double.parse(price),
            salePrice: salePrice.isEmpty ? double.parse(price) : double.parse(salePrice),
            stockQuantity: int.parse(stock),
            imagePath: pickedImagePath,
          ),
        );
        Navigator.pushNamedAndRemoveUntil(context, Products.id, (route) => false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      body: ListView(
        children: [
          SizedBox(height: 50),
          Container(
            padding: EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    onTap: () async {
                      showBottomSheet(context);
                    },
                    readOnly: true,
                    decoration: InputDecoration(
                      fillColor: Colors.black,
                      filled: true,
                      hintText: pickedImagePath == '' ? 'Product Image' : imageName,
                      hintStyle: TextStyle(color: Colors.white70),
                      prefixIcon: Icon(
                        Icons.image,
                        color: Colors.white,
                      ),
                      suffixIcon: pickedImagePath == ''
                          ? Icon(Icons.star_rate_rounded, color: Colors.red.shade500, size: 14)
                          : Container(
                              color: Colors.white70,
                              padding: EdgeInsets.all(1),
                              margin: EdgeInsets.only(right: 10),
                              child: Image.file(file),
                              width: double.minPositive,
                              height: double.minPositive,
                            ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  ValidationError(errorMessage: 'Image is required.', visible: showImageError),
                  SizedBox(height: 25),
                  TextFormField(
                    onSaved: (value) {
                      name = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) return 'Name is required.';
                      if (value.length < 2) return 'Name is too short.';
                      if (value.length > 60) return 'Name too long.';
                      return null;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.shopping_basket),
                      suffixIcon: Icon(Icons.star_rate_rounded, color: Colors.red.shade500, size: 14),
                      hintText: 'Name',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    onSaved: (value) {
                      description = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) return 'Description is required.';
                      if (value.length < 5) return 'Description is too short.';
                      if (value.length > 150) return 'Description too long.';
                      return null;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.description),
                      suffixIcon: Icon(Icons.star_rate_rounded, color: Colors.red.shade500, size: 14),
                      hintText: 'Description',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    onChanged: (value) {
                      price = value;
                    },
                    onSaved: (value) {
                      price = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) return 'Price is required.';
                      if (!isNumeric(value)) return 'Price must be a numeric value.';
                      if (double.parse(value) <= 0) return 'Price must be greater than 0.';
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.money),
                      suffixIcon: Icon(Icons.star_rate_rounded, color: Colors.red.shade500, size: 14),
                      hintText: 'Price',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    onSaved: (value) {
                      salePrice = value;
                    },
                    validator: (value) {
                      if (value!.isNotEmpty) {
                        if (!isNumeric(value)) return 'Sale price must be a numeric value.';
                        if (double.parse(value) <= 0) return 'Price must be greater than 0.';
                        if (double.parse(value) >= double.parse(price))
                          return 'Sale price must be less than product price.';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.price_change),
                      hintText: 'Sale price',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    onSaved: (value) {
                      stock = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) return 'Stock quantity is required.';
                      if (!isNumeric(value)) return 'Stock must be a numeric value.';
                      if (int.tryParse(value) == null) return 'Stock must be an integer value.';
                      if (int.parse(value) <= 0) return 'Stock must be greater than 0.';
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.inventory),
                      suffixIcon: Icon(Icons.star_rate_rounded, color: Colors.red.shade500, size: 14),
                      hintText: 'Stock quantity',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    child: Text('Add Product', style: TextStyle(fontSize: 20)),
                    onPressed: () async {
                      addProduct(context);
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
