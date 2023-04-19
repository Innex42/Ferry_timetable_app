import 'package:flutter/material.dart';

List<DropdownMenuItem<String>> larMill = [
  DropdownMenuItem(
    value: "largs",
    child: Text("Largs"),
  ),
  DropdownMenuItem(
    value: "millport",
    child: Text("Millport"),
  )
];
List<DropdownMenuItem<String>> gilStm = [
  DropdownMenuItem(value: "gills", child: Text("Gills Bay")),
  DropdownMenuItem(
      value: "st margaret's hope", child: Text("St Margaret's Hope"))
];
List<DropdownMenuItem<String>> bluemull = [
  DropdownMenuItem(value: "gutcher", child: Text("Gutcher")),
  DropdownMenuItem(value: "belmont", child: Text("Belmont")),
  DropdownMenuItem(value: "hamars ness", child: Text("Hamars Ness"))
];
List<DropdownMenuItem<String>> piePap = [
  DropdownMenuItem(value: "pierowall", child: Text("Pierowall")),
  DropdownMenuItem(value: "papa westray", child: Text("Papa Westray"))
];
List<DropdownMenuItem<String>> wemRot = [
  DropdownMenuItem(value: "wemyss bay", child: Text("Wemyss Bay")),
  DropdownMenuItem(value: "rothesay", child: Text("Rothesay"))
];

List<DropdownMenuItem<String>> nonSelect = [
  DropdownMenuItem(
    value: "nonselect",
    child: Text("Select a Route"),
  )
];

class DropDownItemSelecter {
  List<DropdownMenuItem<String>> getDropDown(String? routeValue) {
    if (routeValue == "lar-mil") {
      return larMill;
    } else if (routeValue == "gil-stm") {
      return gilStm;
    } else if (routeValue == "bluemull") {
      return bluemull;
    } else if (routeValue == "pie-pap") {
      return piePap;
    } else if (routeValue == "wem-rot") {
      return wemRot;
    } else {
      return nonSelect;
    }
  }
}
