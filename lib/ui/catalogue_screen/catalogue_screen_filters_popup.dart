import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_furniture_shop/domain/catalogue_furniture_item.dart';
import 'package:flutter_furniture_shop/ui/catalogue_screen/catalogue_bloc.dart';

class FilterPopup extends StatefulWidget {
  final List<CatalogueFurnitureItem> itemsList;
  FilterPopup(this.itemsList);
  @override
  _FilterPopupState createState() => _FilterPopupState();
}

class _FilterPopupState extends State<FilterPopup> {
  Set<CheckBoxListTileModel> checkBoxListTileModel = {
    CheckBoxListTileModel(
      'Yellow',
      '0xffE4B34C',
      false,
    ),
    CheckBoxListTileModel(
      'Beige',
      '0xffB2A39D',
      false,
    ),
    CheckBoxListTileModel(
      'Gray',
      '0xff9A9E9F',
      false,
    ),
    CheckBoxListTileModel(
      'Dark Blue',
      '0xff505C72',
      false,
    ),
  };
  RangeValues _currentRangeValues;
  double _sliderLowerValue = 0;
  double _sliderUpperValue;
  @override
  void initState() {
    super.initState();
    widget.itemsList.sort((a, b) {
      return a.price.compareTo(b.price);
    });
    _sliderUpperValue =
        widget.itemsList[widget.itemsList.length - 1].price.toDouble();
    _currentRangeValues = RangeValues(0, _sliderUpperValue);
  }

  @override
  Widget build(BuildContext context) {
    String _startRangeValue = _currentRangeValues.start.round().toString();
    String _endRangeValue = _currentRangeValues.end.round().toString();

    return AlertDialog(
      title: Text('Фильтры'),
      content: Column(
        children: [
          Text(
            'Стоимость',
            style: const TextStyle(fontSize: 18),
          ),
          RangeSlider(
            min: _sliderLowerValue,
            max: _sliderUpperValue,
            values: _currentRangeValues,
            divisions: _sliderUpperValue.toInt(),
            labels: RangeLabels(
              _startRangeValue,
              _endRangeValue,
            ),
            onChanged: (values) {
              setState(() {
                _currentRangeValues = values;
              });
            },
            activeColor: Theme.of(context).primaryColor,
            inactiveColor: Colors.black54,
          ),
          Text('Товары от $_startRangeValue до $_endRangeValue Руб.'),
          SizedBox(
            height: 30,
          ),
          Text(
            'Цвета',
            style: const TextStyle(fontSize: 18),
          ),
          Container(
            width: double.maxFinite,
            height: 250,
            child: ListView.builder(
              itemCount: checkBoxListTileModel.length,
              itemBuilder: (
                BuildContext context,
                int index,
              ) {
                List<CheckBoxListTileModel> checkBoxList = checkBoxListTileModel.toList();
                return CheckboxListTile(
                  title: Text(checkBoxList[index].title),
                  secondary:
                      _colorAvatarBuilder(checkBoxList[index].color),
                  value: checkBoxList[index].isChecked,
                  onChanged: (bool value) {
                    setState(() {
                      checkBoxList[index].isChecked = value;
                    });
                  },
                  contentPadding: EdgeInsets.zero,
                );
              },
            ),
          ),
        ],
      ),
      actions: [
        FlatButton(
          onPressed: () {
            setState(() {
              _currentRangeValues = RangeValues(0, _sliderUpperValue);
              checkBoxListTileModel.forEach(
                (element) {
                  element.isChecked = false;
                },
              );
            });
          },
          child: Text(
            'Сбросить',
            style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        FlatButton(
          onPressed: () {
            Set<ColorStringAndHex> _selectedColors = checkBoxListTileModel
                .where((element) => element.isChecked == true)
                .map(
              (e) {
                return ColorStringAndHex(e.title, e.color);
              },
            ).toSet();

            RangeValues _priceFilter =
                (_currentRangeValues == RangeValues(0, _sliderUpperValue))
                    ? null
                    : _currentRangeValues;

            Set<ColorStringAndHex> _colorFilter =
                (_selectedColors.isEmpty) ? null : _selectedColors;

            context.read<FurnitureItemsBloc>().add(
                  FilterItemsEvent(
                    _priceFilter,
                    _colorFilter,
                  ),
                );
            Navigator.of(context).pop();
          },
          child: Text(
            'Применить',
            style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}

class CheckBoxListTileModel {
  final String title;
  final String color;
  bool isChecked;
  CheckBoxListTileModel(
    this.title,
    this.color,
    this.isChecked,
  );
}

Widget _colorAvatarBuilder(stringColor) {
  return Container(
    width: 20,
    height: 20,
    decoration: BoxDecoration(
      color: Color(
        int.parse(
          stringColor,
        ),
      ),
      shape: BoxShape.circle,
    ),
  );
}
