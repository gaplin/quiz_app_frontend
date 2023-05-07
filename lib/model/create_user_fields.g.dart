// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_user_fields.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateUserFields _$CreateUserFieldsFromJson(Map<String, dynamic> json) =>
    CreateUserFields(
      json['login'] as String?,
      json['password'] as String?,
      json['userName'] as String?,
    );

Map<String, dynamic> _$CreateUserFieldsToJson(CreateUserFields instance) =>
    <String, dynamic>{
      'login': instance.login,
      'password': instance.password,
      'userName': instance.userName,
    };
