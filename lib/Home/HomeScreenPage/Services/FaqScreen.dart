import 'package:flutter/material.dart';

class FaqScreen extends StatefulWidget {
  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {

  String language = "English";

  Widget suggestionChip(IconData icon, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Color(0xFF147B72)),
          SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(
              color: Color(0xFF147B72),
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }

  Widget categoryItem(IconData icon, String title, String subtitle, Color color) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color.withOpacity(0.15),
        child: Icon(icon, color: color),
      ),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle),
      trailing: Icon(Icons.chevron_right),
    );
  }

  Widget infoItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey),
      title: Text(title),
      trailing: Icon(Icons.open_in_new, size: 18),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      /// ✅ Main Background Color (Light Teal)


      /// ✅ AppBar Styled Properly
      appBar: AppBar(
        backgroundColor: Color(0xFF147B72),
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Help & Support",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),

      /// ✅ Body Wrapped in Container for consistency
      body: Container(
        color: Color(0xFF147B72).withOpacity(0.08),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// Heading
              Center(
                child: Column(
                  children: [
                    Text(
                      "How can we help?",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 8),

                    Text(
                      "Find answers quickly or reach out to our team.",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    )
                  ],
                ),
              ),

              SizedBox(height: 25),

              /// Search Field
              TextField(
                maxLength: 90,
                decoration: InputDecoration(
                  hintText: "Try asking: How can I reset my password?",
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  counterText: "",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              SizedBox(height: 10),

              Row(
                children: [
                  Icon(Icons.info, color: Colors.blue, size: 18),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "AI Search uses AI to generate responses. Please avoid sharing sensitive information.",
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  )
                ],
              ),

              SizedBox(height: 20),

              Divider(),

              SizedBox(height: 10),

              /// Quick Suggestions
              Text(
                "QUICK SUGGESTIONS",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                  letterSpacing: 1,
                ),
              ),

              SizedBox(height: 15),

              suggestionChip(Icons.key, "How to reset my password"),
              SizedBox(height: 10),
              suggestionChip(Icons.lock, "Why is my account locked"),

              SizedBox(height: 25),

              /// Help Categories
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),

                child: Column(
                  children: [

                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Help Categories",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    categoryItem(Icons.error, "Problem Category",
                        "General issues and bugs", Colors.blue),

                    categoryItem(Icons.person, "Account Issues",
                        "Profile, login, settings", Colors.green),

                    categoryItem(Icons.credit_card, "Payment Issues",
                        "Billing, refunds, cards", Colors.orange),

                    categoryItem(Icons.medication, "Medicine Orders",
                        "Tracking, returns, recipes", Colors.teal),

                    categoryItem(Icons.local_hospital, "Doctor Consultation",
                        "Appointments, video calls", Colors.purple),

                    categoryItem(Icons.build, "Technical Problems",
                        "App crashes, slow loading", Colors.grey),
                  ],
                ),
              ),

              SizedBox(height: 30),

              /// Contact Support
              Center(
                child: Text(
                  "Need more help?",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ),

              SizedBox(height: 15),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: Icon(Icons.headset_mic),
                  label: Text("Contact Support"),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 18),
                    backgroundColor: Color(0xFF147B72),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {},
                ),
              ),

              SizedBox(height: 30),

              /// Info Section
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),

                child: Column(
                  children: [
                    infoItem(Icons.business, "About Company"),
                    infoItem(Icons.groups, "Community"),
                    infoItem(Icons.shield, "Privacy Policy"),
                    infoItem(Icons.description, "Terms of Service"),
                  ],
                ),
              ),

              SizedBox(height: 25),

              /// Language
              Text(
                "LANGUAGE",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                  letterSpacing: 1,
                ),
              ),

              SizedBox(height: 10),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                  color: Colors.white,
                ),

                child: DropdownButton(
                  value: language,
                  isExpanded: true,
                  underline: SizedBox(),
                  items: ["English","Hindi","Marathi","Spanish","French"]
                      .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ))
                      .toList(),
                  onChanged: (value){
                    setState(() {
                      language = value!;
                    });
                  },
                ),
              ),

              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}