import 'package:rxdart/rxdart.dart';
import 'package:valiu_challenge/src/models/tag_model.dart';
import 'package:valiu_challenge/src/providers/tags_provider.dart';

class TagBloc {
  final _tagsController = new BehaviorSubject<List<TagModel>>();
  final _loadingController = new BehaviorSubject<bool>();

  final _tagsProvider = new TagsProvider();

  //Stream definition
  Stream<List<TagModel>> get tagStream => _tagsController.stream;
  Stream<bool> get loading => _loadingController.stream;

  // Get all tags
  void loadTags() async {
    // start loading
    _loadingController.sink.add(true);

    // get tags
    final tags = await _tagsProvider.getTags();
    if (tags != null) {
      _tagsController.sink.add(tags);
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
