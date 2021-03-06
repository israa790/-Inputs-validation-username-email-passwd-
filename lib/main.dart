import 'dart:developer';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fomulaire avec validation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _enableAutoValidation = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Fomulaire avec validation"),
      ),

      body: Center(
        child: SingleChildScrollView(
          child: Card(
            elevation: 8.0,
            child: SizedBox(
              height: 350,
              width: 300,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  autovalidateMode: _enableAutoValidation
                      ? AutovalidateMode.onUserInteraction
                      : AutovalidateMode.disabled,
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: _nameController,
                        validator: (String? value) {
                          if (value != null && value.isEmpty) {
                            return "Please enter your name";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: "Enter your name",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _emailController,
                        validator: (String? value) {
                          if (value != null &&
                              (value.isEmpty || !value.contains("@"))) {
                            return "Please enter a valid email";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: "Enter your email",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _passwordController,
                        validator: (String? value) {
                          if (value != null &&
                              (value.isEmpty || value.length < 6)) {
                            return "Please enter a strong password gretter then 6 !";
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: "Enter your password",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      InkWell(
                        child: Ink(
                          height: 50,
                          decoration: const BoxDecoration(
                            color: Colors.purpleAccent,
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              "Validate",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            // -- Auto validation for better UX
                            _enableAutoValidation = true;
                          });
                          if (_formKey.currentState != null &&
                              _formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: const Text(
                                ' valid fields',
                                style: TextStyle(fontSize: 16.0),
                              ),
                              duration: const Duration(seconds: 1),
                              action: SnackBarAction(
                                label: 'Ok',
                                textColor: Colors.white,
                                onPressed: () {
                                  log(_nameController.text);
                                  log(_emailController.text);
                                  log(_passwordController.text);
                                },
                              ),
                              backgroundColor: Colors.green[600],
                            ));
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
