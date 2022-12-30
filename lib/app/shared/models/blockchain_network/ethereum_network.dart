import 'package:altme/app/app.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ethereum_network.g.dart';

@JsonSerializable()
class EthereumNetwork extends BlockchainNetwork {
  const EthereumNetwork({
    required String networkname,
    required String apiUrl,
    required String rpcNodeUrl,
    required String title,
    required String subTitle,
    required this.chainId,
    required this.chain,
    String apiKey = '',
  }) : super(
          networkname: networkname,
          apiUrl: apiUrl,
          rpcNodeUrl: rpcNodeUrl,
          title: title,
          subTitle: subTitle,
          apiKey: apiKey,
        );

  factory EthereumNetwork.mainNet() => const EthereumNetwork(
        networkname: 'Mainnet',
        apiUrl: Urls.moralisBaseUrl,
        chainId: 1,
        chain: 'eth',
        rpcNodeUrl: 'https://ethereum.publicnode.com',
        title: 'Ethereum Mainnet',
        subTitle:
            'This network is the official Ethereum blockchain running Network.'
            ' You should use this network by default.',
      );

  factory EthereumNetwork.testNet() => const EthereumNetwork(
        networkname: 'Testnet',
        apiUrl: Urls.moralisBaseUrl,
        chain: 'sepolia',
        chainId: 11155111, // Sepolia testnet chainId
        rpcNodeUrl: 'https://rpc.sepolia.dev',
        title: 'Ethereum Testnet (Sepolia)',
        subTitle: 'This network is used to test protocol upgrades'
            ' (do not use it unless you are a developer).',
      );

  factory EthereumNetwork.fromJson(Map<String, dynamic> json) =>
      _$EthereumNetworkFromJson(json);

  final int chainId;
  final String chain;

  @override
  Map<String, dynamic> toJson() => _$EthereumNetworkToJson(this);

  @override
  List<Object?> get props => [super.props, chainId, chain];
}
