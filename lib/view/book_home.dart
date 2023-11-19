import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/app/home_controller.dart';
import '/books_profile.dart';
import 'widget/book_home/book_section.dart';

class BooksHome extends StatefulWidget {
  const BooksHome({Key? key}) : super(key: key);

  @override
  State<BooksHome> createState() => _BooksHomeState();
}

class _BooksHomeState extends State<BooksHome> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  var loading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    Future.delayed(const Duration(seconds: 0), () async {
      final provider = Provider.of<HomeController>(context, listen: false);
      await provider.discoverBooks();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeController>(context);
    loading = provider.isLoading;

    return Scaffold(
      key: _scaffoldKey,
      body: loading ? _buildLoadingIndicator() : _buildContent(provider),
    );
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildContent(HomeController provider) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/Home2.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          _buildTopRow(),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 50, left: 50),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xfffff8ee),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildGreetingText(),
                    const SizedBox(height: 30),
                    BookSection(
                      heading: "Continue Reading",
                      bookList: provider.discoverBook,
                    ),
                    BookSection(
                      heading: "Discover More",
                      bookList: provider.discoverBook,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopRow() {
    return Container(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 70, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
              size: 35,
            ),
            onPressed: () => _openBooksProfile(),
          ),
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.white,
              size: 35,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildGreetingText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Hello,",
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Text(
          "Alice",
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w700,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 15, bottom: 30),
          width: 100,
          height: 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: const Color(0xffc44536),
          ),
        ),
      ],
    );
  }

  void _openBooksProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const BooksProfile(),
      ),
    );
  }
}
