import 'package:flutter/material.dart';
import 'package:smart_transportation/presentation/dashboard/pages/other/pages/member/member_details/view/member_detail_view.dart';
import 'package:smart_transportation/presentation/dashboard/pages/other/pages/widgets/custom_list.dart';
import 'package:smart_transportation/presentation/resources/asset_manager.dart';
import 'package:smart_transportation/presentation/resources/color_manager.dart';
import 'package:smart_transportation/presentation/resources/font_manager.dart';
import 'package:smart_transportation/presentation/resources/strings_manager.dart';
import 'package:smart_transportation/presentation/resources/values_manager.dart';
import 'package:smart_transportation/presentation/utils/size.config.dart';

class MemberView extends StatefulWidget {
  const MemberView({super.key});

  @override
  State<MemberView> createState() => _MemberViewState();
}

class _MemberViewState extends State<MemberView> {
  final List<Map<String, dynamic>> _allMembers = [
    {
      "name": "Ahmed Shehab",
      "role": "member",
      "id": "1",
      "image": ImageAssets.ahmed,
      "email": "ahmedshehab@example.com",
      "phoneNumber": "+2001550427589",
      "address": "mansoura",
      "status": "active",
      "students": [
        {
          "image": ImageAssets.awad,
          "name": "layla ahmed shehab",
          "id": "stu_1",
          "age": 5,
          "grade": "kg 1",
          "parentContact": "+2001550427589"
        },
        {
          "image": ImageAssets.haggar,
          "name": "yehia ahmed shehab",
          "id": "stu_2",
          "age": 12,
          "grade": "6th",
          "parentContact": "+2001550427589"
        }
      ]
    },
    {
      "name": "Mohamed Awadeen",
      "role": "member",
      "id": "2",
      "image": ImageAssets.awad,
      "email": "m.youssef@example.com",
      "phoneNumber": "+201001234567",
      "address": "cairo",
      "status": "active",
      "students": [
        {
          "image": ImageAssets.awad,
          "name": "salma mohamed",
          "id": "stu_3",
          "age": 8,
          "grade": "3rd",
          "parentContact": "+201001234567"
        }
      ]
    },
    {
      "name": "Adham Ebied",
      "role": "member",
      "id": "3",
      "image": ImageAssets.adham,
      "email": "fatma.khaled@example.com",
      "phoneNumber": "+201112345678",
      "address": "giza",
      "status": "active",
      "students": [
        {
          "image": ImageAssets.ahmed,
          "name": "omar khaled",
          "id": "stu_4",
          "age": 10,
          "grade": "5th",
          "parentContact": "+201112345678"
        },
        {
          "image": ImageAssets.ahmed,
          "name": "jana khaled",
          "id": "stu_5",
          "age": 6,
          "grade": "1st",
          "parentContact": "+201112345678"
        }
      ]
    },
    {
      "name": "Mohamed ELhaggar",
      "role": "member",
      "id": "4",
      "image": ImageAssets.haggar,
      "email": "yasmine.hassan@example.com",
      "phoneNumber": "+201223456789",
      "address": "alexandria",
      "status": "active",
      "students": [
        {
          "image": ImageAssets.ahmed,
          "name": "hassan tarek",
          "id": "stu_6",
          "age": 9,
          "grade": "4th",
          "parentContact": "+201223456789"
        }
      ]
    },
    {
      "name": "Mostafa Ibrahim",
      "role": "member",
      "id": "5",
      "image": ImageAssets.ahmed,
      "email": "mostafa.ibrahim@example.com",
      "phoneNumber": "+201334567890",
      "address": "zagazig",
      "status": "active",
      "students": [
        {
          "image": ImageAssets.ahmed,
          "name": "ibrahim mostafa",
          "id": "stu_7",
          "age": 11,
          "grade": "6th",
          "parentContact": "+201334567890"
        }
      ]
    },
    {
      "name": "Aya Mahmoud",
      "role": "member",
      "id": "6",
      "image": ImageAssets.ahmed,
      "email": "aya.mahmoud@example.com",
      "phoneNumber": "+201445678901",
      "address": "ismailia",
      "status": "active",
      "students": [
        {
          "image": ImageAssets.ahmed,
          "name": "mariam mohamed",
          "id": "stu_8",
          "age": 7,
          "grade": "2nd",
          "parentContact": "+201445678901"
        },
        {
          "image": ImageAssets.ahmed,
          "name": "adel mohamed",
          "id": "stu_9",
          "age": 5,
          "grade": "kg 2",
          "parentContact": "+201445678901"
        }
      ]
    },
    {
      "name": "Omar Hany",
      "role": "member",
      "id": "7",
      "image": ImageAssets.ahmed,
      "email": "omar.hany@example.com",
      "phoneNumber": "+201556789012",
      "address": "tanta",
      "status": "active",
      "students": [
        {
          "image": ImageAssets.ahmed,
          "name": "ziad omar",
          "id": "stu_10",
          "age": 6,
          "grade": "1st",
          "parentContact": "+201556789012"
        }
      ]
    },
    {
      "name": "Heba Adel",
      "role": "member",
      "id": "8",
      "image": ImageAssets.ahmed,
      "email": "heba.adel@example.com",
      "phoneNumber": "+201667890123",
      "address": "benha",
      "status": "active",
      "students": [
        {
          "image": ImageAssets.ahmed,
          "name": "sandy adel",
          "id": "stu_11",
          "age": 9,
          "grade": "3rd",
          "parentContact": "+201667890123"
        },
        {
          "image": ImageAssets.ahmed,
          "name": "malek adel",
          "id": "stu_12",
          "age": 11,
          "grade": "5th",
          "parentContact": "+201667890123"
        }
      ]
    },
    {
      "name": "Karim ElSayed",
      "role": "member",
      "id": "9",
      "image": ImageAssets.ahmed,
      "email": "karim.elsayed@example.com",
      "phoneNumber": "+201778901234",
      "address": "sohag",
      "status": "active",
      "students": [
        {
          "image": ImageAssets.ahmed,
          "name": "selim karim",
          "id": "stu_13",
          "age": 8,
          "grade": "3rd",
          "parentContact": "+201778901234"
        }
      ]
    },
    {
      "name": "Nourhan Fathy",
      "role": "member",
      "id": "10",
      "image": ImageAssets.ahmed,
      "email": "nourhan.fathy@example.com",
      "phoneNumber": "+201889012345",
      "address": "luxor",
      "status": "active",
      "students": [
        {
          "image": ImageAssets.ahmed,
          "name": "fathy nour",
          "id": "stu_14",
          "age": 6,
          "grade": "1st",
          "parentContact": "+201889012345"
        }
      ]
    }
  ];

  late List<Map<String, dynamic>> _filteredMembers;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredMembers = _allMembers; // Initially, display all members

    // Add a listener to the search controller to filter as text changes
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    _filterMembers(_searchController.text);
  }

  void _filterMembers(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredMembers = _allMembers; // If query is empty, show all members
      });
    } else {
      final lowerCaseQuery = query.toLowerCase();
      setState(() {
        _filteredMembers = _allMembers.where((member) {
          // You can search by name, email, phone number, etc.
          // Add more fields to search by if needed.
          final name = member['name']?.toLowerCase() ?? '';
          final email = member['email']?.toLowerCase() ?? '';
          final phoneNumber = member['phoneNumber']?.toLowerCase() ?? '';
          final address = member['address']?.toLowerCase() ?? '';
          final id = member['id']?.toLowerCase() ?? '';


          return name.contains(lowerCaseQuery) ||
                 email.contains(lowerCaseQuery) ||
                 phoneNumber.contains(lowerCaseQuery) ||
                 address.contains(lowerCaseQuery) ||
                 id.contains(lowerCaseQuery);
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      backgroundColor: ColorManager.white, // Set Scaffold background
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation: 0,
        leading: BackButton(color: ColorManager.black),
        centerTitle: false,
        title: Text(
          'Members',
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                color: ColorManager.black,
              ),
        ),
      ),
      body: Column(
        children: [
          _getSearchBar(),
          Expanded(
            child: CustomList(
              list: _filteredMembers, // Use the filtered list here
              onItemTap: _navigateToMemberDetails,
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToMemberDetails(Map<String, dynamic> memberData) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MemberDetailsView(member: memberData),
      ),
    );
  }

  Widget _getSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p20),
      child: TextField(
        controller: _searchController, // Assign the controller
        decoration: InputDecoration(
          hintText: AppStrings.searchForAMember,
          hintStyle: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontSize: FontSize.s16),
          fillColor: ColorManager.search,
          filled: true,
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: AppSize.s10),
            child: Icon(
              Icons.search,
              color: ColorManager.grey,
              size: 32,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.s30),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.s30),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.s30),
            borderSide: BorderSide.none,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.s30),
            borderSide: BorderSide.none,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.s30),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSize.s20,
            vertical: AppSize.s16,
          ),
        ),
      ),
    );
  }
}