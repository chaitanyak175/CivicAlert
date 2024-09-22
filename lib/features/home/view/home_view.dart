import 'package:civicalert/constants/ui_constants.dart';
import 'package:civicalert/core/utils.dart';
import 'package:civicalert/features/complain/views/create_complain_view.dart';
import 'package:civicalert/theme/pallete.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeView extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => HomeView());
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _page = 0;
  final appbar = UiConstants.appbar();

  void onPageChange(int index) {
    setState(() {
      _page = index;
      HapticFeedback.heavyImpact();
    });
  }

  void onCreateComplain() {
    Navigator.push(context, CreateComplainView.route());
  }

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }

  Future<void> _requestLocationPermission() async {
    final permissionGranted = await requestLocationPermission();
    if (mounted && !permissionGranted) {
      showLocationPermissionSnackBar(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      backgroundColor: Pallete.backgroundColor,
      body: IndexedStack(
        index: _page,
        children: UiConstants.bottomTabBarPages,
      ),
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
      bottomNavigationBar: SizedBox(
        height: 95,
        child: CupertinoTabBar(
          currentIndex: _page,
          onTap: onPageChange,
          backgroundColor: Pallete.backgroundColor,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                _page == 0 ? Icons.other_houses : Icons.other_houses_outlined,
                color:
                    _page == 0 ? Pallete.buttonColor : Pallete.selectionColor,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                _page == 1 ? Icons.people_alt : Icons.people_alt_outlined,
                color:
                    _page == 1 ? Pallete.buttonColor : Pallete.selectionColor,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                _page == 2 ? Icons.notifications : Icons.notifications_none,
                color:
                    _page == 2 ? Pallete.buttonColor : Pallete.selectionColor,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                _page == 3 ? Icons.person : Icons.person_outline,
                color:
                    _page == 3 ? Pallete.buttonColor : Pallete.selectionColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
