import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mycricplay/general/ImageUploads/AppFeature.dart';
import 'package:mycricplay/general/ImageUploads/ImageUploadUtil.dart';

class ImageWidget extends StatelessWidget {
  String imageUrl = '';
  String imageUploadPath = '';
  AppFeature appFeature;
  bool doImageCrop;
  ImageWidget(
      {Key? key,
      required this.imageUrl,
      required this.appFeature,
      required this.doImageCrop,
      required this.imageUploadPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future showPicker(context) async {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext bc) {
            ImageUploadUtil imageUploadUtil = ImageUploadUtil(
                imageUploadPath: imageUploadPath,
                doImageCrop: doImageCrop,
                appFeature: appFeature);
            return SafeArea(
              child: Wrap(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Upload image from',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: const Text('Gallery'),
                      onTap: () async {
                        imageUploadUtil.imgFromGallery();

                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: const Text('Camera'),
                    onTap: () {
                      imageUploadUtil.imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                  const Divider(
                    color: Colors.black,
                  ),
                  ListTile(
                      leading: const Icon(Icons.delete),
                      title: const Text('Remove'),
                      onTap: () {
                        imageUploadUtil.removeImage(imageUrl);
                        Navigator.of(context).pop();
                      }),
                ],
              ),
            );
          });
    }

    return Column(
      children: <Widget>[
        const SizedBox(
          height: 10,
        ),
        GestureDetector(
          child: Column(
            children: [
              imageUrl != ''
                  ? CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      width: 800,
                      height: 250,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                    )
                  : Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(50)),
                      width: 600,
                      height: 240,
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.grey[800],
                      ),
                    ),
            ],
          ),
          onTap: () async {
            showPicker(context);
          },
        )
      ],
    );
  }
}
