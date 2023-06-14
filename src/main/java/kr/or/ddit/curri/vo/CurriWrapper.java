package kr.or.ddit.curri.vo;

import java.util.List;

import lombok.Data;

@Data
public class CurriWrapper {

	CurriVO curri;
	List<CurriDetailVO> curriDetail;
}
