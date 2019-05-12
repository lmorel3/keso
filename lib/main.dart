import 'package:flutter/material.dart';
import 'package:keso/review.dart';

import 'model/author.dart';
import 'model/book.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Keso',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: MyHomePage(title: 'Keso'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();

}

const List<Book> books = <Book> [
  const Book(id: 1, title: 'Mon livre', cover: 'https://books.google.fr/books/content?id=QE_CDQAAQBAJ&printsec=frontcover&img=1&zoom=5&edge=curl&imgtk=AFLRE71VkEaCjrBgjTbplKhXpbJ40n9XvDk3XjqNJFQuVyzguulgF2qAL7deTNUnN1HsKfhMGbH3K9SRbugPb6N2lrsKgMzLTLmdC3IitDx8uwNMmNpu0PDVfDWDgYUGARGCNErgvgqV', author: Author(name: 'Auteur'), rating: 5, review: "Salut"),
  const Book(id: 1, title: 'Mon livre', cover: 'https://books.google.fr/books/content?id=QE_CDQAAQBAJ&printsec=frontcover&img=1&zoom=5&edge=curl&imgtk=AFLRE71VkEaCjrBgjTbplKhXpbJ40n9XvDk3XjqNJFQuVyzguulgF2qAL7deTNUnN1HsKfhMGbH3K9SRbugPb6N2lrsKgMzLTLmdC3IitDx8uwNMmNpu0PDVfDWDgYUGARGCNErgvgqV', author: Author(name: 'Auteur'), rating: 5, review: "Salut"),
  const Book(id: 1, title: 'Mon livre', cover: 'https://books.google.fr/books/content?id=QE_CDQAAQBAJ&printsec=frontcover&img=1&zoom=5&edge=curl&imgtk=AFLRE71VkEaCjrBgjTbplKhXpbJ40n9XvDk3XjqNJFQuVyzguulgF2qAL7deTNUnN1HsKfhMGbH3K9SRbugPb6N2lrsKgMzLTLmdC3IitDx8uwNMmNpu0PDVfDWDgYUGARGCNErgvgqV', author: Author(name: 'Auteur'), rating: 5, review: "Salut"),
  const Book(id: 1, title: 'Mon livre', cover: 'https://books.google.fr/books/content?id=QE_CDQAAQBAJ&printsec=frontcover&img=1&zoom=5&edge=curl&imgtk=AFLRE71VkEaCjrBgjTbplKhXpbJ40n9XvDk3XjqNJFQuVyzguulgF2qAL7deTNUnN1HsKfhMGbH3K9SRbugPb6N2lrsKgMzLTLmdC3IitDx8uwNMmNpu0PDVfDWDgYUGARGCNErgvgqV', author: Author(name: 'Auteur'), rating: 5, review: "Salut"),
  const Book(id: 1, title: 'Mon livre', cover: 'https://books.google.fr/books/content?id=QE_CDQAAQBAJ&printsec=frontcover&img=1&zoom=5&edge=curl&imgtk=AFLRE71VkEaCjrBgjTbplKhXpbJ40n9XvDk3XjqNJFQuVyzguulgF2qAL7deTNUnN1HsKfhMGbH3K9SRbugPb6N2lrsKgMzLTLmdC3IitDx8uwNMmNpu0PDVfDWDgYUGARGCNErgvgqV', author: Author(name: 'Auteur'), rating: 5, review: "Salut"),
];

class _MyHomePageState extends State<MyHomePage> {

  void _incrementCounter() {
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GridView.count(
          crossAxisCount: 3,
          children: List.generate(books.length, (index) {
            return Center(
              child: BookItem(book: books[index])
            );
          })
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class BookItem extends StatelessWidget {
  const BookItem({Key key, this.book}) : super(key: key);
  final Book book;

  void openReview(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ReviewPage(book: this.book)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle titleStyle = Theme.of(context).textTheme.body1;
    final TextStyle authorStyle = Theme.of(context).textTheme.caption;
    return InkWell(
        onTap: () { openReview(context); },
        child: Center(child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.network(book.cover, height:80.0),
              Text(book.title, style: titleStyle),
              Text(book.author.name, style: authorStyle),
            ]
        ))
    );
  }
}
