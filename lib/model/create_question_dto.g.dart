// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_question_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateQuestionDTO _$CreateQuestionDTOFromJson(Map<String, dynamic> json) =>
    CreateQuestionDTO(
      json['text'] as String,
      (json['answers'] as List<dynamic>).map((e) => e as String).toList(),
      json['correctAnswer'] as int,
    );

Map<String, dynamic> _$CreateQuestionDTOToJson(CreateQuestionDTO instance) =>
    <String, dynamic>{
      'text': instance.text,
      'answers': instance.answers,
      'correctAnswer': instance.correctAnswer,
    };
