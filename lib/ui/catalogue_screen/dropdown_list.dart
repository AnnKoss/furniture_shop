import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_furniture_shop/domain/category_item.dart';
import 'package:flutter_furniture_shop/ui/catalogue_screen/catalogue_bloc.dart';

class DropDownList extends StatefulWidget {
  final DropdownListModel ddList;
  final String dropDownTitleText;
  final bool isExpanded;
  DropDownList(
    this.ddList,
    this.dropDownTitleText,
    this.isExpanded,
  );

  @override
  _DropDownListState createState() => _DropDownListState();
}

class _DropDownListState extends State<DropDownList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            child: GestureDetector(
              onTap: () {},
              child: Row(
                children: [
                  Text(widget.dropDownTitleText),
                  (widget.isExpanded)
                      ? Icon(Icons.keyboard_arrow_up)
                      : Icon(Icons.keyboard_arrow_down),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xffEFF0F6),
              ),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 4,
                  color: Colors.black26,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: widget.ddList.dropdownMenuItemList.map(
                (e) {
                  return FlatButton(
                    onPressed: () {
                      context.read<FurnitureItemsBloc>().add(
                            FetchFurnitureCategoryItemsEvent(e.category),
                          );
                    },
                    child: Text(e.text),
                  );
                },
              ).toList(),
            ),
          ),
          // _buildDropDownListOptions(dropListModel.listOptionItems, context))
        ],
      ),
    );
  }
}

class DropdownListModel {
  final List<CategoryItem> dropdownMenuItemList;
  final Function onChanged;
  final String value;
  DropdownListModel(
    this.dropdownMenuItemList,
    this.onChanged,
    this.value,
  );
}
