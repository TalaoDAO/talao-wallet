// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credential_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CredentialModel _$CredentialModelFromJson(Map<String, dynamic> json) =>
    CredentialModel(
      id: CredentialModel.fromJsonId(json['id']),
      alias: json['alias'] as String?,
      image: json['image'] as String?,
      credentialPreview: Credential.fromJson(
          json['credentialPreview'] as Map<String, dynamic>),
      shareLink: json['shareLink'] as String? ?? '',
      display: CredentialModel.fromJsonDisplay(json['display']),
      data: json['data'] as Map<String, dynamic>,
      revocationStatus: $enumDecodeNullable(
              _$RevocationStatusEnumMap, json['revocationStatus']) ??
          RevocationStatus.unknown,
    );

Map<String, dynamic> _$CredentialModelToJson(CredentialModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'alias': instance.alias,
      'image': instance.image,
      'data': instance.data,
      'shareLink': instance.shareLink,
      'credentialPreview': instance.credentialPreview.toJson(),
      'display': instance.display.toJson(),
      'revocationStatus': _$RevocationStatusEnumMap[instance.revocationStatus],
    };

const _$RevocationStatusEnumMap = {
  RevocationStatus.active: 'active',
  RevocationStatus.expired: 'expired',
  RevocationStatus.revoked: 'revoked',
  RevocationStatus.unknown: 'unknown',
};