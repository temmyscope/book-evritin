import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart' show DragStartBehavior;

class Create extends StatefulWidget {
  Create({Key key}) : super(key: key);

  @override
  _StoreCreationState createState() => _StoreCreationState();

}

class _StoreCreationState extends State<Create>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextFieldDemo(),
      ),
    );
  }
}

class TextFieldDemo extends StatelessWidget {
  const TextFieldDemo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const TextFormFieldDemo(),
    );
  }
}

class TextFormFieldDemo extends StatefulWidget {
  const TextFormFieldDemo({Key key}) : super(key: key);

  @override
  TextFormFieldDemoState createState() => TextFormFieldDemoState();
}

class StoreData {
  String uniqueName = '';
  String displayName = '';
  String description = '';
  List categoryTag = [];
  List operationLocations = [];
}

class TextFormFieldDemoState extends State<TextFormFieldDemo> {
  StoreData store = StoreData();

  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _validateName(String value) {
    if (value.isEmpty) {
      return "This field is required.";
    }
    final nameExp = RegExp(r'^[A-Za-z ]+$');
    if (!nameExp.hasMatch(value)) {
      return "Name can only be alphanumeric and space characters.";
    }
    return null;
  }

  void _handleSubmitted() {
    final form = _formKey.currentState;
    if (!form.validate()) {
      _autoValidateMode = AutovalidateMode.always; // Start validating on every change.
    } else {
      form.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    const sizedBoxSpace = SizedBox(height: 24);

    return Scaffold(
      body: Form(
        key: _formKey,
        autovalidateMode: _autoValidateMode,
        child: Scrollbar(
          child: SingleChildScrollView(
            dragStartBehavior: DragStartBehavior.down,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                sizedBoxSpace,
                TextFormField(
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    filled: true,
                    icon: const Icon(Icons.store_sharp),
                    hintText: "Only your store would use this name",
                    labelText: "Store Unique Name",
                  ),
                  onSaved: (value) {
                    store.uniqueName = value;
                  },
                  validator: _validateName,
                ),
                sizedBoxSpace,
                TextFormField(
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    filled: true,
                    icon: const Icon(Icons.storefront_sharp),
                    hintText: "The display name",
                    labelText: "Store Display Name",
                  ),
                  onSaved: (value) {
                    store.displayName = value;
                  },
                  validator: _validateName,
                ),
                sizedBoxSpace,
                TextFormField(
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    filled: true,
                    icon: const Icon(Icons.tag),
                    hintText: "Enter Your Store Category(s)",
                    labelText: "Store Category & Tags",
                  ),
                  onSaved: (value) {
                    store.categoryTag.add(value);
                  },
                  validator: _validateName,
                ),
                sizedBoxSpace,
                TextFormField(
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    filled: true,
                    icon: const Icon(Icons.location_on_sharp ),
                    hintText: "Enter Locations Your Store can Reach",
                    labelText: "Store Location",
                  ),
                  onSaved: (value) {
                    store.operationLocations.add(value);
                  },
                  validator: _validateName,
                ),
                sizedBoxSpace,
                TextFormField(
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: "Your store's one-liner",
                    helperText: "Keep It Short & Simple",
                    labelText: "Store Description",
                  ),
                  onSaved: (value) {
                    store.description = value;
                  },
                  maxLines: 2,
                ),
                sizedBoxSpace,
                Center(
                  child: ElevatedButton(
                    child: Text("Create Store"),
                    onPressed: _handleSubmitted,
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.lightGreen)
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}