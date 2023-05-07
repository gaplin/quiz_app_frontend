// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_base.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizBase _$QuizBaseFromJson(Map<String, dynamic> json) => QuizBase(
      json['id'] as String,
      json['title'] as String,
      json['category'] as String,
      json['author'] as String,
      json['numberOfQuestions'] as int,
    );

Map<String, dynamic> _$QuizBaseToJson(QuizBase instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'category': instance.category,
      'author': instance.author,
      'numberOfQuestions': instance.numberOfQuestions,
    };
