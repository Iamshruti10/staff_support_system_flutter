

import 'package:flutter/material.dart';
import 'package:staff_support_system_flutter/HomePage/HomePage.dart';


class HomePage_start extends StatefulWidget {
  const HomePage_start({super.key});

  @override
  State<HomePage_start> createState() => _HomePage_startState();
}

class _HomePage_startState extends State<HomePage_start> {
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

  @override
  Widget build(BuildContext context) {
    List<int> matchingItemIndexes = [];

    for (int i = 0; i < STD.length; i++) {
      matchingItemIndexes.add(i);
    }
    return Scaffold(
      backgroundColor: Colors.grey[250],
      bottomNavigationBar: Theme(
        data: ThemeData(
          canvasColor: const Color(0xFF053498),
        ),
        child: BottomNavigationBar(
          selectedItemColor: const Color(0xFF5FB2FF)
,
          unselectedItemColor:
              const Color.fromARGB(255, 255, 255, 255).withOpacity(0.8),
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
      body: Stack(
        children: [
          Container(
            decoration:
                const BoxDecoration(color:  Color(0xFF053498)
),
            child: const SizedBox(
              height: 250,
              width: 600,
              child: Card(
                elevation: 10,
                color:  Color(0xFF053498),
                child: Padding(
                  padding: EdgeInsets.only(top: 30.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.menu,
                      color: Colors.white,
                      size: 35,
                    ),
                    title: Text(
                      'Teacher Name',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    subtitle: Text(
                      'Designation',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    trailing: CircleAvatar(
                      radius: 35,
                      backgroundImage: NetworkImage(""),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(100, 150, 0, 120),
            child: Text(
              "Explore Exisiting Classes!",
              style: TextStyle(
                fontSize: 22,
                color: Colors.white.withOpacity(0.9),
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 210, 10, 0),
            child: Container(
              // height: 570,
              decoration: BoxDecoration(
                color: Colors.white,
                //border: Border.all(width: 1.5),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                          elevation: 5,
                          color: Colors.blue[50],
                          child: SizedBox(
                            height: 100,
                            width: 100,
                            child: Center(
                              child: Text(
                                STD[itemIndex],
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color(0xF30A3590),
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
    );
  }
}
