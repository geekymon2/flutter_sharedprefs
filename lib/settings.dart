import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(nullable: true)
class Settings {
  Settings({this.fontSize, this.isBold, this.isItalics});

  final double fontSize;
  final bool isBold;
  final bool isItalics;

  factory Settings.initial() =>
      Settings(fontSize: 10, isBold: false, isItalics: false);

  Settings copyWith({double fontSize, bool isBold, bool isItalics}) {
    return Settings(
      fontSize: fontSize ?? this.fontSize,
      isBold: isBold ?? this.isBold,
      isItalics: isItalics ?? this.isItalics,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = new Map();
    map["fontSize"] = this.fontSize;
    map["isBold"] = this.isBold;
    map["isItalics"] = this.isItalics;
    return map;
  }

  
}
