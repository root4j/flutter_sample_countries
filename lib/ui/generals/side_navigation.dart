import 'package:flutter/material.dart';

import '../../constants.dart';

class SideNavigation extends StatelessWidget {
  final Function setIndex;
  final MenuOption selectedIndex;

  const SideNavigation(
      {Key? key, required this.setIndex, required this.selectedIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: bgColor),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: const <Widget>[
                  SizedBox(
                    width: 70,
                    height: 70,
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/unknown.jpg'),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'User Conected',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: fgColor,
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'user@sample.com',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: fgColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Dash
          _navItem(context, Icons.dashboard, 'Load Data', onTap: () {
            _navItemClicked(context, MenuOption.load);
          }, selected: selectedIndex == MenuOption.load),
          // Task
          _navItem(context, Icons.task, 'Tasks', onTap: () {
            _navItemClicked(context, MenuOption.task);
          }, selected: selectedIndex == MenuOption.task),
          // Country
          _navItem(context, Icons.maps_ugc, 'Countries', onTap: () {
            _navItemClicked(context, MenuOption.country);
          }, selected: selectedIndex == MenuOption.country),
        ],
      ),
    );
  }

  _navItem(BuildContext context, IconData icon, String text,
          {Text? suffix, Function()? onTap, bool selected = false}) =>
      Container(
        color: selected ? Colors.grey.shade300 : Colors.transparent,
        child: ListTile(
          leading: Icon(icon,
              color: selected ? Theme.of(context).primaryColor : Colors.black),
          trailing: suffix,
          title: Text(text),
          selected: selected,
          onTap: onTap,
        ),
      );

  _navItemClicked(BuildContext context, MenuOption option) {
    setIndex(option);
    Navigator.of(context).pop();
  }
}