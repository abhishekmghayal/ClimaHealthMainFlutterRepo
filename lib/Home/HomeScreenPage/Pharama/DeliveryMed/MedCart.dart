import 'package:climahealth/Home/HomeScreenPage/Pharama/DeliveryMed/SuccessOrder.dart';
import 'package:flutter/material.dart';

class MedCart extends StatefulWidget {

  final List<Map<String, dynamic>> selectedItems;

  MedCart({required this.selectedItems});

  @override
  State<MedCart> createState() => _MedCartState();
}

class _MedCartState extends State<MedCart> {

  double getTotal() {
    double total = 0;

    for (var item in widget.selectedItems) {
      String priceStr = item['medicine'].price.replaceAll("\$", "");
      double price = double.parse(priceStr);
      int qty = item['quantity'];

      total += price * qty;
    }

    return total;
  }

  String getCurrentDateTime() {
    DateTime now = DateTime.now();
    return "${now.day}/${now.month}/${now.year}, ${now.hour}:${now.minute}";
  }

  Widget cartItem(var med, int qty) {
    return Column(
      children: [
        Row(
          children: [

            Image.asset(med.image, height: 50, width: 50),

            SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${qty} pcs",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  SizedBox(height: 4),
                  Text(
                    med.name,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                ],
              ),
            ),

            Text(
              "\$${(double.parse(med.price.replaceAll("\$", "")) * qty).toStringAsFixed(2)}",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
Divider()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),

          child: Column(
            children: [

              SizedBox(height: 40),

              /// Logo
             Image.asset('assets/images/getstart.png',width: 200,height: 200,),

              SizedBox(height: 8),

              Text("PHARMACY",
                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black, fontSize: 20)),

              SizedBox(height: 5),

              Text("Care That Reaches You Faster",
                  style: TextStyle(color: Colors.teal, fontSize: 12)),

              SizedBox(height: 20),

              /// Total
              Text(
                "\$ ${getTotal().toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),

              SizedBox(height: 5),

              /// REAL TIME DATE
              Text(getCurrentDateTime(),
                  style: TextStyle(color: Colors.grey)),

              SizedBox(height: 20),

              /// Items
              Container(
                width: double.infinity,
                height: 300,
                child: Expanded(
                  child: ListView(
                    children: widget.selectedItems
                        .map((item) => cartItem(item['medicine'], item['quantity']))
                        .toList(),
                  ),
                ),
              ),
              /// Subtotal
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Sub Total : "),
                  Text(
                    "\$ ${getTotal().toStringAsFixed(2)}",
                    style: TextStyle(
                        color: Colors.teal,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              SizedBox(height: 15),

              /// Pay Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  onLongPress: (){
                    Navigator.push(context, MaterialPageRoute(builder:(context)=>SuccessOrder()));

                    /* ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Order successfully"),
                          backgroundColor: Color(0xFF147B72))
                      ,
                    );*/
                  },
                  child: Text("Pay",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
              ),

              SizedBox(height: 10),

            ],
          ),
        ),
      ),
    );
  }
}