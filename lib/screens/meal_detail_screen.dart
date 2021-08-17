import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../providers/language_provider.dart';
import '../providers/meal_provider.dart';
import 'package:provider/provider.dart';
import '../dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail';

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget buildContainer(Widget child, BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    var dw = MediaQuery.of(context).size.width;
    var dh = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.all(10),
      height: isLandscape ? dh * 0.5 : dh * 0.25,
      width: isLandscape ? (dw * 0.5 - 30) : dw,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    var accentColor = Theme.of(context).accentColor;
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    List<String> liStepsLi = lan.getTexts('steps-$mealId') as List<String>;
    var liSteps = ListView.builder(
      itemBuilder: (ctx, index) => Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              child: Text('# ${(index + 1)}'),
            ),
            title: Text(
              liStepsLi[index],
              style: TextStyle(color: Colors.black),
            ),
          ),
          Divider(),
        ],
      ),
      itemCount: selectedMeal.steps.length,
    );
    List<String> liIngredientsLi =
        lan.getTexts('ingredients-$mealId') as List<String>;
    var liIngredients = ListView.builder(
      itemBuilder: (ctx, index) => Card(
        color: accentColor,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Text(
            liIngredientsLi[index],
            style: TextStyle(
              color: accentColor.computeLuminance() > 0.5
                  ? Colors.black
                  : Colors.white,
            ),
          ),
        ),
      ),
      itemCount: selectedMeal.ingredients.length,
    );
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(lan.getTexts('meal-$mealId')),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 250,
                width: double.infinity,
                child: Hero(
                  tag: mealId,
                  child: InteractiveViewer(
                    child: FadeInImage(
                      fit: BoxFit.cover,
                      placeholder: AssetImage('assets/images/a2.png'),
                      image: NetworkImage(selectedMeal.imageUrl),
                    ),
                  ),
                ),
              ),
              isLandscape
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            buildSectionTitle(
                                context, lan.getTexts('Ingredients')),
                            buildContainer(liIngredients, context),
                          ],
                        ),
                        Column(
                          children: [
                            buildSectionTitle(context, lan.getTexts('Steps')),
                            buildContainer(liSteps, context),
                          ],
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        buildSectionTitle(context, lan.getTexts('Ingredients')),
                        buildContainer(liIngredients, context),
                        buildSectionTitle(context, lan.getTexts('Steps')),
                        buildContainer(liSteps, context),
                      ],
                    ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Provider.of<MealProvider>(context, listen: true).isFavorite(mealId)
                ? Icons.star
                : Icons.star_border,
          ),
          onPressed: () => Provider.of<MealProvider>(context, listen: false)
              .toggleFavorite(mealId),
        ),
      ),
    );
  }
}
