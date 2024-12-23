import 'dart:async';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:e_pesan_resto/controllers/payment_controller.dart';
import 'package:e_pesan_resto/global/global_state.dart';
import 'package:e_pesan_resto/global_utility/widget.dart';
import 'package:e_pesan_resto/models/cart_model.dart';
import 'package:e_pesan_resto/presentation/cart/cart_state.dart';
import 'package:e_pesan_resto/presentation/homepage/state/user_home_state.dart';
import 'package:e_pesan_resto/presentation/order/component/order_detail_tile.dart';
import 'package:e_pesan_resto/presentation/order/order_state.dart';
import 'package:e_pesan_resto/presentation/order/payment_screen.dart';
import 'package:e_pesan_resto/theme/font_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../global_utility/functionality.dart';
import '../../models/login_model.dart';

class DetailOrderPage extends StatefulWidget {
  final CartResponse cartResponse;
  const DetailOrderPage({super.key, required this.cartResponse});

  @override
  State<DetailOrderPage> createState() => _DetailOrderPageState();
}

class _DetailOrderPageState extends State<DetailOrderPage> {
  final oState = Get.put(OrderState());
  var cS = Get.put(CartState());

  Widget head() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            size: 24,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        const Text(
          'Detail Pesanan',
          style: bold20,
        ),
      ],
    );
  }

  Widget componentDetail(String left, String right) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(left, style: regular14),
        Text(
          right,
          style: regular14,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var date = DateTime.now();
    var format = DateFormat('dd-MM-yyyy');
    String dateOnFormat = format.format(date);

    final pc = Get.put(PaymentController());
    final gs = Get.put(GlobalState());
    final uhs = Get.put(UserHomeState());

    oState.paymentUrl.listen(
      (value) async {
        if (value.isNotEmpty || value != '') {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PaymentScreen(url: value),
            ),
          );

          if (result == 'finish') {
            oState.statusSuccess.value = true;
          } else if (result == 'unfinish') {
            oState.statusUnfinish.value = true;
          } else {
            oState.statusError.value = true;
          }
        }
      },
    );

    oState.statusUnfinish.listen((value) {
      if (value) {
        Future.delayed(const Duration(milliseconds: 500), () {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.warning,
            animType: AnimType.topSlide,
            title: 'Pending',
            titleTextStyle: bold20,
            descTextStyle: regular14,
            desc: 'Pembayaran tertunda, harap coba kembali',
            buttonsTextStyle: regular14,
            btnOkOnPress: () {
              oState.statusError.value = false;
              uhs.changeMenuItem(2);
              Get.offAllNamed('/user-dashboard');
            },
          ).show();
        });
      }
    });

    oState.statusError.listen((value) {
      if (value) {
        Future.delayed(const Duration(milliseconds: 500), () {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.topSlide,
            title: 'Erorr',
            titleTextStyle: bold20,
            descTextStyle: regular14,
            desc: 'Pembayaran gagal, harap coba kembali',
            buttonsTextStyle: regular14,
            btnOkOnPress: () {
              oState.statusError.value = false;
              uhs.changeMenuItem(2);
              Get.offAllNamed('/user-dashboard');
            },
          ).show();
        });
      }
    });

    oState.statusSuccess.listen((value) {
      if (value) {
        Future.delayed(const Duration(milliseconds: 500), () {
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.topSlide,
            title: 'Success',
            titleTextStyle: bold20,
            descTextStyle: regular14,
            desc: 'Pembayaran berhasil',
            buttonsTextStyle: regular14,
            btnOkOnPress: () {
              oState.statusSuccess.value = false;
              uhs.changeMenuItem(2);
              Get.offAllNamed('/user-dashboard');
            },
          ).show();
        });
      }
    });

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.sizeOf(context).height,
                )
              ],
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  head(),
                  const SizedBox(
                    height: 30,
                  ),
                  componentDetail(
                    DateFormat('EEEE').format(date),
                    dateOnFormat,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  componentDetail(
                    'Total harga',
                    calculateCartItem(widget.cartResponse.items),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Item',
                    style: bold16,
                  ),
                  ListView.builder(
                    itemCount: widget.cartResponse.items.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: OrderDetailTile(
                          cart: widget.cartResponse.items[index],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 25,
            right: 25,
            child: InkWell(
              splashColor: Colors.grey,
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              focusColor: Colors.orange,
              onTap: () {
                pc.createPayment(widget.cartResponse.id!);
                cS.data.value = CartResponse(
                  id: 0,
                  items: List.empty(),
                  createdAt: DateTime(0),
                  updatedAt: DateTime(0),
                  deletedAt: DateTime(0),
                  userId: 0,
                  account: LoginModel(
                    id: 0,
                    name: '',
                    email: '',
                    phoneNumber: '',
                    role: '',
                    createdAt: DateTime(0),
                    updatedAt: DateTime(0),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5,
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Bayar',
                        style: regular16.copyWith(color: Colors.white),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      SvgPicture.asset(
                        'assets/images/icon_pay2.svg',
                        width: 25,
                        height: 25,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Obx(
            () {
              if (gs.isLoading.value) {
                return Container(
                  decoration: const BoxDecoration(color: Colors.black45),
                  child: loadingWidget,
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}
