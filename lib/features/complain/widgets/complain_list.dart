import 'package:civicalert/common/error_page.dart';
import 'package:civicalert/common/loading_page.dart';
import 'package:civicalert/features/complain/controller/complain_controller.dart';
import 'package:civicalert/features/complain/widgets/complain_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ComplainList extends ConsumerWidget {
  const ComplainList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getComplainProvider).when(
          data: (complains) {
            if (complains.isEmpty) {
              return const Center(
                child: Text(
                  'No complaints found',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              itemCount: complains.length,
              itemBuilder: (BuildContext context, int index) {
                final complain = complains[index];
                return ComplainCard(
                  complain: complain,
                );
              },
            );
          },
          error: (error, stackTrace) => ErrorText(
            error: error.toString(),
          ),
          loading: () => const Center(child: LoadingPage()),
        );
  }
}
