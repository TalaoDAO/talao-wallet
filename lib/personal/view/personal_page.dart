import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:talao/app/pages/credentials/pages/list.dart';
import 'package:talao/app/shared/ui/ui.dart';
import 'package:talao/app/shared/widget/back_leading_button.dart';
import 'package:talao/app/shared/widget/base/button.dart';
import 'package:talao/app/shared/widget/base/page.dart';
import 'package:talao/app/shared/widget/base/text_field.dart';
import 'package:talao/drawer/profile/cubit/profile_cubit.dart';
import 'package:talao/drawer/profile/models/profile.dart';
import 'package:talao/l10n/l10n.dart';
import 'package:talao/self_issued_credential/widget/sef_issued_credential_button.dart';

class PersonalPage extends StatefulWidget {
  final ProfileModel profileModel;
  final bool isFromOnBoarding;

  const PersonalPage({
    Key? key,
    required this.profileModel,
    required this.isFromOnBoarding,
  }) : super(key: key);

  static Route route({required profileModel, required isFromOnBoarding}) =>
      MaterialPageRoute(
        builder: (context) => PersonalPage(
          profileModel: profileModel,
          isFromOnBoarding: isFromOnBoarding ?? false,
        ),
        settings: RouteSettings(name: '/personalPage'),
      );

  @override
  _PersonalPageState createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController phoneController;
  late TextEditingController locationController;
  late TextEditingController emailController;

  bool _isFirstName = true;
  bool _isLastName = true;
  bool _isPhone = true;
  bool _isLocation = true;
  bool _isEmail = true;

  @override
  void initState() {
    super.initState();

    firstNameController =
        TextEditingController(text: widget.profileModel.firstName);
    lastNameController =
        TextEditingController(text: widget.profileModel.lastName);
    phoneController = TextEditingController(text: widget.profileModel.phone);
    locationController =
        TextEditingController(text: widget.profileModel.location);
    emailController = TextEditingController(text: widget.profileModel.email);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return WillPopScope(
      onWillPop: () async {
        if (!widget.isFromOnBoarding) {
          Navigator.pop(context);
        }
        return false;
      },
      child: BasePage(
        title: l10n.personalTitle,
        titleLeading: widget.isFromOnBoarding ? null : BackLeadingButton(),
        floatingActionButton: SelfIssuedCredentialButton(
          selfIssuedCredentialButtonClick: () {
            return SelfIssuedCredentialDataModel(
              givenName: _isFirstName ? firstNameController.text : '',
              familyName: _isLastName ? lastNameController.text : '',
              telephone: _isPhone ? phoneController.text : '',
              address: _isLocation ? locationController.text : '',
              email: _isEmail ? emailController.text : '',
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        titleTrailing: InkWell(
          borderRadius: BorderRadius.circular(8.0),
          onTap: () {
            var model = ProfileModel(
                firstName: firstNameController.text,
                lastName: lastNameController.text,
                phone: phoneController.text,
                location: locationController.text,
                email: emailController.text,
                issuerVerificationSetting:
                    widget.profileModel.issuerVerificationSetting);

            context.read<ProfileCubit>().update(model);
            if (widget.isFromOnBoarding) {
              Navigator.of(context).pushReplacement(CredentialsList.route());
            } else {
              Navigator.of(context).pop();
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 8.0,
            ),
            child: Text(
              l10n.personalSave,
              style: Theme.of(context).textTheme.bodyText1!,
            ),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 32.0,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                l10n.personalSubtitle,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(color: Theme.of(context).colorScheme.subtitle1),
              ),
            ),
            // Center(
            //   child: Container(
            //     width: MediaQuery.of(context).size.width * 0.2,
            //     height: MediaQuery.of(context).size.width * 0.2,
            //     decoration: BoxDecoration(
            //       color: Colors.pink,
            //       borderRadius: BorderRadius.circular(16.0),
            //     ),
            //   ),
            // ),
            const SizedBox(height: 32.0),
            BaseTextField(
              label: l10n.personalFirstName,
              controller: firstNameController,
              icon: Icons.person,
              textCapitalization: TextCapitalization.words,
              prefixIcon: Checkbox(
                value: _isFirstName,
                fillColor: MaterialStateProperty.all(
                    Theme.of(context).colorScheme.secondaryContainer),
                onChanged: (value) {
                  if (value != null && _isFirstName != value) {
                    setState(() {
                      _isFirstName = value;
                    });
                  }
                },
              ),
            ),
            const SizedBox(height: 16.0),
            BaseTextField(
              label: l10n.personalLastName,
              controller: lastNameController,
              icon: Icons.person,
              textCapitalization: TextCapitalization.words,
              prefixIcon: Checkbox(
                value: _isLastName,
                fillColor: MaterialStateProperty.all(
                    Theme.of(context).colorScheme.secondaryContainer),
                onChanged: (value) {
                  if (value != null && _isLastName != value) {
                    setState(() {
                      _isLastName = value;
                    });
                  }
                },
              ),
            ),
            const SizedBox(height: 16.0),
            BaseTextField(
              label: l10n.personalPhone,
              controller: phoneController,
              icon: Icons.phone,
              type: TextInputType.phone,
              prefixIcon: Checkbox(
                value: _isPhone,
                fillColor: MaterialStateProperty.all(
                    Theme.of(context).colorScheme.secondaryContainer),
                onChanged: (value) {
                  if (value != null && _isPhone != value) {
                    setState(() {
                      _isPhone = value;
                    });
                  }
                },
              ),
            ),
            const SizedBox(height: 16.0),
            BaseTextField(
              label: l10n.personalLocation,
              controller: locationController,
              icon: Icons.location_pin,
              textCapitalization: TextCapitalization.words,
              prefixIcon: Checkbox(
                value: _isLocation,
                fillColor: MaterialStateProperty.all(
                    Theme.of(context).colorScheme.secondaryContainer),
                onChanged: (value) {
                  if (value != null && _isLocation != value) {
                    setState(() {
                      _isLocation = value;
                    });
                  }
                },
              ),
            ),
            const SizedBox(height: 16.0),
            BaseTextField(
              label: l10n.personalMail,
              controller: emailController,
              icon: Icons.email,
              type: TextInputType.emailAddress,
              prefixIcon: Checkbox(
                value: _isEmail,
                fillColor: MaterialStateProperty.all(
                    Theme.of(context).colorScheme.secondaryContainer),
                onChanged: (value) {
                  if (value != null && _isEmail != value) {
                    setState(() {
                      _isEmail = value;
                    });
                  }
                },
              ),
            ),
          ],
        ),
        navigation: !widget.isFromOnBoarding
            ? null
            : SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      BaseButton.primary(
                        context: context,
                        textColor: Theme.of(context).colorScheme.onPrimary,
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacement(CredentialsList.route());
                        },
                        child: Text(l10n.personalSkip),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
