package ru.aleksey2093.rutube.chat;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class Web {


    @GetMapping(path = "/chat", produces = MediaType.TEXT_HTML_VALUE)
    public String chatPage(@RequestParam("id") String chatId, Model model) {
        model.addAttribute("chatId", chatId);
        return "chat";
    }

}
