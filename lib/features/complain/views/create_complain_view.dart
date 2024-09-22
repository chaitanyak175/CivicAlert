import 'package:civicalert/constants/ui_constants.dart';
import 'package:civicalert/features/complain/widgets/create_complain_button.dart';
import 'package:civicalert/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final locationController = TextEditingController();
  final contactController = TextEditingController();

  Widget _buildCounter(int currentLength, int maxLength) {
    return Text(
      '${maxLength - currentLength}',
      style: TextStyle(
        color: currentLength > (maxLength - 10)
            ? Colors.red
            : const Color.fromARGB(255, 115, 114, 114),
        fontSize: 13,
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    locationController.dispose();
    contactController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.coinswtichColor,
      appBar: UiConstants.createComplainAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Container(
                width: constraints.maxWidth,
                decoration: BoxDecoration(
                  color: Pallete.backgroundColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Title',
                                style: TextStyle(
                                  fontFamily: 'Gilroy',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                ),
                              ),
                              _buildCounter(titleController.text.length, 50),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                            controller: titleController,
                            maxLength: 50,
                            maxLines: 2,
                            onChanged: (value) {
                              SchedulerBinding.instance
                                  .addPostFrameCallback((_) {
                                setState(() {});
                              });
                            },
                            onTapOutside: (PointerDownEvent event) {
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            decoration: const InputDecoration(
                              hintText: 'Enter a brief title for the complaint',
                              hintStyle: TextStyle(
                                fontFamily: 'Gilroy',
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 204, 202, 202),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(194, 0, 0, 0),
                                ),
                              ),
                              counterText: '',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Description',
                                style: TextStyle(
                                  fontFamily: 'Gilroy',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                ),
                              ),
                              _buildCounter(
                                  descriptionController.text.length, 200),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                            controller: descriptionController,
                            maxLength: 200,
                            maxLines: 5,
                            onChanged: (value) {
                              SchedulerBinding.instance
                                  .addPostFrameCallback((_) {
                                setState(() {});
                              });
                            },
                            onTapOutside: (PointerDownEvent event) {
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            decoration: const InputDecoration(
                              hintText:
                                  'Provide a detailed description of the issue',
                              hintStyle: TextStyle(
                                fontFamily: 'Gilroy',
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 204, 202, 202),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(194, 0, 0, 0),
                                ),
                              ),
                              counterText: '',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Location',
                                style: TextStyle(
                                  fontFamily: 'Gilroy',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                ),
                              ),
                              _buildCounter(
                                  locationController.text.length, 100),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                            controller: locationController,
                            keyboardType: TextInputType.streetAddress,
                            maxLength: 100,
                            maxLines: 3,
                            onChanged: (value) {
                              SchedulerBinding.instance
                                  .addPostFrameCallback((_) {
                                setState(() {});
                              });
                            },
                            onTapOutside: (PointerDownEvent event) {
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            decoration: const InputDecoration(
                              hintText: 'Specify the location of the complaint',
                              hintStyle: TextStyle(
                                fontFamily: 'Gilroy',
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 204, 202, 202),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(194, 0, 0, 0),
                                ),
                              ),
                              counterText: '',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Contact Number',
                                style: TextStyle(
                                  fontFamily: 'Gilroy',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                ),
                              ),
                              _buildCounter(contactController.text.length, 10),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                            controller: contactController,
                            keyboardType: TextInputType.phone,
                            maxLength: 10,
                            maxLines: 1,
                            onChanged: (value) {
                              SchedulerBinding.instance
                                  .addPostFrameCallback((_) {
                                setState(() {});
                              });
                            },
                            onTapOutside: (PointerDownEvent event) {
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                            decoration: const InputDecoration(
                              hintText: 'Enter your phone number',
                              hintStyle: TextStyle(
                                fontFamily: 'Gilroy',
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 204, 202, 202),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(194, 0, 0, 0),
                                ),
                              ),
                              counterText: '',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(top: 10),
        decoration: const BoxDecoration(
          color: Pallete.backgroundColor,
          border: Border(
            top: BorderSide(
              color: Pallete.selectionColor,
              width: 0.5,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0).copyWith(
            left: 25,
            right: 25,
            bottom: 40,
          ),
          child: CreateComplainButton(
            buttonText: 'Complain',
            onPressed: () {},
            isLoading: false,
          ),
        ),
      ),
    );
  }
}
