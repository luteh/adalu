import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_rekret_ecommerce/view/basewidget/textfield/custom_textfield.dart';

class CounterNumberField extends StatefulWidget {
  final Function(String value) onChanged;

  const CounterNumberField({
    Key key,
    @required this.onChanged,
  }) : super(key: key);
  @override
  _CounterNumberFieldState createState() => _CounterNumberFieldState();
}

class _CounterNumberFieldState extends State<CounterNumberField> {
  final _controller = TextEditingController();
  final _streamController = StreamController<int>();

  StreamSubscription<int> _subscription;

  Stream<int> get _stream => _streamController.stream;
  Sink<int> get _sink => _streamController.sink;

  int initValue = 1;

  @override
  void initState() {
    super.initState();
    _sink.add(initValue);
    _subscription =
        _stream.listen((event) => _controller.text = event.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            _sink.add(--initValue);
          },
          child: const Icon(
            Icons.remove,
            size: 20,
          ),
        ),
        SizedBox(width: 2),
        Expanded(
          child: CustomTextField(
            controller: _controller,
            textInputType: TextInputType.phone,
            onChanged: widget.onChanged,
          ),
        ),
        SizedBox(width: 2),
        InkWell(
          onTap: () {
            _sink.add(++initValue);
          },
          child: const Icon(
            Icons.add,
            size: 20,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _streamController.close();
    _controller.dispose();
    super.dispose();
  }
}
