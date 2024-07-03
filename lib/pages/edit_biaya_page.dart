import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:magang_flutter/common/app_color.dart';
import 'package:magang_flutter/widgets/build_button.dart';
import 'package:magang_flutter/widgets/build_test_appbar.dart';
import 'package:magang_flutter/widgets/build_text_field.dart';

class EditBiayaPage extends StatefulWidget {
  const EditBiayaPage({super.key});

  @override
  State<EditBiayaPage> createState() => _EditBiayaPageState();
}

class _EditBiayaPageState extends State<EditBiayaPage> {
  final List<File> _images = [];
  final picker = ImagePicker();

  Future<void> getImageGallery() async {
    try {
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      if (pickedFile != null) {
        setState(() {
          _images.add(File(pickedFile.path));
        });
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: const BuildTestAppbar(title: 'Edit Biaya'),
    body: Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ListView(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const BuildTextField(
                        title: 'Amount',
                        required: true,
                      ),
                      Text(
                        'Unggah Foto',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColor.textBody,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: GestureDetector(
                          onTap: getImageGallery,
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(12),
                            dashPattern: const [5],
                            strokeWidth: 1,
                            color: AppColor.textBody,
                            padding: const EdgeInsets.all(06),
                            child: SizedBox(
                              height: 129,
                              width: double.infinity,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.image,
                                    size: 40,
                                    color: AppColor.textBody,
                                  ),
                                  Text(
                                    'Upload foto',
                                    style: TextStyle(
                                      color: AppColor.textBody,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      decoration: TextDecoration.underline,
                                      decorationColor: AppColor.textBody,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (_images.isNotEmpty)
                        Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: _images.map((image) {
                            return Stack(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(right: 11, top: 11),
                                  height: 71,
                                  width: 71,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.file(
                                      image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _images.remove(image);
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(1),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Icon(
                                        Icons.cancel,
                                        color: AppColor.decline,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              BuildButton(
                context: context,
                title: 'Update',
                onPressed: () {},
              ),
              const SizedBox(height: 16,),
              BuildButton(
                context: context,
                title: 'Batal',
                onPressed: () {},
                width: double.infinity,
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                borderColor: AppColor.textBody,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
}