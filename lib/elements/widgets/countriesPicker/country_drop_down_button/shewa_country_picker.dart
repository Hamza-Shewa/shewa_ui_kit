import 'package:flutter/material.dart';
import 'package:shewa_ui_kit/elements/widgets/countriesPicker/shewa_country_picker.dart';

class ShewaCountryPicker extends StatefulWidget {
  const ShewaCountryPicker({
    super.key,
    this.onTap,
    this.shewaDropDownStyle,
    this.widgetItem,
    this.initialValue,
    this.enabled = true,
  });
  final void Function(Country)? onTap;
  final Widget Function(Country)? widgetItem;
  final CountryDropDownStyle? shewaDropDownStyle;
  final String? initialValue;
  final bool enabled;
  @override
  State<ShewaCountryPicker> createState() => _ShewaCountryPickerState();
}

class _ShewaCountryPickerState extends State<ShewaCountryPicker> {
  List<Country> countries = [];
  bool loading = true;
  Country? initialValue;
  final Countries countriesApi = Countries();
  final CountriesDropDownController controller = CountriesDropDownController();
  Future fetchCountries() async {
    if (countries.isNotEmpty) return;
    countries = await countriesApi.getCountries();
    if (widget.initialValue != null && widget.initialValue!.isNotEmpty) {
      initialValue = countries.firstWhere(
        (element) =>
            element.enName.toLowerCase() ==
                widget.initialValue!.toLowerCase() ||
            element.arName.toLowerCase() == widget.initialValue ||
            element.dialCode.toLowerCase() ==
                widget.initialValue!.toLowerCase(),
      );
    }
    loading = false;
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
    if (loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return CountriesDropdownButton(
        controller: controller,
        searchField: true,
        enabled: widget.enabled,
        initialValue: initialValue,
        shewaDropDownStyle: widget.shewaDropDownStyle ??
            CountryDropDownStyle(
              prefix: true,
              prefixSize: const Size(24, 24),
            ),
        items: List<CountriesDropDownItem<Country>>.generate(
          countries.length,
          (index) => CountriesDropDownItem(
            item: widget.widgetItem != null
                ? widget.widgetItem!(countries[index])
                : ListTile(
                    minLeadingWidth: 40,
                    contentPadding: const EdgeInsetsDirectional.only(start: 8),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: SizedBox(
                        height: 30,
                        width: 40,
                        child: Image.asset(
                          countries[index].flag,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(
                      countries[index].enName,
                      style: widget.shewaDropDownStyle?.dropDownTextStyle ??
                          const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
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
}
