import 'package:flutter/material.dart';

import 'DeliveryMed/MedCart.dart';

class DiseaseMedicineScreen extends StatefulWidget {
  final String diseaseName;

  DiseaseMedicineScreen({required this.diseaseName});

  @override
  State<DiseaseMedicineScreen> createState() =>
      _DiseaseMedicineScreenState();
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

class _DiseaseMedicineScreenState extends State<DiseaseMedicineScreen> {
  late List<Medicine> medicines;
  late List<int> counters;

  @override
  void initState() {
    super.initState();
    medicines = getMedicines(widget.diseaseName);
    counters = List.generate(medicines.length, (index) => 0);
  }

  List<Medicine> getMedicines(String disease) {
    switch (disease) {
      case "Malaria":
        return [
          Medicine(
              name: "Artemether + Lumefantrine",
              image: "assets/images/p2.png",
              price: "\$12.99",
              pcs: 6),
          Medicine(
              name: "Chloroquine",
              image: "assets/images/p2.png",
              price: "\$3.99",
              pcs: 10),
          Medicine(
              name: "Primaquine",
              image: "assets/images/p2.png",
              price: "\$4.99",
              pcs: 14),
          Medicine(
              name: "Artemether + Lumefantrine",
              image: "assets/images/p2.png",
              price: "\$12.99",
              pcs: 6),
          Medicine(
              name: "Chloroquine",
              image: "assets/images/p2.png",
              price: "\$3.99",
              pcs: 10),
          Medicine(
              name: "Primaquine",
              image: "assets/images/p2.png",
              price: "\$4.99",
              pcs: 14),
          Medicine(
              name: "Artemether + Lumefantrine",
              image: "assets/images/p2.png",
              price: "\$12.99",
              pcs: 6),
          Medicine(
              name: "Chloroquine",
              image: "assets/images/p2.png",
              price: "\$3.99",
              pcs: 10),
          Medicine(
              name: "Primaquine",
              image: "assets/images/p2.png",
              price: "\$4.99",
              pcs: 14),
          Medicine(
              name: "Artemether + Lumefantrine",
              image: "assets/images/p2.png",
              price: "\$12.99",
              pcs: 6),
          Medicine(
              name: "Chloroquine",
              image: "assets/images/p2.png",
              price: "\$3.99",
              pcs: 10),
          Medicine(
              name: "Primaquine",
              image: "assets/images/p2.png",
              price: "\$4.99",
              pcs: 14),
          Medicine(
              name: "Artemether + Lumefantrine",
              image: "assets/images/p2.png",
              price: "\$12.99",
              pcs: 6),
          Medicine(
              name: "Chloroquine",
              image: "assets/images/p2.png",
              price: "\$3.99",
              pcs: 10),
          Medicine(
              name: "Primaquine",
              image: "assets/images/p2.png",
              price: "\$4.99",
              pcs: 14),
        ];

      case "Dengue":
        return [
          Medicine(
              name: "Paracetamol",
              image: "assets/images/p2.png",
              price: "\$2.99",
              pcs: 10),
          Medicine(
              name: "ORS",
              image: "assets/images/p2.png",
              price: "\$1.99",
              pcs: 5),
        ];

      case "Lyme":
        return [
          Medicine(
              name: "Doxycycline",
              image: "assets/images/p2.png",
              price: "\$5.49",
              pcs: 10),
          Medicine(
              name: "Amoxicillin",
              image: "assets/images/p2.png",
              price: "\$6.99",
              pcs: 12),
        ];

      default:
        return [
          Medicine(
              name: "Supportive Care",
              image: "assets/images/p2.png",
              price: "\$3.99",
              pcs: 5),
        ];
    }
  }

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

  double getTotalPrice() {
    double total = 0;
    for (int i = 0; i < medicines.length; i++) {
      String priceStr = medicines[i].price.replaceAll("\$", "");
      double price = double.parse(priceStr);
      total += price * counters[i];
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: const Color(0xFF147B72).withOpacity(0.12),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF147B72)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
            widget.diseaseName,
            style: TextStyle(
                color: Color(0xFF147B72),
                fontWeight: FontWeight.bold
            )
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 20),
        color: const Color(0xFF147B72).withOpacity(0.12),
        child: GridView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: medicines.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) {
            Medicine med = medicines[index];

            return Container(
              padding: const EdgeInsets.all(10),
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
                      child: Image.asset(
                        med.image,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    med.name,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text("${med.pcs} pcs"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        med.price,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                        ),
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
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.remove,
                                size: 18,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            counters[index].toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () => increment(index),
                            child: Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                color: const Color(0xFF147B72).withOpacity(0.8),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 18,
                              ),
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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5 ),
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
                  const Text(
                    "Total",
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    "\$${getTotalPrice().toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              /// Button
              ElevatedButton.icon(
                onPressed: () {
                  // Check if any items are selected
                  bool hasItems = counters.any((count) => count > 0);
                  if (!hasItems) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Please select at least one medicine for ${widget.diseaseName}"),
                        backgroundColor: Color(0xFF147B72),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                    return;
                  }

                  // Create a list of selected medicines with quantities
                  List<Map<String, dynamic>> selectedMedicines = [];
                  for (int i = 0; i < medicines.length; i++) {
                    if (counters[i] > 0) {
                      selectedMedicines.add({
                        'medicine': medicines[i],
                        'quantity': counters[i],
                      });
                    }
                  }Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MedCart(
                        selectedItems: selectedMedicines,
                      ),
                    ),
                  );

                  // TODO: Navigate to cart screen with selected items
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => CartScreen(
                  //       selectedMedicines: selectedMedicines,
                  //       diseaseName: widget.diseaseName,
                  //     ),
                  //   ),
                  // );

                  // Show success message (remove this when navigation is implemented)
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Added ${selectedMedicines.length} medicine(s) to cart"),
                      backgroundColor: Color(0xFF147B72),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                icon: const Icon(Icons.shopping_cart),
                label: const Text("Add to Cart"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF147B72),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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

// Uncomment this when you create your cart screen
// class CartScreen extends StatelessWidget {
//   final List<Map<String, dynamic>> selectedMedicines;
//   final String diseaseName;
//
//   const CartScreen({
//     Key? key,
//     required this.selectedMedicines,
//     required this.diseaseName,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Cart - $diseaseName"),
//       ),
//       body: Center(
//         child: Text("Cart Screen - Implement your cart UI here"),
//       ),
//     );
//   }
// }