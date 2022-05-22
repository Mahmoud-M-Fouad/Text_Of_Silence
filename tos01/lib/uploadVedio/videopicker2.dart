import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tflite/tflite.dart';
import 'package:video_player/video_player.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:camera/camera.dart';
import 'package:learning_input_image/learning_input_image.dart';

import '../Provider.dart';
import '../face_detect/detecter.dart';
import '../face_detect/mainFane.dart';

class VedioPicker2 extends StatefulWidget {
  const VedioPicker2({Key? key}) : super(key: key);

  @override
  State<VedioPicker2> createState() => _VedioPicker2State();
}

class _VedioPicker2State extends State<VedioPicker2> {
  FaceDetectionState get state => Provider.of(context, listen: false);

  late VideoPlayerController _videoPlayerController;
  File? _video;
  final ImagePicker _picker = ImagePicker();
  late final XFile? video;

  Future<dynamic> pickVideoGallery()async {
    video = await _picker.pickVideo(source: ImageSource.gallery);
    _video = File(video!.path);
    _videoPlayerController = VideoPlayerController.file(_video!)..initialize().then((_){
      setState(() {

      });
      _videoPlayerController.play();
    });
  }
  Future<dynamic> pickVideoCamera()async {
    video = await _picker.pickVideo(source: ImageSource.camera);
    _video = File(video!.path);
    _videoPlayerController = VideoPlayerController.file(_video!)..initialize().then((_){
      setState(() {

      });
      //FaceDetector().detect(_videoPlayerController);
      _videoPlayerController.play();
    });
  }

  Fetchingvedio(int index) async
  {
    if (index == 0) {
      await pickVideoCamera();
    }
    if (index == 2) {
      await pickVideoGallery();
    }
  }
  var recognitions;
  /*Future<dynamic> readDataFromModel() async {
    recognitions = await Tflite.runModelOnFrame(
      bytesList: video.planes.map((plane) {
        return plane.bytes;
      }).toList(),
      // required
      imageHeight: video.height,
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
  }*/


@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _videoPlayerController = VideoPlayerController.network('https://youtu.be/aAmP-WcI6dg')..initialize()
      .then((_){
        setState(() {

        });
    });
    _videoPlayerController.setLooping(true);
    _videoPlayerController.hasListeners;
  }
  void dispose() async {
    // TODO: implement dispose
    super.dispose();
    _videoPlayerController.dispose();
    await Tflite.close();
  }
  @override
  Widget build(BuildContext context) {
    int indexfetch = Provider.of<MyProvider>(context, listen: true).count;
    return ListView(

      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(_video!=null)
              _videoPlayerController.value.isInitialized ?
              AspectRatio(
                  aspectRatio: _videoPlayerController.value.aspectRatio,
                  child: VideoPlayer(_videoPlayerController)
              ):Container(
                height: 200,
                child: Center(child: CircularProgressIndicator()),
              ),
            VideoProgressIndicator(_videoPlayerController, allowScrubbing: true,
              padding: const EdgeInsets.all(5),

            ),
            IconButton(onPressed: ()
            {
              setState(() {
                _videoPlayerController.value.isPlaying?
                _videoPlayerController.pause():_videoPlayerController.play();

              });
            },
              icon: _videoPlayerController.value.isPlaying?const Icon(Icons.pause,color: Colors.yellow,)
                  :const Icon(Icons.play_arrow,color: Colors.yellow,),),

            SizedBox(height: 50,),
            ElevatedButton(
              onPressed: () async{
                setState(() {
                  pickVideoGallery();
                });
              },
              child:Text("Gallery"),

            ),
            SizedBox(height: 50,),
            ElevatedButton(
              onPressed: () async{
                setState(() {
                  pickVideoCamera();
                });
              },
              child:Text("Camera"),
            ),
            SizedBox(height: 50,),





          ],

        ),
      ],
    );
  }
}

