// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_quiz_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateQuizDTO _$CreateQuizDTOFromJson(Map<String, dynamic> json) =>
    CreateQuizDTO(
      json['title'] as String,
      json['category'] as String,
      (json['questions'] as List<dynamic>)
          .map((e) => CreateQuestionDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CreateQuizDTOToJson(CreateQuizDTO instance) =>
    <String, dynamic>{
      'title': instance.title,
      'category': instance.category,
      'questions': instance.questions,
    };
