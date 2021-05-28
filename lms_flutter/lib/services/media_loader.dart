import 'package:image_picker/image_picker.dart';

class MediaLoader {

  final picker = ImagePicker();

    getImage() {
    var  path ;
    picker.getImage(source: ImageSource.gallery)
        .then((value) => {
        print(value.path)
        });

  }

}