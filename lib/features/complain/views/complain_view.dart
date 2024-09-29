import 'package:civicalert/constants/appbar_constants.dart';
import 'package:civicalert/features/complain/views/create_complain_view.dart';
import 'package:civicalert/features/complain/widgets/complain_list.dart';
import 'package:civicalert/theme/pallete.dart';
import 'package:flutter/material.dart';

class ComplainView extends StatefulWidget {
  const ComplainView({super.key});

  @override
  State<ComplainView> createState() => _ComplainViewState();
}

class _ComplainViewState extends State<ComplainView> {
  void onCreateComplain() {
    Navigator.push(context, CreateComplainView.route());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarConstants.complainViewAppbar(),
      body: const ComplainList(),
      floatingActionButton: SizedBox(
        height: 60,
        width: 60,
        child: RawMaterialButton(
          onPressed: onCreateComplain,
          shape: const CircleBorder(),
          fillColor: Pallete.buttonColor,
          child: const Icon(
            Icons.create_outlined,
            color: Pallete.backgroundColor,
            size: 28,
          ),
        ),
      ),
    );
  }
}
