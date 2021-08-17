import 'package:flutter/material.dart';
import '../providers/language_provider.dart';
import 'package:provider/provider.dart';
import '../screens/meal_detail_screen.dart';
import '../models/meal.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;

  MealItem({
    @required this.id,
    @required this.title,
    @required this.imageUrl,
    @required this.affordability,
    @required this.complexity,
    @required this.duration,
  });



  void selectMeal(BuildContext context) {
    Navigator.of(context)
        .pushNamed(
      MealDetailScreen.routeName,
      arguments: id,
    )
        .then((result) {
      if (result != null) {
        // removeItem(result);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<LanguageProvider>(context, listen: true);
    bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: InkWell(
        onTap: () => selectMeal(context),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 4,
          margin: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: Hero(
                      tag: id,
                      child: InteractiveViewer(
                        child: FadeInImage(
                          height: 250,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          placeholder: AssetImage('assets/images/a2.png'),
                          image: NetworkImage(imageUrl),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    right: isLandscape?20:10,
                    left: isLandscape?5:0,
                    child: Container(
                      width: 300,
                      color: Colors.black54,
                      padding: EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 20,
                      ),
                      child: Text(
                        lan.getTexts('meal-$id'),
                        style: TextStyle(
                          fontSize: 26,
                          color: Colors.white,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.schedule,
                          color: Theme.of(context).buttonColor,
                        ),
                        SizedBox(width: 6),
                        if (duration <= 10)
                          Text('$duration ' + lan.getTexts('min2')),
                        if (duration > 10)
                          Text('$duration ' + lan.getTexts('min')),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.work,
                          color: Theme.of(context).buttonColor,
                        ),
                        SizedBox(width: 6),
                        Text(lan.getTexts('$complexity')),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.attach_money,
                          color: Theme.of(context).buttonColor,
                        ),
                        SizedBox(width: 6),
                        Text(lan.getTexts('$affordability')),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
