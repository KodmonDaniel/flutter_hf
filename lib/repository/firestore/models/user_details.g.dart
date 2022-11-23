// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDetails _$UserDetailsFromJson(Map<String, dynamic> json) => UserDetails(
      username: json['username'] as String?,
      email: json['email'] as String?,
      admin: json['admin'] as bool?,
    );

Map<String, dynamic> _$UserDetailsToJson(UserDetails instance) =>
    <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'admin': instance.admin,
    };
