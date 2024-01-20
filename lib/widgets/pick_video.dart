import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:invictus/widgets/show_snackbar.dart';

pickVideo({required BuildContext context})async
{
  final picker=ImagePicker();
  XFile? videoFile;
  try
  {
    videoFile=await picker.pickVideo(source: ImageSource.gallery);
    if(videoFile!=null)
    {
      return  videoFile.path;
    }
    {
      print('No image selected');
    }

  }catch(err)
  {
    print(err.toString());
    showSnackBar(context: context, content: err.toString());
  }
}