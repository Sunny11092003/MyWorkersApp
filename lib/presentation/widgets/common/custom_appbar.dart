import 'package:flutter/material.dart';
import '../../../config/theme/app_colors.dart';
import '../../../config/theme/app_text_styles.dart';

/// Reusable AppBar with consistent styling across screens.
///
/// Wrap [title] in [Text] if you need a plain string; pass any widget for
/// richer layouts.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.showBackButton = true,
    this.onBackPressed,
    this.actions,
    this.backgroundColor = AppColors.white,
    this.elevation = 0,
    this.centerTitle = false,
  });

  final String title;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;
  final Color backgroundColor;
  final double elevation;
  final bool centerTitle;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: elevation,
      centerTitle: centerTitle,
      automaticallyImplyLeading: false,
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: onBackPressed ?? () => Navigator.pop(context),
            )
          : null,
      title: Text(title, style: AppTextStyles.appBarTitle),
      actions: actions,
    );
  }
}
