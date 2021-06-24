import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:lms_flutter/services/exceptions/no_permission_exception.dart';
import 'package:permission_handler/permission_handler.dart';

showSnackbar(BuildContext context, String texte) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(texte)));
}

showDefaultErrorMessage(BuildContext context, int statusCode) {
  switch (statusCode) {
    case 401:
      showSnackbar(context,
          "Erreur d'authentification : veuillez vous reconnecter et reessayer");
      break;
    case 403:
      showSnackbar(context, "Erreur : vous n'avez pas le droit de faire ceci");
      break;
    default:
      showSnackbar(
          context, "Une erreur s'est produite, veuillez ressayer plus tard");
  }
}

Future askConfirmation(BuildContext context,
    {String texte = 'Etes-vous sûr de vouloir faire cette action ?'}) {
  return showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(texte),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              child: const Text('Oui'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Non'),
            )
          ],
        );
      });
}

IconData findIconFromFileType(String mimeType) {
  if (mimeType.startsWith("image"))
    return Icons.image;
  else if (mimeType.startsWith("text"))
    return Icons.text_format;
  else if (mimeType.startsWith("audio"))
    return Icons.music_note;
  else if (mimeType.startsWith("video"))
    return Icons.ondemand_video_outlined;
  else if (mimeType == "application/pdf")
    return Icons.picture_as_pdf;
  else
    return Icons.insert_drive_file;
}

Future<PlatformFile> chooseFile() {
  return Permission.storage.request().then((permissionStatus) {
    if (!permissionStatus.isGranted) throw NoPermissionException();
  }).then((_) => FilePicker.platform
          .pickFiles(allowMultiple: false, withReadStream: true)
          .then((result) {
        if (result == null)
          throw "nothing";
        else if (result.isSinglePick)
          return result.files[0];
        else if (result.files.isEmpty)
          throw "nothing";
        else
          throw "error";
      }));
}
