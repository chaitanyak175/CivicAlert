import 'package:civicalert/constants/appbar_constants.dart';
import 'package:civicalert/features/complain/views/create_complain_view.dart';
import 'package:civicalert/features/complain/widgets/complain_list.dart';
import 'package:civicalert/theme/pallete.dart';
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
      body: const ComplainList(),
    );
  }
}
