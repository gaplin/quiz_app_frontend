// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
      json['text'] as String,
      (json['answers'] as List<dynamic>).map((e) => e as String).toList(),
      json['correctAnswer'] as int,
    );

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'text': instance.text,
      'answers': instance.answers,
      'correctAnswer': instance.correctAnswer,
    };
