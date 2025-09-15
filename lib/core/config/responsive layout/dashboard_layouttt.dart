import 'package:flutter/material.dart';

class DashboardLayout extends StatelessWidget {
  final Widget? sidebar; // Sidebar menu (drawer on mobile)
  final Widget centerColumn;
  final Widget? rightColumn;

  const DashboardLayout({
    super.key,
    this.sidebar,
    required this.centerColumn,
    this.rightColumn,
  });

  static const double desktopXL = 1600;
  static const double desktop = 1200;
  static const double smallDesktop = 1000;
  static const double tablet = 768;
  static const double mobile = 600;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;

        if (maxWidth >= desktopXL) {
          return _threeColumn(centered: true);
        } else if (maxWidth >= desktop) {
          return _threeColumn(centered: true);
        } else if (maxWidth >= smallDesktop) {
          return _twoColumn();
        } else if (maxWidth >= tablet) {
          return _twoColumn();
        } else {
          // 📱 mobile → sidebar drawer + stack center + right
          return _withDrawerAndStack(context);
        }
      },
    );
  }

  // ----------- Desktop (3 column) ------------
  Widget _threeColumn({required bool centered}) {
    final row = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (sidebar != null) SizedBox(width: 240, child: sidebar!),
        const SizedBox(width: 24),
        Expanded(child: centerColumn),
        const SizedBox(width: 24),
        if (rightColumn != null) SizedBox(width: 300, child: rightColumn!),
      ],
    );

    return centered
        ? Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1400),
              child: row,
            ),
          )
        : row;
  }

  // ----------- Tablet / Small desktop (2 column) ------------
  Widget _twoColumn() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(flex: 7, child: centerColumn),
        const SizedBox(width: 16),
        if (rightColumn != null) Flexible(flex: 3, child: rightColumn!),
      ],
    );
  }

  // ----------- Mobile → Drawer + stack center + right ------------
  Widget _withDrawerAndStack(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        leading: sidebar != null
            ? Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              )
            : null,
      ),
      drawer: sidebar != null ? Drawer(child: SafeArea(child: sidebar!)) : null,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 700),
              child: centerColumn,
            ),
            if (rightColumn != null) ...[
              const SizedBox(height: 16),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 700),
                child: rightColumn!,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
