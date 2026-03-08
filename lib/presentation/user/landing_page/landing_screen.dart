import 'package:dips/core/routing/route_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';


class LandingScreen extends StatefulWidget {
  final Widget child;
  const LandingScreen({super.key, required this.child});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int _selectedIndex = 0;

  final List<String> _pages = [
    RoutePath.home,
    RoutePath.seaerch,
    RoutePath.favourite,
    RoutePath.profile,
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: widget.child,
      bottomNavigationBar: _buildBottomNav(),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          context.push(RoutePath.chatbot);
        },
        backgroundColor: Color(0xFF041E41),
        child: SvgPicture.asset("assets/icons/bot_icon.svg", width: 24),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildBottomNav() {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem("assets/icons/home (1).svg", 'Home', 0),
            _buildNavItem("assets/icons/search-normal.svg", 'Search', 1),
            const SizedBox(width: 40), // FAB space
            _buildNavItem("assets/icons/Vector (2).svg", 'Favorites', 2),
            _buildNavItem("assets/icons/profile.svg", 'Profile', 3),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(String icon, String label, int index) {
    final isSelected = _selectedIndex == index;

    return InkWell(
      onTap: () {
        if (_selectedIndex == index) return;

        setState(() => _selectedIndex = index);
        context.go(_pages[index]);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            icon,
            width: 22,
            colorFilter: ColorFilter.mode(
              isSelected ? Theme.of(context).primaryColor : Colors.grey,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
