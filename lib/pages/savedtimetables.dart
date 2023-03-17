import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:ferry_app/widgets/checkselectedport.dart';
import 'package:ferry_app/widgets/getdropdownfield.dart';
import 'package:flutter/material.dart';

class SavedTimetablesPage extends StatefulWidget {
  const SavedTimetablesPage({super.key});

  @override
  State<SavedTimetablesPage> createState() => _SavedTimetablesPageState();
}

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

class _SavedTimetablesPageState extends State<SavedTimetablesPage> {
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
        appBar: AppBar(
          title: const Text("Saved Timetables"),
          centerTitle: true,
        ),
        body: Column(children: [
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
          SizedBox(width: 8),
          ElevatedButton(
              onPressed: validInputs == false
                  ? null
                  : () {
                      /*Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SearchResultPage()),
                );*/
                    },
              child: Text('Search'))
        ]),
      );
}
