import 'package:flutter/material.dart';
import 'package:widget_dictionary/slide_bar/reponsive_sidebar.dart';
import 'package:widget_dictionary/slide_bar/sidebar_controller.dart';
import 'package:widget_dictionary/slide_bar/sidebar_menuItem.dart';
import 'package:widget_dictionary/slide_bar/sidebar_subItem.dart';
import 'package:widget_dictionary/slide_bar/sidebar_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int? _selectedIndex;
  late SidebarController _controller;
  Widget? subWidget;

  final SideBarTheme  _theme  = SideBarTheme(
      selectedTextStyle: const TextStyle(color: Colors.blue),
      iconTheme: const IconThemeData(color: Colors.white),
      selectedIconTheme: const IconThemeData(color: Colors.blue),
      hoverColor: Colors.amber.withOpacity(0.5),
      hoverIconTheme: const IconThemeData(color: Colors.white),
      textStyle: const TextStyle(color: Colors.white),
      hoverTextStyle: const TextStyle(color: Colors.white),
      itemDecoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      selectedItemDecoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      itemMargin: const EdgeInsets.symmetric(vertical: 5),
      selectedItemMargin: const EdgeInsets.symmetric(vertical: 5),
      // decoration: BoxDecoration(
      //   color: Colors.blue,
      //   borderRadius: BorderRadius.circular(10),
      // ),
    extendedWidth: 200,
      collapsedWidth: 56,
      subDecoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(10),
      ),
    );

  final List<Widget> _list = [
    Container(
      color: Colors.red.withOpacity(0.5),
      child: const Center(
        child: Text('Home Root'),
      )
    ),
    Container(
      color: Colors.blue.withOpacity(0.5),
      child: const Center(
        child: Text('Profile Root'),
    ),
    ),
  ];


  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // Initialize _controller here
    _controller = SidebarController(selectedIndex: _selectedIndex, extended: true);
    _controller.addListener(() {
      setState(() {
        selectedIndex = _controller.selectedIndex!;
        subWidget = null;
      }); // Rebuild when the controller state changes
    });
    // _controller.addListener(() {
    //   setState(() {}); // Rebuild when the controller state changes
    // });
  }

  @override
  Widget build(BuildContext context) {
    final List<SidebarMenuItem> items = [
      SidebarMenuItem(
        icon: Icons.home,
        label: 'home',
        subItems: [
          SidebarSubItem(
            title: 'sub_Home',
            onTap: () {
              setState(() {
                subWidget = const SubHomePage();
              });
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const SubHomePage()),
              // );
            },
          ),
          SidebarSubItem(
            title: 'sub_Home2',
            onTap: () {
              setState(() {
                subWidget = const SubHome2Page();
              });
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const SubHome2Page()),
              // );
            },
          )
        ],
      ),
      SidebarMenuItem(
          icon: Icons.person,
          label: 'Profile',
          subItems: [
            SidebarSubItem(
              title: 'sub_profile',
              onTap: () {
                setState(() {
                  subWidget = const SubProfilePage();
                });
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => const SubProfilePage()),
                // );
              },
            ),
          ]
      ),
    ];
    return Scaffold(
      body: ResponsiveSidebar(
        controller: _controller,
        theme: _theme,
        items: items,
        footerItems: const [],
        headerBuilder: (context, extended) {
          return ListTile(
            contentPadding: const EdgeInsets.only(left: 22),
            // leading: Icon(Icons.person, color: Colors.white.withOpacity(0.7)),
            title: Text(
              _controller.extended ? "로고영역" : "",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )
            ),
            onTap: () {
              print('Profile');
            },
          );
        },
        footerBuilder: (context, extended) {
          return ListTile(
            contentPadding: const EdgeInsets.only(left: 22),
            leading: Icon(Icons.logout, color: Colors.white.withOpacity(0.7)),
            title: Text(
              _controller.extended ? "로그아웃 하기" : "",
            ),
            onTap: () {
              print('로그아웃 하기');
            },
          );
        },
        showToggleButton: true,
        animationDuration: const Duration(milliseconds: 300),
        child: Container(
          color: Colors.white,
          child:  Center(
            child: subWidget?? _list[selectedIndex],
          ),
        ),
      ),
    );
  }
}

class SubHomePage extends StatelessWidget {
  const SubHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sub Home Page'),
      ),
      body: const Center(
        child: Text('This is the Sub Home Page'),
      ),
    );
  }
}

class SubHome2Page extends StatelessWidget {
  const SubHome2Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sub Home 2 Page'),
      ),
      body: Container(
        color: Colors.green.withOpacity(0.5),
        child: const Center(
          child: Text('This is the Sub Home 2 Page'),
        ),
      ),
    );
  }
}

class SubProfilePage extends StatelessWidget {
  const SubProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sub Profile Page'),
      ),
      body: Container(
        color: Colors.amber.withOpacity(0.5),
        child: const Center(
          child: Text('This is the Sub Profile Page'),
        ),
      ),
    );
  }
}