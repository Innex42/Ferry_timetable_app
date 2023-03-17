import 'package:ferry_app/pages/searchresult.dart';
import 'package:flutter/material.dart';
import 'package:ferry_app/widgets/checkselectedport.dart';
import 'package:ferry_app/widgets/getdropdownfield.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

enum DateOptions { now, custom }

DateOptions? _dateOptions = DateOptions.now;

List<DropdownMenuItem<String>> get routeDropdownItems {
  List<DropdownMenuItem<String>> routeList = [
    DropdownMenuItem(value: "lar-mil", child: Text("Largs - Millport")),
    DropdownMenuItem(
        value: "gil-stm",
        child: Text("Gills Bay - St Margaret's Hope (Pentland)")),
    DropdownMenuItem(value: "bluemull", child: Text("Bluemull")),
    DropdownMenuItem(
        value: "pie-pap",
        child: Text("Westray - Papa Westray Passenger Service")),
    DropdownMenuItem(
        value: "wem-rot", child: Text("Bute: Wemyss Bay - Rothesay")),
  ];
  return routeList;
}

class _SearchPageState extends State<SearchPage> {
  TimeOfDay time = TimeOfDay.now();
  DateTime date = DateTime.now();
  bool _isDepartNowSelected = true;
  String? selectedRouteValue;
  String? selectedDeparturePoint;
  String? selectedArrivalPoint;
  bool alertHasApeared = false;
  bool depSelected = false;
  bool arrSelected = false;
  bool bothSelected = false;
  bool validInputs = false;

  @override
  Widget build(BuildContext context) => Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Search"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: DropdownButtonFormField2(
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding:
                          EdgeInsets.only(left: 5, bottom: 18, top: 18),
                      labelText: "Route Name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      hintText: 'Route Name',
                    ),
                    isExpanded: true,
                    value: selectedRouteValue,
                    items: routeDropdownItems,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedRouteValue = newValue!;
                        arrSelected = false;
                        depSelected = false;
                        bothSelected = false;
                        alertHasApeared = false;
                        selectedArrivalPoint = null;
                        selectedDeparturePoint = null;
                        debugPrint(
                            "Route:$selectedRouteValue is both selected?: $bothSelected");
                      });
                    }),
              ),
              SizedBox(
                width: 10,
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    DropdownButtonFormField2(
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding:
                              EdgeInsets.only(left: 5, bottom: 18, top: 18),
                          labelText: "Departure Point",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                          hintText: 'Departure Point',
                        ),
                        isExpanded: true,
                        value: selectedDeparturePoint,
                        items: DropDownItemSelecter()
                            .getDropDown(selectedRouteValue),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedDeparturePoint = newValue!;
                            if (depSelected == false && arrSelected == false) {
                              depSelected = true;
                            } else if (depSelected == false &&
                                arrSelected == true) {
                              depSelected = true;
                              bothSelected = true;
                            }
                            if (selectedArrivalPoint != null &&
                                selectedDeparturePoint != null &&
                                selectedArrivalPoint ==
                                    selectedDeparturePoint &&
                                bothSelected == true) {
                              showSameSelectionDialog(context);
                              alertHasApeared = true;
                            } else if (selectedArrivalPoint != null &&
                                selectedDeparturePoint != null &&
                                selectedArrivalPoint !=
                                    selectedDeparturePoint &&
                                bothSelected == true) {
                              validInputs = true;
                            }
                            debugPrint(
                                "Departure:$depSelected $selectedDeparturePoint is both selected?: $bothSelected");
                          });
                        }),
                    SizedBox(height: 15),
                    DropdownButtonFormField2(
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding:
                              EdgeInsets.only(left: 5, bottom: 18, top: 18),
                          labelText: "Arrival Point",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                          hintText: 'Arrival Point',
                        ),
                        value: selectedArrivalPoint,
                        items: DropDownItemSelecter()
                            .getDropDown(selectedRouteValue),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedArrivalPoint = newValue!;
                            if (arrSelected == false && depSelected == false) {
                              arrSelected = true;
                              alertHasApeared = false;
                            } else if (arrSelected == false &&
                                depSelected == true) {
                              arrSelected = true;
                              bothSelected = true;
                              alertHasApeared = false;
                            }
                            if (selectedArrivalPoint != null &&
                                selectedDeparturePoint != null &&
                                selectedArrivalPoint ==
                                    selectedDeparturePoint &&
                                bothSelected == true &&
                                alertHasApeared != true) {
                              showSameSelectionDialog(context);
                              alertHasApeared = true;
                            } else if (selectedArrivalPoint != null &&
                                selectedDeparturePoint != null &&
                                selectedArrivalPoint !=
                                    selectedDeparturePoint &&
                                bothSelected == true) {
                              validInputs = true;
                            }
                            debugPrint(
                                "arrival:$arrSelected $selectedArrivalPoint is both selected?: $bothSelected");
                          });
                        })
                  ],
                ),
              ),
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FloatingActionButton(
                        onPressed: () {
                          setState(() {
                            String? temp;
                            temp = selectedArrivalPoint;
                            selectedArrivalPoint = selectedDeparturePoint;
                            selectedDeparturePoint = temp;
                          });
                        },
                        child: Icon(
                          Icons.swap_vert,
                          size: 35,
                        ),
                      )
                    ]),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.only(left: 20.0),
            alignment: Alignment.centerLeft,
            child: Text(
              'Select Time & Day',
              style: TextStyle(fontSize: 15),
            ),
          ),
          RadioListTile<DateOptions>(
            title: Text('Depart Now'),
            value: DateOptions.now,
            groupValue: _dateOptions,
            onChanged: (DateOptions? value) {
              setState(() {
                _dateOptions = value;
                _isDepartNowSelected = true;
                time = TimeOfDay.now();
                date = DateTime.now();
              });
            },
          ),
          RadioListTile<DateOptions>(
            title: Text('Custom'),
            value: DateOptions.custom,
            groupValue: _dateOptions,
            onChanged: (DateOptions? value) {
              setState(() {
                _dateOptions = value;
                _isDepartNowSelected = false;
              });
            },
          ),
          SizedBox(
            height: 5,
          ),
          ListTile(
            title: time.minute > 9
                ? Text('The Selected time is ${time.hour}:${time.minute} ')
                : Text('The Selected time is ${time.hour}:0${time.minute} '),
            subtitle: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: _isDepartNowSelected
                  ? null
                  : () async {
                      TimeOfDay? newTime = await showTimePicker(
                          context: context, initialTime: time);

                      //if 'CANCEL' => null
                      if (newTime == null) return;

                      //if 'OK' => Time Of Day
                      setState(() => time = newTime);
                    },
              child: Text('Select Time'),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          ListTile(
            title: Text(
                'The Selected Date is ${date.day}/${date.month}/${date.year} '),
            subtitle: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: _isDepartNowSelected
                  ? null
                  : () async {
                      DateTime? newDate = await showDatePicker(
                          context: context,
                          initialDate: date,
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(Duration(days: 7)));

                      //if cancel => null
                      if (newDate == null) return;

                      //if OK => DateTime
                      setState(() => date = newDate);
                    },
              child: Text('Select Date'),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: validInputs == false
                  ? null
                  : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SearchResultPage()),
                      );
                    },
              child: Text('Search')),
        ],
      )));
}
