import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'app_gs.dart';
import 'image_view_page.dart';

class Camera_W extends StatefulWidget {
  Camera_W({Key? key, this.cdata}) : super(key:key);
  final List<CameraDescription>? cdata;
  _Camera_WState createState() => _Camera_WState();
}

class _Camera_WState extends State<Camera_W> with
    WidgetsBindingObserver{

  CameraController? controller;
  String? imagePath;


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    print("init camera state set cam data");

    /// Only use back camera for now
    onNewCameraSelected(widget.cdata![0]);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // App state changed before we got the chance to initialize.
    if (controller == null || !controller!.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      controller?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      if (controller != null) {
        onNewCameraSelected(controller!.description);
      }
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _showCameraException(CameraException e) {
    logError(e.code, e.description);
    showInSnackBar('Error: ${e.code}\n${e.description}');
  }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  void showInSnackBar(String message) {
    // ignore: deprecated_member_use
    // _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller!.dispose();
    }
    controller = CameraController(
      cameraDescription,
      ResolutionPreset.medium,
      enableAudio: false,
    );

    // If the controller is updated then update the UI.
    controller!.addListener(() {
      if (mounted) setState(() {});
      if (controller!.value.hasError) {
        showInSnackBar('Camera error ${controller!.value.errorDescription}');
      }
    });

    try {
      await controller!.initialize();
    } on CameraException catch (e) {
      _showCameraException(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  Future<String> takePicture() async {
    if (!controller!.value.isInitialized) {
      showInSnackBar('Error: select a camera first.');
      return "notfound";
    }
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures/SB_Poster';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.jpg';

    AGS.images_paths.add(filePath);

    if (controller!.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return "notfound";
    }

    try {
      await controller!.takePicture(filePath);
    } on CameraException catch (e) {
      _showCameraException(e);
      return "notfound";
    }
    return filePath;
  }

  void onTakePictureButtonPressed() {
    takePicture().then((String filePath) {
      if (mounted) {
        setState(() {
          imagePath = filePath;
        });
        if (filePath != "notfound") showInSnackBar('Picture saved to $filePath');
      }

      Navigator.of(context).push(MaterialPageRoute(builder: (context){
        return Image_View_Page(AGS.images_paths,);
      }));
    });


  }

  /// Returns a suitable camera icon for [direction].
  IconData getCameraLensIcon(CameraLensDirection direction) {
    switch (direction) {
      case CameraLensDirection.back:
        return Icons.camera_rear;
      case CameraLensDirection.front:
        return Icons.camera_front;
      case CameraLensDirection.external:
        return Icons.camera;
    }
    throw ArgumentError('Unknown lens direction');
  }

  void logError(String code, String message) =>
      print('Error: $code\nError Message: $message');

  Widget _cameraPreviewWidget() {
    if (controller == null || !controller!.value.isInitialized) {
      return const Text(
        'Tap a camera',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
        ),
      );
    } else {
      return AspectRatio(
        aspectRatio: controller!.value.aspectRatio,
        child: CameraPreview(controller),
      );
    }
  }

  Widget _captureControlRowWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.camera_alt),
          color: Colors.blue,
          onPressed: controller != null &&
              controller!.value.isInitialized &&
              !controller!.value.isRecordingVideo
              ? onTakePictureButtonPressed
              : (){showInSnackBar("controller null");},
        ),

      ],
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: Column(children:[_cameraPreviewWidget(),
          _captureControlRowWidget()

        ]));
  }
}