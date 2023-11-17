import 'package:flutter/material.dart';
import '/books_profile.dart';
import '/book_data.dart';
import 'book_model.dart';
import 'books_details.dart';

class BooksHome extends StatelessWidget {
  const BooksHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Home2.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                left: 30,
                right: 30,
                top: 70,
                bottom: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.white,
                      size: 35,
                    ),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BooksProfile(),
                      ),
                    ),
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
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(
                  top: 50,
                  left: 50,
                ),
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
                        margin: const EdgeInsets.only(
                          top: 15,
                          bottom: 30,
                        ),
                        width: 100,
                        height: 10,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: const Color(0xffc44536),
                        ),
                      ),
                      const BookSection(
                        heading: "Continue Reading",
                      ),
                      const BookSection(
                        heading: "Discover More",
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BookSection extends StatelessWidget {
  final String heading;
  const BookSection({super.key, required this.heading});
  @override
  Widget build(BuildContext context) {
    List<Book> bookList = [];
    if (heading == "Continue Reading") {
      bookList = recentBooks;
    } else if (heading == "Discover More") {
      bookList = allBooks;
    } else if (heading == "BookShelf") {
      bookList = allBooks;
    }
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            height: MediaQuery.of(context).size.height * 0.4,
            child: ListView.builder(
              itemBuilder: (ctx, i) => GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => BooksDetails(
                      index: i,
                      section: heading,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            top: 10,
                            left: 5,
                          ),
                          height: MediaQuery.of(context).size.height * 0.27,
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.4),
                                      blurRadius: 5,
                                      offset: const Offset(8, 8),
                                      spreadRadius: 1,
                                    )
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(
                                    bookList[i].coverImage,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.27,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.black.withOpacity(0.4),
                                      Colors.transparent,
                                      Colors.black.withOpacity(0.4),
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          bookList[i].name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          bookList[i].author,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                  ],
                ),
              ),
              itemCount: bookList.length,
              scrollDirection: Axis.horizontal,
            ),
          )
        ],
      ),
    );
  }
}
