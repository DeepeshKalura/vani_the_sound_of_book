import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:provider/provider.dart';

import 'controller/app/read_pdf_controller.dart';
import 'model/response_book.dart';

class BooksRead extends StatelessWidget {
  final Book book;

  const BooksRead({super.key, required this.book});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffff8ee),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            SafeArea(
              child: SizedBox(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                              size: 35,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                          if (!Provider.of<ReadPdfController>(context)
                              .isFavorite)
                            IconButton(
                              icon: const Icon(
                                Icons.favorite_border,
                                color: Colors.black,
                                size: 35,
                              ),
                              onPressed: () {
                                Provider.of<ReadPdfController>(context,
                                        listen: false)
                                    .changeFavorite();
                              },
                            )
                          else
                            IconButton(
                              icon: const Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 35,
                              ),
                              onPressed: () {
                                Provider.of<ReadPdfController>(context,
                                        listen: false)
                                    .changeFavorite();
                              },
                            )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: PDF(
                          enableSwipe: true,
                          swipeHorizontal: true,
                          autoSpacing: false,
                          pageFling: false,
                          nightMode: false,
                          onError: (error) {
                            print(error.toString());
                          },
                          onPageError: (page, error) {
                            print('$page: ${error.toString()}');
                          },
                          onPageChanged: (page, total) =>
                              Provider.of<ReadPdfController>(context)
                                  .fetchPageNumber(
                            page ?? 0,
                            total ?? 0,
                          ),
                        ).cachedFromUrl(book.pdfUrl!,
                            placeholder: (double progress) => Center(
                                  child: CircularProgressIndicator(),
                                ),
                            errorWidget: (dynamic error) => Center(
                                  child: Text(error.toString()),
                                )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton.icon(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.bookmark,
                            ),
                            label: const Text(
                              "Notes",
                              style: TextStyle(
                                fontSize: 22,
                              ),
                            ),
                          ),
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text:
                                    "${Provider.of<ReadPdfController>(context).currentPageNumber}/",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextSpan(
                                text:
                                    "${Provider.of<ReadPdfController>(context).totalPageNumber}",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey,
                                ),
                              ),
                            ]),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
