import 'package:flutter/material.dart';
import 'package:vendar/components/login/login_view.dart';

class VendAR extends StatelessWidget {
  const VendAR({super.key});
  
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginView(),
    );
  }

}