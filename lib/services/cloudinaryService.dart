
import 'dart:convert'; // Used to convert JSON responses into Dart objects
import 'dart:io'; // Used to work with File objects on mobile and desktop

import 'package:http/http.dart' as http; // Used to send HTTP requests
import 'package:image_picker/image_picker.dart'; // Used to pick images from gallery or camera


// Service class responsible for picking and uploading images to Cloudinary
class CloudinaryService {

  // Cloudinary account name
  static const String cloudName = 'dgy6ibefe';

  // Upload preset created in Cloudinary dashboard
  static const String uploadPreset = 'my_flutter_upload';


  // --------------------------------------------------
  // METHOD 1: PICK IMAGE
  // --------------------------------------------------

  // This method allows the user to select an image
  // from the gallery or camera.
  //
  // ImageSource.gallery = Select image from gallery
  // ImageSource.camera = Capture image using camera
  //
  // Returns XFile if an image is selected.
  // Returns null if the user cancels image selection.

  static Future<XFile?> pickImage({
    ImageSource source = ImageSource.gallery,
  }) async {

    // Create an ImagePicker object
    final ImagePicker picker = ImagePicker();

    // Open gallery or camera and select an image
    final XFile? image = await picker.pickImage(
      source: source,

      // Compress image quality to 80%
      // This helps reduce image size and upload time
      imageQuality: 80,
    );

    // Return the selected image
    return image;
  }


  // --------------------------------------------------
  // METHOD 2: UPLOAD IMAGE TO CLOUDINARY
  // --------------------------------------------------

  // This method accepts an XFile and uploads it
  // to Cloudinary using its image upload API.
  //
  // Returns the secure image URL if upload succeeds.
  // Returns null if upload fails.

  static Future<String?> uploadImage(XFile imageFile) async {

    try {

      // Step 1: Create Cloudinary API upload URL
      final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/$cloudName/image/upload',
      );


      // Step 2: Create a Multipart HTTP POST request
      // MultipartRequest is used to send files through an API
      final request = http.MultipartRequest('POST', url)

      // Add upload preset to request fields
        ..fields['upload_preset'] = uploadPreset;


      // Step 3: Read the selected image as bytes
      // Image data is converted into binary format
      final bytes = await imageFile.readAsBytes();


      // Step 4: Convert image bytes into MultipartFile
      // 'file' is the field name expected by Cloudinary
      final multipartFile = http.MultipartFile.fromBytes(
        'file',
        bytes,

        // Use original image name
        // If the name is empty, use upload.jpg
        filename: imageFile.name.isNotEmpty
            ? imageFile.name
            : 'upload.jpg',
      );


      // Step 5: Attach image file to HTTP request
      request.files.add(multipartFile);


      // Step 6: Send image upload request to Cloudinary
      // await waits until the server responds
      final streamedResponse = await request.send();


      // Step 7: Convert streamed response into normal HTTP response
      // This allows us to access statusCode and response body
      final response = await http.Response.fromStream(
        streamedResponse,
      );


      // Step 8: Check whether image upload was successful
      // 200 = Request successful
      // 201 = Resource created successfully

      if (response.statusCode == 200 ||
          response.statusCode == 201) {

        // Step 9: Decode JSON response into a Dart Map
        final Map<String, dynamic> responseData =
        jsonDecode(response.body);


        // Step 10: Extract secure image URL from response
        // This URL can be saved in Firebase or Supabase
        return responseData['secure_url'] as String?;

      } else {

        // If upload fails, print server error details
        print(
          'Cloudinary upload failed with status '
              '${response.statusCode}: ${response.body}',
        );

        // Return null because upload was unsuccessful
        return null;
      }

    } catch (e) {

      // Handle unexpected errors such as network problems
      // or invalid Cloudinary configuration
      print('Error uploading image to Cloudinary: $e');

      // Return null if an exception occurs
      return null;
    }
  }


  // --------------------------------------------------
  // METHOD 3: UPLOAD FILE DIRECTLY
  // --------------------------------------------------

  // This is a convenience method for mobile and desktop.
  //
  // It accepts a File object instead of XFile.
  // Converts File into XFile and reuses uploadImage().
  //
  // Returns the secure image URL after successful upload.

  static Future<String?> uploadFile(File file) async {

    // Convert File into XFile using its file path
    // Then call the existing uploadImage method
    return uploadImage(XFile(file.path));
  }
}
