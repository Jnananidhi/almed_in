import 'package:flutter/material.dart';


String getCurrentRouteName(BuildContext context) {
  return ModalRoute.of(context)?.settings.name ?? '/';
}