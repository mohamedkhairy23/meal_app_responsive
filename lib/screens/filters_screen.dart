import 'package:flutter/material.dart';
import '../providers/language_provider.dart';
import '../providers/meal_provider.dart';
import '../providers/theme_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  final bool fromOnBoarding;

  FiltersScreen({this.fromOnBoarding = false});

  @override
  _FiltersScreenState createState() => _FiltersScreenState(fromOnBoarding);
}

class _FiltersScreenState extends State<FiltersScreen> {
  final bool fromOnBoarding;

  _FiltersScreenState(this.fromOnBoarding);

  Widget _buildSwitchListTile(String title, String description,
      bool currentValue, Function updateValue) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(description),
      onChanged: updateValue,
      inactiveTrackColor:
          Provider.of<ThemeProvider>(context, listen: true).tm ==
                  ThemeMode.light
              ? null
              : Colors.black,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, bool> currentFilters =
        Provider.of<MealProvider>(context, listen: true).filters;
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: fromOnBoarding
            ? AppBar(
                backgroundColor: Theme.of(context).canvasColor, elevation: 0)
            : AppBar(title: Text(lan.getTexts('filters_appBar_title'))),
        drawer: MainDrawer(),
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                lan.getTexts('filters_screen_title'),
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  _buildSwitchListTile(
                    lan.getTexts('Gluten-free'),
                    lan.getTexts('Gluten-free-sub'),
                    currentFilters['gluten'],
                    (newValue) {
                      setState(() {
                        currentFilters['gluten'] = newValue;
                      });
                      Provider.of<MealProvider>(context, listen: false)
                          .setFilters();
                    },
                  ),
                  _buildSwitchListTile(
                    lan.getTexts('Lactose-free'),
                    lan.getTexts('Lactose-free_sub'),
                    currentFilters['lactose'],
                    (newValue) {
                      setState(() {
                        currentFilters['lactose'] = newValue;
                      });
                      Provider.of<MealProvider>(context, listen: false)
                          .setFilters();
                    },
                  ),
                  _buildSwitchListTile(
                    lan.getTexts('Vegan'),
                    lan.getTexts('Vegan-sub'),
                    currentFilters['vegan'],
                    (newValue) {
                      setState(() {
                        currentFilters['vegan'] = newValue;
                      });
                      Provider.of<MealProvider>(context, listen: false)
                          .setFilters();
                    },
                  ),
                  _buildSwitchListTile(
                    lan.getTexts('Vegetarian'),
                    lan.getTexts('Vegetarian-sub'),
                    currentFilters['vegetarian'],
                    (newValue) {
                      setState(() {
                        currentFilters['vegetarian'] = newValue;
                      });
                      Provider.of<MealProvider>(context, listen: false)
                          .setFilters();
                    },
                  ),
                  SizedBox(height: fromOnBoarding?80:0)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
