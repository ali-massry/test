import 'package:capef/models/offline_data_response.dart';
import 'package:capef/utils/colors.dart';
import 'package:capef/utils/constant.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BuildPickSecondaryActivity extends StatefulWidget {
  const BuildPickSecondaryActivity({
    super.key,
    required this.restCategories,
    required this.onTap,
  });
  final List<Categories> restCategories;
  final Function(int?) onTap;

  @override
  State<BuildPickSecondaryActivity> createState() =>
      _BuildPickSecondaryActivityState();
}

class _BuildPickSecondaryActivityState
    extends State<BuildPickSecondaryActivity> {
  int? selectedId = -1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text(
          'Choisir votre Activité Secondaire',
          style: GlobalTextStyles.ts12montboldGreen,
        ),
        SizedBox(height: mqh(context, 23)),
        ListView.separated(
          separatorBuilder: (context, index) {
            return SizedBox(height: mqh(context, 4));
          },
          itemCount: widget.restCategories.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (selectedId == widget.restCategories[index].id) {
                    selectedId = -1;
                  } else {
                    selectedId = widget.restCategories[index].id;
                  }
                });
                widget.onTap(selectedId);
              },
              child: SizedBox(
                height: 40,
                child: Row(
                  children: [
                    Container(
                      width: 17,
                      height: 17,
                      decoration: BoxDecoration(
                          color: selectedId == widget.restCategories[index].id
                              ? GlobalColors.mainGreenColor
                              : Colors.white,
                          border: Border.all(
                              color: GlobalColors.mainGreenColor, width: 2),
                          borderRadius: BorderRadius.circular(100)),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      widget.restCategories[index].name ?? '',
                      style: GlobalTextStyles.ts13montsemiBoldBlack,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ]),
    );
  }
}
