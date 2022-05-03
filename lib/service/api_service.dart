import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../models/ayah_of_the_day.dart';
import '../models/juzz.dart';
import '../models/qari.dart';
import '../models/surah.dart';
import '../models/translation.dart';

class ApiServices {

  final endPointUrl = "http://api.alquran.cloud/v1/surah";
  List<Surah> list = [];
  List<Qari> qarilist = [];

  
  Future<AyaOfTheDay> getAyaOfTheDay() async {
    String url = "https://api.alquran.cloud/v1/ayah/${random(
        1, 6237)}/editions/quran-uthmani,en.asad,en.pickthall";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return AyaOfTheDay.fromJSON(json.decode(response.body));
    } else {
      print("Failed to load");
      throw Exception("Failed  to Load Post");
    }
  }

  random(min, max) {
    var rn = new Random();
    return min + rn.nextInt(max - min);
  }

  Future<List<Surah>> getSurah() async{

    Response res = await http.get(Uri.parse(endPointUrl));
    if(res.statusCode == 200){
      Map<String,dynamic> json = jsonDecode(res.body);
      json['data'].forEach((element){
        if(list.length<114) {
          list.add(Surah.fromJson(element));
        }
      });
      print('ol ${list.length}');
      return list;
    }else{
      throw ("Can't get the Surah");
    }
  }

  Future<JuzModel> getJuzz(int index) async {
    String url = "http://api.alquran.cloud/v1/juz/$index/quran-uthmani";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return JuzModel.fromJSON(json.decode(response.body));
    } else {
      print("Failed to load");
      throw Exception("Failed  to Load Post");
    }
  }

  Future<SurahTranslationList> getTranslation(int index , int translationIndex) async{

    String lan = "";
    if(translationIndex == 0){
      lan = "urdu_junagarhi";
    }else if(translationIndex == 1){
      lan = "hindi_omari";
    }else if(translationIndex == 2){
      lan = "english_saheeh";
    }else if(translationIndex == 3){
      lan = "spanish_garcia";
    }

    final url = "https://quranenc.com/api/translation/sura/$lan/$index";
    var res = await http.get(Uri.parse(url));

    return SurahTranslationList.fromJson(json.decode(res.body));
  }

  Future<List<Qari>> getQariList() async {

    final url = "https://quranicaudio.com/api/qaris";
    final res = await http.get(Uri.parse(url));

    jsonDecode(res.body).forEach((element){
      if(qarilist.length<20) // 20 is not mandatory , you can change it upto 157
        qarilist.add(Qari.fromjson(element));
    });
    qarilist.sort((a,b)=>a.name!.compareTo(b.name!)); // sort according to A B C
    return qarilist;
  }

}
