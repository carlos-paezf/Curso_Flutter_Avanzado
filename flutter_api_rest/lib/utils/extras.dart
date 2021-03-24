import 'package:image_picker/image_picker.dart';

class Extras {
  static Future<PickedFile> (bool fromCamera) async {
    final ImagePicker picker = ImagePicker();
    final PickedFile file = (await picker.getImage(
      source: fromCamera ? ImageSource.camera : ImageSource.gallery,
    )) as PickedFile;
    return file;
  }
}
