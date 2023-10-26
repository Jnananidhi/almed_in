import 'package:almed_in/constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';
import 'dart:io';

class UploadFilePage extends StatelessWidget {
  final String uploadUrl = '${api}fileUpload1.php'; // Replace with your PHP script URL

  Future<void> uploadFile(FilePickerResult? pickedFile) async {
    if (pickedFile != null) {
      try {
        var file = pickedFile.files.first;
        var request = http.MultipartRequest('POST', Uri.parse(uploadUrl));
        final Uint8List? fileBytes = await file.bytes; // Convert to non-nullable Uint8List

        request.files.add(http.MultipartFile(
          'file',
          http.ByteStream.fromBytes(fileBytes!),
          file.size,
          filename: file.name,
        ));
        var response = await request.send();

        if (response.statusCode == 200) {
          print('File uploaded successfully');
        } else {
          print('File upload failed with status code ${response.statusCode}');
        }
      } catch (e) {
        print('Error during file upload: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                var pickedFile = await FilePicker.platform.pickFiles();
                uploadFile(pickedFile);
                print(pickedFile?.files.first.name);
              },
              child: Text('Upload File'),
            ),
          ],
        ),
      );
  }
}

