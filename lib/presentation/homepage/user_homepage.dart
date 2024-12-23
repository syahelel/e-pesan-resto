import 'package:e_pesan_resto/controllers/home_controller.dart';
import 'package:e_pesan_resto/controllers/session_controller.dart';
import 'package:e_pesan_resto/global/global_state.dart';
import 'package:e_pesan_resto/global_component/search_component.dart';
import 'package:e_pesan_resto/presentation/homepage/component/categories_tile.dart';
import 'package:e_pesan_resto/presentation/homepage/component/menus_tile.dart';
import 'package:e_pesan_resto/presentation/homepage/component/menus_tile_loading.dart';
import 'package:e_pesan_resto/presentation/homepage/state/user_home_state.dart';
import 'package:e_pesan_resto/presentation/order/order_page.dart';
import 'package:e_pesan_resto/theme/font_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  final SessionController sc = Get.put(SessionController());
  final UserHomeState cc = Get.put(UserHomeState());
  final GlobalState gs = Get.put(GlobalState());
  final HomeController hm = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    sc.getPreference();
    hm.getAllProduct(sc.session.value.token);
    cc.initialProduct();
  }

  // Extended widget
  Widget head({String name = ""}) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          color: Colors.orange,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 30),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.person_2_outlined,
                              size: 40,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 18,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hallo, $name',
                              style: bold20.copyWith(color: Colors.white),
                            ),
                            Text(
                              'Mau pesan apa hari ini?',
                              style: regular14.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.toNamed('/cart');
                          },
                          child: SvgPicture.asset(
                            'assets/images/icon_cart2.svg',
                            width: 25,
                            height: 25,
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed('/login');
                            sc.clearPreference();
                          },
                          child: SvgPicture.asset(
                            'assets/images/icon_logout.svg',
                            width: 25,
                            height: 25,
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                SearchComponent(
                  message: "Temukan favorit anda",
                  onTextCompleted: (value) {
                    cc.onMenuSearch(value);
                  },
                )
              ],
            ),
          ),
        ),
        Positioned(
          left: 0,
          bottom: 0,
          right: 0,
          child: Container(
            height: 30,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
          ),
        )
      ],
    );
  }

  Widget categories({
    String asset = '',
    String label = '',
    int id = 1,
  }) {
    return CategoriesTile(
      imageAsset: asset,
      label: label,
      id: id,
    );
  }

  Widget itemMenu({String assets = '', String label = '', required int id}) {
    return GestureDetector(
      onTap: () => cc.changeMenuItem(id),
      child: Obx(
        () => Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 30),
              curve: Curves.easeInOut,
              child: SvgPicture.asset(
                assets,
                width: cc.menuItem.value == id ? 25 : 20,
                height: cc.menuItem.value == id ? 25 : 20,
                colorFilter: ColorFilter.mode(
                  cc.menuItem.value == id ? Colors.orange : Colors.grey,
                  BlendMode.srcIn,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: Container(
                height: 5,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                  color: cc.menuItem.value == id
                      ? Colors.orange
                      : Colors.transparent,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.sizeOf(context).height,
                )
              ],
            ),
          ),
          Obx(
            () {
              return cc.menuItem.value == 1
                  ? SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          head(name: sc.session.value.name),
                          const Padding(
                            padding: EdgeInsets.only(left: 40, top: 20),
                            child: Text("Kategori", style: bold20),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 40,
                            ),
                            child: Row(
                              children: [
                                categories(
                                  asset: 'assets/images/icon_makanan.svg',
                                  label: 'Makanan',
                                  id: 1,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                categories(
                                  asset: 'assets/images/icon_minuman.svg',
                                  label: 'Minuman',
                                  id: 2,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 40),
                            child: Text(
                              'Menu',
                              style: bold20,
                            ),
                          ),
                          Obx(
                            () {
                              return Padding(
                                padding: EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                  bottom: cc.displayedProduct.length <= 2
                                      ? 150
                                      : 100,
                                ),
                                child: gs.isLoading.value
                                    ? GridView.count(
                                        crossAxisCount: 2,
                                        childAspectRatio: 3 / 4.5,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10,
                                        physics: const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        children: List.generate(
                                          4,
                                          (index) {
                                            return const MenusTileLoading();
                                          },
                                        ),
                                      )
                                    : GridView.count(
                                        crossAxisCount: 2,
                                        childAspectRatio: 3 / 4.5,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        children: List.generate(
                                          cc.displayedProduct.length,
                                          (index) {
                                            return MenusTile(index: index);
                                          },
                                        ),
                                      ),
                              );
                            },
                          ),
                        ],
                      ),
                    )
                  : const OrderPage();
            },
          ),
          Positioned(
            bottom: 20,
            left: 25,
            right: 25,
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.orange),
                color: Colors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    itemMenu(
                      assets: 'assets/images/icon_home.svg',
                      label: 'Home',
                      id: 1,
                    ),
                    itemMenu(
                      assets: 'assets/images/icon_transaction.svg',
                      label: 'Order',
                      id: 2,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
