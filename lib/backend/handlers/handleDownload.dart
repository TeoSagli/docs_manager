import 'package:dio/dio.dart';
import 'package:docs_manager/backend/read_db.dart';
import 'package:docs_manager/others/alerts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

downloadFile(String fileUrl, String fileName, context) async {
  Map<Permission, PermissionStatus> statuses = await [
    Permission.storage,
    //add more permission to request here.
  ].request();

  if (statuses[Permission.storage]!.isGranted) {
    var dir = await getApplicationDocumentsDirectory();
    String savePath = "${dir.path}/$fileName";
    print(savePath);
    //output:  /storage/emulated/0/Download/banner.png

    try {
      await Dio().download(fileUrl, savePath,
          onReceiveProgress: (received, total) {
        if (total != -1) {
          print("${(received / total * 100).toStringAsFixed(0)}%");
          //you can build progressbar feature too
        }
      });
      Alert().onSuccessDownload(context);
    } on DioError catch (e) {
      print(e.message);
    }
  } else {
    print("No permission to read and write.");
  }
}

getUrlAndDownload(
    int i, String catName, String fileName, String ext, context) async {
  var url =
      await ReadDB().readDownloadUrlFileStorage(i, catName, fileName, ext);
  downloadFile(url, "$fileName$i.$ext", context);
}
