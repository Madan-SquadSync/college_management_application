import 'package:flutter/material.dart';
 

class DropButtonForTakeAttendance extends StatelessWidget {
  const DropButtonForTakeAttendance({
    Key? key,
    required this.listOfItems,
    required this.onChanged,
    required this.currentItem, required this.text,
  }) : super(key: key);

  final List<String> listOfItems;
  final Function(String) onChanged;
  final String currentItem;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        elevation: 3,
        child: SizedBox(
          width: double.infinity,
          child: DropdownButton(
            isExpanded: true,
            value: currentItem.length == 0 ? listOfItems[0] : currentItem,
            alignment: Alignment.bottomCenter,
            borderRadius: BorderRadius.circular(10),
            hint: const Text("Select Year"),
            items: listOfItems
                .map((e) => DropdownMenuItem(
                      value: e,
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          e.toString(),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ))
                .toList(),
            onChanged: (value) {
              onChanged(value.toString());
            },
          ),
        ),
      ),
    );
  }
}
