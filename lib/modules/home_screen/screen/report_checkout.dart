import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googlemap_ui/config/const/app_colors.dart';
import 'package:googlemap_ui/modules/checkOut/controller/checkout_controller.dart';
import 'package:googlemap_ui/utils/fuction.dart';
import 'package:googlemap_ui/utils/widgets/custom_app.dart';
import 'package:googlemap_ui/utils/widgets/custom_buttom.dart';
import 'package:googlemap_ui/utils/widgets/custom_cache_network_image.dart';
import 'package:googlemap_ui/utils/widgets/custom_texfiled.dart';

class ReportCheckOut extends StatefulWidget {
  final String date;
  final String remark;
  final bool hasOrder;
  final double lat;
  final double long;
  final String urlImage;
  final int routeId;
  final int checkInId;
  const ReportCheckOut({
    super.key,
    required this.date,
    required this.remark,
    required this.hasOrder,
    required this.lat,
    required this.long,
    required this.urlImage,
    required this.routeId,
    required this.checkInId,
  });

  @override
  State<ReportCheckOut> createState() => _ReportCheckOutState();
}

class _ReportCheckOutState extends State<ReportCheckOut> {
  final controller = CheckOutController();
  @override
  void initState() {
    controller.hasOrder.value = widget.hasOrder;
    controller.remarkText.value.text = widget.remark;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: const CustomAppBar(title: "Detail"),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Date:",
                  style: Theme.of(context).textTheme.titleSmall!,
                ),
                Text(
                  widget.date,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
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
                CustomTextfiled(
                  controller: controller.remarkText.value,
                  hintText: "Enter Remark",
                  onChanged: (value) {
                    controller.remark.value = value;
                  },
                  maxLines: 5,
                ),
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
                      onChanged: (bool? value) {
                        controller.hasOrder.value = value!;
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                CustomCachedImageCircle(
                  borderRadius: BorderRadius.circular(0),
                  height: 200,
                  width: 400,
                  image: widget.urlImage,
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${widget.lat}, ${widget.long}",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Theme.of(context).colorScheme.onSecondary,
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
            )),
            Container(
              margin: const EdgeInsets.only(bottom: 10, top: 10),
              child: Row(
                children: [
                  Expanded(
                    child: CustomButtom(
                      textColors: AppColor.secondnaryColor,
                      title: "UPDATE",
                      onTap: () {},
                      colors: Colors.transparent,
                      borderColor: AppColor.secondnaryColor,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: CustomButtom(title: "CHECK IN", onTap: () {})),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
