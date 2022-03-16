import 'package:bloc/bloc.dart';
import 'package:talao/app/interop/didkit/didkit.dart';
import 'package:talao/app/interop/secure_storage/secure_storage.dart';
import 'package:talao/app/shared/model/message.dart';
import 'package:logging/logging.dart';
import 'package:talao/did/cubit/did_state.dart';

class DIDCubit extends Cubit<DIDState> {
  final SecureStorageProvider? secureStorageProvider;
  final DIDKitProvider? didKitProvider;

  DIDCubit({this.didKitProvider, this.secureStorageProvider})
      : super(DIDStateDefault(did: ''));

  void load(String did) async {
    final log = Logger('talao-wallet/DID/load');

    try {
      emit(DIDStateWorking());
      await SecureStorageProvider.instance.set(SecureStorageKeys.did, did);
      emit(DIDStateDefault(did: did));
    } catch (e) {
      log.severe('something went wrong', e);

      emit(DIDStateMessage(
          message: StateMessage.error('Failed to load DID. '
              'Check the logs for more information.')));
    }
  }
}
