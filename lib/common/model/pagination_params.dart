import 'package:json_annotation/json_annotation.dart';

part 'pagination_params.g.dart';

@JsonSerializable()
class PaginationParameters {
  final String? after;

  final int? count;

  const PaginationParameters({
    this.after,
    this.count,
  });
  
  factory PaginationParameters.fromJson(Map<String, dynamic> json) => _$PaginationParametersFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationParametersToJson(this);
}
