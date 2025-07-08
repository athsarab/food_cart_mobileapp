import 'package:flutter/material.dart';
import 'package:d_chart/d_chart.dart';
import 'package:intl/intl.dart';
import 'package:munju_mpo/page/nic.dart';
import 'package:shared_preferences/shared_preferences.dart';

class dashboard extends StatefulWidget {
  const dashboard({super.key});

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  String dateView = "0000-00-00 00:00:00";
  String user = '';
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd HH:mm:ss');

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      user = prefs.getString('name').toString();
      dateView = formatter.format(now);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 25, 141, 187)),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 6),
              child: Column(
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Hi $user",
                            style: const TextStyle(fontSize: 25),
                          ),
                          Text(
                            dateView,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Color.fromARGB(255, 8, 48, 63)),
                          ),
                        ],
                      ),
                      const CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/avertar.jpeg'), // Add your asset
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 70,
                  )
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  const SizedBox(
                    height: 140,
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 60, 69, 72)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          children: [
                            Text(
                              'Monthly Target',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 151, 154, 157)),
                            ),
                            Text(
                              'Rs.150000.00',
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Achievement',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 151, 154, 157)),
                            ),
                            Text(
                              'Rs.6300.00',
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.4,
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Stack(
                            children: [
                              DChartPieO(
                                data: ordinalDataList,
                                configRenderPie: const ConfigRenderPie(
                                  arcWidth: 20,
                                  strokeWidthPx: 0,
                                ),
                              ),
                              const Center(
                                child: Text(
                                  '65%',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                    color: Color.fromARGB(221, 255, 255, 255),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 60, 69, 72)),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: DChartBarO(
                        configRenderBar: ConfigRenderBar(
                          barGroupInnerPaddingPx: 0,
                          radius: 30,
                        ),
                        domainAxis: const DomainAxis(
                          showLine: false,
                          gapAxisToLabel: 12,
                        ),
                        measureAxis: const MeasureAxis(
                          noRenderSpec: true,
                        ),
                        groupList: [
                          OrdinalGroup(
                            id: '1',
                            data: series1,
                            color: const Color.fromARGB(255, 155, 94, 222),
                          ),
                          OrdinalGroup(
                            id: '2',
                            data: series2,
                            color: const Color.fromARGB(255, 65, 147, 228),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 60, 69, 72)),
                    child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Kalum sadaruwan',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            'Rs.13090.00',
                            style: TextStyle(fontSize: 20),
                          ),
                        ]),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 60, 69, 72)),
                    child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Amarapala hewage',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            'Rs.28500.00',
                            style: TextStyle(fontSize: 20),
                          ),
                        ]),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 60, 69, 72)),
                    child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Sunitha premadasa',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            'Rs.26000.00',
                            style: TextStyle(fontSize: 20),
                          ),
                        ]),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 60, 69, 72)),
                    child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Erasha sewwandi',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            'Rs.10000.00',
                            style: TextStyle(fontSize: 20),
                          ),
                        ]),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 7, 226, 255),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const nic(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

List<OrdinalData> ordinalDataList = [
  OrdinalData(
    domain: 'Completed',
    measure: 65,
    color: const Color.fromARGB(255, 58, 98, 183),
  ),
  OrdinalData(
    domain: 'Uncompleted',
    measure: 35,
    color: Colors.deepPurple.shade50,
  ),
];

List<OrdinalData> series1 = [
  OrdinalData(domain: 'Mon', measure: 2.4),
  OrdinalData(domain: 'Tue', measure: 2),
  OrdinalData(domain: 'Wed', measure: 1),
  OrdinalData(domain: 'Thu', measure: 4.5),
  OrdinalData(domain: 'Fri', measure: 2),
  OrdinalData(domain: 'Sat', measure: 3.5),
  OrdinalData(domain: 'Sun', measure: 2),
];
List<OrdinalData> series2 = [
  OrdinalData(domain: 'Mon', measure: 3),
  OrdinalData(domain: 'Tue', measure: 1.8),
  OrdinalData(domain: 'Wed', measure: 4),
  OrdinalData(domain: 'Thu', measure: 3),
  OrdinalData(domain: 'Fri', measure: 6),
  OrdinalData(domain: 'Sat', measure: 5),
  OrdinalData(domain: 'Sun', measure: 3.5),
];
