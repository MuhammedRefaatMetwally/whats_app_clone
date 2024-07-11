import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:giphy_picker/giphy_picker.dart';

import '../theme/style.dart';

void toast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: tabColor,
      textColor: whiteColor,
      fontSize: 16.0);
}

Future<GiphyGif?> pickGIF(BuildContext context) async {
  GiphyGif? gif;
  try {
    gif = await GiphyPicker.pickGif(
        context: context,
        apiKey: 'Mrbgpy7KDqilcKlmjWyWGFGF0mHzMfc7');
    if (gif != null) {
      toast('GIF selected: ${gif.id}');
    } else {
      toast('No GIF selected');
    }
  } catch (e) {
    toast('Failed to pick GIF: ${e.toString()}');
  }
  return gif;
}
