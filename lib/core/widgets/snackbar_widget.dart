import 'package:elevare_ars/main.dart';
import 'package:flutter/material.dart'; // import rootScaffoldMessengerKey

/// ✅ Shows a green snackbar for success messages
void snackbarSuccessMessage(String message) {
  // Use the global key to access the ScaffoldMessenger at the root
  rootScaffoldMessengerKey.currentState?.showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: Colors.green, // Success = green
    ),
  );
}

/// ❌ Shows a red material banner for error messages
void snackbarErrorMessage(String message) {
  // Use the global key to show a material banner instead of snackbar
  rootScaffoldMessengerKey.currentState?.showMaterialBanner(
    MaterialBanner(
      content: Text(message),
      actions: [
        TextButton(
          // Button to dismiss the banner
          child: const Text("Dismiss"),
          onPressed: () => rootScaffoldMessengerKey.currentState
              ?.hideCurrentMaterialBanner(),
        ),
      ],
      backgroundColor: Colors.red, // Error = red
    ),
  );
}
