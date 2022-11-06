package ru.aleksey2093.rutube.chat;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import java.time.ZoneId;
import java.time.ZoneOffset;
import java.time.ZonedDateTime;
import java.util.Map;

@RestController
@RequestMapping("/api")
public class Rest {

    @Autowired
    RestTemplate restTemplate;

    @GetMapping("/getMessages")
    public Map<String, Object> getMessages(@RequestParam("chatId") String chatId) {
        long ms = ZonedDateTime.now(ZoneOffset.ofHours(3)).toInstant().toEpochMilli();
        String url = "https://rutube.ru/api/chat/" + chatId + "?time=" + ms + "&direction=past&format=json&limit=10000";
        return restTemplate.getForObject(url,Map.class);
    }

}
