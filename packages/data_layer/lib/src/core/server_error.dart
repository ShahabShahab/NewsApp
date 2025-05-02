import 'package:json_annotation/json_annotation.dart';

/// status : "error"
/// code : "maximumResultsReached"
/// message : "You have requested too many results. Developer accounts are limited to a max of 100 results. You are trying to request results 80 to 120. Please upgrade to a paid plan if you need more results."

part 'server_error.g.dart';

@JsonSerializable()
class ServerError {
  ServerError({
    this.status,
    this.code,
    this.message,
  });

  String? status;
  String? code;
  String? message;

  factory ServerError.fromJson(Map<String, dynamic> json) =>
      _$ServerErrorFromJson(json);

  Map<String, dynamic> toJson() => _$ServerErrorToJson(this);
}
