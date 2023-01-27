import 'package:flutter/material.dart';
import 'package:shewa_ui_kit/elements/widgets/storeDropdownButton/components/shewa_dropdown_controller.dart';

import '../storeDropdownButton/components/shewa_dropdown_item.dart';
import '../storeDropdownButton/shewa_dropdown_button.dart';
import 'countries.dart';

class ShewaCountryPicker extends StatefulWidget {
  const ShewaCountryPicker({
    super.key,
    this.onTap,
    this.shewaDropDownStyle,
    this.widgetItem,
  });
  final void Function(Country)? onTap;
  final Widget Function(Country)? widgetItem;
  final ShewaDropDownStyle? shewaDropDownStyle;
  @override
  State<ShewaCountryPicker> createState() => _ShewaCountryPickerState();
}

class _ShewaCountryPickerState extends State<ShewaCountryPicker> {
  List<Country> countries = [];
  final Countries countriesApi = Countries();
  final ShewaDropDownController controller = ShewaDropDownController();
  Future fetchCountries() async {
    if (countries.isNotEmpty) return;
    countries = await countriesApi.getCountries();
    setState(() {});
  }

  @override
  void initState() {
    fetchCountries();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShewaDropdownButton(
      controller: controller,
      centerDropDown: true,
      searchField: true,
      shewaDropDownStyle: widget.shewaDropDownStyle ??
          ShewaDropDownStyle(
            prefix: true,
            prefixSize: const Size(24, 24),
          ),
      items: List<ShewaDropdownItem<Country>>.generate(
        countries.length,
        (index) => ShewaDropdownItem(
          item: widget.widgetItem != null
              ? widget.widgetItem!(countries[index])
              : ListTile(
                  leading: SizedBox(
                    height: 20,
                    width: 20,
                    child: Image.asset(
                      countries[index].flag,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    countries[index].enName,
                    style: widget.shewaDropDownStyle?.dropDownTextStyle,
                  ),
                ),
          onTap: () {
            if (widget.onTap != null) {
              widget.onTap!(countries[index]);
            }
          },
          value: countries[index],
        ),
      ),
    );
  }
}
