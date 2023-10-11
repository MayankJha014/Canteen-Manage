import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages;
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:zomato_clone/common/widgets/shimmer.dart';
import 'package:zomato_clone/features/home/services/home_services.dart';
import 'package:zomato_clone/models/advertise.dart';

class CarouselImages extends StatefulWidget {
  const CarouselImages({
    Key? key,
    required this.category,
  }) : super(key: key);
  final String category;

  @override
  State<CarouselImages> createState() => _CarouselImagesState();
}

class _CarouselImagesState extends State<CarouselImages> {
  List<Advertise>? advertises;
  final HomeServices homeServices = HomeServices();

  @override
  void initState() {
    super.initState();
    fetchAdsOfDay();
  }

  fetchAdsOfDay() async {
    advertises = await homeServices.fetchAdsOfDay(context: context);
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    // var images1 = advertises![index].images;
    return advertises == null
        ? const NewLoader()
        : Container(
            // margin: EdgeInsets.symmetric(vertical: 12),
            height: 250,
            child: Swiper(
              itemCount: advertises!.length,
              itemBuilder: (BuildContext context, int index) {
                return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                      image: NetworkImage('${advertises![index].images[0]}'),
                      fit: BoxFit.fitWidth,
                    ));
              },
              pagination: SwiperPagination(builder: SwiperPagination.rect),
              layout: SwiperLayout.DEFAULT,
            ),
          );
  }
}
