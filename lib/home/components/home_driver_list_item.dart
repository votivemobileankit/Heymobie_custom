import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:grambunny_customer/components/components.dart';
import 'package:grambunny_customer/generated/l10n.dart';
import 'package:grambunny_customer/home/home.dart';
import 'package:grambunny_customer/theme/theme.dart';
import 'package:grambunny_customer/utils/ui_utils.dart';
import 'package:grambunny_customer/utils/utils.dart';

const double _kMenuImageWidthSize = 100.0;
const double _kMenuImageHeightSize = 100.0;
const double _kMenuitemNameTextFontSize = 16.0;
const double _kMenuTypeTextFontSize = 16.0;
const double _kVerticalSpaceSeparatorLineHeight = 10;
const double _kSeparatorLineHeight = .5;
const double _kButtonNextWidth = 102;
const kHeightBtnAddToCart = 35.0;

class HomeDriverListRowItem extends StatelessWidget {
  DriverList driverInfoData;

  HomeDriverListRowItem(this.driverInfoData);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 150.0.scale(),
      padding: EdgeInsets.only(top: 10.0.scale(), bottom: 10.0.scale()),
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              children: [
                AHorizontalSpace(5.0.scale()),
                Container(
                  width: _kMenuImageHeightSize.scale(),
                  height: _kMenuImageHeightSize.scale(),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: CachedNetworkImage(
                      imageUrl:
                          "https://herbariumdelivery.com/public/uploads/vendor/profile/" +
                              driverInfoData.profileImg1,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) =>
                          new Icon(Icons.error),
                    ),
                  ),
                ).align(Alignment.centerRight),
                AHorizontalSpace(5.0.scale()),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${driverInfoData.name}  ${driverInfoData.lastName}',
                          style: textStyleBoldCustomColor(
                              _kMenuitemNameTextFontSize.scale(),
                              KColorCommonText),
                        ).leftPadding(5.0.scale()),
                        AHorizontalSpace(3.0.scale()),
                        Image(
                          image: AssetImage('${imgPathGeneral}ic_bluetick.png'),
                        ),
                      ],
                    ),
                    RatingBar.builder(
                      initialRating: 3,
                      minRating: 1,
                      itemSize: 20,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      ignoreGestures: true,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                    AVerticalSpace(5.0.scale()),
                    Row(
                      children: [
                        ARoundedButton(
                          btnBgColor: kColorCommonButtonBackGround,
                          btnTextColor: kColorCommonButton,
                          btnOnPressed: () {
                            if (driverInfoData.name != "Test") {
                              BlocProvider.of<HomeBloc>(context).add(
                                  HomeEventDriverItemClick(driverInfoData));
                            }

                            // BlocProvider.of<HomeBloc>(context)
                            //     .add(HomeEventSettingSideNavigationClick());
                          },
                          btnText: Stringss.current.txtShop,
                          btnHeight: kHeightBtnAddToCart.scale(),
                          btnWidth: _kButtonNextWidth.scale(),
                          btnFontSize: kFontSizeBtnLarge.scale(),
                          btnElevation: 0,
                          btnBorderSideColor: kColorCommonButton,
                        ),
                      ],
                    ).leftPadding(5.0.scale()),
                  ],
                ).expand(),
                AVerticalSpace(5.0.scale()),
              ],
            ),
            AVerticalSpace(_kVerticalSpaceSeparatorLineHeight.scale()),
            // ASeparatorLine(
            //   height: _kSeparatorLineHeight.scale(),
            //   color: KColorAppointmentDropinHistoryListSeprator,
            // ),
          ],
        ),
      ),
    );
  }
}
