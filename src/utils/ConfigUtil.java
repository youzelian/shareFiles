package utils;

import java.io.IOException;
import java.util.Properties;

public class ConfigUtil {
    private static final Properties properties = new Properties();

    static {
        try {
            properties.load(ConfigUtil.class.getClassLoader().getResourceAsStream("utils/application.properties"));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static String getProperty(String key) {
        return properties.getProperty(key);
    }
}