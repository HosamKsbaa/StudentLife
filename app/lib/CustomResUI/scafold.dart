import 'package:flutter/material.dart';

class ResponsiveScaffold extends StatefulWidget {
  final List<DrawerItem> drawerItems;
  final List<NavbarItem> navbarItems;
  final int initalIndex;

  ResponsiveScaffold({
    required this.drawerItems,
    required this.navbarItems,
    required this.initalIndex,
  });

  @override
  State<ResponsiveScaffold> createState() => _ResponsiveScaffoldState();
}

class _ResponsiveScaffoldState extends State<ResponsiveScaffold> {
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
      appBar: AppBar(title: Text('Responsive Scaffold')),
      drawer: _buildResponsiveWidget(
        smallScreenWidget: _buildDrawer(context),
        largeScreenWidget: null,
      ),
      body: Row(

        children: [
          _buildResponsiveWidget(
            smallScreenWidget: null,
            largeScreenWidget: _buildDrawerAsPartOfScreen(),
          ) ?? SizedBox.shrink(),

          Expanded(child: widget.initalIndex),
          _buildResponsiveWidget(
            smallScreenWidget: null,
            largeScreenWidget: _buildNavigationRail(),
          ) ?? SizedBox.shrink(),
        ].reversed.toList(),
      ),
      bottomNavigationBar: _buildResponsiveWidget(
        smallScreenWidget: BottomNavigationBar(
          items: widget.navbarItems
              .map((item) => BottomNavigationBarItem(
            icon: Icon(item.icon),
            label: item.text,
          ))
              .toList(),
          onTap: (index) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => widget.navbarItems[index].widget));
            // widget.navbarItems[index].widget();
          },
        ),
        largeScreenWidget: null,
      ),
    );
  }

  Widget _buildNavigationRail() {
    return NavigationRail(
      selectedIndex: 0,
      onDestinationSelected: (index) {
        // Handle item selection
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
    return Drawer(
      child: ListView(
        children: widget.drawerItems
            .map((item) => ListTile(
          title: Text(item.text),
          onTap: () {
            Navigator.pop(context);
            item.onPressed();
          },
        ))
            .toList(),
      ),
    );
  }

  Widget _buildDrawerAsPartOfScreen() {
    return Container(
      width: 250, // Fixed width for the drawer as part of the screen
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
