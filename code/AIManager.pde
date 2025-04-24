import processing.core.PImage;
import processing.data.JSONObject;
import processing.data.JSONArray;
import java.io.OutputStream;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Scanner;
import java.io.BufferedReader;
import java.io.InputStreamReader;

class AIManager {
  String apiKey = ""; // Put the OpenAI API key here
  String endpoint = "https://api.openai.com/v1/images/generations";

  AIManager() {}

  PImage generateOutline(String prompt) {
    println("Sending prompt to OpenAI: " + prompt);

    try {
      URL url = new URL(endpoint);
      HttpURLConnection conn = (HttpURLConnection) url.openConnection();
      conn.setRequestMethod("POST");
      conn.setRequestProperty("Authorization", "Bearer " + apiKey);
      conn.setRequestProperty("Content-Type", "application/json");
      conn.setDoOutput(true);

      // Create JSON request body using Processing's JSONObject
      JSONObject request = new JSONObject();
      request.setString("model", "dall-e-3");
      request.setString("prompt", prompt);
      request.setInt("n", 1);
      request.setString("size", "1024x1024");

      // Send request
      OutputStream os = conn.getOutputStream();
      os.write(request.toString().getBytes("UTF-8"));
      os.close();

      // Read response
      InputStream is = conn.getInputStream();
      BufferedReader reader = new BufferedReader(new InputStreamReader(is));
      StringBuilder responseStr = new StringBuilder();
      String line;
      while ((line = reader.readLine()) != null) {
        responseStr.append(line);
      }
      reader.close();
      is.close();


      // Parse JSON response using Processing's JSONObject
      JSONObject response = parseJSONObject(responseStr.toString());
      JSONArray data = response.getJSONArray("data");
      if (data != null && data.size() > 0) {
        String imageUrl = data.getJSONObject(0).getString("url");
        println("Generated Image URL: " + imageUrl);

        return loadImage(imageUrl);
      }
    } catch (Exception e) {
      println("Error generating image: " + e.getMessage());
    }

    println("Failed to generate image.");
    return null;
  }
}
