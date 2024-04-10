import 'package:awesome_snackbar_content_new/awesome_snackbar_content.dart';
import 'package:awesome_snackbar_content_new/src/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

class SnackMessage extends StatelessWidget {
  const SnackMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MaterialBanner(
              /// need to set following properties for best effect of awesome_snackbar_content_new
              elevation: 0,
              backgroundColor: Colors.transparent,
              forceActionsBelow: true,
              content: AwesomeSnackbarContent(
                title: 'Atención',
                message: 'Parece que no tienes conexión a internet',

                /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                contentType: ContentType.failure,
                // to configure for material banner
                inMaterialBanner: true,
              ),
              actions: const [SizedBox.shrink()],
            )
          ],
        ),
      ),
    );
  }
}
