import 'dart:io';
import 'package:longer_stories/constants/AppConstants.dart';
import 'package:path/path.dart' as p;

class StorageService {
  saveFile(String path) async {
    File f = File(path);
    if (await f.exists()) {
      var imagesFolder = AppConstants.imagesFolder;
      Directory d = Directory(imagesFolder);
      if (!d.existsSync()) {
        await Directory(imagesFolder).create();
      }

      var savingFolder = p.join(imagesFolder, 'LongerStories');
      Directory s = Directory(savingFolder);
      if (!s.existsSync()) {
        await Directory(savingFolder).create();
      }

      File savedFile = await f.copy(p.join(savingFolder, p.basename(f.path)));
      if (savedFile.path.length > 0) {
        return savingFolder;
      } else {
        return 'Not saved';
      }
    } else {
      print('File not found');
    }
  }
}
