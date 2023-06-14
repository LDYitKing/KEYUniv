package kr.or.ddit.curri.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Service;

import kr.or.ddit.curri.dao.HomeCurriDAO;

@Service
public class HomeCurriServiceImpl implements HomeCurriService {
	private HomeCurriDAO dao;

	@Override
	public List<String[]> getUrlsAndTexts() {
		String domain = "https://www.saramin.co.kr";
		String inflearnUrl = domain + "/zf_user/help/live?category=10";

		List<String[]> result = new ArrayList<>();

		try {
			Document document = Jsoup.connect(inflearnUrl).get();
			Elements imageUrlElements = document
					.getElementsByClass("content_tit");

			for (Element element : imageUrlElements) {
				String url = String.format("%s%s", domain,
						element.select("a").attr("href"));
				String text = element.select("a").text();
				result.add(new String[]{url, text});
			}
		} catch (IOException e) {
			e.printStackTrace();
		}

		return result;
	}
}
