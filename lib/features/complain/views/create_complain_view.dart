import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateComplainView extends ConsumerStatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => CreateComplainView());
  const CreateComplainView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateComplainViewState();
}

class _CreateComplainViewState extends ConsumerState<CreateComplainView> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
