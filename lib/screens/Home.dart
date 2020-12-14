import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();

}

class _MyStatefulWidgetState extends State<Home>  with RestorationMixin {
  final RestorableBool _isSelected = RestorableBool(false);

  @override
  String get restorationId => 'cards';

  @override
  void restoreState(RestorationBucket oldBucket, bool initialRestore) {
    registerForRestoration(_isSelected, 'is_selected');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          restorationId: 'cards_demo_list_view',
          padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
          children: [
            for (final destination in destinations(context))
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: SelectableTravelDestinationItem(
                  destination: destination, isSelected: _isSelected.value,
                  onSelected: () { setState(() { _isSelected.value = !_isSelected.value; }); },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class TravelDestination {
  const TravelDestination({
    @required this.imageName, @required this.title,  @required this.description, @required this.category, @required this.location,
  }) : assert(imageName != null), assert(title != null), assert(description != null), assert(category != null), assert(location != null);

  final String imageName;
  final String title;
  final String description;
  final String category;
  final String location;
}

List<TravelDestination> destinations(BuildContext context) => [
  TravelDestination(
      imageName: 'https://gallery.flutter.dev/#/demo/card/places/india_tanjore_thanjavur_temple.png',
      title:"Deroyal Cocktail", description: "We Bring the bar to you", category: "Mobile Bar", location: "Lagos, Nigeria"
  ),
  TravelDestination(
      imageName: 'https://gallery.flutter.dev/#/demo/card/places/india_tanjore_thanjavur_temple.png',
      title:"Deroyal Cocktail", description: "We Bring the bar to you", category: "Mobile Bar", location: "Lagos, Nigeria"
  ),
  TravelDestination(
      imageName: 'https://gallery.flutter.dev/#/demo/card/places/india_tanjore_thanjavur_temple.png',
      title:"Deroyal Cocktail", description: "We Bring the bar to you", category: "Mobile Bar", location: "Lagos, Nigeria"
  ),
];

class SelectableTravelDestinationItem extends StatelessWidget {
  const SelectableTravelDestinationItem({
    Key key, @required this.destination, @required this.isSelected, @required this.onSelected, this.shape,
  })  : assert(destination != null), super(key: key);

  final TravelDestination destination;
  final ShapeBorder shape;
  final bool isSelected;
  final VoidCallback onSelected;

  // This height will allow for all the Card's content to fit comfortably within the card.
  static const height = 298.0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      top: false,
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            SectionTitle( title: "Card" ),
            SizedBox(
              height: height,
              child: Card(
                clipBehavior: Clip.antiAlias,
                shape: shape,
                child: InkWell(
                  onTap: () { },
                  onLongPress: () { onSelected(); },
                  splashColor: colorScheme.onSurface.withOpacity(0.12),
                  highlightColor: Colors.transparent,
                  child: Stack(
                    children: [
                      Container( color: isSelected ? colorScheme.primary.withOpacity(0.08) : Colors.transparent ),
                      TravelDestinationContent(destination: destination),
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Icon( Icons.check_circle, color: isSelected ? colorScheme.primary : Colors.transparent ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {

  const SectionTitle({ Key key, this.title }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 4, 4, 12),
      child: Align(
        alignment: Alignment.centerLeft, child: Text(title, style: Theme.of(context).textTheme.subtitle1),
      ),
    );
  }
}

class TravelDestinationContent extends StatelessWidget {
  const TravelDestinationContent({Key key, @required this.destination})
      : assert(destination != null),
        super(key: key);

  final TravelDestination destination;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleStyle = theme.textTheme.headline5.copyWith(color: Colors.white);
    final descriptionStyle = theme.textTheme.subtitle1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 184,
          child: Stack(
            children: [
              Positioned.fill(
                child: Ink.image(
                  image: AssetImage(destination.imageName),
                  fit: BoxFit.cover,
                  child: Container(),
                ),
              ),
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(destination.title, style: titleStyle,),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: DefaultTextStyle(
            softWrap: false,
            overflow: TextOverflow.ellipsis,
            style: descriptionStyle,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    destination.description,
                    style: descriptionStyle.copyWith(color: Colors.black54),
                  ),
                ),
                Text(destination.category),
                Text(destination.location),
              ],
            ),
          ),
        ),
        ButtonBar(
          alignment: MainAxisAlignment.start,
          children: [
            TextButton(
              child: Text("Cart"),
              onPressed: () {
                print('pressed');
              },
            ),
            TextButton(
              child: Text("Share"),
              onPressed: () {
                print('pressed');
              },
            ),
          ],
        ),
      ],
    );
  }
}