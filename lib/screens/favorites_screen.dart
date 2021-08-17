import 'package:flutter/material.dart';
import '../providers/language_provider.dart';
import '../providers/meal_provider.dart';
import 'package:provider/provider.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    final List<Meal> favoriteMeals =
        Provider.of<MealProvider>(context, listen: true).favoriteMeals;
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var dw = MediaQuery.of(context).size.width;

    if (favoriteMeals.isEmpty) {
      return Directionality(
        textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
        child: Center(
          child: Text(lan.getTexts('favorites_text')),
        ),
      );
    } else {
      return isLandscape
          ? GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 400,
                childAspectRatio: dw / dw * 0.9,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
              ),
              itemBuilder: (ctx, index) {
                return MealItem(
                  id: favoriteMeals[index].id,
                  title: favoriteMeals[index].title,
                  imageUrl: favoriteMeals[index].imageUrl,
                  duration: favoriteMeals[index].duration,
                  affordability: favoriteMeals[index].affordability,
                  complexity: favoriteMeals[index].complexity,
                );
              },
              itemCount: favoriteMeals.length,
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return MealItem(
                  id: favoriteMeals[index].id,
                  title: favoriteMeals[index].title,
                  imageUrl: favoriteMeals[index].imageUrl,
                  duration: favoriteMeals[index].duration,
                  affordability: favoriteMeals[index].affordability,
                  complexity: favoriteMeals[index].complexity,
                );
              },
              itemCount: favoriteMeals.length,
            );
    }
  }
}
