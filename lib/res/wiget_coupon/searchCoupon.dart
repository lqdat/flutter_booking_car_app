import 'package:flutter/material.dart';

class SearchInput extends StatefulWidget {
  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only( bottom: 25),
      child: 
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                child: TextField(
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    fillColor: Color(0xff368f8b),
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    hintText: 'Nhập mã giảm giá...',
                    hintStyle: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
              SizedBox(
                
                height: 60,
                child: ElevatedButton.icon(
                  
                  icon: Icon(
                    Icons.check_circle,
                    color: Color(0xff368f8b),
                    size: 30.0,
                  ),
                  label: Text(
                    'Áp dụng',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              )
            ],
          )
        
      
    );
  }
}
