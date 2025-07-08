import 'package:flutter/material.dart';
import 'package:munju_mpo/database/config.dart';

class stock extends StatefulWidget {
  const stock({super.key});

  @override
  State<stock> createState() => _stockState();
}

class _stockState extends State<stock> {
  void initState() {
    super.initState();
    _getData();
  }

  List<Map<String, dynamic>> _dataList = [];
  Future<void> _getData() async {
    final List<Map<String, dynamic>> data =
        await DatabaseHelper.getData('product');

    setState(() {
      _dataList = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'PRODUCT LIST',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              for (var data in _dataList)
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: data['product_id'] < 4
                        ? const Color.fromARGB(255, 139, 98, 23)
                        : const Color.fromARGB(255, 90, 90, 88),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 6),
                  margin: const EdgeInsets.all(3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image(
                        image: AssetImage('assets/${data['img']}'),
                        width: 20,
                      ),
                      Text(
                        data['name'].toString(),
                        style: const TextStyle(fontSize: 18),
                      ),
                      Text(data['qty'].toString(),
                          style: const TextStyle(fontSize: 18))
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
