import 'package:elevare_ars/screens/dahsboard/mentor/mentor_dashboard.dart';
import 'package:elevare_ars/screens/dahsboard/student/student_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TopNav extends StatefulWidget implements PreferredSizeWidget {
  const TopNav({super.key});

  @override
  State<TopNav> createState() => _TopNavState();

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class _TopNavState extends State<TopNav> {
  bool _isSearching = false; // ✅ now in state

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    if (width >= 766) {
      // ---------- DESKTOP VIEW ----------
      return _buildDesktopNav();
    } else if (width > 610) {
      // ---------- TABLET VIEW ----------
      return _buildTabletNav();
    } else {
      // ---------- MOBILE VIEW ----------
      return _buildMobileNav(context);
    }
  }

  // -------------------- DESKTOP NAV --------------------
  AppBar _buildDesktopNav() {
    return AppBar(
      elevation: 0.5,
      toolbarHeight: 60,
      automaticallyImplyLeading: false,
      title: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Row(
            children: [
              // App Logo
              Container(
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
              ),
              const SizedBox(width: 24),

              // Search bar
              Expanded(child: _buildSearchBar()),

              const SizedBox(width: 32),

              // Right side nav items
              Row(
                children: [
                  _buildNavIcon(
                    FontAwesomeIcons.house,
                    "Home",
                    onTap: () {
                      debugPrint("Home tapped");
                      // Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
                    },
                  ),
                  _buildNavIcon(
                    FontAwesomeIcons.users,
                    "Explore",
                    onTap: () {
                      debugPrint("Explore tapped");
                    },
                  ),
                  _buildNavIcon(
                    FontAwesomeIcons.message,
                    "Messages",
                    onTap: () {
                      debugPrint("Messages tapped");
                    },
                  ),
                  _buildNavIcon(
                    FontAwesomeIcons.bell,
                    "Notifications",
                    onTap: () {
                      Navigator.push(
                        (context),
                        MaterialPageRoute(
                          builder: (builder) => StudentDashboard(),
                        ),
                      );
                    },
                  ),
                  _buildNavIcon(
                    Icons.dashboard,
                    "Dashboard",
                    onTap: () {
                      Navigator.push(
                        (context),
                        MaterialPageRoute(
                          builder: (builder) => MentorDashboard(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(width: 16),
                  _buildProfileMenu("Me"),
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(icon, size: 17),
            const SizedBox(height: 2),
            Text(label, style: const TextStyle(fontSize: 9)),
          ],
        ),
      ),
    );
  }

  /// Profile menu
  Widget _buildProfileMenu(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 12,
            backgroundColor: Colors.blue,
            child: Icon(Icons.person, size: 14, color: Colors.white),
          ),
          const SizedBox(height: 2),
          Text(label, style: const TextStyle(fontSize: 11)),
        ],
      ),
    );
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
              // 🔹 Logo
              Container(
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
              ),
              const SizedBox(width: 24),

              // 🔹 If searching → show expanded search
              if (_isSearching)
                Expanded(child: _buildSearchBar())
              else
                const Spacer(),

              const SizedBox(width: 32),

              // 🔹 Right side nav items
              if (_isSearching)
                IconButton(
                  icon: const FaIcon(FontAwesomeIcons.xmark),
                  onPressed: () {
                    setState(() {
                      _isSearching = false;
                    });
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
                      onPressed: () {
                        setState(() {
                          _isSearching = true;
                        });
                      },
                    ),
                    _buildNavIcon(
                      FontAwesomeIcons.house,
                      "Home",
                      onTap: () {
                        debugPrint("Home tapped");
                        // Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
                      },
                    ),
                    _buildNavIcon(
                      FontAwesomeIcons.users,
                      "Explore",
                      onTap: () {
                        debugPrint("Explore tapped");
                      },
                    ),
                    _buildNavIcon(
                      FontAwesomeIcons.message,
                      "Messages",
                      onTap: () {
                        debugPrint("Messages tapped");
                      },
                    ),
                    _buildNavIcon(
                      FontAwesomeIcons.bell,
                      "Notifications",
                      onTap: () {
                        debugPrint("Notifications tapped");
                      },
                    ),
                    _buildNavIcon(
                      Icons.dashboard,
                      "Dashboard",
                      onTap: () {
                        debugPrint("Dashboard tapped");
                      },
                    ),
                    const SizedBox(width: 16),
                    _buildProfileMenu("Me"),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔹 Profile avatar (nav bar version, opens drawer)
  Widget _buildProfileCircle(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        Scaffold.of(context).openDrawer(); // or openEndDrawer()
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
      title: _buildSearchBar(),
      actions: [
        IconButton(
          icon: const FaIcon(FontAwesomeIcons.message, size: 18),
          onPressed: () {},
        ),
        const SizedBox(width: 12),
      ],
    );
  }

  // -------------------- HELPERS --------------------
  Widget _buildLogo() {
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        color: Colors.blue.shade700,
        borderRadius: BorderRadius.circular(4),
      ),
      alignment: Alignment.center,
      child: const Text(
        "in",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSearchBar({
    String hint = "Search...",
    TextEditingController? controller,
    bool autoFocus = false,
  }) {
    final searchController = controller ?? TextEditingController();

    return SizedBox(
      height: 44,
      child: TextField(
        controller: searchController,
        autofocus: autoFocus,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
          prefixIcon: const Icon(Icons.search, size: 20, color: Colors.grey),
          suffixIcon: ValueListenableBuilder<TextEditingValue>(
            valueListenable: searchController,
            builder: (context, value, _) {
              return value.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(
                        Icons.close,
                        size: 18,
                        color: Colors.grey,
                      ),
                      onPressed: () => searchController.clear(),
                    )
                  : const SizedBox.shrink();
            },
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide: BorderSide(color: Colors.blue.shade300, width: 1.5),
          ),
        ),
      ),
    );
  }

  Widget _buildIconOnly(IconData icon) {
    return IconButton(
      icon: FaIcon(icon, size: 20, color: Colors.black87),
      onPressed: () {},
    );
  }
}
