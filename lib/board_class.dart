import 'package:flutter/material.dart';

class SurfBoard {
  SurfBoard({
    this.itemID = " ",
    this.userID = " ",
    this.title = " ",
    this.description = " ",
    this.boardType = " ",
    this.finSetup = " ",
    this.finBrand = " ",
    this.condition = " ",
    this.price = " ",
    this.brand = " ",
    this.itemLink = " ",
    this.localImages,
    this.netImages,
    this.dimensions,
    this.timestamp_millis,
  });

  String itemID;
  String title;
  String userID;
  String boardType = " ";
  String price;
  String brand;
  String description;
  int? timestamp_millis;
  String itemLink;

  List<String>? localImages;
  List<String>? netImages;

  ///may want to change all to string
  var latitude = 0.0;
  var longitude = 0.0;
  String cityName = " ";

  ///this is causing issues may want to change to string
  String condition;
  String finBrand = " ";
  String finSetup = " ";
  Map? dimensions = {
    "lengthFeet": " ",
    "lengthInches": " ",
    "widthInches": " ",
    "widthFrac": " ",
    "thicknessInches": " ",
    "thicknessFrac": " ",
    "volume": " ",
  };

  toJSON() {
    Map<String, String> jret = Map();
    jret["dimensions"] = this.dimensions.toString();
    jret["finSetup"] = this.finSetup;
    jret["finBrand"] = this.finBrand;
    jret["condition"] = this.condition;
    jret["cityName"] = this.cityName;
    jret["longitude"] = this.longitude.toString();
    jret["latitude"] = this.latitude.toString();
    jret["netImages"] = this.netImages.toString();
    jret["localImages"] = this.localImages.toString();
    jret["itemLink"] = this.itemLink.toString();
    jret["timestamp_millis"] = this.timestamp_millis.toString();
    jret["description"] = this.description;
    jret["title"] = this.title;
    jret["price"] = this.price;
    jret["itemUUID"] = this.itemID;
    jret["userID"] = this.userID;
    return jret;
  }
}
