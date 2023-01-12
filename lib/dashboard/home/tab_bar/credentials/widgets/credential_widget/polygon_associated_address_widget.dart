import 'package:altme/app/app.dart';
import 'package:altme/dashboard/dashboard.dart';
import 'package:altme/l10n/l10n.dart';
import 'package:flutter/material.dart';

class PolygonAssociatedAddressWidget extends StatelessWidget {
  const PolygonAssociatedAddressWidget({
    Key? key,
    required this.credentialModel,
  }) : super(key: key);

  final CredentialModel credentialModel;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final associatedAddress = credentialModel.credentialPreview
        .credentialSubjectModel as PolygonAssociatedAddressModel;
    return MyBlockchainAccountBaseWidget(
      image: IconStrings.polygon,
      name: l10n.polygonNetwork,
      walletAddress: associatedAddress.associatedAddress?.isEmpty == true
          ? ''
          : associatedAddress.associatedAddress.toString(),
    );
  }
}
