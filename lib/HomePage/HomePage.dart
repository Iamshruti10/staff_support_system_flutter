import 'package:flutter/material.dart';
import 'package:staff_support_system_flutter/HomePage/navBar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<int, IconData> icons = {
    0: Icons.checklist_sharp,
    1: Icons.calendar_month,
    2: Icons.note_add_rounded,
    3: Icons.book,
    4: Icons.notifications,
    5: Icons.favorite,
    6: Icons.chat,
    7: Icons.search,
    8: Icons.more_vert,
    9: Icons.add,
  };

  final List<String> itemNames = [
    'Attendece',
    'TimeTable',
    'LessonPlan',
    'Submission',
    'notifications',
    'favorite',
    'chat',
    'search',
    'more_vert',
    'add',
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

    for (int i = 0; i < itemNames.length; i++) {
      matchingItemIndexes.add(i);
    }
    return Scaffold(
       drawer: Drawer(
    child: ListView(
      children: [
        ListTile(
          title: Text('My Page 1'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NavBarPage()),
            );
          },
        ),
        ListTile(
          title: Text('My Page 2'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NavBarPage()),
            );
          },
        ),
      ],
    ),
  ),
      backgroundColor: Colors.grey[250],
      bottomNavigationBar: Theme(
        data: ThemeData(
          canvasColor: const Color(0xFF053498),
        ),
        child: BottomNavigationBar(
          selectedItemColor: const Color(0xFF5FB2FF),
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
                const BoxDecoration(color:  Color(0xFF053498)),
            child:  SizedBox(
              height: 250,
              width: 600,
              child: Card(
                elevation: 10,
                color:  Color(0xFF053498),
                child: Padding(
                  padding: EdgeInsets.only(top: 30.0),
                  child: ListTile(
                    leading: IconButton(
                      icon: const Icon(
                        Icons.menu,
                        color: Colors.white,
                        size: 35,
                      ), onPressed: () {
                     Scaffold.of(context).openDrawer();
                   },
                    ),
                    title:const  Text(
                      'Teacher Name',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    subtitle:const  Text(
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
            padding: const EdgeInsets.fromLTRB(150, 140, 0, 150),
            child: Column(
              children: [
                Text(
                  "Current class:",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white.withOpacity(0.8),
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const Text(
                  "Selected STD",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 210, 15, 0),
            child: Card(
              color:  Colors.white,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: matchingItemIndexes.length,
                itemBuilder: (BuildContext context, int index) {
                  int itemIndex = matchingItemIndexes[index];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Card(
                        
                        elevation: 5,
                        color: Colors.white, // Set color to transparent
                        shape: const CircleBorder(),
                        child: Icon(
                          
                          icons[index],
                          color: const Color(0xF30A3590),
                          size: 45.0,
                        ),
                      ),
                      Text(
                        itemNames[itemIndex],
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xFF076EBF),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
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
