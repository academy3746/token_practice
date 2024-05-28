// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginationParameters _$PaginationParametersFromJson(
        Map<String, dynamic> json) =>
    PaginationParameters(
      after: json['after'] as String?,
      count: (json['count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PaginationParametersToJson(
        PaginationParameters instance) =>
    <String, dynamic>{
      'after': instance.after,
      'count': instance.count,
    };
