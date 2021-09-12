import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class Localization {
  static of(BuildContext context) {
    final l = context.read<Localization>();
    l.context = context;
    return l;
  }

  final Map<String, String>? en;
  final Map<String, String>? tr;
  final Map<String, String> _en;
  final Map<String, String> _tr;

  BuildContext? context;

  Localization({
    this.en,
    this.tr,
  })  : _en = {
          "summary": "Summary",
          "definitions": "Definitions",
          "settings": "Settings",
          "general": "General",
          "name": "Name",
          "save": "Save",
          "delete": "Delete",
          "okay": "Okay",
          "cancel": "Cancel",
          "yes": "Yes",
          "no": "No",
          "price": "Price",
          "warning": "Warning",
          "deleting": "Deleting",
          "item_will_be_deleted": "Item will be deleted",
          "pick_a_color": "Pick a color",
        },
        _tr = {
          "summary": "Özet",
          "definitions": "Tanımlar",
          "settings": "Ayarlar",
          "general": "Genel",
          "name": "İsim",
          "save": "Kaydet",
          "delete": "Sil",
          "okay": "Tamam",
          "cancel": "İptal",
          "yes": "Evet",
          "no": "Hayır",
          "price": "Fiyat",
          "warning": "Uyarı",
          "error": "Hata",
          "deleting": "Siliniyor",
          "item_will_be_deleted": "Kayıt silinecek",
          "pick_a_color": "Renk seçin",
        };

  String getString(String key, [BuildContext? context]) {
    final k = key.toLowerCase();
    if (context == null && this.context == null) return k;
    assert(context != null || this.context != null);
    // final lang = Localizations.localeOf(context ?? this.context!).languageCode;
    final lang = Platform.localeName;

    if (lang.contains("en"))
      return en?[k] ?? _en[k] ?? k;
    else if (lang.contains("tr"))
      return tr?[k] ?? _tr[k] ?? k;
    else
      return k;
  }
}

String getStr(BuildContext context, String key) {
  return Localization.of(context).getString(key);
}
