import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Define a breakpoint for mobile vs desktop layout
        const double mobileBreakpoint = 600.0;

        // Check if the screen width is less than the mobile breakpoint
        if (constraints.maxWidth < mobileBreakpoint) {
          // Mobile layout: Stack items vertically in a Column
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 20.0,
            ),
            // Wrap the Column with a SizedBox to force it to take the full width
            // This provides a constrained width for the inner Row, fixing the layout error.
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Connect with Industry Professionals, Elevate Your Career.",
                    style: GoogleFonts.inter(
                      fontSize: 28, // Smaller font size for mobile
                      fontWeight: FontWeight.w900,
                      color: Colors.black87,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Elevate Ars is your gateway to career exploration. Students gain invaluable mentorship and real-world learning experiences, while professionals inspire the next generation and shape future talent.",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: Colors.black54,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Buttons are kept in a row to allow for horizontal layout
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black38,
                            shadowColor: Colors.black12,
                            elevation: 1,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text("Join as a Student"),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black87,
                            foregroundColor: Colors.white,
                            shadowColor: Colors.black26,
                            elevation: 3,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text("Join as a Professional"),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      "lib/core/assets/image/groupmentorship.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          // Desktop layout: Keep the original Row-based layout
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 40.0,
            ),
            // Wrap the Row with a SizedBox to force it to take the full width,
            // which provides a constrained width for its children.
            child: SizedBox(
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Connect with Industry Professionals, Elevate Your Career.",
                          style: GoogleFonts.inter(
                            fontSize: 42,
                            fontWeight: FontWeight.w900,
                            color: Colors.black87,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Elevate Ars is your gateway to career exploration. Students gain invaluable mentorship and real-world learning experiences, while professionals inspire the next generation and shape future talent.",
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            color: Colors.black54,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Expanded(
                              // Fix applied here
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black38,
                                  shadowColor: Colors.black12,
                                  elevation: 1,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text("Join as a Student"),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              // Fix applied here
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black87,
                                  foregroundColor: Colors.white,
                                  shadowColor: Colors.black26,
                                  elevation: 3,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text("Join as a Professional"),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 32),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        "lib/core/assets/image/groupmentorship.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
