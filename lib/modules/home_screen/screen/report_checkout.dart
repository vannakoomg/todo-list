import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googlemap_ui/config/const/app_colors.dart';
import 'package:googlemap_ui/modules/checkOut/controller/checkout_controller.dart';
import 'package:googlemap_ui/utils/fuction.dart';
import 'package:googlemap_ui/utils/widgets/custom_app.dart';

class ReportCheckOut extends StatefulWidget {
  final String date;
  final String remark;
  final bool hasOrder;
  final double lat;
  final double long;
  final String urlImage;
  const ReportCheckOut({
    super.key,
    required this.date,
    required this.remark,
    required this.hasOrder,
    required this.lat,
    required this.long,
    required this.urlImage,
  });

  @override
  State<ReportCheckOut> createState() => _ReportCheckOutState();
}

class _ReportCheckOutState extends State<ReportCheckOut> {
  final controller = CheckOutController();
  @override
  void initState() {
    controller.hasOrder.value = widget.hasOrder;
    controller.remark.value = widget.remark;
    controller.remarkText.value.text = widget.remark;
    controller.oldHasOrder.value = widget.hasOrder;
    controller.oldRemark.value = widget.remark;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: const CustomAppBar(title: "Detail"),
        body: Obx(
          () => Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(10),
            ),
            margin:
                const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Date",
                          style: Theme.of(context).textTheme.titleSmall!,
                        ),
                        Text(
                          widget.date,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Remark",
                          style: Theme.of(context).textTheme.titleSmall!,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.remark,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                        ),

                        // CustomTextfiled(
                        //   controller: controller.remarkText.value,
                        //   hintText: "Enter Remark",
                        //   onChanged: (value) {
                        //     controller.remark.value = value;
                        //   },
                        //   maxLines: 5,
                        // ),
                        Row(
                          children: [
                            Text(
                              "Has Order",
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            Checkbox(
                              value: controller.hasOrder.value,
                              activeColor: AppColor.successColor,
                              checkColor: Colors.white,
                              onChanged: (value) {
                                // controller.hasOrder.value =
                                //     !controller.hasOrder.value;
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          height: MediaQuery.sizeOf(context).width / 1.8,
                          width: MediaQuery.sizeOf(context).width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                width: 0.4,
                                color: AppColor.secondnaryColor,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              image: DecorationImage(
                                image: imageFromBase64String(
                                    "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"),
                                fit: BoxFit.cover,
                              )),
                        )
                        // GestureDetector(
                        //   onTap: () {
                        //     controller.takePhoto();
                        //   },
                        //   child: Container(
                        //     child: controller.photo.value.path != ""
                        //         ? Stack(
                        //             children: [
                        //               Container(
                        //                 height:
                        //                     MediaQuery.sizeOf(context).width /
                        //                         1.8,
                        //                 width: MediaQuery.sizeOf(context).width,
                        //                 decoration: BoxDecoration(
                        //                   color: Theme.of(context)
                        //                       .colorScheme
                        //                       .background,
                        //                   border: Border.all(
                        //                       color: AppColor.secondnaryColor),
                        //                   borderRadius:
                        //                       BorderRadius.circular(5),
                        //                   image: DecorationImage(
                        //                     image: FileImage(
                        //                         controller.photo.value),
                        //                     fit: BoxFit.cover,
                        //                   ),
                        //                 ),
                        //               ),
                        //               Positioned(
                        //                 right: 5,
                        //                 top: 5,
                        //                 child: GestureDetector(
                        //                   onTap: () {
                        //                     controller.photo.value = File("");
                        //                     debugPrint(
                        //                         "khmer sl khmer ${controller.photo.value.path}");
                        //                   },
                        //                   child: Container(
                        //                     decoration: BoxDecoration(
                        //                       color:
                        //                           Colors.black.withOpacity(0.6),
                        //                       shape: BoxShape.circle,
                        //                     ),
                        //                     height: 25,
                        //                     width: 25,
                        //                     child: const Icon(
                        //                       Icons.close_rounded,
                        //                       size: 18,
                        //                       color: Colors.white,
                        //                     ),
                        //                   ),
                        //                 ),
                        //               )
                        //             ],
                        //           )
                        //         :
                        //          CustomCachedImageCircle(
                        //             height:
                        //                 MediaQuery.sizeOf(context).width / 1.8,
                        //             width: MediaQuery.sizeOf(context).width,
                        //             image: widget.urlImage,
                        //           ),
                        //   ),
                        // ),
                        ,
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${widget.lat}, ${widget.long}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
                                    ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                openGoogleMap(context, widget.lat, widget.long);
                              },
                              child: Text(
                                "View Map",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(color: AppColor.secondnaryColor),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // Container(
                //   margin: const EdgeInsets.only(bottom: 10, top: 10),
                //   child: CustomButtom(
                //     white: double.infinity,
                //     disble: controller.validateUpdate(),
                //     title: "UPDATE",
                //     onTap: () {},
                //   ),
                // ),
              ],
            ),
          ),
        ));
  }
}
