import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lms/data/connectivity/no_internet_screen.dart';
import 'package:lms/data/model/auth_response/country_response.dart';
import 'package:lms/screen/auth/sign_up_screen/sign_up_provider.dart';
import 'package:lms/screen/auth/login_screen/login_screen.dart';
import 'package:lms/screen/auth/widgets/text_form_field.dart';
import 'package:lms/utils/app_consts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../widgets/elevated_button_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isObscure = true;
  late String locationMsg;
  late String lat;
  late String long;

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location Service is Disabled');
    }

    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      if (permission == LocationPermission.denied) {
        return Future.error("Location Permission are denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          "Location permission are permanently denied, we cannot request permission location");
    }

    return await Geolocator.getCurrentPosition();
  }

  void _liveLocation() {
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.best,
      distanceFilter: 100,
    );

    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      lat = position.latitude.toString();
      long = position.longitude.toString();

      setState(() {
        locationMsg = 'Lat: $lat Long: $long';
      });
    });
  }

  Future<void> _openMap(String lat, String long) async {
    String googleURL =
        'https://www.google.com/maps/search/?api=1&query=$lat,$long';
    await canLaunchUrlString(googleURL)
        ? await launchUrlString(googleURL)
        : throw 'Could not launch $googleURL';
  }

  @override
  void initState() {
    super.initState();
    getCountries("Kuwait", "");
  }

  ResponseCountry? responseCountry;
  String selectedCountry = "Kuwait";
  String selectedProvince = "";
  String selectedCity = "";

  Future<void> getCountries(String country, String province) async {
    country = "nationName=$country";
    province = "&provinceName=$province";

    var dio = Dio();
    var response = await dio.request(
      'https://lms.null-safety.com/api/v1/nation-city?$country$province',
      options: Options(
        method: 'GET',
      ),
    );

    // final response = await ApiService.getDio()!.get("/nation-city?", data: country + province);

    if (response.statusCode == 200) {
      print(json.encode(response.data));
      setState(() {
        responseCountry = ResponseCountry.fromJson(response.data);
      });
    }
    else {
      print(response.statusMessage);
    }
/*    country = "nationName=$country";
    province = "&provinceName=$province";
    final response = await ApiService.getDio()!.get("/nation-city?", data: country + province);
    if (response.statusCode == 200) {
      setState(() {
        responseCountry = ResponseCountry.fromJson(response.data);
      });
    } else {
      // Handle error if needed
    }*/
  }

//   https://stackoverflow.com/questions/73490833/current-location-on-the-google-maps-flutter
  @override
  Widget build(BuildContext context) {
    return NoInternetScreen(
      child: ChangeNotifierProvider(
        create: (context) => SignUpProvider(),
        child: Consumer<SignUpProvider>(
          builder: (context, provider, _) {
            return Scaffold(
              body: SafeArea(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.0.w, vertical: 20.h),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30.h,
                        ),
                        Text(
                          "Create Account",
                          style: TextStyle(
                              fontSize: 20.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          'Create an account to continue!',
                          style: TextStyle(
                              color: AppColors.body,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        //user name///
                        FromField(
                          controller: provider.nameController,
                          title: "User Name",
                          hintText: 'Write your full Name',
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        ////Email/phone from field////
                        FromField(
                          controller: provider.emailController,
                          title: "Email",
                          hintText: 'Write your email',
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        ////Email/phone from field////
                        FromField(
                          controller: provider.phoneController,
                          title: "Phone",
                          hintText: 'Write your phone',
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        ////Password from field/////
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Password',
                              style: TextStyle(
                                  letterSpacing: 1,
                                  color: Colors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            TextFormField(
                              controller: provider.passController,
                              obscureText: _isObscure,
                              decoration: InputDecoration(
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.primary, width: 1.0),
                                  ),
                                  filled: true,
                                  fillColor: AppColors.white,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 13.h, horizontal: 16.w),
                                  hintText: 'Password',
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColors.border),
                                  ),
                                  suffixIcon: IconButton(
                                      icon: Icon(
                                        _isObscure
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.grey.withOpacity(.4),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _isObscure = !_isObscure;
                                        });
                                      }),
                                  hintStyle: const TextStyle(
                                      fontSize: 14,
                                      color: AppColors.hintTextColor,
                                      fontWeight: FontWeight.w400),
                                  border: const OutlineInputBorder()),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Confirm Password',
                              style: TextStyle(
                                  letterSpacing: 1,
                                  color: Colors.black,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            TextFormField(
                              controller: provider.confirmPasswordController,
                              obscureText: _isObscure,
                              decoration: InputDecoration(
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.primary, width: 1.0),
                                  ),
                                  filled: true,
                                  fillColor: AppColors.white,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 13.h, horizontal: 16.w),
                                  hintText: 'Confirm Password',
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: AppColors.border),
                                  ),
                                  suffixIcon: IconButton(
                                      icon: Icon(
                                        _isObscure
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.grey.withOpacity(.4),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _isObscure = !_isObscure;
                                        });
                                      }),
                                  hintStyle: const TextStyle(
                                      fontSize: 14,
                                      color: AppColors.hintTextColor,
                                      fontWeight: FontWeight.w400),
                                  border: const OutlineInputBorder()),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        if(responseCountry != null && responseCountry!.arabCountries!.isNotEmpty)
                        Text(
                          'Select Country',
                          style: TextStyle(
                              letterSpacing: 1,
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        if(responseCountry != null && responseCountry!.arabCountries!.isNotEmpty)
                        DropdownMenu<String>(
                          initialSelection: responseCountry?.arabCountries?.first,
                          onSelected: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              getCountries(value!, "");
                              // dropdownValue = value!;
                            });
                          },
                          dropdownMenuEntries: responseCountry?.arabCountries?.map<DropdownMenuEntry<String>>((String value) {
                            return DropdownMenuEntry<String>(
                                value: value, label: value);
                          }).toList() ?? [],
                        ),
                        if(responseCountry != null && responseCountry!.provinces!.isNotEmpty)
                        SizedBox(
                          height: 16.h,
                        ),
                        if(responseCountry != null && responseCountry!.provinces!.isNotEmpty)
                        Text(
                          'Select Provinces',
                          style: TextStyle(
                              letterSpacing: 1,
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        if(responseCountry != null && responseCountry!.provinces!.isNotEmpty)
                        DropdownMenu<String>(
                          initialSelection: responseCountry?.provinces?.first,
                          onSelected: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              getCountries("Kuwait", value!);
                              selectedProvince = value;
                              // dropdownValue = value!;
                            });
                          },
                          dropdownMenuEntries: responseCountry?.provinces?.map<DropdownMenuEntry<String>>((String value) {
                            return DropdownMenuEntry<String>(
                                value: value, label: value);
                          }).toList() ?? [],
                        ),
                        if(responseCountry != null && responseCountry!.cities!.isNotEmpty)
                        SizedBox(
                          height: 16.h,
                        ),
                        if(responseCountry != null && responseCountry!.cities!.isNotEmpty)
                        Text(
                          'Select City',
                          style: TextStyle(
                              letterSpacing: 1,
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        if(responseCountry != null && responseCountry!.cities!.isNotEmpty)
                        DropdownMenu<String>(
                          initialSelection: "",
                          onSelected: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              // dropdownValue = value!;
                              selectedCity = value!;
                            });
                          },
                          dropdownMenuEntries: responseCountry?.cities?.map<DropdownMenuEntry<String>>((String value) {
                            return DropdownMenuEntry<String>(
                                value: value, label: value);
                          }).toList() ?? [],
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              _getCurrentLocation().then((value) {
                                lat = '${value.latitude}';
                                long = '${value.longitude}';
                                setState(() {
                                  locationMsg = 'lat: $lat long: $long';
                                });
                                _liveLocation();
                              });
                            },
                            child: const Text('Set current Location')),
                        SizedBox(
                          height: 20.h,
                        ),
                        ElevatedbuttonWidget(
                          text: 'SIGN UP',
                          onPressed: () {

                            provider.signUpApi(context, long, lat, selectedCountry, selectedProvince, selectedCity);
                          },
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          children: [
                            Text(
                              'Already have an account?',
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.body),
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LogInScreen(),
                                    ));
                              },
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primary),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
