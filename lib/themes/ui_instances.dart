import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pet_nature/themes/color_theme.dart';
import 'package:pet_nature/themes/letter_theme.dart';
import 'package:pet_nature/widgets/estoques/baixas_history.dart';
import 'package:pet_nature/widgets/ui/logo.dart';
import 'package:pet_nature/widgets/ui/user_avatar.dart';

class UiInstances {
  const UiInstances();

  static BoxShadow shadow = BoxShadow(
    color: Colors.grey.withAlpha(15),
    blurRadius: 5,
    spreadRadius: 5,
    offset: Offset(2, 4),
  );

  static EdgeInsets screenPadding = const EdgeInsets.symmetric(
    vertical: 50,
    horizontal: 20,
  );

  static EdgeInsets screenPaddingWithAppBar = const EdgeInsets.only(
    left: 20,
    right: 20,
    bottom: 50,
  );

  static AppBar appBar(
    Function() goToProfile, {
    bool useHistory = false,
    BuildContext? context,
  }) {
    return AppBar(
      leading:
          useHistory && context != null
              ? IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => BaixasHistory(),
                  );
                },
                icon: Icon(
                  Icons.history,
                  size: 36,
                  color: ColorTheme.secondary,
                ),
              )
              : null,
      actionsPadding: EdgeInsets.symmetric(horizontal: 20),
      backgroundColor: ColorTheme.light,
      surfaceTintColor: ColorTheme.light,
      toolbarHeight: 75,
      centerTitle: true,

      title: Padding(padding: const EdgeInsets.only(bottom: 8), child: Logo()),
      actions: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: ColorTheme.primaryOne, width: 1),
            shape: BoxShape.circle,
          ),
          child: InkWell(onTap: goToProfile, child: UserAvatar()),
        ),
      ],
    );
  }

  static EdgeInsets modalPadding = EdgeInsets.symmetric(
    vertical: 28,
    horizontal: 16,
  );

  static showSnackbar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 10,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text, style: LetterTheme.button.copyWith(fontSize: 12)),
          ],
        ),
        backgroundColor: ColorTheme.danger,
        padding: const EdgeInsets.symmetric(vertical: 24),
      ),
    );
  }

  static Widget logoToMainContentSpacer = const SizedBox(height: 116);
}
