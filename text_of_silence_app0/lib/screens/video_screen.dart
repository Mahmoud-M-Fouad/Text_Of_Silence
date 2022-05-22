import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:text_of_silence_app0/screens/prediction_result_screen.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;

import '../theme/theme.dart';

late int Indexvideocolor = 1;

class VideoScreen extends StatefulWidget {
  const VideoScreen({Key? key}) : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen>
    with SingleTickerProviderStateMixin {
  late VideoPlayerController _controllerCamera;
  late VideoPlayerController _controllerGallery;
  //late File _Video = File('C:/Users/A/Desktop/Graduation Team/FlutterApp_TOS/text_of_silence_app0/video/amr.mp4');
  late File _Video = File('amr.mp4');
  late final picker = ImagePicker();
  late final videodete;

  Future _MethodpickVideoCamera() async {
    //_controllerCamera.initialize();
    final XFile? pickedFile =
        await picker.pickVideo(source: ImageSource.camera);
    _Video = File(pickedFile!.path);
    videodete = _controllerCamera = VideoPlayerController.file(_Video)
      ..initialize().then((_) {
        setState(() {});
        _controllerCamera.play();
      });
  }

  Future _MethodpickVideoGallery() async {
    //_controllerGallery.initialize();
    final XFile? pickedFile =
        await picker.pickVideo(source: ImageSource.gallery);
    _Video = File(pickedFile!.path);
    _controllerGallery = VideoPlayerController.file(_Video)
      ..initialize().then((_) {
        setState(() {});
        _controllerGallery.play();
      });
  }

  Future<void> sendVideos(String filename, String url) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    print("1");
    request.fields['create_upload_file'] = 'file_name';
    print(request);

    request.files.add(await http.MultipartFile.fromPath('result', filename.toString()));
    print("2");
    try {
      // Adjust request timeout
      http.StreamedResponse response =
      await request.send().timeout(const Duration(seconds: 30));
      print("3");
      // await request.send().timeout(Duration(minutes: 2));
      if (response.statusCode == 200) {
        print('Success');
      } else {
        print(
            'Request failed with status: ${response.reasonPhrase} ${response.statusCode}.');
        setState(() {
        //  _loadingSpinKit = _connectionError(context);
          print("111");
        });
      }
    } catch (e) {
      print(e);
      setState(() {
       // _loadingSpinKit = _connectionError(context);
      });
    }
  }

  //file = {'file': open('amr.mp4', 'rb')};
  //resp = requests.post(url=url, files=file);
  //print(resp.json());

  Future<Video> createVideos(String title) async {
    print("111111111111111");
    final response = await http.post(
      Uri.parse('http://localhost:8000/video'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',

      },

      body: jsonEncode(<String, String>{
        'Video_title': title,
      }),

    );
    print("222222222222222222222");
    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      print("111111111111111");
      return Video.fromJson(jsonDecode(response.body));

    } else {
      print("33333333333333");
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create Video.');
    }
  }
//*****

  //***
  //-------------
  Future<void> getPredictedText(String url) async {
   /* try {
     // http.Response response = await http.get(url);
      //if (response.body == "") {
      //  setState(() {
      //    _gettingData = true;
      //    getPredictedText(url);
      //    return;
      //  });
      //}
      if (response.statusCode == 200) {
        setState(() {
         // _predictedText = convert.jsonDecode(response.body);
         // _gettingData = false;
        });
      } else {
        print(
            'Request failed with status: ${response.reasonPhrase} ${response.statusCode}.');
        setState(() {
         // _loadingSpinKit = _connectionError(context);
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        //_loadingSpinKit = _connectionError(context);
      });
    }*/
  }
  @override
  void initState() {
    // TODO: implement initState
    _controllerCamera = VideoPlayerController.asset('video/amr.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
    _controllerGallery = VideoPlayerController.asset('video/amr.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controllerCamera.dispose();
    _controllerGallery.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, theme, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
          theme: theme.getTheme(),
          home:DefaultTabController(
            length: 2,
            child: Scaffold(
              key: const ValueKey<String>('home_page'),
              appBar: AppBar(
                title: const Text('Text Of Silence'),
                centerTitle: true,
                actions: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          if(theme.getTheme()==theme.darkTheme) {
                            theme.setLightMode();
                          }
                          else
                          {
                            theme.setDarkMode();
                          }
                        });
                      }, icon: (theme.getTheme()==theme.darkTheme)?const Icon(Icons.wb_sunny_outlined):
                  const Icon(Icons.nightlight_round)
                  ),
                ],
                bottom: const TabBar(
                  isScrollable: true,

                  tabs: <Widget>[
                    Tab(icon: Icon(Icons.camera_alt_outlined), text: 'Camera'),
                    Tab(icon: Icon(Icons.create_new_folder), text: 'Gallery'),
                    //Tab(icon: Icon(Icons.list), text: 'List example'),
                  ],
                ),
              ),
              body: TabBarView(
                children: <Widget>[
                  ListView(
                    children: [
                      Column(
                        children: <Widget>[
                          Container(padding: const EdgeInsets.only(top: 20.0)),
                          const Text('With Camera mp4'),
                          const SizedBox(
                            height: 10,
                          ),

                          FloatingActionButton(
                            backgroundColor:theme.getTheme()==theme.darkTheme?
                          Colors.black54:Colors.white70,
                            child: theme.getTheme()==theme.darkTheme?
                            const Icon(Icons.video_call_outlined, size: 25,color: Colors.white,):
                            const Icon(Icons.video_call_outlined, size: 25,color: Colors.black,),
                              onPressed: (){
                                setState(() {
                                  _MethodpickVideoCamera();
                                });
                              }
                              ),
                          Container(
                            height: 500,
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            child: AspectRatio(

                              aspectRatio: _controllerCamera.value.aspectRatio,
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: <Widget>[
                                  VideoPlayer(_controllerCamera),
                                  ClosedCaption(
                                      text: _controllerCamera.value.caption.text),
                                  _ControlsOverlay(controller: _controllerCamera),
                                  VideoProgressIndicator(_controllerCamera,
                                      allowScrubbing: true),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Divider(
                            height: 5,
                            color: Colors.teal,
                          ),
                          Text(_Video.toString())
                        ],
                      ),
                    ],
                  ),
                  ListView(
                    children: [
                      Column(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.only(top: 20.0),
                          ),
                          const Text('With Gallery mp4'),
                          const SizedBox(
                            height: 10,
                          ),
                          FloatingActionButton(
                              backgroundColor:theme.getTheme()==theme.darkTheme?
                              Colors.black54:Colors.white70,
                              child: theme.getTheme()==theme.darkTheme?
                              const Icon(Icons.video_call_outlined, size: 25,color: Colors.white,):
                              const Icon(Icons.video_call_outlined, size: 25,color: Colors.black,),
                              onPressed: (){
                                setState(() {
                                  _MethodpickVideoGallery();
                                });
                              }
                          ),
                          Container(
                            height: 500,
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            child: AspectRatio(
                              aspectRatio: _controllerGallery.value.aspectRatio,
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: <Widget>[
                                  VideoPlayer(_controllerGallery),
                                  _ControlsOverlay(controller: _controllerGallery),
                                  ClosedCaption(
                                      text: _controllerGallery.value.caption.text),
                                  VideoProgressIndicator(_controllerGallery,
                                      allowScrubbing: true),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Divider(
                            height: 5,
                            color: Colors.teal,
                          ),
                          Text(_Video.toString()),
                          const Divider(
                            height: 5,
                            color: Colors.teal,
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              floatingActionButton: FloatingActionButton(
                elevation: 4.0,
                child: const Icon(
                  Icons.title,
                ),
                onPressed: () {
                  createVideos(_Video.path);
                 //
                  // get Text
                }
                ),
              ),
            ),
          )
    );

  }
}
//--------------------------------------------------------------

//--------------------------------------------------------------
class _ControlsOverlay extends StatelessWidget {
  const _ControlsOverlay({Key? key, required this.controller})
      : super(key: key);

  static const List<Duration> _exampleCaptionOffsets = <Duration>[
    Duration(seconds: -10),
    Duration(seconds: -3),
    Duration(seconds: -1, milliseconds: -500),
    Duration(milliseconds: -250),
    Duration(milliseconds: 0),
    Duration(milliseconds: 250),
    Duration(seconds: 1, milliseconds: 500),
    Duration(seconds: 3),
    Duration(seconds: 10),
  ];
  static const List<double> _examplePlaybackRates = <double>[
    0.25,
    0.5,
    1.0,
    1.5,
    2.0,
    3.0,
    5.0,
    10.0,
  ];

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 50),
          reverseDuration: const Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? const SizedBox.shrink()
              : Container(
                  color: Colors.black26,
                  child: const Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 100.0,
                      semanticLabel: 'Play',
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            controller.value.isPlaying ? controller.pause() : controller.play();
          },
        ),
        Align(
          alignment: Alignment.topLeft,
          child: PopupMenuButton<Duration>(
            initialValue: controller.value.captionOffset,
            tooltip: 'Caption Offset',
            onSelected: (Duration delay) {
              controller.setCaptionOffset(delay);
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuItem<Duration>>[
                for (final Duration offsetDuration in _exampleCaptionOffsets)
                  PopupMenuItem<Duration>(
                    value: offsetDuration,
                    child: Text('${offsetDuration.inMilliseconds}ms'),
                  )
              ];
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                // Using less vertical padding as the text is also longer
                // horizontally, so it feels like it would need more spacing
                // horizontally (matching the aspect ratio of the video).
                vertical: 12,
                horizontal: 16,
              ),
              child: Text('${controller.value.captionOffset.inMilliseconds}ms'),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: PopupMenuButton<double>(
            initialValue: controller.value.playbackSpeed,
            tooltip: 'Playback speed',
            onSelected: (double speed) {
              controller.setPlaybackSpeed(speed);
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuItem<double>>[
                for (final double speed in _examplePlaybackRates)
                  PopupMenuItem<double>(
                    value: speed,
                    child: Text('${speed}x'),
                  )
              ];
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                // Using less vertical padding as the text is also longer
                // horizontally, so it feels like it would need more spacing
                // horizontally (matching the aspect ratio of the video).
                vertical: 12,
                horizontal: 16,
              ),
              child: Text('${controller.value.playbackSpeed}x'),
            ),
          ),
        ),
      ],
    );
  }
}
//--------------------------------------------------------------
class Video {
  final String Video_title;
  const Video({ required this.Video_title});

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      Video_title: json['Video_title'],
    );
  }
}