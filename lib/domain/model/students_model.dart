import 'package:freezed_annotation/freezed_annotation.dart';

part 'students_model.freezed.dart';
part 'students_model.g.dart';

@freezed
class Student with _$Student {
  const factory Student({
    @JsonKey(name: '_id') required String id,
    required String name,
    required String ssn,
    required String image,
    required List<String> disabilities,
    @Default('-') String phone,
    @Default('-') String address,
  }) = _Student;


  factory Student.fromJson(Map<String, dynamic> json) => _$StudentFromJson(json);

  factory Student.safeFromJson(Map<String, dynamic> json) {
    final fixedJson = Map<String, dynamic>.from(json);
    if (fixedJson['image'] != null && fixedJson['image'] is String) {
      fixedJson['image'] = (fixedJson['image'] as String)
          .replaceAll('\\', '/')
          .replaceAll('localhost', '10.0.2.2');
    }
    return _$StudentFromJson(fixedJson);
  }

}
