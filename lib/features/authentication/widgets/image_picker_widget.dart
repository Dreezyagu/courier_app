import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ojembaa_courier/utils/components/colors.dart';
import 'package:ojembaa_courier/utils/components/extensions.dart'; 

class ImagePickerWidget extends StatelessWidget {
  final ImagePicker _imagePicker = ImagePicker();
  final ValueChanged<XFile>? onImageSelected;
  final VoidCallback onCanceled;

  ImagePickerWidget(
      {super.key, this.onImageSelected, required this.onCanceled});
  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: Text(
        'Select an option',
        style: TextStyle(
          color: AppColors.black,
          fontSize: context.width(.04),
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        CupertinoActionSheetAction(
          onPressed: () async {
            await _openCamera();
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Take Photo',
                  style: TextStyle(
                    color: Color(0xFF181818),
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Icon(Icons.camera_alt, color: Color(0xFF007AFF))
              ],
            ),
          ),
        ),
        CupertinoActionSheetAction(
          onPressed: () async {
            await _openGallery();
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Photo Library',
                  style: TextStyle(
                    color: Color(0xFF181818),
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Icon(Icons.content_copy, color: Color(0xFF007AFF))
              ],
            ),
          ),
        )
      ],
      cancelButton: CupertinoActionSheetAction(
        onPressed: () {
          onCanceled();
        },
        child: const Text(
          'Cancel',
          style: TextStyle(color: Color(0xFF007AFF), fontSize: 18),
        ),
      ),
    );
  }

  Future<void> _openGallery() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      onImageSelected?.call(pickedFile);
    }
    onCanceled();
  }

  Future<void> _openCamera() async {
    final pickedFile = await _imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      onImageSelected?.call(pickedFile);
    }
    onCanceled();
  }
}
