import 'package:e_pesan_resto/global/global_state.dart';
import 'package:e_pesan_resto/presentation/homepage/component/menus_tile_for_admin.dart';
import 'package:e_pesan_resto/presentation/homepage/component/menus_tile_loading.dart';
import 'package:e_pesan_resto/presentation/homepage/state/user_home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/home_controller.dart';
import '../../controllers/session_controller.dart';
import '../../global_component/search_component.dart';
import '../../theme/font_theme.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  final UserHomeState cc = Get.put(UserHomeState());
  final GlobalState gs = Get.put(GlobalState());
  final SessionController sc = Get.put(SessionController());
  final HomeController hm = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    sc.getPreference();
    hm.getAllProduct(sc.session.value.token);
  }

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
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              'Selamat datang kembali',
                              style: regular14.copyWith(
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ],
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
                const SizedBox(
                  height: 30,
                ),
                SearchComponent(
                  message: "Cari item",
                  onTextCompleted: (value) {
                    cc.onMenuSearchAdmin(value);
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
                topRight: Radius.circular(30),
              ),
            ),
          ),
        )
      ],
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
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                head(name: sc.session.value.name),
                const Padding(
                  padding: EdgeInsets.only(left: 40, top: 20),
                  child: Text("Action", style: bold20),
                ),
                const SizedBox(
                  height: 12,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed('/transaction-page');
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 40,
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.orange),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Center(
                              child: SvgPicture.asset(
                                'assets/images/icon_transaction_list.svg',
                                width: 25,
                                height: 25,
                                colorFilter: const ColorFilter.mode(
                                  Colors.orange,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          'Transaksi',
                          style: regular14.copyWith(color: Colors.orange),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 40),
                  child: Text(
                    'Produk',
                    style: bold20,
                  ),
                ),
                Obx(
                  () {
                    var data = cc.displayedProductAdmin;
                    return Padding(
                      padding: EdgeInsets.only(
                        left: 20,
                        right: 20,
                        bottom: data.length <= 2 ? 150 : 100,
                      ),
                      child: gs.isLoading.value
                          ? GridView.count(
                              crossAxisCount: 2,
                              childAspectRatio: 1 / 1.3,
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
                              childAspectRatio: 1 / 1.9,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              children: List.generate(
                                data.length,
                                (index) {
                                  return MenusTileForAdmin(index: index);
                                },
                              ),
                            ),
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.orange,
        label: Row(
          children: [
            Text(
              'Tambah produk',
              style: regular14.copyWith(color: Colors.white),
            ),
            const SizedBox(
              width: 10,
            ),
            const Icon(
              Icons.add,
              color: Colors.white,
            )
          ],
        ),
        onPressed: () {
          Get.toNamed('/add-product-page');
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
