import 'package:ferry_app/pages/searchresult.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

enum DateOptions { now, custom }

DateOptions? _dateOptions = DateOptions.now;

class _SearchPageState extends State<SearchPage> {
  TimeOfDay time = TimeOfDay.now();
  DateTime date = DateTime.now();

  bool _isDepartNowSelected = true;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Search"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            ListTile(
              title: Text('Route Name'),
              subtitle: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  hintText: 'Route name',
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: Text('Departure Point'),
                    subtitle: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        hintText: 'Departure Point',
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: ListTile(
                    title: Text('Arrival Point'),
                    subtitle: TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        hintText: 'Arrival Point',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            FloatingActionButton(
              onPressed: () {},
              child: Icon(
                Icons.swap_horiz,
                size: 35,
              ),
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
              title: Text('The Selected time is ${time.hour}:${time.minute} '),
              subtitle: ElevatedButton(
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchResultPage()),
                  );
                },
                child: Text('Search'))
          ],
        ),
      );
}
