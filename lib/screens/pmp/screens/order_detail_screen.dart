import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:streamit_flutter/main.dart';
import 'package:streamit_flutter/models/pmp_models/pmp_order_model.dart';
import 'package:streamit_flutter/utils/constants.dart';
import 'package:streamit_flutter/utils/resources/colors.dart';

class OrderDetailScreen extends StatelessWidget {
  final PmpOrderModel? orderDetail;

  const OrderDetailScreen({this.orderDetail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
        centerTitle: true,
        title: Text(language!.invoiceDetail, style: boldTextStyle()),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: context.iconColor),
          onPressed: () {
            finish(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(language!.invoice, style: boldTextStyle(size: 18)),
            Text(
              'Id #${orderDetail!.code} on ${DateFormat(dateFormatPmp).format(DateTime.parse(orderDetail!.timestamp.validate()))}',
              style: primaryTextStyle(),
            ),
            Divider(color: textColorPrimary, height: 30),
            RichTextWidget(
              list: <TextSpan>[
                TextSpan(
                  text: '${language!.accountHolderName}:  ',
                  style: primaryTextStyle(fontFamily: GoogleFonts.nunito().fontFamily),
                ),
                TextSpan(
                  text: '${appStore.userFirstName} ${appStore.userLastName}',
                  style: boldTextStyle(fontFamily: GoogleFonts.nunito().fontFamily),
                ),
              ],
            ),
            RichTextWidget(
              list: <TextSpan>[
                TextSpan(
                  text: '${language!.membershipPlan}:  ',
                  style: primaryTextStyle(fontFamily: GoogleFonts.nunito().fontFamily),
                ),
                TextSpan(
                  text: orderDetail!.membershipName,
                  style: boldTextStyle(fontFamily: GoogleFonts.nunito().fontFamily),
                ),
              ],
            ),
            RichTextWidget(
              list: <TextSpan>[
                TextSpan(
                  text: '${language!.status}:  ',
                  style: primaryTextStyle(fontFamily: GoogleFonts.nunito().fontFamily),
                ),
                TextSpan(
                  text: '${language!.paid}',
                  style: boldTextStyle(fontFamily: GoogleFonts.nunito().fontFamily),
                ),
              ],
            ),
            if (orderDetail!.membershipName != 'Free')
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(color: textColorPrimary, height: 30),
                  Text('${language!.billingAddress}', style: primaryTextStyle(size: 18)),
                  8.height,
                  Text(orderDetail!.billing!.name.validate(), style: boldTextStyle()),
                  Text(orderDetail!.billing!.street.validate(), style: boldTextStyle()),
                  Text(
                    '${orderDetail!.billing!.city.validate()}, ${orderDetail!.billing!.state.validate()} ${orderDetail!.billing!.zip.validate()}',
                    style: boldTextStyle(),
                  ),
                  Text(orderDetail!.billing!.country.validate(), style: boldTextStyle()),
                  Text(orderDetail!.billing!.phone.validate(), style: boldTextStyle()),
                  if (orderDetail!.accountnumber.validate().isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Divider(color: textColorPrimary, height: 30),
                        Text(language!.paymentMethod, style: boldTextStyle(size: 18)),
                        8.height,
                        Text(
                          '${orderDetail!.cardtype.validate().isEmpty ? 'Card' : orderDetail!.cardtype.validate()} ${language!.endingWith} ${orderDetail!.accountnumber.validate().substring(orderDetail!.accountnumber.validate().length - 4)}',
                          style: boldTextStyle(),
                        ),
                        if (orderDetail!.expirationmonth.validate().isNotEmpty && orderDetail!.expirationyear.validate().isNotEmpty)
                          RichTextWidget(
                            list: <TextSpan>[
                              TextSpan(
                                text: '${language!.expiration}:  ',
                                style: boldTextStyle(fontFamily: GoogleFonts.nunito().fontFamily),
                              ),
                              TextSpan(
                                text: '${orderDetail!.expirationmonth}/${orderDetail!.expirationyear}',
                                style: boldTextStyle(fontFamily: GoogleFonts.nunito().fontFamily),
                              ),
                            ],
                          ),
                      ],
                    ),
                ],
              ),
            Divider(color: textColorPrimary, height: 30),
            Text(language!.totalBilled, style: boldTextStyle(size: 18)),
            8.height,
            RichTextWidget(
              list: <TextSpan>[
                TextSpan(
                  text: '${language!.total}:  ',
                  style: primaryTextStyle(fontFamily: GoogleFonts.nunito().fontFamily),
                ),
                TextSpan(
                  text: '${appStore.pmpCurrency}${orderDetail!.total}',
                  style: boldTextStyle(fontFamily: GoogleFonts.nunito().fontFamily),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
