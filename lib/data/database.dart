import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:keso/model/book.dart';

class BookDatabase {
  static final BookDatabase _bookDatabase = new BookDatabase._internal();

  final String tableName = "Books";

  Database db;

  bool didInit = false;

  static BookDatabase get() {
    return _bookDatabase;
  }

  BookDatabase._internal();

  Future<Database> _getDb() async{
    if(!didInit) await _init();
    return db;
  }

  Future _init() async {
    // Get a location using path_provider
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "demo.db");
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              "CREATE TABLE $tableName ("
                  "${Book.db_id} STRING PRIMARY KEY,"
                  "${Book.db_title} TEXT,"
                  "${Book.db_description} TEXT,"
                  "${Book.db_author_name} TEXT,"
                  "${Book.db_rating} BIT,"
                  "${Book.db_review} TEXT,"
                  "${Book.db_cover} TEXT"
                  ")");
        });

    didInit = true;
  }

  Future<Book> getBook(String id) async{
    var db = await _getDb();
    var result = await db.rawQuery('SELECT * FROM $tableName WHERE ${Book.db_id} = "$id"');
    if(result.length == 0)return null;
    return new Book.fromDb(result[0]);
  }

  Future<List<Book>> getBooks() async{
    var db = await _getDb();
    var result = await db.rawQuery('SELECT * FROM $tableName');
    var books = [];
    result.forEach((book) => Book.fromDb(book));
    return books;
  }

  Future<List<Book>> searchBooks(String query) async{
    var db = await _getDb();
    var result = await db.rawQuery('SELECT * FROM $tableName WHERE ${Book.db_title} LIKE %$query%');
    if(result.length == 0) return [];
    var books = [];
    result.forEach((book) => Book.fromDb(book));
    return books;
  }

  /// Inserts or replaces the book.
  Future updateBook(Book book) async {
    var db = await _getDb();
    await db.rawInsert(
          'INSERT OR REPLACE INTO '
              '$tableName(${Book.db_id}, ${Book.db_title}, ${Book.db_author_name}, ${Book.db_description}, ${Book.db_cover}, ${Book.db_rating}, ${Book.db_review})'
              ' VALUES(?,?,?,?,?,?,?)', [book.id, book.title, book.author.name, book.description, book.cover, book.rating, book.review]);
  }

  Future close() async {
    var db = await _getDb();
    return db.close();
  }

}
