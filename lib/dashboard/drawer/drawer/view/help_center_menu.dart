import 'package:altme/app/app.dart';
import 'package:altme/dashboard/drawer/drawer/drawer.dart';
import 'package:altme/l10n/l10n.dart';
import 'package:altme/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpCenterMenu extends StatelessWidget {
  const HelpCenterMenu({super.key});

  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => const HelpCenterMenu(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const HelpCenterView();
  }
}

class HelpCenterView extends StatelessWidget {
  const HelpCenterView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.drawerBackground,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                BackLeadingButton(
                  padding: EdgeInsets.zero,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                const Center(
                  child: AltMeLogo(size: 90),
                ),
                const SizedBox(
                  height: Sizes.spaceSmall,
                ),
                DrawerItem(
                  title: '${l10n.contactUs} : ${AltMeStrings.appSupportMail}',
                ),
                DrawerItem(
                  onTap: () {
                    launchUrl(Uri.parse('https://${AltMeStrings.appOfficialWebsite}'));
                  },
                  title: '${l10n.officialWebsite} :',
                  trailing: Expanded(
                    flex: 2,
                    child: Text(
                      AltMeStrings.appOfficialWebsite,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.subtitle2?.copyWith(
                            decoration: TextDecoration.underline,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
