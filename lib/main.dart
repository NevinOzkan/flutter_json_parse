import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_json_parse/KisilerCevap.dart';
import 'package:flutter_json_parse/Kisiler.dart';
import 'package:flutter_json_parse/mesajlar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void mesajParse() {
    String stVeri = '{"mesajlar": {"mesaj_kod":1,"mesaj_icerik":"başarılı" } }';

    var jsonVeri = json.decode(stVeri);
    var jsonNesne = jsonVeri["mesajlar"];

    var mesaj = Mesajlar.fromJson(jsonNesne);

    print("Mesaj kod:${mesaj.mesaj_kod}");
    print("Mesaj içerik:${mesaj.mesaj_icerik}");
  }

  void kisilerParse() {
    String strVeri =
        '{"kisiler":[{"kisi_id":"1","kisi_ad":"Ahmet","kisi_tel":"12312312"}'
        ',{"kisi_id":"2","kisi_ad":"Mehmet","kisi_tel":"234234234"}]}';

    var jsonVeri = json.decode(strVeri);

    var jsonArray = jsonVeri["kisiler"] as List;

    List<Kisiler> kisilerListesi = jsonArray
        .map((jsonArrayNesnesi) => Kisiler.fromJson(jsonArrayNesnesi))
        .toList();
    for (var k in kisilerListesi) {
      print("***********");
      print("Kişi id : ${k.kisi_id}");
      print("Kişi ad : ${k.kisi_ad}");
      print("Kişi tel : ${k.kisi_tel}");
    }
  }

  void kisilerCevapParse() {
    String strVeri =
        '{"success":1,"kisiler":[{"kisi_id":"1","kisi_ad":"Ahmet","kisi_tel":"12312312"},'
        '{"kisi_id":"2","kisi_ad":"Mehmet","kisi_tel":"912318212"}]}';

    var jsonVeri = json.decode(strVeri);
    var kisilerCevap = KisilerCevap.fromJson(jsonVeri);
    print("Success : {kisilerCevap.success}");

    List<Kisiler> kisilerListesi = kisilerCevap.kisilerListesi;
    for (var k in kisilerListesi) {
      print("***********");
      print("Kişi id : ${k.kisi_id}");
      print("Kişi ad : ${k.kisi_ad}");
      print("Kişi tel : ${k.kisi_tel}");
    }
  }

  @override
  void initState() {
    super.initState();
    //mesajParse();
    //kisilerParse();
    kisilerCevapParse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
    );
  }
}
