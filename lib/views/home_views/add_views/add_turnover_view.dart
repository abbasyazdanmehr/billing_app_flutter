import 'package:billing_app/constants/constants.dart';
import 'package:billing_app/controllers/turnovers_controller.dart';
import 'package:billing_app/enums/turnover_type.dart';
import 'package:billing_app/models/turnover.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';

class AddTurnoverView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final box = GetStorage();
  final controller = Get.put(TurnoversController());

  Widget formFields(BuildContext context) {
    int _inputMount;
    String _inputDescription;

    return Form(
      key: _formKey,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Column(
              children: [
                if (box.read('turnoverIndex') == TurnoverType.Income.index)
                  Text(
                    'Add Income!',
                    style: TextStyle(fontSize: 35.sp),
                  ),
                if (box.read('turnoverIndex') == TurnoverType.Cost.index)
                  Text(
                    'Add Cost!',
                    style: TextStyle(fontSize: 35.sp),
                  ),
                if (box.read('turnoverIndex') == TurnoverType.FutureCost.index)
                  Text(
                    'Add Future Cost!',
                    style: TextStyle(fontSize: 20.sp),
                  ),
                TextFormField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.money),
                    hintText: 'Mount',
                  ),
                  validator: (String value) {
                    if (value.isEmpty || !Constants.isInteger(value)) {
                      return 'this mount is invalid';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (String value) => _inputMount = int.parse(value),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'description',
                  ),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'this description is invalid';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (String value) => _inputDescription = value,
                ),
                SizedBox(
                  height: 10.h,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 1.h,
            right: 2.w,
            child: Container(
              height: 7.h,
              width: 86.w,
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    controller.createTurnover(
                      Turnover(
                        mount: _inputMount,
                        bankAccountId: 1, //TODO: _inputBankAccount
                        time: DateTime.now(),
                        turnoverType: box.read('turnoverIndex'),
                        description: _inputDescription,
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
                child: Text('Add'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Constants.responsiveGlassBlock(
              context: context,
              heightRatio: 0.8,
              widthRatio: 0.9,
              content: formFields(context),
            ),
          ),
        ),
      ),
    );
  }
}
