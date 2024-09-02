import 'package:flutter/material.dart';

import '../pages/NotificationPage.dart';
import '../pages/drawer.dart';

class ResponsiveScaffold extends StatefulWidget {
  // final List<DrawerItem> drawerItems;
  final List<NavbarItem> navbarItems;
  final int initialIndex;

  ResponsiveScaffold({
    // required this.drawerItems,
    required this.navbarItems,
    required this.initialIndex,
  });

  @override
  State<ResponsiveScaffold> createState() => _ResponsiveScaffoldState();
}

class _ResponsiveScaffoldState extends State<ResponsiveScaffold> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  // Utility function to return widget based on screen size
  Widget? _buildResponsiveWidget({
    required Widget? smallScreenWidget,
    required Widget? largeScreenWidget,
  }) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;
    return isSmallScreen ? smallScreenWidget : largeScreenWidget;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Responsive Scaffold'), actions: [
        IconButton(
          icon: Icon(Icons.notifications),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NotificationPage()),
            );
          },
        ),
      ]),
      drawer: _buildResponsiveWidget(
        smallScreenWidget: _buildDrawer(context),
        largeScreenWidget: null,
      ),
      body: Row(
        children: [
          _buildResponsiveWidget(
                smallScreenWidget: null,
                largeScreenWidget: Directionality(textDirection: TextDirection.rtl, child: _buildDrawerAsPartOfScreen()),
              ) ??
              SizedBox.shrink(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: widget.navbarItems[_currentIndex].widget,
            ),
          ),
          _buildResponsiveWidget(
                smallScreenWidget: null,
                largeScreenWidget: _buildNavigationRail(),
              ) ??
              SizedBox.shrink(),
        ].reversed.toList(),
      ),
      bottomNavigationBar: _buildResponsiveWidget(
        smallScreenWidget:BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => widget.navbarItems[index].widget));
          },
          items: widget.navbarItems
              .map((item) => BottomNavigationBarItem(
            icon: Icon(
              item.icon,
              color: _currentIndex == widget.navbarItems.indexOf(item)
                  ? Colors.blue // Active icon color
                  : Colors.grey, // Inactive icon color
            ),
            label: item.text,
          ))
              .toList(),
          backgroundColor: Colors.grey[100], // Background color of the navigation bar
          selectedItemColor: Colors.blue, // Color of the selected item
          unselectedItemColor: Colors.grey, // Color of unselected items
          selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.bold, // Style for the selected label
            fontSize: 14, // Increase font size for better readability
          ),
          unselectedLabelStyle: TextStyle(
            fontWeight: FontWeight.w400, // Style for the unselected label
            fontSize: 12, // Slightly smaller font size for unselected items
          ),
          type: BottomNavigationBarType.fixed, // Ensures all items are always displayed
          elevation: 10, // Add a subtle shadow for a more lifted look
          showUnselectedLabels: true, // Display labels for unselected items
          showSelectedLabels: true, // Display labels for selected items
          iconSize: 28, // Increase icon size for better visibility
        )
        ,
        largeScreenWidget: null,
      ),
    );
  }

  Widget _buildNavigationRail() {
    return NavigationRail(
      backgroundColor: Colors.grey[100],
      selectedIndex: _currentIndex,
      onDestinationSelected: (index) {
        setState(() {
          _currentIndex = index;
        });
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => widget.navbarItems[index].widget));
      },
      labelType: NavigationRailLabelType.all,
      destinations: widget.navbarItems
          .map((item) => NavigationRailDestination(
                icon: Icon(item.icon),
                label: Text(item.text),
              ))
          .toList(),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return const HDMDrawer();
    // return Drawer(
    //   child: ListView(
    //     children: widget.drawerItems
    //         .map((item) => ListTile(
    //       title: Text(item.text),
    //       onTap: () {
    //         Navigator.pop(context);
    //         item.onPressed();
    //       },
    //     ))
    //         .toList(),
    //   ),
    // );
  }

  Widget _buildDrawerAsPartOfScreen() {
    return Container(
      // width: 250, // Fixed width for the drawer as part of the screen
      color: Theme.of(context).drawerTheme.backgroundColor ?? Colors.white,
      child: _buildDrawer(context),
    );
  }
}

class DrawerItem {
  final String text;
  final VoidCallback onPressed;

  DrawerItem({required this.text, required this.onPressed});
}

class NavbarItem {
  final String text;
  final IconData icon;
  final Widget widget;

  NavbarItem({
    required this.text,
    required this.icon,
    required this.widget,
  });
}
