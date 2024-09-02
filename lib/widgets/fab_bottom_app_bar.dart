import 'package:flutter/material.dart';
import 'package:magang_flutter/common/app_color.dart';

class FABBottomAppBarItem {
  FABBottomAppBarItem({required this.iconPage, required this.title,});
  final IconData iconPage;
  final String title;
}

class FABBottomAppBar extends StatefulWidget {
  FABBottomAppBar({
    super.key,
    this.items,
    this.height = 60.0,
    this.iconSize = 24.0,
    this.backgroundColor,
    this.color,
    this.selectedColor,
    this.notchedShape,
    this.onTabSelected,
    this.selectedIndex = 0,
  }) {
    // assert(items!.length == 2 || items!.length == 3 || items!.length == 5);
  }
  final List<FABBottomAppBarItem>? items;
  final double? height;
  final double? iconSize;
  final Color? backgroundColor;
  final Color? color;
  final Color? selectedColor;
  final NotchedShape? notchedShape;
  final ValueChanged<int>? onTabSelected;
  final int selectedIndex;
  @override
  State<StatefulWidget> createState() => FABBottomAppBarState();
}

class FABBottomAppBarState extends State<FABBottomAppBar> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex;
  }

  _updateIndex(int index) {
    widget.onTabSelected!(index);
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(widget.items!.length, (int index) {
      return _buildTabItem(
        item: widget.items![index],
        index: index,
        onPressed: _updateIndex,
      );
    });

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: items,
    );
  }

  Widget _buildTabItem({
    FABBottomAppBarItem? item,
    int? index,
    ValueChanged<int>? onPressed,
  }) {
    Color? color = widget.selectedIndex == index
        ? widget.selectedColor
        : AppColor.textBody;
    
    return Expanded(
      child: SizedBox(
        child: GestureDetector(
          onTap: () => onPressed!(index!),
          // onDoubleTap: () {
          //   if (index == 1) {
          //     final businessTripController = Get.find<BusinessTripController>();
          //     businessTripController.fetchBusinessTrips();
          //     businessTripController.resetFilter();
          //   }
          // },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                item!.iconPage,
                size: 24,
                color: color,
              ),
              Text(
                item.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

