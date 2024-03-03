import 'package:e_commerce_assignment/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            
            children: [
          
              const SizedBox(height: 80,),
              //logo
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset('assets/images/grocery_cart.png', width: 250, height: 200,),
              ),
              const SizedBox(height: 25,),
              //title
              Text("Wait for what!... \n Start Shopping now...", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30, ),),
          
              const SizedBox(height: 35,),
          
              Text('One app for all your needs', style: TextStyle(fontSize: 24,color: Colors.deepPurpleAccent),),
            const SizedBox(height: 135,),
              //start now button
              GestureDetector(
                onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage())),
                child: Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                    
                    color: Colors.deepPurpleAccent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(child: Text('Shop Now', style: TextStyle(color: Colors.white,fontSize: 30),)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
