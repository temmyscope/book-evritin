import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  Cart({Key key}) : super(key: key);

  @override
  _CartListState createState() => _CartListState();

}

class _CartListState extends State<Cart>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(

        ),
      ),
    );
  }
}

class ProgressIndicatorDemo extends StatefulWidget {
  const ProgressIndicatorDemo({Key key}) : super(key: key);

  @override
  _ProgressIndicatorDemoState createState() => _ProgressIndicatorDemoState();
}

class _ProgressIndicatorDemoState extends State<ProgressIndicatorDemo> with SingleTickerProviderStateMixin{

  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
      animationBehavior: AnimationBehavior.preserve,
    )..forward();

    _animation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.9, curve: Curves.fastOutSlowIn),
      reverseCurve: Curves.fastOutSlowIn,
    )..addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        _controller.forward();
      } else if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.stop();
    super.dispose();
  }

  String get _title {
    return 'circular';
  }

  Widget _buildIndicators(BuildContext context, Widget child) {
    return Column(
      children: [
        const CircularProgressIndicator(),
        const SizedBox(height: 32),
        CircularProgressIndicator(value: _animation.value),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(_title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(8),
            child: AnimatedBuilder(animation: _animation, builder: _buildIndicators ),
          ),
        ),
      ),
    );
  }
}

class DialogDemo extends StatelessWidget {
  DialogDemo({Key key}) : super(key: key);

  Future<void> _showDemoDialog<T>({BuildContext context, Widget child}) async {
    child = Theme( data: Theme.of(context), child: child );

    final value = await showDialog<T>( context: context, builder: (context) => child );

    if (value != null && value is String) {
      Scaffold.of(context).hideCurrentSnackBar();
      Scaffold.of(context).showSnackBar( SnackBar( content: Text("") ) );
    }
  }

  void _showSimpleDialog(BuildContext context) {
    final theme = Theme.of(context);
    _showDemoDialog<String>(
      context: context,
      child: SimpleDialog(
        title: Text(""),
        children: [
          _DialogDemoItem(
            icon: Icons.account_circle,
            color: theme.colorScheme.primary,
            text: 'username@gmail.com',
          ),
          _DialogDemoItem(
            icon: Icons.account_circle,
            color: theme.colorScheme.secondary,
            text: 'user02@gmail.com',
          ),
          _DialogDemoItem(
            icon: Icons.add_circle,
            text: "",
            color: theme.disabledColor,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        return _NoAnimationMaterialPageRoute<void>(
          builder: (context) => Scaffold(
            body: Center(
              child: ElevatedButton(
                child: Text(""),
                onPressed: () {
                  _showSimpleDialog(context);
                }
              ),
            ),
          ),
        );
      },
    );
  }
}

class _NoAnimationMaterialPageRoute<T> extends MaterialPageRoute<T> {
  _NoAnimationMaterialPageRoute({
    @required WidgetBuilder builder,
    RouteSettings settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
  }) : super(
      builder: builder,
      maintainState: maintainState,
      settings: settings,
      fullscreenDialog: fullscreenDialog);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }
}

class _DialogDemoItem extends StatelessWidget {
  const _DialogDemoItem({
    Key key,
    this.icon,
    this.color,
    this.text,
  }) : super(key: key);

  final IconData icon;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SimpleDialogOption(
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop(text);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 36, color: color),
          Flexible(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 16),
              child: Text(text),
            ),
          ),
        ],
      ),
    );
  }
}