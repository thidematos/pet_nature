import 'package:flutter/material.dart';
import 'package:pet_nature/themes/color_theme.dart';
import 'package:pet_nature/themes/ui_instances.dart';
import 'package:pet_nature/widgets/ui/page_title.dart';

class Loader extends StatelessWidget {
  const Loader({this.isPageLoader = false, super.key});

  final bool isPageLoader;

  @override
  Widget build(BuildContext context) {
    Widget content = SizedBox(
      height: 20,
      width: 20,
      child: CircularProgressIndicator(color: ColorTheme.light, strokeWidth: 2),
    );

    if (isPageLoader) {
      content = Column(
        children: [
          UiInstances.logoToMainContentSpacer,
          PageTitle('Produtos cadastrados'),
          Expanded(
            child: Center(
              child: SizedBox(
                height: 75,
                width: 75,
                child: CircularProgressIndicator(
                  color: ColorTheme.secondaryTwo,
                ),
              ),
            ),
          ),
        ],
      );
    }

    return content;
  }
}
