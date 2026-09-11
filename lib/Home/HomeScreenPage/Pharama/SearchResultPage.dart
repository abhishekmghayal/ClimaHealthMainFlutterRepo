import 'package:flutter/material.dart';

import 'DeliveryMed/MedCart.dart';

class SearchResultPage extends StatefulWidget {
  final String searchText;
  const SearchResultPage({super.key, required this.searchText});

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class Medicine {
  String name;
  String image;
  String price;
  int pcs;

  Medicine({
    required this.name,
    required this.image,
    required this.price,
    required this.pcs,
  });
}

List<Medicine> allMedicines = [
  Medicine(name: "Paracetamol", image: "assets/images/p2.png", price: "\$7.99", pcs: 12),
  Medicine(name: "Panadol", image: "assets/images/p2.png", price: "\$7.99", pcs: 12),
  Medicine(name: "Dolo 650", image: "assets/images/p2.png", price: "\$7.99", pcs: 12),
  Medicine(name: "Crocin", image: "assets/images/p2.png", price: "\$7.99", pcs: 12),
  Medicine(name: "Ctera", image: "assets/images/p2.png", price: "\$7.99", pcs: 12),
  Medicine(name: "Crocnono", image: "assets/images/p2.png", price: "\$7.99", pcs: 12),
  Medicine(name: "Paima", image: "assets/images/p2.png", price: "\$7.99", pcs: 12),
  Medicine(name: "Daledo", image: "assets/images/p2.png", price: "\$7.99", pcs: 12),
  Medicine(name: "Chema", image: "assets/images/p2.png", price: "\$7.99", pcs: 12),
];

class _SearchResultPageState extends State<SearchResultPage> {
  List<Medicine> results = [];
  List<int> counters = []; // ⭐ initialize here

  @override
  void initState() {
    super.initState();

    results = allMedicines.where((med) {
      return med.name.toLowerCase().contains(widget.searchText.toLowerCase());
    }).toList();

    counters = List.generate(results.length, (index) => 0);
  }

  void increment(int index) {
    setState(() => counters[index]++);
  }

  void decrement(int index) {
    setState(() {
      if (counters[index] > 0) counters[index]--;
    });
  }

  double getTotalPrice(){
    double total = 0;

    for(int i = 0; i < results.length; i++){
      String priceStr = results[i].price.replaceAll("\$", "");
      double price = double.parse(priceStr);

      total += price * counters[i];
    }

    return total;
  }

  @override
  Widget build(BuildContext context) {
    if (counters.length != results.length) {
      counters = List.generate(results.length, (index) => 0);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Search: ${widget.searchText}"),
        backgroundColor: Color(0xFF147B72).withOpacity(0.12),
      ),
      body: results.isEmpty
          ? Center(child: Text("No Product Found"))
          : Container(
        color: Color(0xFF147B72).withOpacity(0.12),
        child: GridView.builder(
          padding: EdgeInsets.all(10),
          itemCount: results.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) {
            Medicine med = results[index];

            return Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 8,
                    spreadRadius: 2,
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Center(
                      child: Image.asset(med.image, fit: BoxFit.contain),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(med.name,
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold)),
                  SizedBox(height: 6),
                  Text(med.pcs.toString()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [


                      Text(med.price,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => decrement(index),
                            child: Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(Icons.remove, size: 18),
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            counters[index].toString(),
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 8),
                          GestureDetector(
                            onTap: () => increment(index),
                            child: Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                color: Color(0xFF147B72).withOpacity(0.8),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(Icons.add,
                                  color: Colors.white, size: 18),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 10,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 10,
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              /// Total Price
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Total",
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    "\$${getTotalPrice().toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              /// Button
              ElevatedButton.icon(
                  onPressed: () {

                    List<Map<String, dynamic>> selectedItems = [];

                    for (int i = 0; i < results.length; i++) {
                      if (counters[i] > 0) {
                        selectedItems.add({
                          'medicine': results[i],
                          'quantity': counters[i],
                        });
                      }
                    }

                    if (selectedItems.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Select at least one medicine"),
                          backgroundColor: Color(0xFF147B72),
                        ),
                      );
                      return;
                    }

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MedCart(selectedItems: selectedItems),
                      ),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Added ${selectedItems.length} medicine(s) to cart"),
                        backgroundColor: Color(0xFF147B72),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                icon: Icon(Icons.shopping_cart),
                label: Text("Add To Cart"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF147B72),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}