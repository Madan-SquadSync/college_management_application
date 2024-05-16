import 'package:flutter/material.dart';
import 'package:nricse123/data/data_source/data.dart';

class AboutDept extends StatelessWidget {
  const AboutDept({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  height: 300,
                  decoration: ShapeDecoration(
                      image: const DecorationImage(
                          image: NetworkImage(
                            "https://www.nriit.ac.in/public/nri/slider/cse_slider.jpeg",
                          ),
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.low),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide())),
                ),
              ),
              ...aboutDept.map((e) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      e.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(overflow: TextOverflow.fade),
                    ),
                  ))
            ],
          ),
        ));
  }
}
