import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:staff_support_system_flutter/HomePage/HomePage.dart';
import 'package:staff_support_system_flutter/auth_screen/login_screen/login_screen.dart';
import 'package:staff_support_system_flutter/common_widgets/commonloadingIndicator.dart';
import 'package:staff_support_system_flutter/common_widgets/utils.dart';
import 'package:staff_support_system_flutter/constants/colors.dart';
import 'package:staff_support_system_flutter/constants/fontstyle.dart';
import 'package:staff_support_system_flutter/firebase_auth/firebaseauthhelper.dart';

class HomePagestart extends StatefulWidget {
  const HomePagestart({super.key});

  @override
  State<HomePagestart> createState() => _HomePagestartState();
}

class _HomePagestartState extends State<HomePagestart> {
  final List<String> STD = [
    'STD-1',
    'STD-2',
    'STD-3',
    'STD-4',
    'STD-5',
    'STD-6',
    'STD-7',
    'STD-8',
    'STD-9',
    'STD-10',
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  var isLoading = false;
  @override
  Widget build(BuildContext context) {
    List<int> matchingItemIndexes = [];

    for (int i = 0; i < STD.length; i++) {
      matchingItemIndexes.add(i);
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(fontFamily: bold),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: primayColor,
              ),
              child: ListTile(
                title: Text(
                  'Teacher Name',
                  style: TextStyle(
                    fontSize: 18,
                    color: textWhiteColor,
                    fontFamily: medium,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 2,
                ),
                subtitle: Text(
                  'Designation',
                  style: TextStyle(
                    fontSize: 14,
                    color: textWhiteColor,
                    fontFamily: regular,
                  ),
                ),
                trailing: CircleAvatar(
                  radius: 35,
                  backgroundColor: textWhiteColor,
                  child: Icon(Icons.person, size: 35),
                ),
              ),
            ),
            ListTile(
              title: const Text(
                'Home',
                style: TextStyle(
                    fontFamily: medium,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: textColor),
              ),
              selected: _selectedIndex == 0,
              onTap: () {
                // Update the state of the app
                _onItemTapped(0);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text(
                'Business',
                style: TextStyle(
                    fontFamily: medium,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: textColor),
              ),
              selected: _selectedIndex == 1,
              onTap: () {
                // Update the state of the app
                _onItemTapped(1);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text(
                'School',
                style: TextStyle(
                    fontFamily: medium,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: textColor),
              ),
              selected: _selectedIndex == 2,
              onTap: () {
                // Update the state of the app
                _onItemTapped(2);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text(
                'Log Out',
                style: TextStyle(
                    fontFamily: medium,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: textColor),
              ),
              selected: _selectedIndex == 0,
              onTap: () {
                // Update the state of the app
                setState(() {
                  isLoading = true;
                });
                FirebaseAuthHelper.firebaseAuthHelper.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
                showMessage(
                    context: context,
                    message: 'Log out Successfully',
                    bgcolor: greenColor);
                setState(() {
                  isLoading = false;
                });
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
          canvasColor: primayColor,
        ),
        child: BottomNavigationBar(
          selectedItemColor: textWhiteColor,
          unselectedItemColor: lightWhiteColor,
          currentIndex: _selectedIndex,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
      body:  SingleChildScrollView(
              child: isLoading
                  ? loadingIndicator()
                  : Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 0.5,
                      color: primayColor,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(
                            'Teacher Name',
                            style: TextStyle(
                              fontSize: 22,
                              color: textWhiteColor,
                              fontFamily: medium,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          subtitle: Text(
                            'Designation',
                            style: TextStyle(
                              fontSize: 20,
                              color: textWhiteColor,
                              fontFamily: regular,
                            ),
                          ),
                          trailing: CircleAvatar(
                            radius: 35,
                            backgroundColor: textWhiteColor,
                            child: Icon(Icons.person, size: 35),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 570,
                    decoration: const BoxDecoration(color: textWhiteColor),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Card(
                      elevation: 0.5,
                      color: textWhiteColor,
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 10.0,
                        ),
                        itemCount: matchingItemIndexes.length,
                        itemBuilder: (BuildContext context, int index) {
                          int itemIndex = matchingItemIndexes[index];
                          String selectedSTD = STD[itemIndex];
                          return GestureDetector(
                            onTap: () {
                              // Navigate to the next page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()),
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Card(
                                  elevation: 0.5,
                                  color: textWhiteColor,
                                  child: SizedBox(
                                    height: 100,
                                    width: 100,
                                    child: Center(
                                      child: Text(
                                        STD[itemIndex],
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontFamily: medium,
                                          color: textColor,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
/*
*
*
*   */
