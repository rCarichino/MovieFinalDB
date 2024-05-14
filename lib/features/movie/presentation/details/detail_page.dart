import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
   DetailPage({super.key, required this.id});
String id;
  @override
  Widget build(BuildContext context) {
    int index = int.parse(id);
    return const Placeholder();
  }
}
