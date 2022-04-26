import 'package:flutter/material.dart';
import 'package:talao/app/shared/model/credential_model/credential_model.dart';
import 'package:talao/app/shared/ui/ui.dart';
import 'package:talao/credentials/credentials.dart';
import 'package:talao/l10n/l10n.dart';

class DisplayDescriptionCard extends StatelessWidget {
  const DisplayDescriptionCard(this.item, {Key? key}) : super(key: key);
  final CredentialModel item;

  @override
  Widget build(BuildContext context) {
    final nameValue = getDescription(context);
    return Text(
      nameValue,
      overflow: TextOverflow.fade,
      style: Theme.of(context).textTheme.credentialTextCard,
    );
  }

  String getDescription(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    var _nameValue =
        getTranslation(item.credentialPreview.description, localizations);
    if (_nameValue == '') {
      _nameValue = item.display.descriptionFallback;
    }

    return _nameValue;
  }
}