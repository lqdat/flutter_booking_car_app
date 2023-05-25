import 'package:flutter/material.dart';
import 'package:flutter_application/res/DTO/coupont.dart';
import 'package:flutter_application/res/base/base.dart';
import 'package:flutter_application/res/service/couponservice.dart';

import '../DTO/user.dart';

class SearchInput extends StatefulWidget {
  User user;
  Function() reload;
  SearchInput(this.user, this.reload);
  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  String? Code;
  Base base = new Base();
  Coupon? coupon;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(bottom: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(
              child: TextField(
                onChanged: (value) => {
                  setState(() {
                    Code = value;
                  })
                },
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
                onPressed: () {
                  AddVoucher();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                ),
              ),
            )
          ],
        ));
  }

  Future<void> AddVoucher() async {
    if (Code != null && Code != "")
      await CouponService.getVoucher(Code!).then((value) => {
            setState(() {
              coupon = value[0];
            })
          });
    if (coupon != null) {
     await CouponService.PostCoupon(coupon!, widget.user.userId).then((rs) => {
            if (rs != null)
              {
                base.showToastSucces(context, "Thêm mã giảm giá thành công"),
                widget.reload()
              }
            else
              {base.showToastError(context, "Mã giảm giá chưa đúng")}
          });
    }
  }
}
