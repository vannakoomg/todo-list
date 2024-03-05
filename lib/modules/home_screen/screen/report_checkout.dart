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
                const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
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
                          height: 20,
                        ),
                        Text(
                          "Remark",
                          style: Theme.of(context).textTheme.titleSmall!,
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
                                  widget.urlImage,
                                ),
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
                                openGoogleMap(
                                  lat: widget.lat,
                                  lng: widget.long,
                                  context: context,
                                  title: "",
                                );
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
