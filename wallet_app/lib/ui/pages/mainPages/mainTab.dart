import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:wallet_app/ui/pages/mainPages/tabPages/mainPage.dart';
import 'package:wallet_app/ui/pages/mainPages/tabPages/notifications.dart';
import 'package:wallet_app/ui/pages/mainPages/tabPages/profile.dart';
import 'package:wallet_app/ui/pages/mainPages/tabPages/transActions.dart';
import '../../../business/styles/colors.dart';

class TabsScreen extends StatefulWidget {
  final String userID;
  const TabsScreen({Key? key, required this.userID}) : super(key: key);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  var _currentIndex = 0;
  bool isLoading = false;

  changeLoading() => setState(() => isLoading = !isLoading);



  final List<Widget> _pages = [
    const Home(),
    const Transactions(),
    const Notifications(),
    ProfileScreen(),
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? CircularProgressIndicator(color: Colors.black,)
          : _pages[_currentIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: PersonalColors.blue,
        onPressed: () {

        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.add_task_outlined,
              color: Colors.white,
            ),
            SizedBox(height: 2),
            Text(
              "Ödeme",
              style: TextStyle(color: Colors.white, fontSize: 11),
            )
          ],
        ),
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar(

          icons: icons,
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.verySmoothEdge,
          activeColor: PersonalColors.orange,
          inactiveColor: PersonalColors.grey3,
          activeIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i)),
    );

    // return PersistentTabView(
    //   context,
    //   navBarHeight: 72,
    //   navBarStyle: NavBarStyle.style15,
    //   decoration: NavBarDecoration(
    //     borderRadius: BorderRadius.circular(10.0),
    //     colorBehindNavBar: Colors.black,
    //   ),
    //   items: isLoading ? null : _navBarsItems(),
    //   screens: isLoading ? [buildCircularProgress()] : _buildScreens(),
    // );
  }

  // List<Widget> _buildScreens() {
  //   return [
  //     const Home(),
  //     const Transactions(),
  //     const AddInvoice(),
  //     const Notifications(),
  //     const Profile()
  //   ];
  // }



  List<IconData> icons = [
    FeatherIcons.home,
    Icons.account_balance_wallet_outlined,
    FeatherIcons.mail,
    FeatherIcons.user
  ];


}