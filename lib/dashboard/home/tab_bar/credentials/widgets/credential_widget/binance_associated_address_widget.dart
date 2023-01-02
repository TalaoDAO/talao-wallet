import 'package:altme/app/app.dart';
import 'package:altme/dashboard/dashboard.dart';
import 'package:altme/l10n/l10n.dart';
import 'package:altme/theme/theme.dart';
import 'package:flutter/material.dart';

class BinanceAssociatedAddressWidget extends StatelessWidget {
  const BinanceAssociatedAddressWidget({
    Key? key,
    required this.credentialModel,
  }) : super(key: key);

  final CredentialModel credentialModel;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final binanceAssociatedAddress = credentialModel.credentialPreview
        .credentialSubjectModel as BinanceAssociatedAddressModel;
    return CredentialImage(
      image: ImageStrings.paymentBinanceCard,
      child: AspectRatio(
        aspectRatio: Sizes.credentialAspectRatio,
        child: CustomMultiChildLayout(
          delegate:
              BinanceAssociatedAddressWidgetDelegate(position: Offset.zero),
          children: [
            LayoutId(
              id: 'name',
              child: FractionallySizedBox(
                widthFactor: 0.8,
                heightFactor: 0.14,
                child: MyText(
                  l10n.binanceNetwork,
                  style: Theme.of(context).textTheme.subMessage.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
              ),
            ),
            LayoutId(
              id: 'accountName',
              child: FractionallySizedBox(
                widthFactor: 0.8,
                heightFactor: 0.16,
                child: MyText(
                  binanceAssociatedAddress.accountName!,
                  style: Theme.of(context).textTheme.title,
                ),
              ),
            ),
            LayoutId(
              id: 'walletAddress',
              child: FractionallySizedBox(
                widthFactor: 0.88,
                heightFactor: 0.26,
                child: MyText(
                  binanceAssociatedAddress.associatedAddress?.isEmpty == true
                      ? ''
                      : binanceAssociatedAddress.associatedAddress.toString(),
                  style: Theme.of(context).textTheme.subMessage.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                  minFontSize: 8,
                  maxLines: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BinanceAssociatedAddressWidgetDelegate extends MultiChildLayoutDelegate {
  BinanceAssociatedAddressWidgetDelegate({this.position = Offset.zero});

  final Offset position;

  @override
  void performLayout(Size size) {
    if (hasChild('name')) {
      layoutChild('name', BoxConstraints.loose(size));
      positionChild(
        'name',
        Offset(size.width * 0.06, size.height * 0.27),
      );
    }

    if (hasChild('accountName')) {
      layoutChild('accountName', BoxConstraints.loose(size));
      positionChild(
        'accountName',
        Offset(size.width * 0.06, size.height * 0.5),
      );
    }

    if (hasChild('walletAddress')) {
      layoutChild('walletAddress', BoxConstraints.loose(size));
      positionChild(
        'walletAddress',
        Offset(size.width * 0.06, size.height * 0.70),
      );
    }
  }

  @override
  bool shouldRelayout(BinanceAssociatedAddressWidgetDelegate oldDelegate) {
    return oldDelegate.position != position;
  }
}
