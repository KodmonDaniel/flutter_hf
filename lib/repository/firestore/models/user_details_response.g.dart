// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDetailsResponse _$UserDetailsFromJson(Map<String, dynamic> json) => UserDetailsResponse(
      username: json['username'] as String?,
      email: json['email'] as String?,
      admin: json['admin'] as bool?,
    );

Map<String, dynamic> _$UserDetailsToJson(UserDetailsResponse instance) =>
    <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'admin': instance.admin,
    };
