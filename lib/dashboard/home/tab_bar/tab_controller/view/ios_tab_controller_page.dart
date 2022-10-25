import 'package:altme/app/app.dart';
import 'package:altme/dashboard/dashboard.dart';
import 'package:altme/l10n/l10n.dart';
import 'package:altme/wallet/cubit/wallet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// TODO(all): Remove IosTabControllerPage when apple accept our NFT #664, https://github.com/TalaoDAO/AltMe/issues/664
class IosTabControllerPage extends StatelessWidget {
  const IosTabControllerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TabControllerCubit(),
      child: const IosTabControllerView(),
    );
  }
}

class IosTabControllerView extends StatefulWidget {
  const IosTabControllerView({Key? key}) : super(key: key);

  @override
  State<IosTabControllerView> createState() => _IosTabControllerViewState();
}

class _IosTabControllerViewState extends State<IosTabControllerView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 2);
    _tabController.addListener(_onTabChanged);
    super.initState();
  }

  void _onTabChanged() {
    context.read<TabControllerCubit>().setIndex(_tabController.index);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<TabControllerCubit, int>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.spaceSmall),
              child: TabBar(
                controller: _tabController,
                padding:
                    const EdgeInsets.symmetric(horizontal: Sizes.space2XSmall),
                indicatorPadding: EdgeInsets.zero,
                labelPadding:
                    const EdgeInsets.symmetric(horizontal: Sizes.space2XSmall),
                indicatorWeight: 0.0001,
                indicatorColor: Colors.transparent,
                indicatorSize: TabBarIndicatorSize.label,
                tabs: [
                  MyTab(
                    text: l10n.cards,
                    icon:
                        state == 0 ? IconStrings.cards : IconStrings.cardsBlur,
                    isSelected: state == 0,
                    onPressed: () {
                      if (context.read<HomeCubit>().state.homeStatus ==
                          HomeStatus.hasNoWallet) {
                        showDialog<void>(
                          context: context,
                          builder: (_) => const WalletDialog(),
                        );
                        return;
                      }
                      _tabController.animateTo(0);
                      context.read<TabControllerCubit>().setIndex(0);
                    },
                  ),
                  MyTab(
                    text: l10n.tokens,
                    icon: state == 1
                        ? IconStrings.health
                        : IconStrings.healthBlur,
                    isSelected: state == 1,
                    onPressed: () {
                      if (context.read<HomeCubit>().state.homeStatus ==
                          HomeStatus.hasNoWallet) {
                        showDialog<void>(
                          context: context,
                          builder: (_) => const WalletDialog(),
                        );
                        return;
                      }
                      _tabController.animateTo(1);
                      context.read<TabControllerCubit>().setIndex(1);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: Sizes.spaceSmall),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: BlocBuilder<CredentialListCubit, CredentialListState>(
                  builder: (context, credentialListState) {
                    return BlocBuilder<WalletCubit, WalletState>(
                      builder: (context, walletState) {
                        return TabBarView(
                          controller: _tabController,
                          physics: context.read<HomeCubit>().state.homeStatus ==
                                  HomeStatus.hasNoWallet
                              ? const NeverScrollableScrollPhysics()
                              : null,
                          children: [
                            // Display DiscoverPage if user has no wallet or if
                            // he has no credentials except
                            // proofOfOwnershipCredentials
                            if (context.read<HomeCubit>().state.homeStatus ==
                                    HomeStatus.hasNoWallet ||
                                walletState.credentials.length ==
                                    credentialListState
                                        .proofOfOwnershipCredentials.length ||
                                credentialListState
                                    .proofOfOwnershipCredentials.isEmpty)
                              const DiscoverPage()
                            else
                              const CredentialsListPage(),
                            const TokensPage(),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
