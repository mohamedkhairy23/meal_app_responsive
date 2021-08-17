import 'package:flutter/material.dart';
import '../providers/language_provider.dart';
import '../providers/meal_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: GridView(
        padding: const EdgeInsets.all(25),
        children: Provider.of<MealProvider>(context).availableCategory
            .map(
              (catData) => CategoryItem(
                    catData.id,
                    catData.title,
                    catData.color,
                  ),
            )
            .toList(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
      ),
    );
  }
}
