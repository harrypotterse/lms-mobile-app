import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/screen/home/all_courses/all_courses_provider.dart';
import 'package:lms/screen/home/all_courses/components/all_courses_cart.dart';
import 'package:lms/screen/home/course_details/course_details_screen/course_details_screen.dart';
import 'package:lms/utils/app_consts.dart';
import 'package:lms/utils/nav_utail.dart';
import 'package:provider/provider.dart';

class AllCoursesScreen extends StatefulWidget {
  const AllCoursesScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AllCoursesScreen> createState() => _AllCoursesScreenState();
}

class _AllCoursesScreenState extends State<AllCoursesScreen> {
  var strSearch = "";

  @override
  Widget build(BuildContext context) {
    return Consumer<AllCoursesProvider>(
      builder: (context, provider, _) {
        AllCoursesProvider allCoursesProvider = provider;
        var categories = "";
        var languages = "";
        var instructors = "";

        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0.w, vertical: 20.w),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          onChanged: (value) {
                            strSearch = value;
                            provider.getSearchValue(strSearch);
                          },
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 13.h, horizontal: 16.w),
                              hintText: 'Search',
                              hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.title.withOpacity(0.3),
                                  fontWeight: FontWeight.w600),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: AppColors.border),
                              ),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(right: 12.0),
                                child: Image.asset(
                                  'assets/home_page/payment/Vector.png',
                                  scale: 1.5,
                                ),
                              ),
                              border: const OutlineInputBorder()),
                        ),
                        // here to add button
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Material(
                        child: InkWell(
                          onTap: () {
                            showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (context) {
                                  return StatefulBuilder(// this is new
                                      builder: (BuildContext context,
                                          StateSetter setState) {
                                    return SizedBox(
                                      height: 400,
                                      child: Center(
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Container(
                                                margin: const EdgeInsets.fromLTRB(
                                                    0, 10, 0, 10),
                                                child:
                                                    const Text('Search Filter',
                                                        style: TextStyle(
                                                          fontSize: 20.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        )),
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Container(
                                                    margin: const EdgeInsets.fromLTRB(
                                                        0, 10, 0, 10),
                                                    child: const Text(
                                                        'Instructors',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                          fontSize: 15.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        )),
                                                  ),
                                                  Container(
                                                      margin:
                                                          const EdgeInsets.symmetric(
                                                              vertical: 20.0),
                                                      height: 60.0,
                                                      child: Center(
                                                        child: ListView.builder(
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            itemCount: provider
                                                                .allCoursesFilterResponse
                                                                ?.data
                                                                ?.instructors
                                                                ?.length,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              return SizedBox(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.6,
                                                                child:
                                                                    CheckboxListTile(
                                                                  controlAffinity:
                                                                      ListTileControlAffinity
                                                                          .leading,
                                                                  tileColor: Colors
                                                                      .transparent,
                                                                  title: Text(allCoursesProvider
                                                                          .allCoursesFilterResponse
                                                                          ?.data
                                                                          ?.instructors?[
                                                                              index]
                                                                          .instructor
                                                                          ?.name ??
                                                                      ""),
                                                                  value: allCoursesProvider
                                                                          .allCoursesFilterResponse
                                                                          ?.data
                                                                          ?.instructors?[
                                                                              index]
                                                                          .instructor
                                                                          ?.isChecked ??
                                                                      false,
                                                                  onChanged:
                                                                      (bool?
                                                                          value) {
                                                                    setState(
                                                                        () {
                                                                      allCoursesProvider
                                                                          .allCoursesFilterResponse
                                                                          ?.data
                                                                          ?.instructors?[
                                                                              index]
                                                                          .instructor
                                                                          ?.isChecked = value!;
                                                                    });
                                                                  },
                                                                ),
                                                              );
                                                            }),
                                                      )),
                                                  const Text('Categories',
                                                      style: TextStyle(
                                                        fontSize: 15.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      )),
                                                  Container(
                                                      margin:
                                                          const EdgeInsets.symmetric(
                                                              vertical: 20.0),
                                                      height: 60.0,
                                                      child: Center(
                                                        child: ListView.builder(
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            itemCount: provider
                                                                .allCoursesFilterResponse
                                                                ?.data
                                                                ?.categories
                                                                ?.length,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              return SizedBox(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.6,
                                                                child:
                                                                    CheckboxListTile(
                                                                  controlAffinity:
                                                                      ListTileControlAffinity
                                                                          .leading,
                                                                  tileColor: Colors
                                                                      .transparent,
                                                                  title: Text(allCoursesProvider
                                                                          .allCoursesFilterResponse
                                                                          ?.data
                                                                          ?.categories?[
                                                                              index]
                                                                          .category
                                                                          ?.title ??
                                                                      ""),
                                                                  value: allCoursesProvider
                                                                          .allCoursesFilterResponse
                                                                          ?.data
                                                                          ?.categories?[
                                                                              index]
                                                                          .category
                                                                          ?.isChecked ??
                                                                      false,
                                                                  onChanged:
                                                                      (value) {
                                                                    setState(
                                                                        () {
                                                                      allCoursesProvider
                                                                          .allCoursesFilterResponse
                                                                          ?.data
                                                                          ?.categories?[
                                                                              index]
                                                                          .category
                                                                          ?.isChecked = value!;
                                                                    });
                                                                  },
                                                                ),
                                                              );
                                                            }),
                                                      )),
                                                  const Text('Languages',
                                                      style: TextStyle(
                                                        fontSize: 15.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      )),
                                                  Container(
                                                      margin:
                                                          const EdgeInsets.symmetric(
                                                              vertical: 20.0),
                                                      height: 60.0,
                                                      child: Center(
                                                        child: ListView.builder(
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            itemCount: provider
                                                                .allCoursesFilterResponse
                                                                ?.data
                                                                ?.languages
                                                                ?.length,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              return SizedBox(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.6,
                                                                child:
                                                                    CheckboxListTile(
                                                                  controlAffinity:
                                                                      ListTileControlAffinity
                                                                          .leading,
                                                                  tileColor: Colors
                                                                      .transparent,
                                                                  title: Text(allCoursesProvider
                                                                          .allCoursesFilterResponse
                                                                          ?.data
                                                                          ?.languages?[
                                                                              index]
                                                                          .lang
                                                                          ?.name ??
                                                                      ""),
                                                                  value: allCoursesProvider
                                                                          .allCoursesFilterResponse
                                                                          ?.data
                                                                          ?.languages?[
                                                                              index]
                                                                          .lang
                                                                          ?.isChecked ??
                                                                      false,
                                                                  onChanged:
                                                                      (value) {
                                                                    setState(
                                                                        () {
                                                                      allCoursesProvider
                                                                          .allCoursesFilterResponse
                                                                          ?.data
                                                                          ?.languages?[
                                                                              index]
                                                                          .lang
                                                                          ?.isChecked = value!;
                                                                    });
                                                                  },
                                                                ),
                                                              );
                                                            }),
                                                      )),
                                                ],
                                              ),
                                              ElevatedButton(
                                                child: const Text('Apply'),
                                                onPressed: () => {
                                                  categories =
                                                  "&categories=",
                                                  languages = "&languages",
                                                  instructors =
                                                  "&instructors",
                                                  for (int i = 0;
                                                      i <
                                                          allCoursesProvider
                                                              .allCoursesFilterResponse!
                                                              .data!
                                                              .categories!
                                                              .length;
                                                      i++)
                                                    {
                                                      if (allCoursesProvider
                                                              .allCoursesFilterResponse!
                                                              .data!
                                                              .categories?[i]
                                                              .category!
                                                              .isChecked ==
                                                          true)
                                                        categories +=
                                                            "${allCoursesProvider.allCoursesFilterResponse!.data!.categories![i].category!.id.toString()},",
                                                    },
                                                  for (int i = 0;
                                                      i <
                                                          allCoursesProvider
                                                              .allCoursesFilterResponse!
                                                              .data!
                                                              .languages!
                                                              .length;
                                                      i++)
                                                    {
                                                      if (allCoursesProvider
                                                              .allCoursesFilterResponse!
                                                              .data!
                                                              .languages?[i]
                                                              .lang!
                                                              .isChecked ==
                                                          true)
                                                        languages +=
                                                            "${allCoursesProvider.allCoursesFilterResponse!.data!.languages![i].lang!.code},",
                                                    },
                                                  for (int i = 0;
                                                      i <
                                                          allCoursesProvider
                                                              .allCoursesFilterResponse!
                                                              .data!
                                                              .instructors!
                                                              .length;
                                                      i++)
                                                    {
                                                      if (allCoursesProvider
                                                              .allCoursesFilterResponse!
                                                              .data!
                                                              .instructors?[i]
                                                              .instructor!
                                                              .isChecked ==
                                                          true)
                                                        instructors +=
                                                            "${allCoursesProvider.allCoursesFilterResponse!.data!.instructors![i].instructor!.id},",
                                                    },
                                                  provider.getSearchValue(
                                                      strSearch +
                                                          instructors +
                                                          categories +
                                                          languages),
                                                  Navigator.pop(context)
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                                });
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image.asset(
                                'assets/home_page/payment/filter_Icon.png',
                                height: 47),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  provider.allCoursesResponse?.data?.isEmpty ?? true == true
                      ? const Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Visibility(
                              visible: true,
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "No courses found",
                                    style: TextStyle(
                                        fontSize: 26,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black26),
                                  )),
                            )
                          ],
                        )
                      : SizedBox(
                          child: GridView.builder(
                            itemCount:
                                provider.allCoursesResponse?.data?.length ?? 0,
                            itemBuilder: (context, index) {
                              final data =
                                  provider.allCoursesResponse?.data?[index];
                              return AllCoursesCart(
                                data: data,
                                onTap: () {
                                  NavUtil.navigateScreen(
                                      context,
                                      CourseDetailsScreen(
                                        id: data?.id,
                                      ));
                                },
                              );
                            },
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 0,
                                    mainAxisExtent: 300.h,
                                    mainAxisSpacing: 10),
                            // ignore: prefer_const_literals_to_create_immutables
                          ),
                        ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
