import 'dart:io';

import 'package:civicalert/common/loading_page.dart';
import 'package:civicalert/constants/appbar_constants.dart';
import 'package:civicalert/core/utils.dart';
import 'package:civicalert/features/auth/controller/auth_controller.dart';
import 'package:civicalert/features/complain/controller/complain_controller.dart';
import 'package:civicalert/features/complain/widgets/carousel_view.dart';
import 'package:civicalert/features/complain/widgets/create_complain_button.dart';
import 'package:civicalert/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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

  GoogleMapController? mapController;
  Position? _currentPosition;
  String? _locationString;
  List<File> images = [];

  void raiseComplain() {
    ref.read(complainControllerProvider.notifier).shareComplain(
          title: titleController.text,
          description: descriptionController.text,
          location: locationController.text,
          contactNumber: contactController.text,
          images: images,
          currentLocation: _locationString!,
          context: context,
        );
  }

  void onPickImages() async {
    List<File> newImages = await pickImages();
    setState(() {
      images.addAll(newImages);
    });
  }

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

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        locationSettings:
            const LocationSettings(accuracy: LocationAccuracy.best),
      );
      if (mounted) {
        setState(() {
          _currentPosition = position;
          _locationString = '${position.latitude},${position.longitude}';
        });
      }
    } catch (e) {
      if (mounted) {
        showLocationErrorSnackBar(context);
        setState(() {
          _locationString = 'Location not available';
        });
      }
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> _initializeLocation() async {
    bool hasPermission = await requestLocationPermission();
    if (hasPermission) {
      await _getCurrentLocation();
    } else if (mounted) {
      showLocationPermissionSnackBar(context);
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeLocation();
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
    final currentUser = ref.watch(currentUserDetailsProvider).when(
      data: (user) {
        debugPrint('User: ${user?.name}');
        return user;
      },
      loading: () {
        debugPrint('Loading user data...');
        return null;
      },
      error: (err, stack) {
        debugPrint('Error: $err');
        return null;
      },
    );
    final isLoading = ref.watch(complainControllerProvider);
    return Scaffold(
      backgroundColor: Pallete.coinswtichColor,
      appBar: AppbarConstants.raiseComplainAppBar(),
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
                            maxLines: 6,
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
                      const SizedBox(
                        height: 25,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Upload Photos',
                            style: TextStyle(
                              fontFamily: 'Gilroy',
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: onPickImages,
                            child:
                                buildImageUploadSection(images, onPickImages),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Your Current Location',
                            style: TextStyle(
                              fontFamily: 'Gilroy',
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          if (_currentPosition != null)
                            SizedBox(
                              height: 200,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: GoogleMap(
                                  onMapCreated: _onMapCreated,
                                  initialCameraPosition: CameraPosition(
                                    target: LatLng(_currentPosition!.latitude,
                                        _currentPosition!.longitude),
                                    zoom: 17,
                                  ),
                                  markers: {
                                    Marker(
                                      markerId:
                                          const MarkerId('current_location'),
                                      position: LatLng(
                                          _currentPosition!.latitude,
                                          _currentPosition!.longitude),
                                    ),
                                  },
                                ),
                              ),
                            )
                          else
                            const SizedBox(
                              height: 200,
                              child: Loader(),
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
            onPressed: raiseComplain,
            isLoading: isLoading,
          ),
        ),
      ),
    );
  }
}
