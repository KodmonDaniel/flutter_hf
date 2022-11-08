import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_details.g.dart';

@JsonSerializable(ignoreUnannotated: true)
class UserDetails extends Equatable {
  @JsonKey(name: 'username') final String? username;
  @JsonKey(name: 'email') final String? email;
  @JsonKey(name: 'admin') final bool? admin;

  const UserDetails({this.username, this.email, this.admin});

  factory UserDetails.fromJson(Map<String, dynamic> json) => _$UserDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$UserDetailsToJson(this);

  @override
  List<Object?> get props => [username, email, admin];
}