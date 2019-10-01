import 'package:share_extend/share_extend.dart';

class ShareService {
  void share(String path, bool isVideo) async {
    ShareExtend.share(path, isVideo ? 'video' : 'image');
  }
}
