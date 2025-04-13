import 'package:freezed_annotation/freezed_annotation.dart';

part 'freezed_data_classes.freezed.dart';

@freezed
class LoginObject with _$LoginObject {
  factory LoginObject({
    required String identifier,
    required String password,
    required String organizationId,
  }) = _LoginObject;
}




