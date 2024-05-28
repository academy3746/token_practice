import 'package:json_annotation/json_annotation.dart';

part 'cursor_pagination_model.g.dart';

abstract class CursorPaginationBase {}

/// 에러 처리
class CursorPaginationError extends CursorPaginationBase {
  final String message;

  CursorPaginationError({required this.message});
}

class CursorPaginationIsLoading extends CursorPaginationBase {}

@JsonSerializable(
  genericArgumentFactories: true,
)
class CursorPaginationModel<T> extends CursorPaginationBase {
  final CursorPaginationMeta meta;

  final List<T> data;

  CursorPaginationModel({
    required this.meta,
    required this.data,
  });

  factory CursorPaginationModel.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) {
    return _$CursorPaginationModelFromJson(
      json,
      fromJsonT,
    );
  }
}

@JsonSerializable()
class CursorPaginationMeta {
  final int? count;

  final bool? hasMore;

  CursorPaginationMeta({
    this.count,
    this.hasMore,
  });

  factory CursorPaginationMeta.fromJson(Map<String, dynamic> json) =>
      _$CursorPaginationMetaFromJson(json);
}

/// 페이지 새로고침
class CursorPaginationReload<T> extends CursorPaginationModel<T> {
  CursorPaginationReload({
    required super.meta,
    required super.data,
  });
}

/// 데이터 더 불러오기
class CursorPaginationMore<T> extends CursorPaginationModel<T> {
  CursorPaginationMore({
    required super.meta,
    required super.data,
  });
}
