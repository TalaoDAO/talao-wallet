// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'did_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DIDState _$DIDStateFromJson(Map<String, dynamic> json) => DIDState(
      did: json['did'] as String?,
      message: json['message'] == null
          ? null
          : StateMessage.fromJson(json['message'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DIDStateToJson(DIDState instance) => <String, dynamic>{
      'did': instance.did,
      'message': instance.message,
    };