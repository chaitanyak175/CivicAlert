import 'package:civicalert/constants/appbar_constants.dart';
import 'package:civicalert/features/myComplains/widgets/my_complains_list.dart';
import 'package:flutter/material.dart';

class MyComplaintsView extends StatefulWidget {
  const MyComplaintsView({super.key});

  @override
  State<MyComplaintsView> createState() => _MyComplaintsViewState();
}

class _MyComplaintsViewState extends State<MyComplaintsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarConstants.myComplaintsViewAppbar(),
      body: const MyComplainsList(),
    );
  }
}
