import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/utils/app_consts.dart';
import 'package:lms/widgets/custom_text.dart';

class MyResultAndHistory extends StatelessWidget {
  const MyResultAndHistory({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: AppColors.border)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CustomText(
                  text: "Course wise My results & history",
                  color: AppColors.title,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
                const Divider(
                  color: AppColors.title,
                ),
                Table(
                  // textDirection: TextDirection.rtl,
                  // defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
                  border: TableBorder.all(width: 2.0, color: AppColors.border),
                  children: const [
                    TableRow(children: [
                      Text(
                        "Course",
                        textScaleFactor: 1,
                      ),
                      Text("Quize", textScaleFactor: 1),
                      Text("Assig..", textScaleFactor: 1),
                      Text("Total..", textScaleFactor: 1),
                    ]),
                    TableRow(children: [
                      Text("UXD-006", textScaleFactor: 1),
                      Text("88", textScaleFactor: 1),
                      Text("18.6", textScaleFactor: 1),
                      Text("88.186..", textScaleFactor: 1),
                    ]),
                    TableRow(children: [
                      Text("ML-006", textScaleFactor: 1),
                      Text("88 ", textScaleFactor: 1),
                      Text("18.6", textScaleFactor: 1),
                      Text("88.186..", textScaleFactor: 1),
                    ]),
                    TableRow(children: [
                      Text("ML-007 ", textScaleFactor: 1),
                      Text("88", textScaleFactor: 1),
                      Text("18.6", textScaleFactor: 1),
                      Text("88.186..", textScaleFactor: 1),
                    ]),
                    TableRow(children: [
                      Text("ML-008 ", textScaleFactor: 1),
                      Text("88", textScaleFactor: 1),
                      Text("18.6", textScaleFactor: 1),
                      Text("88.186..", textScaleFactor: 1),
                    ]),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    ));
  }
}
