import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart' show DragStartBehavior;

class Send extends StatefulWidget {
  Send({Key key}) : super(key: key);

  @override
  _SendFormState createState() => _SendFormState();

}

class _SendFormState extends State<Send>{

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

class PersonData {
  String phoneNumber = '';
  num amount = 00.0;
}

List<Widget> _options = [
  TextButton(
    child: Text("Send Only"),
    onPressed: (){

    },
  ),
  TextButton(
    child: Text("Send & Save"),
    onPressed: (){

    },
  )
];

class _BottomSheetContent extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Column(
        children: [
          Container(
            height: 70,
            child: Center(
              child: Text("Options", textAlign: TextAlign.center ),
            ),
          ),
          const Divider(thickness: 1),
          Expanded(
            child: ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                return ListTile( title: _options[index], enabled: true, );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TextFormFieldDemoState extends State<TextFormFieldDemo> {
  PersonData person = PersonData();

  void showInSnackBar(String value) {
    Scaffold.of(context).hideCurrentSnackBar();
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(value),
    ));
  }

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return _BottomSheetContent();
      },
    );
  }

  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _UsNumberTextInputFormatter _phoneNumberFormatter = _UsNumberTextInputFormatter();

  void _handleSubmitted() {
    final form = _formKey.currentState;
    if (!form.validate()) {
      _autoValidateMode = AutovalidateMode.always; // Start validating on every change.
      showInSnackBar("", );
    } else {
      form.save();
    }
    _showModalBottomSheet(context);
  }

  String _validatePhoneNumber(String value) {
    final phoneExp = RegExp(r'^\(\d\d\d\) \d\d\d\-\d\d\d\d$');
    if (!phoneExp.hasMatch(value)) {
      return "Invalid mobile number in use.";
    }
    return null;
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
                  decoration: InputDecoration(
                    filled: true,
                    icon: const Icon(Icons.phone),
                    hintText: "Recipient PhoneNumber",
                    labelText: "PhoneNumber",
                    prefixText: '+ ',
                  ),
                  keyboardType: TextInputType.phone,
                  onSaved: (value) {
                    person.phoneNumber = value;
                  },
                  maxLength: 18,
                  maxLengthEnforced: false,
                  validator: _validatePhoneNumber,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly, _phoneNumberFormatter,
                  ],
                ),
                sizedBoxSpace,
                TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    icon: const Icon( Icons.money_sharp ),
                    hintText: "Amount",
                    labelText: "Amount",
                    prefixText: "USD ",
                  ),
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    person.amount = double.parse(value);
                  },
                  maxLength: 14,
                  maxLengthEnforced: true,
                ),
                sizedBoxSpace,
                Center(
                  child: ElevatedButton(
                    child: Text("Complete Transfer"),
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

class _UsNumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final newTextLength = newValue.text.length;
    final newText = StringBuffer();
    var selectionIndex = newValue.selection.end;
    var usedSubstringIndex = 0;
    if (newTextLength >= 4) {
      newText.write(newValue.text.substring(0, usedSubstringIndex = 3) + '-');
      if (newValue.selection.end >= 3) selectionIndex++;
    }
    if (newTextLength >= 7) {
      newText.write(newValue.text.substring(4, usedSubstringIndex = 7) + '-');
      if (newValue.selection.end >= 6) selectionIndex++;
    }
    if (newTextLength >= 11) {
      newText.write(newValue.text.substring(6, usedSubstringIndex = 10) + '-');
      if (newValue.selection.end >= 10) selectionIndex++;
    }
    if (newTextLength >= 14) {
      newText.write(newValue.text.substring(9, usedSubstringIndex = 13) + '-');
      if (newValue.selection.end >= 10) selectionIndex++;
    }
    if (newTextLength >= usedSubstringIndex) {
      newText.write(newValue.text.substring(usedSubstringIndex));
    }
    return TextEditingValue(
        text: newText.toString(), selection: TextSelection.collapsed(offset: selectionIndex)
    );
  }
}