import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:montra/app/shared/theme/font.dart';

import '../shared/theme/colors.dart';


void alertConfirm({
  required String title,
  String subtitle = "",
  String? saveTitle,
  String? cancelTitle,
  String image = "",
  bool showImage = false,
  void Function()? saveButtonTap,
  void Function()? cancelButtonTap,
}) {
  Get.defaultDialog(
    radius: 20,
    title: '',
    contentPadding: EdgeInsets.zero,
    titlePadding: const EdgeInsets.only(
      top: 0,
    ),
    content: Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Visibility(
            visible: showImage,
            child: Center(
              child: Image.asset(
                image,
                width: 200,
                height: 200,
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            width: double.infinity,
            child: Text(
              title,
              style: title3,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          Visibility(
            visible: subtitle.isNotEmpty,
            child: SizedBox(
              width: double.infinity,
              child: Text(
                subtitle,
                style: regular2.copyWith(
                  color: light40,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity,
            height: 44,
            child: ElevatedButton(
              onPressed: saveButtonTap,
              child: Text(
                saveTitle ?? "Simpan",
                style:regular3.copyWith(color:light40)
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            width: double.infinity,
            height: 44,
            child: TextButton(
              onPressed: cancelButtonTap,
              child: Text(cancelTitle ?? "Batal"),
            ),
          )
        ],
      ),
    ),
  );
}