import 'package:flutter/material.dart';
import 'package:climahealth/icons/eva_icons.dart';

import 'HomeScreenPage/Pharama/PopularProductActivity.dart';
import 'HomeScreenPage/Pharama/SearchResultPage.dart';
import 'HomeScreenPage/Pharama/UploadPresciScreen.dart';
import 'HomeScreenPage/Pharama/VectorBornMedScreen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}
////Model for seach engine



class PopularProduct{
  final String name;
  final String quantity;
  final String price;
  final String image;

  PopularProduct({
    required this.name,
    required this.quantity,
    required this.price,
    required this.image
  });
}

class ProductSale{
  final String name;
  final String quantity;
  final String price;
  final String image;

  ProductSale({
    required this.name,
    required this.quantity,
    required this.price,
    required this.image
  });
}


class _SearchScreenState extends State<SearchScreen> {


TextEditingController searchController=TextEditingController();

  @override
  Widget build(BuildContext context) {

    List<ProductSale> productOnSale=[
      ProductSale(name: "OBH Combi",
          quantity: "20pcs",
          price: "\$9.99",
          image: "assets/images/p2.png"
      ),
      ProductSale(name: "Betadicen",
          quantity: "20pcs",
          price: "\$6.99",
          image: "assets/images/p2.png"
      ),ProductSale(name: "Boxdin",
          quantity: "20pcs",
          price: "\$7.99",
          image: "assets/images/p2.png"
      ),
    ];

    List<PopularProduct> products=[
      PopularProduct(name: "Panadol",
          quantity: "20pcs",
          price: "\$15.99",
          image: "assets/images/p2.png"
      ),
      PopularProduct(name: "Bodreex Herbal",
          quantity: "20pcs",
          price: "\$15.99",
          image: "assets/images/p2.png"
      ),PopularProduct(name: "Koniin",
          quantity: "20pcs",
          price: "\$15.99",
          image: "assets/images/p2.png"
      ),
    ];


    // TODO: implement build
    return Scaffold(
      backgroundColor: const Color(0xFF147B72).withOpacity(0.12),
      body: Stack(
        children: [

          // --- FIXED TOP BACKGROUND ---
          Container(
            height: 140, // Height for the top background design
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF147B72),
                  Color(0xFF0C524C),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
          ),

          SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // --- FIXED HEADER SECTION ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 1,),
                      Row(
                        children: [
                          const SizedBox(width: 145,),
                          const Text(
                            "Pharmacy",
                            style: TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Tinos",
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25,),
                    ],
                  ),
                ),

                // --- SCROLLABLE CONTENT SECTION ---
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          // Search Bar Container
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 14),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(40),
                                boxShadow: const[
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 12,
                                    offset: Offset(0, 6),
                                  )
                                ]
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  EvaIcons.search_outline,
                                  color: Color(0xFF147B72),
                                  size: 22,
                                ),
                                const SizedBox(width: 10,),
                                Expanded(
                                  child: TextField(
                                    controller: searchController,
                                    textInputAction: TextInputAction.search,
                                    decoration: const InputDecoration(
                                      hintText: "Search drugs, category...",
                                      border:
                                      InputBorder.none,
                                      isDense: true,
                                    ),
                                    onSubmitted: (value) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              SearchResultPage(searchText: value),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Container for Product Prescription
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Container(
                              height: 200,
                              width: double.infinity,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: const Color(0xFF147B72).withOpacity(0.09), // light grey background
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Row(
                                children: [
                                  /// Left Side Content
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          "Order quickly with\nPrescription",
                                          style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            height: 1.2,
                                            color: Colors.black87,
                                          ),
                                        ),

                                        const SizedBox(height: 5,),
                                        /// Button
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>UploadPresciScreen()));
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(0xFF147B72).withOpacity(0.8),
                                            padding: const EdgeInsets.symmetric(horizontal: 15 ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            elevation: 0,
                                          ),
                                          child: const Text(
                                            "Upload Prescription",
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),

                                  /// Right Side Image
                                  Expanded(
                                    flex: 1,
                                    child: Image.asset(
                                      "assets/images/medicine.png", // add your image
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // POPULAR PRODUCT
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Popular Product",
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight:
                                        FontWeight.w600,
                                        fontFamily:"Tinos"
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context)
                                      =>PopularProductActivity()));
                                    },
                                    child: const Text(
                                      "See all",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color:
                                        Color(0xFF147B72),
                                        fontFamily: "Tinos",
                                        fontWeight:
                                        FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 5),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 0),
                                child: SizedBox(
                                  height: 220,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: products.length,
                                      itemBuilder: (context,index){
                                        return ProductCard (product:products[index]);
                                      }
                                  ),
                                ),
                              )

                            ],
                          ),

                          // Product on Sale
                          const SizedBox(height: 10,),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Vector Born Disease",
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Tinos"
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context)
                                          =>VectorBornMedScreen())
                                      );
                                    },
                                    child: const Text(
                                      "See all",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFF147B72),
                                          fontFamily: "Tinos",
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 5),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 0),
                                child: SizedBox(
                                  height: 220,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: products.length,
                                      itemBuilder: (context,index){
                                        return ProductSaleCard(
                                          productOnSale: productOnSale[index],
                                        );
                                      }
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 100,)
                        ],
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProductSaleCard extends StatelessWidget {
  final ProductSale productOnSale;
  const ProductSaleCard({super.key,required this.productOnSale});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 150,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Color(0xFF147B72).withOpacity(0.5)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              spreadRadius: 2,
            )
          ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.asset(
              productOnSale.image,
              width: 120,
              height: 100,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 5,),
          Text(
            productOnSale.name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 1,),
          Text(
            productOnSale.quantity,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.grey,
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                productOnSale.price,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                height: 36,
                width: 36,
                decoration: BoxDecoration(
                  color: Color(0xFF147B72).withOpacity(0.8),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final PopularProduct product;
  const ProductCard({super.key,required this.product});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 150,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Color(0xFF147B72).withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            spreadRadius: 2,
          )
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.asset(
                product.image,
              width: 120,
              height: 100,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 5,),
          Text(
              product.name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 1,),
          Text(
            product.quantity,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.grey,
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                product.price,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                height: 36,
                width: 36,
                decoration: BoxDecoration(
                  color: Color(0xFF147B72).withOpacity(0.8),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}