import 'package:credible/app/pages/credentials/models/credential.dart';
import 'package:credible/app/pages/credentials/models/credential_status.dart';
import 'package:credible/app/shared/model/credential.dart';
import 'package:credible/app/shared/ui/ui.dart';
import 'package:credible/app/shared/widget/base/box_decoration.dart';
import 'package:credible/app/shared/widget/hero_workaround.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

class _BaseItem extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final bool enabled;
  final bool? selected;

  const _BaseItem({
    Key? key,
    required this.child,
    this.onTap,
    this.enabled = true,
    this.selected,
  }) : super(key: key);

  @override
  __BaseItemState createState() => __BaseItemState();
}

class __BaseItemState extends State<_BaseItem>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    // controller = AnimationController(
    //   duration: Duration(minutes: 4),
    //   vsync: this,
    // );
    //
    // animation = Tween<double>(begin: 0.0, end: 360.0).animate(controller)
    //   ..addStatusListener((status) {
    //     if (status == AnimationStatus.completed) {
    //       controller.forward(from: 0.0);
    //     }
    //   });
    //
    // controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    // controller?.dispose();
  }

  @override
  Widget build(BuildContext context) => Opacity(
        opacity: !widget.enabled ? 0.33 : 1.0,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          decoration: BaseBoxDecoration(
            color: UiKit.palette.credentialBackground,
            shapeColor: UiKit.palette.credentialDetail.withOpacity(0.2),
            value: 1.0,
            anchors: <Alignment>[
              Alignment.bottomRight,
            ],
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: UiKit.palette.shadow,
                offset: Offset(0.0, 2.0),
                blurRadius: 2.0,
              ),
            ],
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20.0),
            child: InkWell(
              borderRadius: BorderRadius.circular(20.0),
              onTap: widget.onTap,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: IntrinsicHeight(child: widget.child),
              ),
            ),
          ),
        ),
      );
}

class CredentialsListItem extends StatelessWidget {
  final CredentialModel item;
  final VoidCallback? onTap;
  final bool? selected;

  CredentialsListItem({
    Key? key,
    required this.item,
    this.onTap,
    this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => _BaseItem(
        enabled: !(item.status != CredentialStatus.active),
        onTap: onTap ??
            () => Modular.to.pushNamed(
                  '/credentials/detail',
                  arguments: item,
                ),
        child: displayListElement(context),
      );

  Row displayListElement(BuildContext context) {
    final credential = Credential.fromJson(item.data);
    return Row(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: HeroFix(
            tag: 'credential/${item.id}/icon',
            child: selected == null
                ? SvgPicture.asset(
                    'assets/brand/spruce-icon.svg',
                    width: 24.0,
                    height: 24.0,
                    color: UiKit.palette.icon,
                  )
                : selected!
                    ? Icon(
                        Icons.check_box,
                        size: 24.0,
                        color: UiKit.palette.icon,
                      )
                    : Icon(
                        Icons.check_box_outline_blank,
                        size: 24.0,
                        color: UiKit.palette.icon,
                      ),
          ),
        ),
        const SizedBox(width: 16.0),
        Expanded(
          child: credential.displayList(context, item),
        ),
      ],
    );
  }
}
