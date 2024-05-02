import 'package:flutter/material.dart';
import 'package:googlemap_ui/utils/widgets/custom_texfiled.dart';

class TotalWidget extends StatelessWidget {
  final double subTotal;
  final double total;
  final Function onchange;
  final TextEditingController contrller;
  const TotalWidget(
      {super.key,
      required this.subTotal,
      required this.total,
      required this.onchange,
      required this.contrller});

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(CreateOrderController());
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSecondary,
        borderRadius: BorderRadius.circular(20),
        // border: Border.all(
        //     // color: AppColor.secondnaryColor,
        //     ),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Row(
            children: [
              Text("SUBTOTAL", style: Theme.of(context).textTheme.bodyMedium!),
              const Spacer(),
              Text(
                "${subTotal.toStringAsFixed(2)} \$",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
          Row(
            children: [
              Text("DISCOUNT", style: Theme.of(context).textTheme.bodyMedium),
              const Spacer(),
              SizedBox(
                width: 80,
                child: CustomTextfiled(
                  onChanged: (value) {
                    onchange(value);
                  },
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.right,
                  controller: contrller,
                  hintText: "",
                  fillColor: Colors.transparent,
                  maxLength: 3,
                  suffixIcon: const Icon(Icons.percent),
                  borderColor: Colors.transparent,
                ),
              )
            ],
          ),
          Row(
            children: [
              Text("TOTAL", style: Theme.of(context).textTheme.bodyMedium),
              const Spacer(),
              Text(
                "${total.toStringAsFixed(2)} \$",
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          )
        ],
      ),
    );
  }
}
