import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:tip_calci/util/hexcolor.dart';


class BillSpliter extends StatefulWidget {

  @override
  _BillSpliterState createState() => _BillSpliterState();
}

class _BillSpliterState extends State<BillSpliter> {

  int _tipPercentage = 0;
  int _personCount = 1;
  double _billAmount = 0.0;

  Color _red = HexColor("#FF0000");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
        alignment: Alignment.center,
        color: Colors.white,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(20.5),
          children: <Widget>[
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: _red.withOpacity(0.5),//Colors.redAccent,
                borderRadius: BorderRadius.circular(20.5),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Total Per Person",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.white
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text("\$ ${ calculateTotalperPerson( _billAmount, _personCount, _tipPercentage)}",
                          style: TextStyle(
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          )),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                      color: Colors.blueGrey.shade100,
                      style: BorderStyle.solid
                  ),
                  borderRadius: BorderRadius.circular(12.0)
              ),
              child: Column(
                children: [
                  TextField(
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    style: TextStyle(color: _red.withOpacity(0.5)),
                    decoration: InputDecoration(
                        prefixText: "Bill Amount : ",
                        prefixIcon: Icon(Icons.attach_money,
                          color: _red.withOpacity(0.4),
                        )
                    ),
                    onChanged: (String value){
                      try{
                        _billAmount = double.parse(value);
                      }catch(exception){
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Split",style: TextStyle(color: Colors.grey.shade700),),
                      Row(
                        children: <Widget>[
                          InkWell(
                            onTap: (){
                              setState(() {
                                if (_personCount >1){
                                  _personCount--;
                                }else{
                                  //do nothing
                                }
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              margin: EdgeInsets.all(10.0),
                              decoration:BoxDecoration(
                                  borderRadius: BorderRadius.circular(7.0),
                                  color: _red.withOpacity(0.2)
                              ),
                              child: Center(
                                child: Text("-",
                                  style: TextStyle(
                                      color: _red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30.0
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Text("$_personCount",
                            style: TextStyle(
                                color: _red,
                                fontWeight: FontWeight.bold,
                                fontSize:25.0
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              setState(() {
                                if (_personCount !=0){
                                  _personCount++;
                                }else{
                                  //do nothing
                                }
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              margin: EdgeInsets.all(10.0),
                              decoration:BoxDecoration(
                                  borderRadius: BorderRadius.circular(7.0),
                                  color: _red.withOpacity(0.2)
                              ),
                              child: Center(
                                child: Text("+",
                                  style: TextStyle(
                                      color: _red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30.0
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  //adding tip
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Tip",style: TextStyle(color: Colors.grey.shade700),),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text("\$ ${calculateTotaltip(_billAmount,_personCount,_tipPercentage)}",style: TextStyle(
                              color: _red,
                              fontWeight: FontWeight.bold,
                              fontSize: 25.5
                          ),),
                        )
                      ]
                  ),
                  //slider
                  Column(
                    children: [
                      Text("$_tipPercentage%",
                        style: TextStyle(
                            color: _red,
                            fontSize: 25.5,
                            fontWeight: FontWeight.bold
                        ),),
                      Slider(
                          min: 0,
                          max: 100,
                          activeColor: _red,
                          inactiveColor: Colors.grey,
                          divisions: 10,
                          value: _tipPercentage.toDouble(),
                          onChanged: (double newvalue){
                            setState(() {
                              _tipPercentage = newvalue.round();
                            });
                          }
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }


  calculateTotalperPerson(double billAmount, int splitBy,int tipPercentage){

    var totalPerPerson = (calculateTotaltip(billAmount, splitBy, tipPercentage) + billAmount) / splitBy;

    return totalPerPerson.toStringAsFixed(2);
  }

  calculateTotaltip(double billAmount, int splitBy, int tipPercentage){
    double totaltip = 0.0;

    if(billAmount <0 || billAmount.toString().isEmpty || billAmount == null){
      //do nothing
    }else{
      totaltip = (billAmount * tipPercentage)/100;
    }
    return totaltip;
  }
}
