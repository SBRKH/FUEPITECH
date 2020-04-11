import 'package:flutter/material.dart';
import 'package:sport_app/models/app_tab.dart';

class TabSelector extends StatelessWidget {
  const TabSelector({
    Key key,
    @required this.activeTab,
    @required this.onTabSelected,
  }) : super(key: key);

  final AppTab activeTab;
  final Function(AppTab) onTabSelected;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: AppTab.values.indexOf(activeTab),
      onTap: (int index) => onTabSelected(AppTab.values[index]),
      items: AppTab.values.map((AppTab tab) {
        return BottomNavigationBarItem(
          icon: Icon(
            tab == AppTab.events ? Icons.list : Icons.person,
          ),
          title: Text(tab == AppTab.profile
              ? 'Profile'
              : 'Events'),
        );
      }).toList(),
    );
  }
}