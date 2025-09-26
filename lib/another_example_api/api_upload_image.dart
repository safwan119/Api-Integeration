import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
class ApiUploadImage extends StatefulWidget {
  const ApiUploadImage({super.key});

  @override
  State<ApiUploadImage> createState() => _ApiUploadImageState();
}

class _ApiUploadImageState extends State<ApiUploadImage> {
  bool showSpinner=false;
  File? image;
  final picker=ImagePicker();
  Future<void> getImage()async{
    final pickImage=await picker.pickImage(source: ImageSource.gallery,imageQuality: 80);
    if(pickImage!=null){
      image=File(pickImage.path);
      setState(() {
      });
    }
    else{
      print("No Image Selected");
    }
  }
  Future<void> uploadImage()async{
    setState(() {
      showSpinner=true;
    });
    var stream=http.ByteStream(image!.openRead());
    stream.cast();
    var length=await image!.length();
    var uri=Uri.parse("https://fakestoreapi.com/products");
    var request=http.MultipartRequest("POST", uri);
    request.fields["title"]="Static title";
    var multipart=http.MultipartFile(
        "image",
        stream,
         length
    );
    request.files.add(multipart);
    var response=await request.send();
    if(response.statusCode==200 || response.statusCode == 201){
      setState(() {
        showSpinner=false;
      });
      print("Image uploaded Successfully");
    }else{
      print("Image uploaded failed and status code is ${response.statusCode}");
      setState(() {
        showSpinner=false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Upload Image Using Api"),
          backgroundColor: Colors.blue,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  getImage();
                },
                child: Container(
                child:  image==null?Text("Pick Image"):Container(
                  child: Center(child: Image.file(image!.absolute,height: 100,width: 100,fit: BoxFit.cover,)),
                )
                  ),
              ),
              SizedBox(height: 20,),
              GestureDetector(
                onTap: (){
                  uploadImage();
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.blue,

                  ),
                  child: Center(child: Text("Upload Image")),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
