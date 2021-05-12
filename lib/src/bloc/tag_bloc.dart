import 'package:rxdart/rxdart.dart';
import 'package:valiu_challenge/src/models/tag_model.dart';
import 'package:valiu_challenge/src/providers/tags_provider.dart';

class TagBloc {
  final _tagsController = new BehaviorSubject<List<TagModel>>();
  final _loadingController = new BehaviorSubject<bool>();

  final _tagsProvider = new TagsProvider();

  List<TagModel> allTags = [];

  //Stream definition
  Stream<List<TagModel>> get tagStream => _tagsController.stream;
  Function(List<TagModel>) get tagSink => _tagsController.sink.add;
  Stream<bool> get loading => _loadingController.stream;

  void addTagToStream(List<TagModel> list) {
    allTags.insertAll(0, list);
    _tagsController.sink.add(allTags);
  }

  // Get all tags
  void loadTags() async {
    // start loading
    _loadingController.sink.add(true);

    // get tags
    allTags = await _tagsProvider.getTags();
    if (allTags != null) {
      _tagsController.sink.add(allTags);
    }

    // stop loading
    _loadingController.sink.add(false);
  }

  // Create tag
  void newTag(TagModel tag) async {
    await _tagsProvider.newTag(tag);
  }

  // Edit tag
  void editTag(TagModel tag) async {
    // start loading
    _loadingController.sink.add(true);

    // edit tag
    await _tagsProvider.editTag(tag);

    // stop loading
    _loadingController.sink.add(false);
  }

  // Delete tag
  void deleteTag(String id) async {
    print('tag deleted: $id');
    await _tagsProvider.deleteTag(id);
  }

  dispose() {
    _tagsController?.close();
    _loadingController?.close();
  }
}
