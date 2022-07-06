import 'dart:convert';
import 'package:aplikasi_ongkir/app/data/models/ongkir_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:aplikasi_ongkir/app/data/models/ongkir_model.dart';

class HomeController extends GetxController{
  TextEditingController beratC = TextEditingController();

  List<Ongkir> ongkosKirim = [];

  RxBool isLoading = false.obs;
  RxString provAsalId = "0".obs;
  RxString cityAsalId = "0".obs;
  RxString provTujuanId = "0".obs;
  RxString cityTujuanId = "0".obs;

  RxString codeKurir = "".obs;

  void cekOngkir() async {
    if(provAsalId != "0" &&
       cityAsalId != "0" &&
       provTujuanId != "0" &&
       cityTujuanId != "0" &&
       beratC.text != "" &&
       provAsalId != ""){
        try{
          isLoading.value = true;
          var response = await http
          .post(Uri.parse("https://api.rajaongkir.com/starter/cost"), body: {
            "origin": cityAsalId.value,
            "destination": cityTujuanId.value,
            "weight": beratC.text,
            "courier": codeKurir.value,
          }, headers: {
            "key": "372146ea941c8f928014866aba042c0f",
            "content-type": "application/x-www-form-urlencoded"
          });

          isLoading.value = false;
          List ongkir = json.decode(response.body)['rajaongkir']['results'][0]
          ['costs'] as List;
          ongkosKirim = Ongkir.fromJsonList(ongkir);

          Get.defaultDialog(
            title: "Ongkos Kirim",
            content: Column(
              children: ongkosKirim
              .map((e) => ListTile(
                title: Text('${e.service!.toUpperCase()}'),
                subtitle: Text('Rp. ${e.cost![0].value}'),
              ))
              .toList(),
            ),
          );


        } catch (e){
          print(e);
          Get.defaultDialog(
            title: "Maaf, Terjadi Kesalahan",
            middleText: "Tidak dapat mnegecek ongkos kirim",
          );
        }
      }else{
        Get.defaultDialog(
          title: "Maaf, Terjadi Kesalahan",
          middleText: "Data input kurang lengkap"
        );
      }
  }
}