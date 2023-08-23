
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
enum CropShape {
  square,
  rectangle,
  heart,
}
class _HomeScreenState extends State<HomeScreen> {

  File imageFile=File('') ;
  CropShape selectedCropShape = CropShape.square;
  bool isOrig =false;
  bool isSquare =false;
  bool isCircle =false;
  bool isRect =false;
  double cSize=30;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Add Image/Crop')),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20.0,),
            Container(
              child: const Text("Upload Image",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,

                ),
              ),
            ),
            imageFile == null
                ? Image.asset('assets/img1.jpg', height: 300.0, width: 300.0,)
                : displayImage(imageFile),
            const SizedBox(height: 20.0,),
            ElevatedButton(
              onPressed: () async {
                Map<Permission, PermissionStatus> statuses = await [
                  Permission.storage, Permission.camera,
                ].request();
                if(statuses[Permission.storage]!.isGranted && statuses[Permission.camera]!.isGranted){
                  showImagePicker(context);
                } else {
                  if (kDebugMode) {
                    print('no permission provided');
                  }
                }
              },
              child: const Text('Choice the Device'),
            ),
          ],
        ),
      ),
    );
  }

  final picker = ImagePicker();

  void showImagePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (builder){
          return Card(
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/5.2,
                margin: const EdgeInsets.only(top: 8.0),
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: InkWell(
                          child: Column(
                            children: const [
                              Icon(Icons.image, size: 60.0,),
                              SizedBox(height: 12.0),
                              Text(
                                "Gallery",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16, color: Colors.black),
                              )
                            ],
                          ),
                          onTap: () async{
                            _imgFromGallery() .then(  {
                              await  showDialog(context: (context), builder: (context)=>AlertDialog(
                                content: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,

                                    children: [
                                      Row(
                                        mainAxisAlignment:MainAxisAlignment.end,
                                        children: [
                                          IconButton(onPressed: (){},
                                              icon: const Icon(Icons.clear,
                                                size: 25,
                                              ))],
                                      ),
                                      const Text("Uploaded Image",style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                      const SizedBox(height: 50,),

                                      displayImage(imageFile),

                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:CrossAxisAlignment.center,
                                        children: [
                                          // GestureDetector(
                                          //   child: Container(
                                          //     decoration: BoxDecoration(
                                          //         border: Border.all(
                                          //         ),
                                          //         borderRadius: BorderRadius.circular(10)
                                          //     ),
                                          //     child: Image.file(imageFile),
                                          //   ),
                                          // ),
                                          GestureDetector(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                  ),
                                                  borderRadius: BorderRadius.circular(10)
                                              ),
                                              child:  ElevatedButton(

                                                onPressed: () {  },
                                                child: Center(child: Text('Original',),
                                                ),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            child: Container(
                                              height:cSize,
                                              width: cSize,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                  ),
                                                  borderRadius: BorderRadius.circular(10)
                                              ),
                                              child: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    isSquare=true;
                                                    isCircle=false;
                                                    isRect = false;
                                                  });
                                                },
                                                // child: Image.asset("assets/user_image_frame_2.png")
                                                icon: Center(child: Icon(Icons.square,
                                                    size: cSize*0.5)),

                                              ),

                                            ),
                                          ),
                                          GestureDetector(
                                            child: Container(
                                              height:cSize,
                                              width: cSize,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                  ),
                                                  borderRadius: BorderRadius.circular(10)
                                              ),
                                              child: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    isSquare=false;
                                                    isCircle=true;
                                                    isRect = false;
                                                  });
                                                },
                                                // child: Image.asset("assets/user_image_frame_3.png")
                                                icon: Center(child: Icon(Icons.circle,
                                                    size: cSize*0.5
                                                )),

                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            child: Container(
                                              height:cSize,
                                              width: cSize,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                  ),
                                                  borderRadius: BorderRadius.circular(10)
                                              ),
                                              child:IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    isSquare=false;
                                                    isCircle=false;
                                                    isRect = true;
                                                  });
                                                },
                                                // child: Image.asset("assets/user_image_frame_4.png")
                                                icon: Center(
                                                    child: Icon(Icons.rectangle,
                                                        size: cSize*0.5
                                                    )),

                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 25,),
                                      ElevatedButton(
                                        onPressed: ()
                                        {
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.only(left: 10, top: 15),
                                          width: double.infinity,
                                          height: 45,
                                          // child: Text(widget.text)
                                          child:  const Center(
                                            child: Text("Use this image",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )

                                    ],
                                  ),
                                ),
                              ))
                            });       },
                        )),
                    Expanded(
                        child: InkWell(
                          child: SizedBox(
                            child: Column(
                              children: const [
                                Icon(Icons.camera_alt, size: 60.0,),
                                SizedBox(height: 12.0),
                                Text(
                                  "Camera",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 16, color: Colors.black),
                                )
                              ],
                            ),
                          ),
                          onTap: () {
                            _imgFromCamera();
                            Navigator.pop(context);
                          },
                        ))
                  ],
                )),
          );
        }
    );
  }
  Container displayImage(File img){

    if(isSquare){
      return Container(
        width: 200,
        height: 200,
        child:
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(),
              ),
            ),
            // if (isSquare)
            ClipRRect(
              child: Image.file(
                img,
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      );
    }
    else if(isCircle){
      return  Container(
        height: 200,
        width: 200,
        child:
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.file(
                img,
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      );
    }
    else if(isRect){
      return Container(
        height: 200,
        width: 200,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 500,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                shape: BoxShape.rectangle,
                border: Border.all(),
              ),
            ),
            //if (isRect)
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.file(
                imageFile,
                width: 500,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      );
    }
    return Container(
    );
  }

  _imgFromGallery() async {
    await  picker.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    ).then((value){
      if(value != null){
        _cropImage(File(value.path));
      }
    });
  }

  _imgFromCamera() async {
    await picker.pickImage(
        source: ImageSource.camera, imageQuality: 50
    ).then((value){
      if(value != null){
        _cropImage(File(value.path));
      }
    });
  }

  _cropImage(File imgFile) async {
    CropAspectRatioPreset aspectRatioPreset;
    switch (selectedCropShape) {
      case CropShape.square:
        aspectRatioPreset = CropAspectRatioPreset.square;
        break;
      case CropShape.rectangle:
        aspectRatioPreset = CropAspectRatioPreset.ratio4x3; // Adjust as needed
        break;
      case CropShape.heart:
        aspectRatioPreset = CropAspectRatioPreset.original;
        break;
      default:
        aspectRatioPreset = CropAspectRatioPreset.original;
        break;
    }


    final croppedFile = await ImageCropper().cropImage(

        sourcePath: imgFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ] : [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio5x3,
          CropAspectRatioPreset.ratio5x4,
          CropAspectRatioPreset.ratio7x5,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [AndroidUiSettings(
            toolbarTitle: "Image Cropper",
            toolbarColor: Colors.blue,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),


          IOSUiSettings(
            title: "Image Cropper",
          )
        ]);
    if (croppedFile != null) {

      imageCache.clear();
      setState(() {
        imageFile = File(croppedFile.path);
      });
      // reload();
    }
  }

}

