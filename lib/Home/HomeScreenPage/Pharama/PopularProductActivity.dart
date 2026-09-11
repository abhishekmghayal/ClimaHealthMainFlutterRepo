import 'package:climahealth/Home/HomeScreenPage/Pharama/DeliveryMed/MedCart.dart';
import 'package:flutter/material.dart';

class PopularProductActivity extends StatefulWidget {
  @override
  State<PopularProductActivity> createState() => _PopularProductState();
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
  Medicine(
      name: "Paracetamol",
      image: "assets/images/p2.png",
      price: "\$2.99",
      pcs: 10),

  Medicine(
      name: "Doxycycline",
      image: "assets/images/p2.png",
      price: "\$5.49",
      pcs: 10),

  Medicine(
      name: "Artemether + Lumefantrine",
      image: "assets/images/p2.png",
      price: "\$12.99",
      pcs: 6),

  Medicine(
      name: "Primaquine",
      image: "assets/images/p2.png",
      price: "\$4.99",
      pcs: 14),

  Medicine(
      name: "Chloroquine",
      image: "assets/images/p2.png",
      price: "\$3.99",
      pcs: 10),
  Medicine(
      name: "Doxycycline",
      image: "assets/images/p2.png",
      price: "\$5.49",
      pcs: 10),

  Medicine(
      name: "Artemether + Lumefantrine",
      image: "assets/images/p2.png",
      price: "\$12.99",
      pcs: 6),

  Medicine(
      name: "Primaquine",
      image: "assets/images/p2.png",
      price: "\$4.99",
      pcs: 14),

  Medicine(
      name: "Chloroquine",
      image: "assets/images/p2.png",
      price: "\$3.99",
      pcs: 10),
  Medicine(
      name: "Doxycycline",
      image: "assets/images/p2.png",
      price: "\$5.49",
      pcs: 10),

  Medicine(
      name: "Artemether + Lumefantrine",
      image: "assets/images/p2.png",
      price: "\$12.99",
      pcs: 6),

  Medicine(
      name: "Primaquine",
      image: "assets/images/p2.png",
      price: "\$4.99",
      pcs: 14),

  Medicine(
      name: "Chloroquine",
      image: "assets/images/p2.png",
      price: "\$3.99",
      pcs: 10),
];

class _PopularProductState extends State<PopularProductActivity> {

  double getTotalPrice(){
    double total=0;
    for(int i=0;i<allMedicines.length;i++){
      String priceStr=allMedicines[i].price.replaceAll("\$", "");
      double price=double.parse(priceStr);
      total+=price*counters[i];
    }
    return total;
  }

  List<int> counters = List.generate(allMedicines.length, (index) => 0);

  void increment(int index) {
    setState(() {
      counters[index]++;
    });
  }

  void decrement(int index) {
    setState(() {
      if (counters[index] > 0) {
        counters[index]--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Popular Products",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Color(0xFF147B72).withOpacity(0.12),
        foregroundColor: Color(0xFF147B72),
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 20),
          color: Color(0xFF147B72).withOpacity(0.12),
          child: GridView.builder(
            padding: EdgeInsets.all(10),
            itemCount: allMedicines.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.75,
            ),
            itemBuilder: (context, index) {
              Medicine med = allMedicines[index];

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
                    Text(
                      med.name,
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 6),
                    Text("${med.pcs} pcs"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          med.price,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () => decrement(index),
                              child: Container(
                                height: 35,
                                width: 35,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius:
                                  BorderRadius.circular(8),
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
                                  color: Color(0xFF147B72)
                                      .withOpacity(0.8),
                                  borderRadius:
                                  BorderRadius.circular(8),
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

                    for (int i = 0; i < allMedicines.length; i++) {
                      if (counters[i] > 0) {
                        selectedItems.add({
                          'medicine': allMedicines[i],
                          'quantity': counters[i],
                        });
                      }
                    }

                    if (selectedItems.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Select at least one medicine"),
                            backgroundColor: Color(0xFF147B72))
                        ,
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
                        content: Text("Added ${allMedicines.length} medicine(s) to cart"),
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