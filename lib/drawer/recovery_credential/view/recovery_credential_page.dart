import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:talao/app/interop/secure_storage/secure_storage.dart';
import 'package:talao/app/shared/widget/back_leading_button.dart';
import 'package:talao/app/shared/widget/base/button.dart';
import 'package:talao/app/shared/widget/base/page.dart';
import 'package:talao/app/shared/widget/mnemonic.dart';
import 'package:flutter/material.dart';
import 'package:talao/l10n/l10n.dart';

class RecoveryCredentialPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(
        builder: (context) => RecoveryCredentialPage(),
        settings: RouteSettings(name: '/recoveryCredentialPage'),
      );

  @override
  _RecoveryCredentialPageState createState() => _RecoveryCredentialPageState();
}

class _RecoveryCredentialPageState extends State<RecoveryCredentialPage> {
  List<String>? _mnemonic;

  @override
  void initState() {
    super.initState();
    loadMnemonic();
  }

  Future<void> loadMnemonic() async {
    final phrase = (await SecureStorageProvider.instance.get('mnemonic'))!;
    setState(() {
      _mnemonic = phrase.split(' ');
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BasePage(
      title: l10n.recoveryCredential,
      titleLeading: BackLeadingButton(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Column(
            children: [
              Text(
                l10n.recoveryCredentialPhrase,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              const SizedBox(height: 8.0),
              Text(
                l10n.recoveryCredentialPhraseExplanation,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
          const SizedBox(height: 32.0),
          BaseButton.primary(
            context: context,
            textColor: Theme.of(context).colorScheme.onPrimary,
            onPressed: () async {
              var result = await FilePicker.platform
                  .pickFiles(type: FileType.custom, allowedExtensions: ['txt']);
              if (result != null) {
                var file = File(result.files.single.path!);
                var text = await file.readAsString();
                print(text);
              }
            },
            child: Text(l10n.recoveryCredentialButtonTitle),
          )
        ],
      ),
    );
  }
}