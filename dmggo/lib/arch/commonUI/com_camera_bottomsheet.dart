import 'package:dmggo/arch/utils/localization/local_fonts.dart';
import 'package:dmggo/arch/utils/localization/local_strings.dart';
import 'package:dmggo/arch/view_model/inspection_log.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class CommonCameraBottomSheet extends StatelessWidget {
  CommonCameraBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: Text(
        strSelectPhoto,
        style: tscwbsn_18b,
      ),
      message: Text(
        strSelectPhotoDesc,
        style: tscwnsn_14b,
      ),
      actions: [
        // CupertinoActionSheetAction(
        //   onPressed: () {},
        //   child: Text(
        //     strGallery,
        //     style: tscwbsn_14b,
        //   ),
        // ),
        CupertinoActionSheetAction(
          onPressed: () {
            context.read<InspectionLog>().openCamera(con: context);
          },
          child: Text(
            strCamera,
            style: tscwbsn_14b,
          ),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        onPressed: () {},
        child: Text(
          strCancel,
          style: tscwbsn_14r,
        ),
      ),
    );
  }
}
