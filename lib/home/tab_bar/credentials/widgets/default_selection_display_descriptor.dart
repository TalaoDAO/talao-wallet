import 'package:altme/app/app.dart';
import 'package:altme/home/home.dart';
import 'package:altme/l10n/l10n.dart';
import 'package:altme/theme/theme.dart';
import 'package:flutter/material.dart';

class DefaultSelectionDisplayDescriptor extends StatelessWidget {
  const DefaultSelectionDisplayDescriptor({
    Key? key,
    required this.credentialModel,
  }) : super(key: key);

  final CredentialModel credentialModel;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return CredentialBackground(
      credentialModel: credentialModel,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: DisplayNameCard(
              credentialModel: credentialModel,
              style: Theme.of(context).textTheme.credentialTitle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: DisplayDescriptionCard(
              credentialModel: credentialModel,
              style: Theme.of(context).textTheme.credentialDescription,
            ),
          ),
          if (credentialModel.credentialPreview.evidence.first.id != '')
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Text(
                    '${l10n.evidenceLabel}: ',
                    style: Theme.of(context).textTheme.credentialFieldTitle,
                  ),
                  Flexible(
                    child: InkWell(
                      onTap: () => LaunchUrl.launch(
                        credentialModel.credentialPreview.evidence.first.id,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Text(
                              credentialModel
                                  .credentialPreview.evidence.first.id,
                              style: Theme.of(context)
                                  .textTheme
                                  .credentialFieldDescription,
                              maxLines: 5,
                              overflow: TextOverflow.fade,
                              softWrap: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          else
            const SizedBox.shrink()
        ],
      ),
    );
  }
}
