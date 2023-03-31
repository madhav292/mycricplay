import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mycricplay/general/ImageUploads/FullScreenImage.dart';

class MyImageUploader extends StatefulWidget {
  const MyImageUploader({Key? key}) : super(key: key);

  @override
  _MyImageUploaderState createState() => _MyImageUploaderState();
}

class _MyImageUploaderState extends State<MyImageUploader> {
  List<XFile> _imageFiles = [];

  Future<void> _uploadImages(String imagePath) async {
    final FirebaseStorage storage = FirebaseStorage.instance;
    for (XFile imageFile in _imageFiles) {
      final String fileName = '${DateTime.now()}.jpg';
      final Reference reference = storage.ref(imagePath).child(fileName);
      final UploadTask uploadTask = reference.putFile(File(imageFile.path));
      await uploadTask.whenComplete(() => null);
      final String imageUrl = await reference.getDownloadURL();
      print('Uploaded image URL: $imageUrl');
    }
  }

  Future<void> _pickImages() async {
    final List<XFile> imageFiles =
        await ImagePicker().pickMultiImage(imageQuality: 50);
    setState(() {
      _imageFiles = imageFiles;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Uploader'),
        actions: [Icon(Icons.delete)],
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: GridView.builder(
                itemCount: _imageFiles.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                ),
                itemBuilder: (context, index) {
                  final XFile imageFile = _imageFiles[index];
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FullScreenImage(
                            imageUrl: "https://firebasestorage.googleapis.com/v0/b/cricplay-c5602.appspot.com/o/Grounds%2Fimage_picker_319CB198-9E19-4EE6-B750-2EA11BCC131F-86164-00000385DF2C6995.jpg?alt=media&token=e0df0461-492c-4f87-8d96-6cf159bfbcd4",
                            tag: 'imageTag',
                          ),
                        ),
                      );
                    },
                      onLongPress:(){
                    _imageFiles.removeAt(index);
                    setState(() {

                    });

                  },
                      child: Image.file(File(imageFile.path), fit: BoxFit.cover));
                }),
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            child: const Text('Pick Images'),
            onPressed: _pickImages,
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            child: const Text('Upload Images'),
            onPressed: () => {_uploadImages("Grounds")},
          ),
        ],
      ),
    );
  }
}
