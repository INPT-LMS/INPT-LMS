import 'package:flutter/material.dart';
import 'package:lms_flutter/services/exceptions/authentication_exception.dart';
import 'package:lms_flutter/services/exceptions/forbidden_exception.dart';
import 'package:lms_flutter/services/exceptions/network_exception.dart';

showSnackbar(BuildContext context, String texte) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(texte)));
}

showDefaultErrorMessage(BuildContext context, Exception e) {
  if (e is ForbiddenException) {
    showSnackbar(context, "Erreur : vous n'avez pas le droit de faire ceci");
  } else if (e is AuthenticationException)
    showSnackbar(context,
        "Erreur d'authentification : veuillez vous reconnecter et reessayer");
  else if (e is NetworkException)
    showSnackbar(
        context, "Le serveur n'a pas répondu, veuillez ressayer plus tard");
  else
    showSnackbar(
        context, "Une erreur s'est produite, veuillez ressayer plus tard");
}

Future askConfirmation(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Etes-vous sûr de vouloir faire cette action ?'),
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
