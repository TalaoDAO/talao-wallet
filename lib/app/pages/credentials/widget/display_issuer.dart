import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:talao/app/shared/model/author.dart';

class DisplayIssuer extends StatelessWidget {
  const DisplayIssuer({
    Key? key,
    required this.issuer,
  }) : super(key: key);

  final Author issuer;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: (issuer.name != '')
          ? Row(
              children: [
                Text('${localizations.issuer} '),
                Text(issuer.name,
                    style:
                        TextStyle(inherit: true, fontWeight: FontWeight.w700)),
                Spacer(),
                (issuer.logo != '')
                    ? Container(height: 30, child: Image.network(issuer.logo))
                    : SizedBox.shrink()
              ],
            )
          : SizedBox.shrink(),
    );
  }
}