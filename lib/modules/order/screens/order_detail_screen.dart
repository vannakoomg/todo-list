import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:googlemap_ui/config/const/app_colors.dart';
import 'package:googlemap_ui/modules/order/controller/create_order_controller.dart';
import 'package:googlemap_ui/modules/order/models/custom_address_model.dart';
import 'package:googlemap_ui/modules/order/widgets/total_widget.dart';
import 'package:googlemap_ui/utils/fuction.dart';
import 'package:googlemap_ui/utils/widgets/custom_app.dart';
import 'package:googlemap_ui/utils/widgets/custom_buttom.dart';
import 'package:googlemap_ui/utils/widgets/custom_loading.dart';
import 'package:googlemap_ui/utils/widgets/custom_order_card.dart';
import 'package:googlemap_ui/utils/widgets/custom_search_selecte.dart';
import 'package:googlemap_ui/utils/widgets/custom_texfiled.dart';

import '../models/customer_model.dart';
import '../models/product_model.dart';

class OrderDetailScreen extends StatefulWidget {
  final int id;
  final String status;
  const OrderDetailScreen({super.key, required this.id, required this.status});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  final controller = CreateOrderController();
  @override
  void initState() {
    controller.fetchOrderDetail(widget.id).then((value) {
      controller.fetchProduct('').then((value) {
        controller.fetchCustomer('');
      });
    });
    controller.deliverDate.value = formatDate(DateTime.now());
    controller.orderDate.value = formatDate(DateTime.now());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: const CustomAppBar(
        title: "Order Detail",
      ),
      body: Obx(
        () => SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: CustomOrderCard(
                                  title: "Order Date",
                                  value: controller.orderDate.value,
                                  ontap: () {},
                                ),
                              ),
                              const Gap(10),
                              Expanded(
                                  child: CustomOrderCard(
                                ontap: () async {
                                  controller.selectDeliveryDate(context);
                                },
                                title: "Delivery Date",
                                value: controller.deliverDate.value,
                              ))
                            ],
                          ),
                          const Gap(20),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Customer",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSecondary,
                                          ),
                                    ),
                                    TypeAheadField<OrderCustomer?>(
                                      controller: TextEditingController(
                                        text: controller.customName.value,
                                      ),
                                      emptyBuilder: (context) => Container(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                          'Not found!',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(color: AppColor.danger),
                                        ),
                                      ),
                                      suggestionsCallback: (pattern) async {
                                        return controller
                                            .getSuggestions(pattern);
                                      },
                                      builder:
                                          (context, controller1, focusNode) {
                                        return CustomTextfiled(
                                          onChanged: (value) {
                                            debugPrint("dsfdsfsd");
                                            controller.fetchCustomer(value);
                                          },
                                          controller: controller1,
                                          hintText: "",
                                          focusNode: focusNode,
                                          suffixIcon: const Icon(
                                            Icons.arrow_downward_rounded,
                                          ),
                                        );
                                      },
                                      itemBuilder:
                                          (context, OrderCustomer? suggestion) {
                                        if (suggestion == null) {
                                          return const SizedBox.shrink();
                                        }
                                        final index = controller
                                            .customer.value.data!
                                            .indexOf(suggestion);
                                        return CustomSearchSelect(
                                          index: index,
                                          title: "${suggestion.name}",
                                        );
                                      },
                                      onSelected: (OrderCustomer? value) {
                                        controller.customName.value =
                                            value!.name!;
                                        controller.customerId.value = value.id!;
                                        controller.deliverAddress.value = "";
                                        controller
                                            .fetchCustomerAddress(value.id!);
                                        unFocus();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const Gap(10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Delivery Address",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSecondary,
                                          ),
                                    ),
                                    TypeAheadField<Delivery?>(
                                      controller: TextEditingController(
                                        text: controller.deliverAddress.value,
                                      ),
                                      emptyBuilder: (context) => Container(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                          'Not found!',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(color: AppColor.danger),
                                        ),
                                      ),
                                      suggestionsCallback: (pattern) async {
                                        return controller
                                            .getSuggestionCustomAddress(
                                                pattern);
                                      },
                                      suggestionsController:
                                          SuggestionsController(),
                                      builder:
                                          (context, controller1, focusNode) {
                                        return CustomTextfiled(
                                          controller: controller1,
                                          hintText: "",
                                          focusNode: focusNode,
                                          suffixIcon: const Icon(
                                            Icons.arrow_downward_rounded,
                                          ),
                                        );
                                      },
                                      itemBuilder:
                                          (context, Delivery? suggestion) {
                                        if (suggestion == null) {
                                          return const SizedBox.shrink();
                                        }
                                        final index = controller
                                            .customeraddress.value.data!
                                            .indexOf(suggestion);
                                        return CustomSearchSelect(
                                          index: index,
                                          title: "${suggestion.name}",
                                        );
                                      },
                                      onSelected: (Delivery? value) {
                                        controller.deliverAddress.value =
                                            value!.name!;
                                        controller.deliveryAddressId.value =
                                            value.id!;
                                        unFocus();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Gap(20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Remark",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
                                    ),
                              ),
                              CustomTextfiled(
                                controller: controller.remakeText.value,
                                hintText: "",
                                onChanged: (value) {
                                  controller.remake.value = value;
                                },
                                maxLines: 3,
                              ),
                            ],
                          ),
                          const Gap(20),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Product",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSecondary,
                                          ),
                                    ),
                                    TypeAheadField<Product?>(
                                      controller: TextEditingController(
                                        text: controller.productName.value,
                                      ),
                                      emptyBuilder: (context) => Container(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                          'Not found!',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(color: AppColor.danger),
                                        ),
                                      ),
                                      suggestionsCallback: (pattern) async {
                                        return controller
                                            .getSuggestionProduct(pattern);
                                      },
                                      builder:
                                          (context, controller1, focusNode) {
                                        return CustomTextfiled(
                                          controller: controller1,
                                          hintText: "",
                                          focusNode: focusNode,
                                          onChanged: (value) {
                                            controller.fetchProduct(value);
                                          },
                                        );
                                      },
                                      itemBuilder:
                                          (context, Product? suggestion) {
                                        if (suggestion == null) {
                                          return const SizedBox.shrink();
                                        }
                                        final index = controller
                                            .product.value.data!
                                            .indexOf(suggestion);
                                        return CustomSearchSelect(
                                          index: index,
                                          title: "${suggestion.name}",
                                        );
                                      },
                                      onSelected: (Product? value) {
                                        unFocus();
                                        controller.qtyText.value.text = "1";
                                        controller.qty.value = "1";
                                        controller.productId.value = value!.id!;
                                        controller.productUom.value =
                                            value.productUomId!;
                                        controller.productName.value =
                                            value.name!;
                                        controller.priceText.value.text =
                                            value.salePrice.toString();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Quanity",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSecondary,
                                          ),
                                    ),
                                    CustomTextfiled(
                                      keyboardType: TextInputType.number,
                                      controller: controller.qtyText.value,
                                      hintText: "",
                                      onChanged: (value) {
                                        controller.qty.value = value;
                                        debugPrint("value $value");
                                      },
                                      maxLength: 10,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Price",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSecondary,
                                          ),
                                    ),
                                    CustomTextfiled(
                                      readOnly: true,
                                      controller: controller.priceText.value,
                                      hintText: controller.priceText.value.text,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Discount",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSecondary,
                                          ),
                                    ),
                                    CustomTextfiled(
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                              decimal: true),
                                      controller: controller.discountText.value,
                                      hintText: "",
                                      maxLength: 3,
                                      onChanged: (value) {
                                        controller.discount.value = value;
                                      },
                                      suffixIcon: const Icon(
                                        Icons.percent_rounded,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Gap(10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Foc",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSecondary),
                                    ),
                                    CustomTextfiled(
                                      keyboardType: TextInputType.number,
                                      controller: controller.focText.value,
                                      hintText: "",
                                      onChanged: (value) {
                                        controller.foc.value = value;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const Gap(10),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "",
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                    CustomButtom(
                                      height: 42,
                                      white: 300,
                                      title: "",
                                      onTap: () {
                                        controller.addOrder();
                                      },
                                      disble:
                                          controller.productName.value != "" &&
                                                  controller.qty.value != ""
                                              ? false
                                              : true,
                                      colors: AppColor.success,
                                      icon: Icons.add_shopping_cart_rounded,
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    const Gap(10),
                    Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onSecondary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Container(
                            decoration: const BoxDecoration(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    "Pro",
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Text("Qty",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!),
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      "Pri",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      "Dis",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      "Foc",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                  width: 40,
                                )
                              ],
                            ),
                          ),
                          const Gap(10),
                          ...controller.order.reversed
                              .toList()
                              .asMap()
                              .entries
                              .map((e) {
                            return Container(
                              alignment: Alignment.bottomLeft,
                              height: 50,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      "${e.value.name}",
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary,
                                          ),
                                    ),
                                  ),
                                  Expanded(
                                      child: Center(
                                          child: Text(
                                    "${e.value.qty}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                        ),
                                  ))),
                                  Expanded(
                                      child: Center(
                                          child: Text(
                                    "${e.value.price}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                        ),
                                  ))),
                                  Expanded(
                                      child: Center(
                                          child: Text(
                                    "${e.value.discount}%",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                        ),
                                  ))),
                                  Expanded(
                                      child: Center(
                                          child: Text(
                                    "${e.value.foc}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                        ),
                                  ))),
                                  GestureDetector(
                                    onTap: () {
                                      controller.deleteProduct(e.key);
                                    },
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      // color: Colors.red,
                                      width: 40,
                                      child: Icon(
                                        Icons.delete_outline_rounded,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                    TotalWidget(
                      subTotal: controller.subTotal.value,
                      total: controller.getTotal(),
                      contrller: controller.discountTotalText.value,
                      onchange: (value) {
                        controller.discountTotal.value = value;
                      },
                    ),
                    const Gap(20),
                    widget.status == "draft"
                        ? CustomButtom(
                            title: "Update",
                            white: MediaQuery.sizeOf(context).width / 2,
                            onTap: () {
                              controller.updateOrder(widget.id);
                            },
                            disble: controller.checkButton(),
                          )
                        : const SizedBox(),
                    const Gap(20),
                  ],
                ),
              ),
              if (controller.isloading.value)
                const Center(
                  child: CustomLoading(),
                )
            ],
          ),
        ),
      ),
    );
  }
}
