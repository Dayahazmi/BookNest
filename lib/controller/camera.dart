import 'package:camera/camera.dart';

late CameraController _controller;

Future<void> initCamera() async {
  final cameras = await availableCameras();
  final back = cameras.first;
  _controller = CameraController(
    back,
    ResolutionPreset.high,
  );
  await _controller.initialize();
}
