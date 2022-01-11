
import 'package:talao/app/pages/on_boarding/third.dart';
import 'package:talao/app/pages/on_boarding/tos.dart';
import 'package:talao/app/shared/ui/ui.dart';
import 'package:talao/app/shared/widget/base/button.dart';
import 'package:talao/app/shared/widget/base/page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnBoardingSecondPage extends StatefulWidget {

  static Route route() => MaterialPageRoute(
        builder: (context) => OnBoardingSecondPage(),
      );
      
  @override
  State<OnBoardingSecondPage> createState() => _OnBoardingSecondPageState();
}

class _OnBoardingSecondPageState extends State<OnBoardingSecondPage> {
  var animate = true;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return GestureDetector(
      onHorizontalDragUpdate: (drag) async {
        if (animate) {
          if (drag.delta.dx > 2) {
            Navigator.of(context).pop();
            disableAnimation();
          }

          if (drag.delta.dx < -2) {
            disableAnimation();
            await Navigator.of(context).push(OnBoardingThirdPage.route());
          }
        }
      },
      child: BasePage(
          scrollView: true,
          body: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/image/slide_2.png',
                  height: 200,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  localizations.appPresentation2,
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
          navigation: Container(
            decoration: BoxDecoration(
              color: UiKit.palette.navBarBackground,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: UiKit.palette.shadow,
                  offset: Offset(-1.0, -1.0),
                  blurRadius: 4.0,
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.circle,
                            color: UiKit.palette.primary.withOpacity(0.2),
                          ),
                          Icon(
                            Icons.circle,
                            color: UiKit.palette.primary,
                          ),
                          Icon(
                            Icons.circle,
                            color: UiKit.palette.primary.withOpacity(0.2),
                          ),
                        ],
                      ),
                    ),
                    BaseButton.primary(
                      onPressed: () {
                        Navigator.of(context).push(OnBoardingTosPage.route());
                      },
                      child: Text(localizations.onBoardingStartButton),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }

  void disableAnimation() {
    animate = false;
    Future.delayed(Duration(seconds: 1), () {
      animate = true;
    });
  }
}