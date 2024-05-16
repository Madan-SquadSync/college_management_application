import 'package:flutter/material.dart';
import 'package:nricse123/data/data_source/data.dart';

class Labs extends StatelessWidget {
  const Labs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Labs",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold, color: mainThemeColor),
              ),
              const SizedBox(
                height: 10,
              ),
              ...labimages.map(
                (e) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 300,
                        decoration: ShapeDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                  e.toString(),
                                ),
                                fit: BoxFit.cover,
                                filterQuality: FilterQuality.low),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide())),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            decoration: ShapeDecoration(
                                color: Colors.lightBlue.withOpacity(0.5),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            width: double.infinity,
                            child: Text(
                              "Lab" + (labimages.indexOf(e) + 1).toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(color: Colors.white),
                            )),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
