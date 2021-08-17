import 'package:flutter/material.dart';
import '../providers/language_provider.dart';
import '../providers/meal_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/meal_item.dart';
import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryId;
  List<Meal> displayedMeals;
  var _loadedInitData = false;


  @override
  void didChangeDependencies() {
    final List<Meal> availableMeals =
        Provider.of<MealProvider>(context, listen: true).availableMeals;

    if (!_loadedInitData) {
      final routeArgs = ModalRoute.of(context).settings.arguments as Map<String, String>;
      categoryId = routeArgs['id'];
      displayedMeals = availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    var dw = MediaQuery.of(context).size.width;

    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(lan.getTexts('cat-$categoryId')),
        ),
        body: isLandscape
            ? GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 400,
                  childAspectRatio: dw/dw*0.9,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                ),
                itemBuilder: (ctx, index) {
                  return MealItem(
                    id: displayedMeals[index].id,
                    title: displayedMeals[index].title,
                    imageUrl: displayedMeals[index].imageUrl,
                    duration: displayedMeals[index].duration,
                    affordability: displayedMeals[index].affordability,
                    complexity: displayedMeals[index].complexity,
                  );
                },
                itemCount: displayedMeals.length,
              )
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return MealItem(
                    id: displayedMeals[index].id,
                    title: displayedMeals[index].title,
                    imageUrl: displayedMeals[index].imageUrl,
                    duration: displayedMeals[index].duration,
                    affordability: displayedMeals[index].affordability,
                    complexity: displayedMeals[index].complexity,
                  );
                },
                itemCount: displayedMeals.length,
              ),
      ),
    );
  }
}
