package com.itwillbs.zero.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.itwillbs.zero.vo.PageInfoVO;
import com.itwillbs.zero.service.AdminService;
import com.itwillbs.zero.service.CsService;
import com.itwillbs.zero.vo.CsVO;

@Controller
public class CsController {
	
	@Autowired
	private AdminService adminService;
	
	@Autowired
	private CsService csService;
	
	// CS - 메인페이지로 디스패치
	@GetMapping("cs_main")
	public String csMain(Model model) {
		System.out.println("CsController - csMain");
		
		List<CsVO> csList = csService.getCsListMain();
		model.addAttribute("csList", csList);
		
		return "cs/cs_main";
	}
	
	// cs_notice 페이지로 디스패치
	@GetMapping("cs_notice")
	public String csNotice(Model model, @RequestParam(defaultValue="1") int pageNum) {
		System.out.println("CsController - csNotice");
		System.out.println(pageNum);
		
		int listLimit = 10; //한페이지 표시 목록갯수
		int startRow = (pageNum - 1) * listLimit; //조회시작 행번호
		
		//페이징 계산작업
		//1.전체게시물 수 조회 작업 요청
		int listCount = csService.getNoticeListCount();
		int pageListLimit = 5; //2.페이지번호개수
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0); //3. 전체 페이지 목록갯수
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1; //4. 시작 페이지 번호
		int endPage = startPage + pageListLimit - 1; //5. 끝페이지 번호
		// 최대페이지번호 처리 
		if(endPage>maxPage) {
			endPage = maxPage;
		}
		//페이징 처리 정보 저장할 PageInfo객체에 계산데이터 저장
		PageInfoVO pageInfo = new PageInfoVO(listCount, pageListLimit, maxPage, startPage, endPage);
		System.out.println(pageInfo);
		
		// 공지사항 목록 조회
		List<CsVO> csList = csService.getCsList(startRow, listLimit);
		model.addAttribute("csList", csList);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("pageInfo", pageInfo);
		
		return "cs/cs_notice";
	}
	
	// 고객센터관리 - cs_notice_view.jsp로 디스패치
	@GetMapping("cs_notice_view")
	public String csNoticeView(@RequestParam int cs_idx, HttpSession session, Model model) {
		System.out.println("CsController - csNoticeView");
		
		CsVO cs = adminService.getCs(cs_idx);
		model.addAttribute("cs", cs);
		
		return "cs/cs_notice_view";
	}
	
	// cs_qna_form 페이지로 디스패치
	@GetMapping("cs_qna_form")
	public String csQnaForm(HttpSession session, Model model) {
		System.out.println("CsController - csQnaForm");
		// 회원만 접근할 수 있도록 설정 - 세션
		
		
		return "cs/cs_qna_form";
	}
	
	// 1:1 문의글 등록하기 (csQnaFormPro)
	@PostMapping("csQnaFormPro")
	public String csQnaFormPro(HttpServletRequest request, HttpSession session, Model model, CsVO cs) {
		System.out.println("CsController - csQnaFormPro");
		
		
		// ===================== 파일 처리 시작 =====================
		// 프로젝트 상 업로드 폴더의 실제 경로 알아내기(request or session 객체 필요)
			String uploadDir = "/resources/upload"; // 현재 폴더상 경로
			String saveDir = request.getServletContext().getRealPath(uploadDir); // 실제 경로
			System.out.println("csQnaFormPro - 실제업로드경로 : " + saveDir);
			
			String subDir = ""; // 서브 디렉토리 ( 업로드 날짜에 따라 디렉토리 구분하기 )
			
			try {
				// 1. Date 객체 생성
				Date date = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd"); // 날짜 형식 포맷 지정 ( / 로 디렉토리 구분 )
				// 실제 업로드 경로에 날짜 경로 결합
				subDir = sdf.format(date); // 날짜 디렉토리
				saveDir += "/" + subDir;
				
				// 실제 경로를 관리하는 객체 리턴받기 
				Path path = Paths.get(saveDir);
				
				// path 객체로 관리하는 경로를 생성
				Files.createDirectories(path);
			} catch (IOException e) {
				System.out.println("1:1 문의 게시판 파일 업로드 : e 이거 오류");
				e.printStackTrace();
			}
			
			// 파라미터로 받은 CsVO cs 에서 전달된 MultipartFile 객체 꺼내기
			MultipartFile mFile = cs.getFile(); // CsVo 객체의 MultipartFile의 변수명 private MultipartFile file;
			System.out.println("csQnaFormPro 원본파일명1 : " + mFile.getOriginalFilename());
			
			// 파일명 중복 방지 처리 - 랜덤 ID (8글자) 붙이기 ( ex. 랜덤ID_파일명.확장자)
			String uuid = UUID.randomUUID().toString().substring(0, 8);
			
			// 파일명이 존재하는 경우에만 파일명 생성(없을 경우를 대비하여 기본 파일명 널스트링으로 처리)
			cs.setCs_file("");
			
			// 파일명을 저장할 변수 선언
			String fileName = uuid.substring(0, 8) + "_" + mFile.getOriginalFilename();
			
			if(!mFile.getOriginalFilename().equals("")) {
				cs.setCs_file(subDir + "/" + fileName);			
			}
			System.out.println("실제 업로드 파일명1 : " + cs.getCs_file());
		// ===================== 파일 처리 끝 =====================
			
		int insertCount = csService.registCsQnaform(cs);
		
		if(insertCount > 0) { // 글쓰기 성공
			try {
				if(!mFile.getOriginalFilename().equals("")) {
					mFile.transferTo(new File(saveDir, fileName));
				}
				
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			return "cs/cs_main";
		} else { // 글쓰기 실패 
			model.addAttribute("msg", "문의 글이 등록되지 않았습니다!");

			return "fail_back";
		}
	}
	
	//================================================================================================
	// 고객센터관리 - cs_faq.jsp로 디스패치
	@GetMapping("cs_faq")
	public String cs_faq() {
		System.out.println("CsController - cs_faq");
		
		return "cs/cs_faq";
	}
	
	// 고객센터관리 - 자주묻는질문 DB 조회하는 메서드
	@GetMapping("/faq_data")
	@ResponseBody	// CsVO -> json으로 리턴
	public List<CsVO> fag_data(@RequestParam("cs_type") String cs_type
//			, @RequestParam("pageNum") int pageNum
			) {
		List<CsVO> faq = csService.getCsFaq(cs_type);
		System.out.println("faq - " + faq);

		return faq;
	}
	
}
