import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'board_class.dart';

class AGS {
  static List<String> images_paths = [];
  static List<CameraDescription> cameras = [];
  static List<Widget>? final_board_posts;

  static var bc_data;

  static bool previewRouteSubmitPress = false;

  static SurfBoard state_post_item = SurfBoard(
      itemID: "test_uuid",
      userID: "test_user",
      title: "test item title",
      description: "dest item description",
      boardType: "Shortboard",
      finSetup: "Thruster",
      finBrand: "Future",
      condition: "New",
      price: '240',
      brand: "test surf brand",
      itemLink: "https://example.com",
      localImages: ["https://surftrade.co/testImg"],
      netImages: ["https://surftrade.co/testImg"],
      dimensions: {
        "lengthFeet": "0",
        "lengthInches": "0",
        "widthInches": "0",
        "widthFrac": "0",
        "thicknessInches": "0",
        "thicknessFrac": "0",
        "volume": "0",
      },
      timestamp_millis: 1604334870555);
}
