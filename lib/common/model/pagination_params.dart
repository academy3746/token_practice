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

  factory PaginationParameters.fromJson(Map<String, dynamic> json) {
    return _$PaginationParametersFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PaginationParametersToJson(this);

  PaginationParameters copyWith({
    String? after,
    int? count,
  }) {
    return PaginationParameters(
      after: after ?? this.after,
      count: count ?? this.count,
    );
  }
}
