import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:nextbasis_hris/controllers/home_controller.dart';
import 'package:path_provider/path_provider.dart';

class GpsCameraScreen extends StatefulWidget {
  final CameraController cameraController;

  const GpsCameraScreen({super.key, required this.cameraController});

  @override
  State<GpsCameraScreen> createState() => _GpsCameraScreenState();
}

class _GpsCameraScreenState extends State<GpsCameraScreen> {
  Position? currentPosition;

  @override
  void initState() {
    super.initState();
    _updatePosition();
  }

  Future<void> _updatePosition() async {
    try {
      currentPosition = await Geolocator.getCurrentPosition();
      setState(() {});
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to get location: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<XFile> _addOverlayToImage(XFile originalImage) async {
    // Baca file gambar asli
    final File imageFile = File(originalImage.path);
    final img.Image? originalImageDecoded =
        img.decodeImage(await imageFile.readAsBytes());

    if (originalImageDecoded == null) throw Exception('Failed to decode image');

    // Buat teks overlay
    final DateTime now = DateTime.now();
    final String overlayText = '''
    Lat: ${currentPosition?.latitude ?? 'Unknown'}
    Lon: ${currentPosition?.longitude ?? 'Unknown'}
    Time: ${now.toString()}
    ''';

    // Tambahkan teks ke gambar
    img.drawString(
      originalImageDecoded,
      overlayText,
      font: img.arial24,
      x: 20,
      y: originalImageDecoded.height - 100,
      color: img.ColorRgb8(255, 255, 255), // Warna putih
    );

    // Simpan gambar yang sudah dimodifikasi
    final Directory tempDir = await getTemporaryDirectory();
    final String tempPath = '${tempDir.path}/photo_with_overlay.jpg';
    final File tempFile = File(tempPath);
    await tempFile.writeAsBytes(img.encodeJpg(originalImageDecoded));

    return XFile(tempPath);
  }

  @override
  Widget build(BuildContext context) {
    final HomePageController homePageController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text('GPS Camera'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Stack(
        fit: StackFit.expand,
        children: [
          CameraPreview(widget.cameraController),
          Positioned(
            bottom: 20,
            left: 10,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currentPosition != null
                        ? 'Lat: ${currentPosition!.latitude}'
                        : 'Fetching location...',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    currentPosition != null
                        ? 'Lon: ${currentPosition!.longitude}'
                        : 'Fetching location...',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.camera),
        onPressed: () async {
          try {
            await _updatePosition();

            if (currentPosition == null) {
              Get.snackbar(
                'Error',
                'Please enable GPS and try again',
                backgroundColor: Colors.red,
                colorText: Colors.white,
              );
              return;
            }
            final XFile originalImage =
                await widget.cameraController.takePicture();
            final XFile processedImage =
                await _addOverlayToImage(originalImage);

            Get.back(closeOverlays: true);

            await homePageController.checkInOut(
              photo: processedImage,
            );
          } catch (e) {
            Get.snackbar(
              'Error',
              'Failed to capture photo: ${e.toString()}',
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          }
        },
      ),
    );
  }
}
