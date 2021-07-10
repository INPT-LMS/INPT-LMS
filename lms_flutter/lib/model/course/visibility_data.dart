import 'package:json_annotation/json_annotation.dart';

part 'visibility_data.g.dart';

@JsonSerializable()
class Visibility {
  int visibilityID;
  String name;

  Visibility(this.visibilityID, this.name);

  factory Visibility.fromJson(Map<String, dynamic> json) =>
      _$VisibilityFromJson(json);

  Map<String, dynamic> toJson() => _$VisibilityToJson(this);
}
