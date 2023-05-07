import 'package:json_annotation/json_annotation.dart';

part 'create_user_fields.g.dart';

@JsonSerializable()
class CreateUserFields {
  String? login;
  String? password;
  String? userName;

  CreateUserFields(
    this.login,
    this.password,
    this.userName,
  );

  factory CreateUserFields.fromJson(Map<String, dynamic> json) =>
      _$CreateUserFieldsFromJson(json);

  Map<String, dynamic> toJson() => _$CreateUserFieldsToJson(this);
}
