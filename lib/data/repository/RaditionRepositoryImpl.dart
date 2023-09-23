//
//
// class DocumentRepositoryImpl implements DocumentRepository {
//
//
//   DocumentRepositoryImpl(this._dao);
//
//   @override
//   Future<Result<List<DocumentList>>> getAllDocumentList() async {
//     final localListings = await _dao.getAllDocument();
//
//     final shouldJustLoadFromCache = localListings.isNotEmpty;
//
//     if (shouldJustLoadFromCache) {
//       return Result.success(
//           localListings.map((e) => e.toDocumentList()).toList());
//     } else {
//       return Result.error(Exception('데이터 로드 실패'));
//     }
//   }
//
//   @override
//   Future<Result<List<DocumentList>>> getDocumentList(String query) async {
//     final localListings = await _dao.searchDocument(query);
//
//     final shouldJustLoadFromCache = localListings.isNotEmpty;
//
//     if (shouldJustLoadFromCache) {
//       return Result.success(
//           localListings.map((e) => e.toDocumentList()).toList());
//     } else {
//       return Result.error(Exception('데이터 로드 실패'));
//     }
//   }
//
//   @override
//   Future<Result<String>> addDocument(
//       {required String filename,
//         required List<String> data,
//         int currentPosition = 0,
//         String currentPositionTime = '0'}) async {
//     try {
//       await _dao.insertDocument(
//         // companyListingEntities
//         DocumentSavedEntity(
//           filename: filename,
//           data: data,
//           currentPosition: currentPosition,
//           currentPositionTime: currentPositionTime,
//         ),
//       );
//       return const Result.success('저장 완료');
//     } catch (e) {
//       return Result.error(Exception('데이터 저장 실패'));
//     }
//   }
//
//   @override
//   Future<Result<String>> deleteDocument(
//       {required DocumentList document}) async {
//     try {
//       await _dao.deleteDocument(document.toDocumentEntity());
//       return const Result.success('삭제 완료');
//     } catch (e) {
//       return Result.error(Exception('데이터 삭제 실패'));
//     }
//   }
// }
