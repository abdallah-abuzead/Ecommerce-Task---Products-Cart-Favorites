import 'package:abdallah_abuzead/screens/products.dart';
import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);
  static const String id = 'welcome';

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          SizedBox(height: 150),
          Container(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) return 'Name is required.';
                      if (value.length < 2) return 'Name must be at least 2 characters.';
                      if (value.length > 50) return 'Name must be at most 50 character.';
                      return null;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      suffixIcon: Icon(Icons.star_rate_rounded, color: Colors.red.shade500, size: 14),
                      hintText: 'Name',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    validator: (value) {
                      bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value!);
                      if (value.isEmpty) return 'Email is required.';
                      if (!emailValid) return 'Invalid email format.';
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      suffixIcon: Icon(Icons.star_rate_rounded, color: Colors.red.shade500, size: 14),
                      hintText: 'Email',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone),
                      hintText: 'Phone',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  ElevatedButton(
                    child: Text('Run App', style: TextStyle(fontSize: 20)),
                    onPressed: () {
                      var formData = _formKey.currentState;
                      if (formData!.validate()) {
                        Navigator.pushReplacementNamed(context, Products.id);
                      }
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
