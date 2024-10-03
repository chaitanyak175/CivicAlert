import 'package:civicalert/common/error_page.dart';
import 'package:civicalert/common/loading_page.dart';
import 'package:civicalert/constants/appwrite_constants.dart';
import 'package:civicalert/features/auth/controller/auth_controller.dart';
import 'package:civicalert/features/complain/controller/complain_controller.dart';
import 'package:civicalert/features/complain/widgets/complain_card.dart';
import 'package:civicalert/models/complain_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyComplainsList extends ConsumerWidget {
  const MyComplainsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserAsync = ref.watch(currentUserAccountProvider);

    return currentUserAsync.when(
      data: (currentUser) {
        if (currentUser == null) {
          return const Center(child: Text('User not logged in'));
        }

        return ref.watch(getComplainsByUidProvider(currentUser.$id)).when(
              data: (complains) {
                return ref.watch(getLatestComplain).when(
                      data: (data) {
                        if (data.events.contains(
                          'databases.*.collections.${AppwriteConstants.complainCollections}.documents.*.create',
                        )) {
                          final newComplain =
                              ComplainModel.fromMap(data.payload);
                          if (newComplain.uid == currentUser.$id) {
                            complains.insert(0, newComplain);
                          }
                        }
                        if (complains.isEmpty) {
                          return const Center(
                            child: Text(
                              'You haven\'t made any complaints yet',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          );
                        }
                        return ListView.builder(
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
                      loading: () {
                        if (complains.isEmpty) {
                          return const Center(
                            child: Text(
                              'You haven\'t made any complaints yet',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          );
                        }
                        return ListView.builder(
                          itemCount: complains.length,
                          itemBuilder: (BuildContext context, int index) {
                            final complain = complains[index];
                            return ComplainCard(
                              complain: complain,
                            );
                          },
                        );
                      },
                    );
              },
              error: (error, stackTrace) => ErrorText(
                error: error.toString(),
              ),
              loading: () => const Center(child: LoadingPage()),
            );
      },
      loading: () => const Center(child: LoadingPage()),
      error: (error, stackTrace) => ErrorText(
        error: error.toString(),
      ),
    );
  }
}
