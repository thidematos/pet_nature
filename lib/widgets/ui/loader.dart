import 'package:flutter/material.dart';
import 'package:pet_nature/themes/color_theme.dart';
import 'package:pet_nature/themes/ui_instances.dart';
import 'package:pet_nature/widgets/ui/page_title.dart';

class Loader extends StatelessWidget {
  const Loader({
    this.isPageLoader = false,
    this.color,
    this.size = 20,
    super.key,
  });

  final bool isPageLoader;
  final Color? color;
  final double size;

  @override
  Widget build(BuildContext context) {
    Widget content = SizedBox(
      height: size,
      width: size,
      child: CircularProgressIndicator(
        color: color ?? ColorTheme.light,
        strokeWidth: 2,
      ),
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
