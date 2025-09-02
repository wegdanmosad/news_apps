import 'package:flutter/material.dart';

class ErrorIndicator extends StatelessWidget {
  ErrorIndicator(String? errorMessage);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Something went wrong!'));
  }
}
