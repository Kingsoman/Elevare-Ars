import 'package:elevare_ars/core/routing/routes/app_route_constants.dart';
import 'package:elevare_ars/features/auth/data/authservice.dart';
import 'package:elevare_ars/features/auth/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class TopNav extends ConsumerStatefulWidget implements PreferredSizeWidget {
  const TopNav({super.key});

  @override
  ConsumerState<TopNav> createState() => _TopNavState();

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class _TopNavState extends ConsumerState<TopNav> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width >= 766) {
      return _buildDesktopNav();
    } else if (width > 610) {
      return _buildTabletNav();
    } else {
      return _buildMobileNav(context);
    }
  }

  // -------------------- DESKTOP NAV --------------------
  AppBar _buildDesktopNav() {
    return AppBar(
      toolbarHeight: 60,
      automaticallyImplyLeading: false,
      title: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Row(
            children: [
              _buildLogo(),
              const SizedBox(width: 16),
              SizedBox(width: 280, child: _buildSearchBar()),
              const Spacer(),
              Row(
                children: [
                  _buildNavIcon(
                    FontAwesomeIcons.house,
                    "Home",
                    onTap: () =>
                        context.goNamed(MyAppRouteConstant.feedsRouteName),
                  ),
                  _buildNavIcon(
                    FontAwesomeIcons.users,
                    "Explore",
                    onTap: () => _handleNavigation(() {
                      debugPrint("Explore tapped");
                    }),
                  ),
                  _buildNavIcon(
                    FontAwesomeIcons.message,
                    "Messages",
                    onTap: () => _handleNavigation(() {
                      debugPrint("Messages tapped");
                    }),
                  ),
                  _buildNavIcon(
                    FontAwesomeIcons.bell,
                    "Notifications",
                    onTap: () => _handleNavigation(() {
                      context.push('/student-dashboard');
                    }),
                  ),
                  _buildNavIcon(
                    Icons.dashboard,
                    "Dashboard",
                    onTap: () => _handleNavigation(() {
                      context.push('/mentor-dashboard');
                    }),
                  ),
                  const SizedBox(width: 16),
                  _buildProfileMenuDropdown("Me"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Reusable nav item
  Widget _buildNavIcon(IconData icon, String label, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(icon, size: 17),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(fontSize: 9),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  /// Profile Menu with Dropdown
  Widget _buildProfileMenuDropdown(String label) {
    return PopupMenuButton<String>(
      offset: const Offset(0, 40),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: "profile",
          child: Row(
            children: [
              Icon(Icons.person, size: 18),
              SizedBox(width: 8),
              Text("My Profile", style: TextStyle(fontSize: 14)),
            ],
          ),
        ),
        const PopupMenuDivider(),
        const PopupMenuItem(
          value: "logout",
          child: Row(
            children: [
              Icon(Icons.logout, size: 18, color: Colors.red),
              SizedBox(width: 8),
              Text(
                "Sign Out",
                style: TextStyle(fontSize: 14, color: Colors.red),
              ),
            ],
          ),
        ),
      ],
      onSelected: (value) => _handleMenuSelection(value),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(
              radius: 12,
              backgroundColor: Colors.blue,
              child: Icon(Icons.person, size: 14, color: Colors.white),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(fontSize: 11),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  /// Safe menu selection handler
  void _handleMenuSelection(String value) {
    if (!mounted) return;

    switch (value) {
      case "profile":
        _handleNavigation(() {
          context.push('/profile');
        });
        break;
      case "logout":
        _handleLogout();
        break;
    }
  }

  /// Safe logout handler - simplified without loading dialog
  Future<void> _handleLogout() async {
    if (!mounted) return;

    try {
      await ref.read(authServiceProvider).signOut();

      if (!mounted) return;

      // Navigate to login screen using GoRouter
      context.go('/login');
    } catch (e) {
      if (!mounted) return;

      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Logout failed: ${e.toString()}'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  /// Safe navigation handler
  void _handleNavigation(VoidCallback callback) {
    if (!mounted) return;
    callback();
  }

  // -------------------- TABLET NAV --------------------
  AppBar _buildTabletNav() {
    return AppBar(
      elevation: 0.5,
      toolbarHeight: 60,
      automaticallyImplyLeading: false,
      title: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Row(
            children: [
              _buildLogo(),
              const SizedBox(width: 16),
              if (_isSearching)
                SizedBox(width: 280, child: _buildSearchBar(autoFocus: true))
              else
                const Spacer(),
              const SizedBox(width: 16),
              if (_isSearching)
                IconButton(
                  icon: const FaIcon(FontAwesomeIcons.xmark),
                  tooltip: "Close search",
                  onPressed: () {
                    if (mounted) {
                      setState(() {
                        _isSearching = false;
                        _searchController.clear();
                      });
                    }
                  },
                )
              else
                Row(
                  children: [
                    IconButton(
                      icon: const FaIcon(
                        FontAwesomeIcons.magnifyingGlass,
                        size: 18,
                      ),
                      tooltip: "Search",
                      onPressed: () {
                        if (mounted) {
                          setState(() {
                            _isSearching = true;
                          });
                        }
                      },
                    ),
                    _buildNavIcon(
                      FontAwesomeIcons.house,
                      "Home",
                      onTap: () => _handleNavigation(() {
                        debugPrint("Home tapped");
                      }),
                    ),
                    _buildNavIcon(
                      FontAwesomeIcons.users,
                      "Explore",
                      onTap: () => _handleNavigation(() {
                        debugPrint("Explore tapped");
                      }),
                    ),
                    _buildNavIcon(
                      FontAwesomeIcons.message,
                      "Messages",
                      onTap: () => _handleNavigation(() {
                        debugPrint("Messages tapped");
                      }),
                    ),
                    _buildNavIcon(
                      FontAwesomeIcons.bell,
                      "Notifications",
                      onTap: () => _handleNavigation(() {
                        debugPrint("Notifications tapped");
                      }),
                    ),
                    _buildNavIcon(
                      Icons.dashboard,
                      "Dashboard",
                      onTap: () => _handleNavigation(() {
                        debugPrint("Dashboard tapped");
                      }),
                    ),
                    const SizedBox(width: 8),
                    _buildProfileMenuDropdown("Me"),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  /// Profile avatar (opens drawer)
  Widget _buildProfileCircle(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        if (mounted) {
          Scaffold.of(context).openDrawer();
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: CircleAvatar(
          radius: 16,
          backgroundColor: Colors.blue.shade600,
          child: const Icon(Icons.person, size: 18, color: Colors.white),
        ),
      ),
    );
  }

  // -------------------- MOBILE NAV --------------------
  AppBar _buildMobileNav(BuildContext context) {
    return AppBar(
      elevation: 0.5,
      toolbarHeight: 60,
      leading: Builder(builder: (context) => _buildProfileCircle(context)),
      title: SizedBox(width: double.infinity, child: _buildSearchBar()),
      actions: [
        IconButton(
          icon: const FaIcon(FontAwesomeIcons.message, size: 18),
          tooltip: "Messages",
          onPressed: () => _handleNavigation(() {
            debugPrint("Messages tapped");
          }),
        ),
        const SizedBox(width: 12),
      ],
    );
  }

  // -------------------- HELPERS --------------------
  Widget _buildLogo() {
    return Container(
      height: 32,
      width: 32,
      decoration: BoxDecoration(
        color: Colors.blue.shade700,
        borderRadius: BorderRadius.circular(6),
      ),
      alignment: Alignment.center,
      child: const Text(
        "EA",
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSearchBar({String hint = "Search...", bool autoFocus = false}) {
    return SizedBox(
      height: 40,
      child: TextField(
        controller: _searchController,
        autofocus: autoFocus,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
          prefixIcon: const Icon(Icons.search, size: 18, color: Colors.grey),
          suffixIcon: ValueListenableBuilder<TextEditingValue>(
            valueListenable: _searchController,
            builder: (context, value, _) {
              return value.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(
                        Icons.close,
                        size: 16,
                        color: Colors.grey,
                      ),
                      tooltip: "Clear search",
                      onPressed: () {
                        if (mounted) {
                          _searchController.clear();
                        }
                      },
                    )
                  : const SizedBox.shrink();
            },
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 12,
          ),
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.blue.shade300, width: 1.5),
          ),
        ),
      ),
    );
  }
}
