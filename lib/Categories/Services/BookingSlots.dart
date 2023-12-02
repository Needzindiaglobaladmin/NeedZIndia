import 'package:NeedZIndia/Class/Services.dart';
import 'package:NeedZIndia/Screen/Login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:NeedZIndia/Screen/SelectAddress.dart';

class BookingSlots extends StatefulWidget {
  final ServicesData servicesData;
  final String serviceName;
  BookingSlots({Key key, this.servicesData,this.serviceName}) : super(key: key );
  @override
  _BookingSlots createState() => _BookingSlots();
}


class _BookingSlots extends State<BookingSlots> {
  String date = '';
  bool clickOnDate = false;
  String radioItem = '';
  String slot1= '';
  String slot2 = '';
  int slot1Id;
  int slot2Id;
  int selectedCard = -1;
  bool clickOnSlot = false;
  int numberOfPerson = 1;
  @override
  void initState() {
    super.initState();
  }
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: FittedBox(fit:BoxFit.fitWidth,
          child: Text('Choose slot',style: GoogleFonts.quicksand(
            textStyle: TextStyle(fontSize: 22),),),
        ),
        backgroundColor: Colors.cyan[600],
      ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blueGrey,
                      width: 0.2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: GridView.builder(
                      shrinkWrap: true,
                      itemCount:   widget.servicesData.bookingSlots.isEmpty==true ? 0 : widget.servicesData.bookingSlots.length,
                      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:4,crossAxisSpacing: 2),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: (){
                            setState(() {
                              selectedCard = index;
                              clickOnDate = true;
                              print(widget.servicesData.bookingSlots[index].date);
                              widget.servicesData.bookingSlots[index].isSlot1Available == true ? slot1 = widget.servicesData.timeSlots[0].name: slot1 = 'Slot1 is full';
                              widget.servicesData.bookingSlots[index].isSlot2Available == true ? slot2 = widget.servicesData.timeSlots[1].name: slot1 = 'Slot2 is full';
                              widget.servicesData.bookingSlots[index].isSlot1Available == true ? slot1Id = widget.servicesData.timeSlots[0].id: slot1Id = 0;
                              widget.servicesData.bookingSlots[index].isSlot2Available == true ? slot2Id = widget.servicesData.timeSlots[1].id: slot2Id = 0;
                              date =  widget.servicesData.bookingSlots[index].date;
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.blueGrey,
                                  width: 0.2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                                color: selectedCard == index ? Colors.cyan[100] : Colors.blueGrey[100],
                              ),
                            margin: EdgeInsets.all(8),
                            child: Container(
                              margin: EdgeInsets.all(5),
                              child: Text(DateFormat("EEE, d MMM yyyy").format(DateTime.parse(widget.servicesData.bookingSlots[index].date)),style: GoogleFonts.quicksand(
                                textStyle: TextStyle(fontSize: 16),),),
                            )
                          ),
                        );
                      }),
                ),
                SizedBox(height: 20,),
                clickOnDate?
                Container(
                  margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blueGrey,
                        width: 0.2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.blueGrey[50],
                    ),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20,),
                        slot1 == 'Slot1 is full'?
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Text(slot1,textAlign: TextAlign.center,style: GoogleFonts.quicksand(
                            textStyle: TextStyle(fontSize: 18,color: Colors.red,fontWeight: FontWeight.w700),),),
                        ):
                        RadioListTile(
                          activeColor: Colors.black,
                          groupValue: radioItem,
                          title: Text(slot1,textAlign: TextAlign.center,style: GoogleFonts.quicksand(
                            textStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.blueGrey),),),
                          value: slot1Id.toString(),
                          onChanged: (val) {
                            setState(() {
                              radioItem = val;
                              clickOnSlot = true;
                            });
                          },
                        ),
                        slot2 == 'Slot1 is full'?
                        Container(
                          margin: EdgeInsets.all(10),
                          child: Text(slot2,textAlign: TextAlign.center,style: GoogleFonts.quicksand(
                            textStyle: TextStyle(fontSize: 18,color: Colors.red,fontWeight: FontWeight.w700),),),
                        ):
                        RadioListTile(
                          activeColor: Colors.black,
                          groupValue: radioItem,
                          title: Text(slot2,textAlign: TextAlign.center,style: GoogleFonts.quicksand(
                            textStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,color: Colors.blueGrey),),),
                          value: slot2Id.toString(),
                          onChanged: (val) {
                            setState(() {
                              radioItem = val;
                              clickOnSlot = true;
                            });
                          },
                        ),
                        SizedBox(height: 20,),
                      ],
                    ),
                ):Container(),
                SizedBox(height: 15,),
                clickOnSlot ? Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blueGrey,
                      width: 0.2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.blueGrey[50],
                  ),
                  child: Row(
                    children:<Widget> [
                      Expanded(child: Container(
                        margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
                        alignment: Alignment.center,
                        child: Text("Number Of Person:"),
                      )),
                      Expanded(child: Container(
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                             GestureDetector(
                               onTap: (){
                                 setState(() {
                                   if(numberOfPerson>1){
                                     numberOfPerson --;
                                   }
                                 });
                               },
                               child:  Container(
                                 color: Colors.blueGrey,
                                 margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                 child: Icon(Icons.remove,color: Colors.white,),
                               ),
                             ),
                              Container(
                                child:Text(numberOfPerson.toString()),
                              ),
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    numberOfPerson++;
                                  });
                                },
                                child: Container(
                                  color: Colors.blueGrey,
                                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Icon(Icons.add,color: Colors.white,),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                    ],
                  ),
                ):Container(),
              ],
            ),
          ),
        ),
      bottomSheet:  Container(
        height: 40,
        margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: RaisedButton(
          textColor: Colors.white,
          color: Colors.cyan[600],
          child: Text('BOOK SLOT',style: GoogleFonts.quicksand(
            textStyle: TextStyle(fontSize: 18),),),
          onPressed: ()  async {
            var _prefs = await SharedPreferences.getInstance();
            var token = _prefs.getString('token');
            if(token == null){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> Login()),
              );
            }
            else{
              var serviceId;
              var price;
              for(int i =0;i<widget.servicesData.services.length;i++){
                if(widget.servicesData.services[i].name == widget.serviceName){
                  serviceId = widget.servicesData.services[i].id;
                  price = widget.servicesData.services[i].pricePerPerson;
                }
              }
              print(widget.serviceName);
              print(serviceId);
              print(date);
              print(radioItem);
              var person = numberOfPerson;
              if(radioItem.isEmpty==true){
                Toast.show('Choose a slot', context, duration: Toast.LENGTH_LONG, gravity:  Toast.TOP);
              }
              else{
                Navigator.push(context, MaterialPageRoute(builder: (context)=> SelectAddress(bookingDate: date,serviceId: serviceId,timeSlotId: radioItem,previousPage: 'SlotBooking',pricePerPerson:price,numberOfPerson: person)),);
              }
            }
          },
        ),
      ),
    );
  }
}

