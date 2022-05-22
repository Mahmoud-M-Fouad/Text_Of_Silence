import 'package:flutter/material.dart';

import 'package:learning_input_image/learning_input_image.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../uploadVedio/videopicker2.dart';
import 'detecter.dart';
import 'face.dart';

class FaceDetectionPage extends StatefulWidget {
  @override
  _FaceDetectionPageState createState() => _FaceDetectionPageState();
}

class _FaceDetectionPageState extends State<FaceDetectionPage> {
  FaceDetectionState get state => Provider.of(context, listen: false);

  final FaceDetector _detector = FaceDetector(
    mode: FaceDetectorMode.accurate,
    detectLandmark: true,
    detectContour: true,
    enableClassification: true,
    enableTracking: true,
  );

  @override
  void dispose() {

    super.dispose();
    _detector.dispose();
  }

  Future<void> _detectFaces(VideoPlayerController v) async {
    if (state.isNotProcessing) {
      state.startProcessing();
      state.image = v;
      state.data = await _detector.detect(v);
      state.stopProcessing();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(body: VedioPicker2());
      /*InputCameraView(
      title: 'Face Detection',
      onImage: _detectFaces,
      resolutionPreset: ResolutionPreset.high,
      overlay: Consumer<FaceDetectionState>(
        builder: (_, state, __) {
          if (state.isEmpty) {
            return Container();
          }

          Size originalSize = state.size!;
          Size size = MediaQuery.of(context).size;

          // if image source from gallery
          // image display size is scaled to 360x360 with retaining aspect ratio
          if (state.notFromLive) {
            if (originalSize.aspectRatio > 1) {
              size = Size(360.0, 360.0 / originalSize.aspectRatio);
            } else {
              size = Size(360.0 * originalSize.aspectRatio, 360.0);
            }
          }

          return FaceOverlay(
            size: size,
            originalSize: originalSize,
            rotation: state.rotation,
            faces: state.data,
            contourColor: Colors.white.withOpacity(0.8),
            landmarkColor: Colors.lightBlue.withOpacity(0.8),
          );
        },
      ),
    );*/
  }
}

class FaceDetectionState extends ChangeNotifier {
  //InputImage? _image;
  late VideoFormat? formatHint;
  VideoPlayerController? v;
  List<Face> _data = [];
  bool _isProcessing = false;

  VideoPlayerController? get video => v;
  List<Face> get data => _data;

  //String? get type => _image?.type;
  //InputImageRotation? get rotation => _image?.metadata?.rotation;
  //Size? get size => _image?.metadata?.size;

  bool get isNotProcessing => !_isProcessing;
  bool get isEmpty => data.isEmpty;
  bool get isFromLive => formatHint == 'bytes';
  bool get notFromLive => !isFromLive;

  void startProcessing() {
    _isProcessing = true;
    notifyListeners();
  }

  void stopProcessing() {
    _isProcessing = false;
    notifyListeners();
  }

  set image(VideoPlayerController? vv) {
    v = vv;

    if (notFromLive) {
      _data = [];
    }
    notifyListeners();
  }

  set data(List<Face> data) {
    _data = data;
    notifyListeners();
  }
}