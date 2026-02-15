import 'package:flutter/material.dart';

import '../../../../core/theme/app_palette.dart';

class AuthGradientButton extends StatelessWidget {
  const AuthGradientButton({super.key, required this.label, this.onPressed});
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: .antiAlias,
      decoration: BoxDecoration(
        borderRadius: .circular(8),
        gradient: const LinearGradient(
          colors: [AppPalette.gradient1, AppPalette.gradient2],
          begin: .bottomLeft,
          end: .topRight,
        ),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shadowColor: AppPalette.transparentColor,
          shape: const BeveledRectangleBorder(),
          fixedSize: const Size(.maxFinite, 55),
          backgroundColor: AppPalette.transparentColor,
        ),
        onPressed: onPressed,
        child: Text(label, style: const .new(fontSize: 17, fontWeight: .w600)),
      ),
    );
  }
}
