import 'dart:io';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'package:video_player/video_player.dart';
import 'package:file_picker/file_picker.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart' as p;

import '../Provider.dart';


class VideoCapture extends StatefulWidget {
  const VideoCapture({Key? key}) : super(key: key);

  @override
  State<VideoCapture> createState() => _VideoCaptureState();
}

class _VideoCaptureState extends State<VideoCapture> {

  final ImagePicker p = ImagePicker();
  File ?pickImg;
  PickedFile? pickedFile;
  late VideoPlayerController _cameraVideoPlayerController;
  late CameraController _cameraPlayerController;
  late final result;

  Future<File?> pickFile() async {
    result = await FilePicker.platform.pickFiles(type: FileType.video);
    if (result == null)
      return null;
    return File(result.files.single.path.toString());
  }

  Future<File?> pickFile2() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.video,

    );
    if (result == null)
      return null;
    return File(result.files.single.path.toString());
  }


  FetchvedioFromGallery() async {
    final XFile? img = await p.pickVideo(source: ImageSource.gallery);
    if (img == null) return null;
    setState(() {
      //pickImg ==null? null:File(img.path);
      pickImg = File(img.path);
    });
  }

  FetchvedioFromCamera() async {
    late VideoPlayerController _videoPlayerController;
    Future<void> videoCatch;
    final XFile? img = await p.pickVideo(source: ImageSource.camera);
    if (img == null) return null;

    setState(() {
      //pickImg ==null? null:File(img.path);
      pickImg = File(img.path);
      _videoPlayerController = VideoPlayerController.file(pickImg!)
        ..initialize().then((_) {
          setState(() {});
          videoCatch = _videoPlayerController.play();
        });
      //img.
    });
  }

  Fetchingvedio(int index) async
  {
    if (index == 0) {
      await FetchvedioFromCamera();
    }
    if (index == 2) {
      await FetchvedioFromGallery();
    }
  }

  FetchvedioFromGallery2() async {
    File _video;
    final picker = ImagePicker();
    _pickVideo() async {
      pickedFile = await picker.getVideo(source: ImageSource.gallery);
      _video = File(pickedFile!.path);
      _cameraVideoPlayerController = VideoPlayerController.file(_video)
        ..initialize().then((_) {
          setState(() {});
          _cameraVideoPlayerController.play();
        });
    }
  }

  FetchvedioFromCamera2() async {
    print("Emad");
    File _video;
    final picker = ImagePicker();
    _pickVideo() async {
      pickedFile =
      (await picker.pickVideo(source: ImageSource.camera)) as PickedFile?;
      _video = File(pickedFile!.path);
      _cameraVideoPlayerController = VideoPlayerController.file(_video)
        ..initialize().then((_) {
          setState(() {});
          _cameraVideoPlayerController.play();
        });
    }
  }

  Fetchingvedio2(int index) async
  {
    if (index == 0) {
      print("Omda");
      await FetchvedioFromCamera2();
    }
    if (index == 2) {
      await FetchvedioFromGallery2();
    }
  }


  Widget CheckMethod(String valueVedio, bool val) {
    return CheckboxListTile(
      checkColor: Colors.white,
      activeColor: Colors.black,
      value: val,
      onChanged: (v) {
        setState(() {
          val == false ? true : false;
        });
      },
      title: Text(valueVedio),

    );
  }

  String res = '';

  Future<void> FunctionLoadModel() async
  {
    Tflite.close();
    res = (await Tflite.loadModel(
        model: "assets/tflite/model.tflite",
        numThreads: 1,
        // defaults to 1
        isAsset: true,
        // defaults to true, set to false to load resources outside assets
        useGpuDelegate: false // defaults to false, set to true to use GPU delegate
    ))!;
  }
  var recognitions;
  Future<dynamic> readDataFromModel() async {
    recognitions = await Tflite.runModelOnFrame(
        bytesList: result.planes.map((plane) {
          return plane.bytes;
        }).toList(),
        // required
        imageHeight: result.height,
        imageWidth: result.width,
        imageMean: 127.5,
        // defaults to 127.5
        imageStd: 127.5,
        // defaults to 127.5
        rotation: 90,
        // defaults to 90, Android only
        numResults: 2,
        // defaults to 5
        threshold: 0.1,
        // defaults to 0.1
        asynch: true,
      // defaults to true
    );
  }

 /* uploadvedio()
  {
    FirebaseStorage storage = FirebaseStorage(strorageBucket:'gs://tos00-d4aef.appspot.com/');
    DeprecatedStorageInfo.TEMPORARY
    }*/
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cameraVideoPlayerController = VideoPlayerController.file(new File(""))
      ..initialize().then((value) {
        _cameraVideoPlayerController.play();
        setState(() {

        });
      });
  }

  void dispose() async {
    // TODO: implement dispose
    super.dispose();
    _cameraVideoPlayerController.dispose();
    await Tflite.close();
  }

  @override
  Widget build(BuildContext context) {
    int indexfetch = Provider
        .of<MyProvider>(context, listen: true)
        .count;
    return Scaffold(
      appBar: AppBar(centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text('widget.title'),
      ),
      body: ListView(
        children: [
          Column(
            children: [

              ElevatedButton(onPressed: () async {
                final file = await pickFile();
                if (file == null)
                  return;
                else {
                  _cameraVideoPlayerController =
                  VideoPlayerController.file(file)
                    ..initialize().then((_) {
                      _cameraVideoPlayerController.play();

                      setState(() {
                      });
                    });
                }
              }, child: Text("Pick a File")),
              Center(
                child: _cameraVideoPlayerController.value.isInitialized ?
                AspectRatio(aspectRatio: _cameraVideoPlayerController.value
                    .aspectRatio,
                  child: VideoPlayer(_cameraVideoPlayerController),)
                    : Container(),
              ),
              const SizedBox(height: 50,),
              /*-Center(
                child: _cameraVideoPlayerController.value.isInitialized?
                AspectRatio(aspectRatio: _cameraVideoPlayerController.value.aspectRatio, child: CameraPreview(_cameraPlayerController),)
                    : Container(),
              ),*/
              const SizedBox(height: 50,),
              ElevatedButton(
                child: Icon(Icons.pause_outlined),
                onPressed: () {
                  _cameraVideoPlayerController.pause();
                },),
              const SizedBox(height: 50,),
              ElevatedButton(
                child: Icon(Icons.play_circle_fill),
                onPressed: () {
                  _cameraVideoPlayerController.play();
                },),
              const SizedBox(height: 50,),
              Center(
                child:Text(recognitions.toString()),
              ),
              const SizedBox(height: 50,),
              ElevatedButton(
                child: Icon(Icons.delete),
                onPressed: () {
                  _cameraVideoPlayerController.initialize();
                  _cameraVideoPlayerController.dispose();

                },),
              const SizedBox(height: 50,),


            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        onPressed: () {
          setState(() {
            Fetchingvedio2(indexfetch);
            print(indexfetch);
          });
        },
        tooltip: 'Choosing Video',
        child: const Icon(Icons.photo_camera_front, size: 30,),
      ),
    );

  }


}


