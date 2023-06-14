package kr.or.ddit.crawling;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class Crawling {

	public List<String[]> getUrlsAndTexts() {
        String domain = "https://www.saramin.co.kr";
        String inflearnUrl = domain + "/zf_user/help/live?category=10";

        List<String[]> result = new ArrayList<>();

        try {
            Document document = Jsoup.connect(inflearnUrl).get();
            Elements imageUrlElements = document.getElementsByClass("content_tit");

            for (Element element : imageUrlElements) {
                String url = String.format("%s%s", domain, element.select("a").attr("href"));
                String text = element.select("a").text();
                result.add(new String[]{url, text});
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return result;
    }
}
