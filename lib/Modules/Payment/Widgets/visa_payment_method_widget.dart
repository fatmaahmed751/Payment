import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../payment_controller.dart';

class VisaPaymentMethodWidget extends StatefulWidget {
  const VisaPaymentMethodWidget({super.key});

  @override
  createState() => VisaPaymentMethodWidgetState();
}

class VisaPaymentMethodWidgetState extends StateMVC<VisaPaymentMethodWidget> {
  VisaPaymentMethodWidgetState() : super(PaymentController()) {
    con = PaymentController();
  }

  late PaymentController con;
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool showBackView = false;
  String cardNumber ="",expiryDate="",cardHolderName="",cvvCode="";
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Padding(
        padding: EdgeInsetsDirectional.symmetric(
            horizontal: 24.w, vertical: 20.h),
        // horizontal: 20.w, vertical: 30.h),(
        child:Form(
         // key: _formKey,
          autovalidateMode: con.autoValidate?
          AutovalidateMode.always:
          AutovalidateMode.disabled,
          child: Column(
            children: [
              CreditCardWidget(
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                isHolderNameVisible: true,
                textStyle: const TextStyle(color: Colors.yellowAccent),
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                showBackView: showBackView, //true when you want to show cvv(back) view
                onCreditCardWidgetChange: (CreditCardBrand brand) {}, // Callback for anytime credit card brand is changed
              ),

          CreditCardForm(
            cardHolderName: cardHolderName,
            cardNumber: cardNumber,
            cvvCode: cvvCode,
            expiryDate: expiryDate,
            onCreditCardModelChange: (creditCardModel) {
              cardHolderName = creditCardModel.cardHolderName;
              cvvCode = creditCardModel.cvvCode;
              cardNumber = creditCardModel.cardNumber;
              expiryDate = creditCardModel.expiryDate;
              showBackView = creditCardModel.isCvvFocused;
              setState(() {});
            },
           formKey: _formKey,

          )
                ],
              ),
        ),
      ),
    );
  }
}
