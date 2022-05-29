
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobi_reads/blocs/book_series_details_bloc/book_series_details_event.dart';
import 'package:mobi_reads/blocs/book_series_details_bloc/book_series_details_state.dart';
import 'package:mobi_reads/entities/books/SeriesDetailsResponse.dart';
import 'package:mobi_reads/repositories/book_repository.dart';
import 'package:mobi_reads/entities/books/Book.dart';

class BookSeriesDetailsBloc extends Bloc<BookSeriesDetailsEvent, BookSeriesDetailsState> {

  BookRepository bookRepository;

  BookSeriesDetailsBloc(this.bookRepository) : super(BookSeriesDetailsState()){
    on<InitializeBookSeriesDetails>((event, emit) async => await handleInitializedEvent(event, emit));
    on<SeriesLoaded>((event, emit) async => await handleLoadedEvent(event, emit));
  }

  Future handleInitializedEvent(InitializeBookSeriesDetails event, Emitter<BookSeriesDetailsState> emit) async {
    emit(state.CopyWith(status: BookSeriesDetailsStatus.BookSeriesDetailsLoading));
    SeriesDetailsResponse details = await this.bookRepository.getSeriesDetails(event.book.SeriesId);

    emit(state.CopyWith(
      id: details.Id,
      title: details.Title,
      subtitle: details.Subtitle,
      bookCountInSeries: details.BookCountInSeries,
      genreCode: details.GenreCode,
      genreName: details.GenreName,
      summary: details.Summary,
      books: getAllBooks(details),
      status: BookSeriesDetailsStatus.BookSeriesDetailsLoaded
    ));
  }

  Future handleLoadedEvent(SeriesLoaded event, Emitter<BookSeriesDetailsState> emit) async {
    emit(state.CopyWith(status: BookSeriesDetailsStatus.Loaded));
  }

  List<Book> getAllBooks(SeriesDetailsResponse details){
    List<Book> allBooks = new List.empty(growable: true);

    // Setup Default Book List
    // This ensures that series with missing books still show coming soon data
    for(int i = 0; i < details.BookCountInSeries; i++){
      allBooks.add(getDefaultSeriesBook(details, i));
    }

    // Replace defaults with actual books.
    for(int i = 0; i < details.Books.length; i++){
      allBooks[i] = details.Books[i];
    }

    return allBooks;
  }

  Book getDefaultSeriesBook(SeriesDetailsResponse details, int numberInSeries){
    return Book(
        "", //this.Id,
        "Coming Soon", //this.Title,
        "", //this.Subtitle,
        dotenv.env['COMING_SOON_IMAGE'] ?? "http://10.0.2.2:4000/images/ComingSoon/ComingSoon_2_200x300.png", //this.FrontCoverImageUrl,
        "image/png", //FrontCoverImageMimeType
        "", //BackCoverImageUrl,
        "", //BackCoverImageMimeType
        "Coming", //AuthorFirstName,
        "Soon", //AuthorLastName,
        "", //AuthorMiddleName,
        "", //Summary,
        0, //Status,
        0, //version
        0, //WordCount,
        0, //ChapterCount,
        0, //this.FollowCount,
        details.Id, //this.SeriesId,
        details.Title, //this.SeriesTitle,
        details.Subtitle, //this.SeriesSubtitle,
        details.BookCountInSeries, //this.BookCountInSeries,
        numberInSeries+1, //this.BookNumberInSeries,
        [], //this.SeriesFrontCoverUrls
        [] //this.preferences
    );
  }
}
