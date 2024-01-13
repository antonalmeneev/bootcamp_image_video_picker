import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

// https://github.com/ponnamkarthik/FlutterImageVideoPickerDemo/blob/master/lib/main.dart

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? _image;
  File? _cameraImage;
  File? _video;
  File? _cameraVideo;

  final ImagePicker picker = ImagePicker();

  VideoPlayerController? _videoPlayerController;
  VideoPlayerController? _cameraVideoPlayerController;

  // This funcion will helps you to pick and Image from Gallery
  _pickImageFromGallery() async {
    ImageSource? source;
    final XFile? pickedFile =
    await picker.pickImage(source: ImageSource.gallery);

    File image = File(pickedFile!.path);

    setState(() {
      _image = image;
    });
  }

  // This funcion will helps you to pick and Image from Camera
  _pickImageFromCamera() async {
    ImageSource? source;
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 50);

    File image = File(pickedFile!.path);

    setState(() {
      _cameraImage = image;
    });
  }

  // This funcion will helps you to pick a Video File
  _pickVideo() async {
    ImageSource? source;
    final XFile? pickedFile = await picker.pickVideo(source: ImageSource.gallery);

    _video = File(pickedFile!.path);

    _videoPlayerController = VideoPlayerController.file(_video as File)
      ..initialize().then((_) {
        setState(() {});
        _videoPlayerController?.play();
      });
  }

  // This funcion will helps you to pick a Video File from Camera
  _pickVideoFromCamera() async {
    ImageSource? source;
    final XFile? pickedFile = await picker.pickVideo(source: ImageSource.camera);

    _cameraVideo = File(pickedFile!.path);

    _cameraVideoPlayerController = VideoPlayerController.file(_cameraVideo as File)
      ..initialize().then((_) {
        setState(() {});
        _cameraVideoPlayerController?.play();
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image / Video Picker"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                if (_image != null)
                  Image.file(_image as File)
                else
                  Text(
                    "Click on Pick Image to select an Image",
                    style: TextStyle(fontSize: 18.0),
                  ),
                ElevatedButton(
                  onPressed: () {
                    _pickImageFromGallery();
                  },
                  child: Text("Pick Image From Gallery"),
                ),
                SizedBox(
                  height: 16.0,
                ),
                if (_cameraImage != null)
                  Image.file(_cameraImage as File)
                else
                  Text(
                    "Click on Pick Image to select an Image",
                    style: TextStyle(fontSize: 18.0),
                  ),
                ElevatedButton(
                  onPressed: () {
                    _pickImageFromCamera();
                  },
                  child: Text("Pick Image From Camera"),
                ),
                if (_video != null)
                  _videoPlayerController!.value.isInitialized
                      ? AspectRatio(
                    aspectRatio: _videoPlayerController!.value.aspectRatio,
                    child: VideoPlayer(_videoPlayerController as VideoPlayerController),
                  )
                      : Container()
                else
                  Text(
                    "Click on Pick Video to select video",
                    style: TextStyle(fontSize: 18.0),
                  ),
                ElevatedButton(
                  onPressed: () {
                    _pickVideo();
                  },
                  child: Text("Pick Video From Gallery"),
                ),
                if (_cameraVideo != null)
                  _cameraVideoPlayerController!.value.isInitialized
                      ? AspectRatio(
                    aspectRatio:
                    _cameraVideoPlayerController!.value.aspectRatio,
                    child: VideoPlayer(_cameraVideoPlayerController as VideoPlayerController),
                  )
                      : Container()
                else
                  Text(
                    "Click on Pick Video to select video",
                    style: TextStyle(fontSize: 18.0),
                  ),
                ElevatedButton(
                  onPressed: () {
                    _pickVideoFromCamera();
                  },
                  child: Text("Pick Video From Camera"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}