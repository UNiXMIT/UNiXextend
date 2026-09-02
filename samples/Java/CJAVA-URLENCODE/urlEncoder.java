import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

public class urlEncoder {
    public static String encodeUrl(String input) {
        try {
            return URLEncoder.encode(input, StandardCharsets.UTF_8.toString());
        } catch (Exception e) {
            return "";
        }
    }
}