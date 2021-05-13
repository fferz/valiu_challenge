import 'package:rxdart/rxdart.dart';
import 'package:valiu_challenge/src/models/tag_model.dart';
import 'package:valiu_challenge/src/providers/tags_provider.dart';

class TagBloc {
  final _tagsController = new BehaviorSubject<List<TagModel>>();
  final _tagsProvider = new TagsProvider();
  List<TagModel> allTags = [];

  //Stream
  Stream<List<TagModel>> get tagStream => _tagsController.stream;

  // socket - add created tag to stream
  void addTagToStream(TagModel tag) {
    allTags.insert(0, tag);
    _tagsController.sink.add(allTags);
  }

  // socket - update edited tag in stream
  void editTagInStream(TagModel tag) {
    int index;

    for (var i = 0; i < allTags.length; i++) {
      if (allTags[i].id == tag.id) {
        index = i;
        print('index: $index');
      }
    }
    allTags.replaceRange(index, index + 1, [tag]);
    _tagsController.sink.add(allTags);
  }

  // socket - delete tag from stream
  void removeTagFromStream(String id) {
    allTags.removeWhere((t) => t.id == id);
    _tagsController.sink.add(allTags);
  }

  // db - Get all tags
  void loadTags() async {
    // get tags
    allTags = await _tagsProvider.getTags();
    if (allTags != null) {
      _tagsController.sink.add(allTags);
    }
  }

  // db - Create tag
  void newTag(TagModel tag) async {
    await _tagsProvider.newTag(tag);
  }

  // db - Edit tag
  void editTag(TagModel tag) async {
    // edit tag
    await _tagsProvider.editTag(tag);
  }

  // db - Delete tag
  void deleteTag(String id) async {
    print('tag deleted: $id');
    await _tagsProvider.deleteTag(id);
  }

  dispose() {
    _tagsController?.close();
  }
}
