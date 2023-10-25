import 'package:almed_in/constants.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

import 'package:open_app_file/open_app_file.dart';
import 'package:flutter/material.dart';

import 'custom_button.dart';

class FileUploadButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomButton(
          onPressed: () async {
            var picked = await FilePicker.platform.pickFiles();
            if (picked != null) {
              print(picked.files.first.name);
            }
          }, label: 'Upload file',
        ),
      ],
    );
  }
}
