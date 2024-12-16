import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

final loadingWidget = SpinKitChasingDots(
  itemBuilder: (context, index) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.all(
          Radius.circular(100),
        ),
      ),
    );
  },
);
