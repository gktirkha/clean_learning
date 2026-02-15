import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/common/entities/user_entity/user_entity.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel implements UserEntity {
  const factory UserModel({
    required String id,
    required String name,
    required String email,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
