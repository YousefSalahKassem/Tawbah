import 'package:hive/hive.dart';
part 'surah.g.dart';

@HiveType(typeId: 0)

class Surah extends HiveObject{
  @HiveField(0)
  int? number;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? englishName;
  @HiveField(3)
  String? englishNameTranslation;
  @HiveField(4)
  int? numberOfAyahs;
  @HiveField(5)
  String? revelationType;

  Surah({this.number, this.name, this.englishName, this.englishNameTranslation,
    this.numberOfAyahs, this.revelationType});

  factory  Surah.fromJson(Map<String,dynamic> json){
    return Surah(
      number: json['number'],
      name: json['name'],
      englishName: json['englishName'],
      englishNameTranslation: json['englishNameTranslation'],
      numberOfAyahs: json['numberOfAyahs'],
      revelationType: json['revelationType'],
    );
  }
}