import "package:shimmer/shimmer.dart";
import 'package:flutter/material.dart';

class NewLoader extends StatelessWidget {
  const NewLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        height: 200.0,
        child: Shimmer.fromColors(
            baseColor: Colors.grey.withOpacity(0.25),
            highlightColor: Colors.white.withOpacity(0.6),
            period: const Duration(seconds: 2),
            child: Container(
              height: 240,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.withOpacity(0.9)),
            )),
      ),
    );
  }
}
