// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qr_code_scan_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QRCodeScanState _$QRCodeScanStateFromJson(Map<String, dynamic> json) =>
    QRCodeScanState(
      uri: json['uri'] == null ? null : Uri.parse(json['uri'] as String),
      promptActive: json['promptActive'] as bool?,
      isDeepLink: json['isDeepLink'] as bool?,
      message: json['message'] == null
          ? null
          : StateMessage.fromJson(json['message'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$QRCodeScanStateToJson(QRCodeScanState instance) =>
    <String, dynamic>{
      'uri': instance.uri?.toString(),
      'promptActive': instance.promptActive,
      'isDeepLink': instance.isDeepLink,
      'message': instance.message,
    };