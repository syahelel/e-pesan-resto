import 'package:e_pesan_resto/presentation/homepage/state/user_home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CategoriesTile extends StatelessWidget {
  final String imageAsset;
  final String label;
  final int id;
  final UserHomeState cc = Get.put(UserHomeState());

  CategoriesTile({
    required this.imageAsset,
    required this.label,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            cc.changeCategoryItem(id);
          },
          child: Obx(
            () {
              return AnimatedContainer(
                duration: const Duration(seconds: 3),
                curve: Curves.easeInOut,
                child: Container(
                  decoration: BoxDecoration(
                    color: cc.categoryItem.value == id
                        ? Colors.orange
                        : Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: SvgPicture.asset(
                      imageAsset,
                      width: 30,
                      height: 30,
                      colorFilter: ColorFilter.mode(
                        cc.categoryItem.value == id
                            ? Colors.white
                            : Colors.grey,
                        BlendMode.srcIn,
                      ),
                      semanticsLabel: label,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Text(
          label,
          style: TextStyle(
              color: Colors.orange,
              fontSize: 12), // Sesuaikan style sesuai kebutuhan
        ),
      ],
    );
  }
}
