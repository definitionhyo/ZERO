package com.itwillbs.zero.controller;

import java.io.*;
import java.nio.file.*;
import java.text.*;
import java.util.*;

import javax.servlet.http.*;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.*;


import com.itwillbs.zero.service.*;
import com.itwillbs.zero.vo.*;

@Controller
public class SecondhandController {

		@Autowired
		private SecondhandService service;
		
		
		
		//중고상품목록페이지
		//날짜순 기본정렬	
		@GetMapping("secondhand_list")
		public String secondhand_list(@RequestParam(defaultValue = "1") int pageNum,
						SecondhandVO secondhand, 
						Model model, 
						HttpSession session) {

			
			//중고 카테고리 리스트 전달 
			List<HashMap<String, String>> categorylist = service.getCategorylist();
			model.addAttribute("categorylist", categorylist);

			// 페이징 처리를 위해 조회 목록 갯수 조절 시 사용될 변수 선언
			int listLimit = 10; // 한 페이지에서 표시할 목록 갯수 지정
			int startRow = (pageNum - 1) * listLimit; // 조회 시작 행(레코드) 번호
			
			//secondhandService - getSecondhandList() 호출하여 게시물목록 조회요청
			//파라미터 : (검색타입,검색어), 시작행번호, 목록갯수
			List<SecondhandVO> secondhandList = service.getSecondhandList(startRow, listLimit);
			
			//페이징처리 위한 계산작업----------------------------------------------------
			//1. SecondhandService - getSecondhandListCount() 호출하여 전체게시물 수 조회요청
			int listCount = service.getSecondhandListCount();
			//2. 전체페이지 목록 개수 계산
			int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0);
			//System.out.println("전체 페이지 목록 갯수 : " + maxPage);
			//----------------------------------------------------------------------------
//			// 최대페이지번호(maxPage)값 또한 JSON데이터로 전달
//			// => 기존목록을 JSONObject 객체통해 객체형태변환, 최대 페이지번호 함께전달
//			JSONObject jsonObject = new JSONObject();
//
//			// JSONXXX 객체의 put() 메서드를 사용하여 데이터 추가 가능
//			jsonObject.put("secondhandList", secondhandList);
//			jsonObject.put("maxPage", maxPage);
//			return jsonObject.toString();
			
			model.addAttribute("secondhandList",secondhandList);
			model.addAttribute("maxPage", maxPage);
			model.addAttribute("listCount", listCount);//전체게시물수
			
			
			System.out.println("+++++++++++++ 리스트 :" + secondhandList);
			//각리스트에서 상품idx당 카테고리idx 번호 알아내기
			//secondhand_idx값설정=> category_idx
			//System.out.println("..................상품번호 : " + secondhand.getSecondhand_idx());
	
			
			
			//String uploadDir = "/resources/upload"; 
			//String saveDir = request.getServletContext().getRealPath(uploadDir); // 사용 가능
//			String saveDir = session.getServletContext().getRealPath("/resources/upload");
//			System.out.println("실제 업로드 경로 : "+ saveDir);
//			//실제업로드경로 : 실제 업로드 경로 : C:\Users\JIN\Documents\workspace_sts\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\ZERO\resources\ upload
//			String image1 = saveDir + secondhand.getSecondhand_image1();
//			String image2 = saveDir + secondhand.getSecondhand_image2();
//			String image3 = saveDir + secondhand.getSecondhand_image3();
//			model.addAttribute("image1",image1);
//			model.addAttribute("image2",image2);
//			model.addAttribute("image3",image3);
			return "secondhand/secondhand_list";
		}
		
		
		
		//목록메서드
		@ResponseBody
		@GetMapping("secondhandListJson")
		public String changedSecondhandList(
				@RequestParam(defaultValue = "1") int pageNum
				, @RequestParam(defaultValue = "") String category
				, @RequestParam(defaultValue = "") String sort ) {
			
			int listLimit = 12; // 한 페이지에서 표시할 목록 갯수 지정
			int startRow = (pageNum - 1) * listLimit; // 조회 시작 행(레코드) 번호
			
			//전달할 목록 값 받아오기 (거래중일경우)
			String type = "거래중";
			List<HashMap<String, String>> changedSecondhandList =  service.getChangedSecondhandList(pageNum, category, sort, startRow, listLimit, type);
		
			//전체 게시물 개수 계산
			int listCount = service.getChangedSecondhandListCount(pageNum, category, sort, type);
			
			//전체페이지 목록 개수 계산
			int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0);
			// => 이것도 리턴값으로 들고가고 싶다 => 객체로 넣기(boardList = XX, maxPage = xx) => JSONObject
			
			// 최대 페이지번호(maxPage) 값도 JSON 데이터로 함께 넘기기
			JSONObject jsonObject = new JSONObject();
			
			jsonObject.put("changedSecondhandList", changedSecondhandList);
			jsonObject.put("maxPage", maxPage);
			jsonObject.put("listCount", listCount);
			System.out.println(jsonObject);
			
			return jsonObject.toString();
		}
		
		
		
//		@ResponseBody
//		@GetMapping("secondhandList_Json")
//		public String secondhandList_Json(@RequestParam(defaultValue = "1") int secondhand_idx) {
//			
//			System.out.println(secondhand_idx);
//			return "";
//		}
		
		
		//ajax 요청 통한 글목록조회
		//글목록-json 데이터 형식 응답
		//JSON문자열로 리턴위해 String으로 리턴타입지정(출력스트림-void타입지정)
		
//		@ResponseBody
//		@GetMapping("SecondhandListJson")
//		public String listJson(
//				@RequestParam(defaultValue = "1") int pageNum,
//				Model model,
//				HttpServletResponse response) {
//			
//			// 페이징 처리를 위해 조회 목록 갯수 조절 시 사용될 변수 선언
//			int listLimit = 10; // 한 페이지에서 표시할 목록 갯수 지정
//			int startRow = (pageNum - 1) * listLimit; // 조회 시작 행(레코드) 번호
//			
//			//secondhandService - getSecondhandList() 호출하여 게시물목록 조회요청
//			//파라미터 : (검색타입,검색어), 시작행번호, 목록갯수
//			List<SecondhandVO> secondhandList = service.getSecondhandList(startRow, listLimit);
//			
//			//페이징처리 위한 계산작업----------------------------------------------------
//			//1. SecondhandService - getSecondhandListCount() 호출하여 전체게시물 수 조회요청
//			int listCount = service.getSecondhandListCount();
//			//2. 전체페이지 목록 개수 계산
//			int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0);
//			//System.out.println("전체 페이지 목록 갯수 : " + maxPage);
//			//----------------------------------------------------------------------------
//			// 최대페이지번호(maxPage)값 또한 JSON데이터로 전달
//			// => 기존목록을 JSONObject 객체통해 객체형태변환, 최대 페이지번호 함께전달
//			JSONObject jsonObject = new JSONObject();
//
//			// JSONXXX 객체의 put() 메서드를 사용하여 데이터 추가 가능
//			jsonObject.put("secondhandList", secondhandList);
//			jsonObject.put("maxPage", maxPage);
//			
//			
//			return jsonObject.toString();
//			
//		}
		
		
		
		//중고 상세정보페이지
		//조회성공시 조회수 증가
		@GetMapping("secondhand_detail")
		public String secondhand_detail(
							@RequestParam int secondhand_idx,
							@RequestParam String member_id,
//							@RequestParam Map<String, String> map,
							Model model, 
							HttpSession session) {
			
			//파라미터로 전달받은 상품번호 확인
			//System.out.println(" 상품번호++++++++++++++++++++" + secondhand_idx);
			System.out.println(" 판매자아이디++++++++++++++++++++" + member_id);
			//상품번호에 해당하는 상품의 정보조회작업
			SecondhandVO secondhandProduct = service.getSecondhandProduct(secondhand_idx);
			//조회결과 저장
			model.addAttribute("secondhandProduct", secondhandProduct);
			
			
			
			//상세페이지의 판매자정보조회 
			//- 파라미터로 전달받은 secondhand_idx의 member_id와 동일한 member정보 얻어옴
			//  멤버테이블 필요정보 : member_profile, member_nickname, member_address1, member_address_deatil1
			//- 리턴타입 : ,파라미터:상품번호, 멤버아이디
			
			//주의!!!!!-> 파라미터 두개이상일경우 매퍼-(@Param)어노테이션필요!

			
			HashMap<String,String> sellerInfo = service.getSellerInfo(secondhand_idx, member_id);
			System.out.println("&&&&&&&&&&&&&&&& 판매자정보 : " + sellerInfo);
			model.addAttribute("seller",sellerInfo);
			
			//판매자의 판매상품 개수 조회
			int sellerProduct = service.getSellerProductCount(member_id);
			System.out.println("&&&&&&&&&&&&&&&&&&&&&&&&"+ sellerProduct);
			model.addAttribute("sellerProduct", sellerProduct);
			
			//판매자의 판매목록조회
			List<HashMap<String, String>> sellerProductList = service.getSellerProductList(member_id);
			model.addAttribute("sellerProductList",sellerProductList);
			System.out.println(sellerProductList);
			
			return "secondhand/secondhand_detail";
		}
		
		
		
		
		//상품등록폼 이동
		@GetMapping("secondhandRegistForm")
		public String secondhandRegistForm(HttpSession session, Model model) {
			//미로그인시 "로그인필수"출력 후 이전페이지 돌아감
			String member_id = (String) session.getAttribute("member_id");
			System.out.println(" member_id : +++++++++++++++++++++++++++++++++++"+ member_id);
			if(member_id == null) {
				model.addAttribute("msg", "로그인이 필요한 작업입니다!");
				return "fail_back";
			}
			
			//중고 카테고리 값 전달 
			List<HashMap<String, String>> categorylist = service.getCategorylist();
			model.addAttribute("categorylist", categorylist);
			
			return "secondhand/secondhand_regist_form";	
		}
		
		
		
		//상품등록처리(POST)(INSERT)
		@ResponseBody
		@PostMapping("secondhandRegistPro")
		public String secondhandRegistPro(SecondhandVO secondhand, HttpSession session, Model model, HttpServletRequest request) {
			
			//JsonConverter 사용하기 위한 Map생성
			Map<String,String> map = new HashMap<>();
			//기본 리턴값 false
			String bResult = "false";		
			
			//상품설명 줄바꿈 하기
			//p_exp = p_exp.replaceAll("\r\n", "<br>");
			secondhand.setSecondhand_content(secondhand.getSecondhand_content().replaceAll("\r\n", "<br>"));
			
			
			//판매자아이디저장
			//secondhand.setMember_idx((String)session.getAttribute("member_idx"));
			String member_id = (String)session.getAttribute("member_id");
			System.out.println("#############" + member_id);
			session.setAttribute("member_id", member_id);
			System.out.println("setAttribute +++++++++++" + member_id);

			if(member_id == null) {
				model.addAttribute("msg", "잘못된 접근입니다!");
				return "fail_back";
			}
			
			//임시
			//secondhand.setMember_id("test3@test.com");
			
			
			
			
			
			//이미지파일업로드==========================================================================
			String uploadDir = "/resources/upload"; 
			//String saveDir = request.getServletContext().getRealPath(uploadDir); // 사용 가능
			String saveDir = session.getServletContext().getRealPath(uploadDir);
			System.out.println("실제 업로드 경로 : "+ saveDir);
			//실제업로드경로 : 
			
			String subDir = ""; // 서브디렉토리(날짜 구분)
			
			try {
				// --------------------------------------------------
				// 업로드 디렉토리를 날짜별 디렉토리로 자동 분류하기(관리편의성,로딩시간단축)
				
				// 1. Date 객체 생성(기본 생성자 호출하여 시스템 날짜 정보 활용)
				Date date = new Date(); // Mon Jun 19 11:26:52 KST 2023
				
				// 2. SimpleDateFormat 클래스를 활용하여 날짜 형식을 "yyyy/MM/dd" 로 지정
				// => 디렉토리 구조로 바로 활용하기 위해 날짜 구분 기호를 슬래시(/)로 지정
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
				
				// 3. 기존 업로드 경로에 날짜 경로 결합하여 저장
				subDir = sdf.format(date);
				saveDir += "/" + subDir;
				
				// --------------------------------------------------------------
				// java.nio.file.Paths 클래스의 get() 메서드를 호출하여
				// 실제 경로를 관리하는 java.nio.file.Path 타입 객체 리턴받기
				// => 파라미터 : 실제 업로드 경로
				Path path = Paths.get(saveDir);
				
				// Files 클래스의 createDirectories() 메서드를 호출하여
				// Path 객체가 관리하는 경로 생성(존재하지 않으면 거쳐가는 경로들 중 없는 경로 모두 생성)
				Files.createDirectories(path);
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			// VO 객체에 전달된 MultipartFile 객체 꺼내기
			MultipartFile mFile1 = secondhand.getFile1();
			MultipartFile mFile2 = secondhand.getFile2();
			MultipartFile mFile3 = secondhand.getFile3();
			System.out.println("원본파일명1 : " + mFile1.getOriginalFilename());
			System.out.println("원본파일명2 : " + mFile2.getOriginalFilename());
			System.out.println("원본파일명3 : " + mFile3.getOriginalFilename());
			
			// 파일명 중복 방지
			// 현재 시스템(서버)에서 랜덤ID 값을 추출하여 파일명 앞에 붙여서
			// "랜덤ID값_파일명.확장자" 형식으로 중복 파일명 처리
			// => 랜덤ID 생성은 java.util.UUID 클래스 활용(UUID = 범용 고유 식별자)
			String uuid = UUID.randomUUID().toString();
			System.out.println("uuid : " + uuid);
			
			// 생성된 UUID 값을 원본 파일명 앞에 결합(파일명과 구분을 위해 _ 기호 추가)
			// => 나중에 사용자 다운로드 시 원본 파일명 표시를 위해 분리할 때 구분자로 사용
			//    (가장 먼저 만나는 _ 기호를 기준으로 문자열 분리하여 처리)
			// => 단, 파일명 길이 조절을 위해 임의로 UUID 중 맨 앞자리 8자리 문자열만 활용
//			System.out.println(uuid.substring(0, 8));
			// 생성된 UUID 값(8자리 추출)과 업로드 파일명을 결합하여 BoardVO 객체에 저장(구분자로 _ 기호 추가)
			// => 단, 파일명이 존재하는 경우에만 파일명 생성(없을 경우를 대비하여 기본 파일명 널스트링으로 처리)
			secondhand.setSecondhand_image1("");
			secondhand.setSecondhand_image2("");
			secondhand.setSecondhand_image3("");


			// 파일명을 저장할 변수 선언
			String fileName1 = null;
			String fileName2 = null;
			String fileName3 = null;
			
			// 업로드 된 파일 존재시 fileNameN 변수에 
			if(mFile1 != null) {
				fileName1 = uuid.substring(0, 8) + "_" + mFile1.getOriginalFilename();
				secondhand.setSecondhand_image1(subDir + "/" + fileName1);
			}
			if(mFile2 != null) {
				fileName2 = uuid.substring(0, 8) + "_" + mFile2.getOriginalFilename();
				secondhand.setSecondhand_image2(subDir + "/" + fileName2);
			}
			if(mFile3 != null) {
				fileName3 = uuid.substring(0, 8) + "_" + mFile3.getOriginalFilename();
				secondhand.setSecondhand_image3(subDir + "/" + fileName3);
			}
			System.out.println("실제 업로드 파일명1 : " + secondhand.getSecondhand_image1());
			System.out.println("실제 업로드 파일명2 : " + secondhand.getSecondhand_image2());
			System.out.println("실제 업로드 파일명3 : " + secondhand.getSecondhand_image3());
			//
			
			//=========================================================================================
			
			//게시물등록작업
			//SecondhandService - registBoard()
			//파라미터 : SecondhandVO객체, 리턴타입 : int(insertCount)
			System.out.println(secondhand);
			int insertCount = service.registBoard(secondhand);
			
			// 등록결과판별
			// 성공 : 업로드파일 - 실제디렉토리에 이동시킨 후, secondhand_list 서블릿 리다이렉트
			// 실패 : "글쓰기실패" 출력 후 이전페이지 돌아가기 처리
			
			if(insertCount > 0) { //성공
				
				//업로드파일 실제디렉토리 이동작업---------------------------------
				try {
					// 업로드된파일 - MultipartFile객체에 의해 임시디렉토리 저장
					// 글쓰기 성공시 임시->실제디렉토리 이동작업 필요 -> MultipartFile.transferTo()->실제위치 업로드
					// 비어있는파일 이동불가(예외) - 제외
					// -> File객체생성시 지정디렉토리에 지정이름으로 파일이동(생성)
					// 	 => 이동위치의 파일명도 UUID결합 파일명 지정해야함(fileNameN)
					if(!mFile1.getOriginalFilename().equals("")) {
						mFile1.transferTo(new File(saveDir, fileName1));
					}
					
					if(!mFile2.getOriginalFilename().equals("")) {
						mFile2.transferTo(new File(saveDir, fileName2));
					}
					
					if(!mFile3.getOriginalFilename().equals("")) {
						mFile3.transferTo(new File(saveDir, fileName3));
					}
					bResult = "true";
					model.addAttribute("res", bResult);
					
				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
				// -----------------------------------------------------------------
				
				// 글쓰기 작업 성공 시 글목록(secondhand_list)으로 리다이렉트
//				model.addAttribute("msg", "글 쓰기 성공!");
				
				return "true";
				
				
			} else { // 실패
				model.addAttribute("msg", "글 쓰기 실패!");
				return "fail_back";
			}
		}
		
		
		
		
		
		
		//상품수정하기폼 이동
		@GetMapping("secondhandModifyForm")
		public String secondhandModifyForm(
					SecondhandVO secondhand, 
					HttpSession session, 
					@RequestParam(defaultValue = "1") int pageNum,
					
					Model model,
					@RequestParam int secondhand_idx) {
			
			String member_id = (String) session.getAttribute("member_id");
			// 세션 아이디가 존재하지 않으면(미로그인) "잘못된 접근입니다!" 출력 후 이전 페이지 돌아가기 처리
		
			if(member_id == null) {
				model.addAttribute("msg", "잘못된 접근입니다!");
				return "fail_back";
			}
//			System.out.println("%&%&%&%&%&%& 수정 - 판매자아이디 : " + member_id);
//			System.out.println("%&%&%&%&%&%& 수정 - 상품번호 : " + secondhand_idx);
			
			
			//중고 카테고리 값 전달(재사용) 
			List<HashMap<String, String>> categorylist = service.getCategorylist();
			model.addAttribute("categorylist", categorylist);
			
			
			//파라미터로 넘어온 상품번호의 상품정보 가져오기
			//디테일조회작업시 사용한 getSecondhandProduct() 재사용
			SecondhandVO secondhandProduct = service.getSecondhandProduct(secondhand_idx);
			System.out.println("%&%&%&%&%&%& 수정 - 상품정보 : " + secondhandProduct);
			
			
			// 상품설명 줄바꿈처리
			secondhandProduct.setSecondhand_content(secondhandProduct.getSecondhand_content().replaceAll("<br>", "\r\n"));
			model.addAttribute("secondhandProduct",secondhandProduct);
			String image1Url = secondhandProduct.getSecondhand_image1();
			String image2Url = secondhandProduct.getSecondhand_image2();
			String image3Url = secondhandProduct.getSecondhand_image3();
			String jsonData = "{\"image1Url\": \"" + image1Url + "\", \"image2Url\": \"" + image2Url + "\", \"image3Url\": \"" + image3Url + "\"}";
			model.addAttribute("jsonData",jsonData);
			
			
			
//			String image1 = secondhandProduct.getSecondhand_image1();
//			String image2 = secondhandProduct.getSecondhand_image2();
//			String image3 = secondhandProduct.getSecondhand_image3();
			
			//받아온 정보 중 image1, image2, image3 List로
//			List<SecondhandVO> image_list = new ArrayList<SecondhandVO>();
//			image_list.add(secondhandProduct.getSecondhand_image1());
//			image_list.add(secondhandProduct.getSecondhand_image2());
//			image_list.add(secondhandProduct.getSecondhand_image3());
			
			//상품번호의 이미지=> List로 따로 만들기
//			//상품번호에 해당하는 이미지정보만 받아오기
//			List<SecondhandVO> image_list = service.getImageList(secondhand_idx);
//			System.out.println("%&%&%&%&%&%& 수정 - 이미지정보 :" + image_list);
		

			
			return "secondhand/secondhand_modify_form";
		}
		
		
		
		
		//상품수정 처리(UPDATE)
		@RequestMapping(value = "secondhandModifyPro", method = {RequestMethod.GET, RequestMethod.POST})
		@ResponseBody
		public String secondhandModifyPro(
					SecondhandVO secondhand,
					HttpSession session, 
					Model model,
//					String[] change_image,
					@RequestParam String secondhand_idx,
					@RequestParam(defaultValue = "1") int pageNum){
		
			
			
			
			//JsonConverter 사용하기 위한 Map생성
			Map<String,String> map = new HashMap<>();
			//기본 리턴값 false
			String bResult = "false";	
		
		//상품설명 줄바꿈 하기
		//p_exp = p_exp.replaceAll("\r\n", "<br>");
		secondhand.setSecondhand_content(secondhand.getSecondhand_content().replaceAll("\r\n", "<br>"));
		
		System.out.println("(*Y(&(*&(*&(*&(*&(*&(&*&(*&(&(*&(*&(&(*&(*&수정오류확인하기" + secondhand_idx);
		 
		
		
		// 파일(이미지)저장작업 
		String uploadDir = "/resources/upload"; 
		String saveDir = session.getServletContext().getRealPath(uploadDir);
		String subDir = ""; // 서브디렉토리(날짜 구분)
		
		try {
			Date date = new Date(); // Mon Jun 19 11:26:52 KST 2023
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
			subDir = sdf.format(date);
			saveDir += "/" + subDir;
			// --------------------------------------------------------------
			Path path = Paths.get(saveDir);
			Files.createDirectories(path);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		// VO 객체에 전달된 MultipartFile 객체 꺼내기
		MultipartFile mFile1 = secondhand.getFile1();
		MultipartFile mFile2 = secondhand.getFile2();
		MultipartFile mFile3 = secondhand.getFile3();
		System.out.println("원본파일명1 : " + mFile1.getOriginalFilename());
		System.out.println("원본파일명2 : " + mFile2.getOriginalFilename());
		System.out.println("원본파일명3 : " + mFile3.getOriginalFilename());
		
		// 파일명 중복 방지
		// 현재 시스템(서버)에서 랜덤ID 값을 추출하여 파일명 앞에 붙여서
		// "랜덤ID값_파일명.확장자" 형식으로 중복 파일명 처리
		// => 랜덤ID 생성은 java.util.UUID 클래스 활용(UUID = 범용 고유 식별자)
		String uuid = UUID.randomUUID().toString();
		System.out.println("uuid : " + uuid);
		
		// 생성된 UUID 값을 원본 파일명 앞에 결합(파일명과 구분을 위해 _ 기호 추가)
		// => 나중에 사용자 다운로드 시 원본 파일명 표시를 위해 분리할 때 구분자로 사용
		//    (가장 먼저 만나는 _ 기호를 기준으로 문자열 분리하여 처리)
		// => 단, 파일명 길이 조절을 위해 임의로 UUID 중 맨 앞자리 8자리 문자열만 활용
//		System.out.println(uuid.substring(0, 8));
		// 생성된 UUID 값(8자리 추출)과 업로드 파일명을 결합하여 BoardVO 객체에 저장(구분자로 _ 기호 추가)
		// => 단, 파일명이 존재하는 경우에만 파일명 생성(없을 경우를 대비하여 기본 파일명 널스트링으로 처리)
		secondhand.setSecondhand_image1("");
		secondhand.setSecondhand_image2("");
		secondhand.setSecondhand_image3("");


		// 파일명을 저장할 변수 선언
		String fileName1 = null;
		String fileName2 = null;
		String fileName3 = null;
		
		// 업로드 된 파일 존재시 fileNameN 변수에 
		if(mFile1 != null) {
			fileName1 = uuid.substring(0, 8) + "_" + mFile1.getOriginalFilename();
			secondhand.setSecondhand_image1(subDir + "/" + fileName1);
		}
		if(mFile2 != null) {
			fileName2 = uuid.substring(0, 8) + "_" + mFile2.getOriginalFilename();
			secondhand.setSecondhand_image2(subDir + "/" + fileName2);
		}
		if(mFile3 != null) {
			fileName3 = uuid.substring(0, 8) + "_" + mFile3.getOriginalFilename();
			secondhand.setSecondhand_image1(subDir + "/" + fileName3);
		}
		System.out.println("실제 업로드 파일명1 : " + secondhand.getSecondhand_image1());
		System.out.println("실제 업로드 파일명2 : " + secondhand.getSecondhand_image2());
		System.out.println("실제 업로드 파일명3 : " + secondhand.getSecondhand_image3());

		

		//=====================================================================================
		
		
//		int fileCnt = 0; // MutipartFile 파일명 인덱스용 카운트 변수
//
//		for (int i = 0; i < change_image.length; i++) {
//			// i가 짝수면
//			if (i % 2 == 0) {
//				// 수정된 사진이면
//				if (!change_image[i].equals("changePhoto")) {
//					//수정된 idx가 정수형이며, 초기화됐던 0이 아닐때
//					if (change_image[i].matches("-?\\d+") && Integer.parseInt(change_image[i])!=0 && !change_image[i+1].equals("delPhoto")) {
//						
//						/* 
//						 해당 idx에 대한 절대경로 이미지파일 삭제 
//						 
//						 DB에 저장되어 있는 파일명에 해당하는 실제 파일삭제
//						 */
//						ImageVo imgFileName = image_dao.selectOneImage(Integer.parseInt(change_image[i]));
//						
//						MyFileDelete.myFileDelete(absPath, imgFileName.getImagedata());
//						
//						
//						Map updateInfo = new HashMap();
//						
//						updateInfo.put("i_idx", Integer.parseInt(change_image[i]));
//						updateInfo.put("imagedata", upload_str.get(fileCnt));
//						
//						fileCnt++;
//						//DB에 이미지 파일명 update
//						int res = image_dao.imageUpdate(updateInfo);
//						
//					}
//
//				// 추가된 사진이면
//				} else {
//
//					
//					ImageVo imageVo = new ImageVo();
//					imageVo.setP_idx(p_idx);
//					imageVo.setImagedata(upload_str.get(fileCnt));
//					
//					
//					fileCnt++;
//					
//					int res = image_dao.insert(imageVo);
//					
//					
//				}
//			
//			//i가 홀수면..
//			}else {
//				//삭제된 파일이면
//				if(change_image[i].equals("delPhoto")) {
//					
//					ImageVo imgFileName = image_dao.selectOneImage(Integer.parseInt(change_image[i-1]));
//					
//					//실제 파일 삭제
//					MyFileDelete.myFileDelete(absPath, imgFileName.getImagedata());
//					
//					//DB삭제
//					int res = image_dao.deleteImage(Integer.parseInt(change_image[i-1]));
//				}
//			}
//
//		}
		
		
		
		
		
		
		
		
		
		//=====================================================================================
		// 글 수정 작업 요청
		// SecondhandService.modifySecondhand() -리턴타입:int(uptdateCount), 파라미터:SecondhandVO객체
		int updateCount = service.modifySecondhand(secondhand);
		

		
		//상품 수정 작업
		//성공시 업로드 파일을 실제 디렉토리로 이동 => BoardList 서블릿으로 리다이렉트
		//실패시 "글쓰기 실패" 메시지 출력 후 이전페이지 돌아가기 처리
		if(updateCount > 0) {
			
			try {
				if(!mFile1.getOriginalFilename().equals("")) {
					mFile1.transferTo(new File(saveDir, fileName1));
				}
				
				if(!mFile2.getOriginalFilename().equals("")) {
					mFile2.transferTo(new File(saveDir, fileName2));
				}
				
				if(!mFile3.getOriginalFilename().equals("")) {
					mFile3.transferTo(new File(saveDir, fileName3));
					bResult = "true";
					model.addAttribute("res", bResult);
				}
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}	


			
			//수정성공시 글목록페이지로 리다이렉트(상품번호,페이지번호)
			return "true";
//			return "redirect:/secondhand_list?secondhand_idx=" + secondhand.getSecondhand_idx() + "&pageNum=" + pageNum;
		} else { // 실패
			model.addAttribute("msg", "글 수정 실패!");
			System.out.println("(*Y(&(*&(*&(*&(*&(*&(&*&(*&(&(*&(*&(&(*&(*&수정오류확인하기" + secondhand_idx);

			return "fail_back";
			
			
		}
		
	}
		
		
		
		
		//끌어올리기(UPDATE - DATE)
		//DB의 registdate날짜 업데이트하기
		//끌어올리기버튼-
		@GetMapping("secondhandUpdateDate")
		public String secondhandUpdateDate(
							@RequestParam int secondhand_idx,
							Model model,
							@RequestParam String member_id
							) {
			//날짜(등록일)업데이트후 secondhand_list페이지로 리다이렉트(서블릿-서블릿)
			System.out.println("*&*&&********업데이트 상품번호" + secondhand_idx);
			System.out.println("*&*&&********업데이트 멤버아이디" + secondhand_idx);
			
			
			
			int updateCount = service.updateRegistdate(secondhand_idx);
			if(updateCount > 0) {
				model.addAttribute("msg", "끌어올리기가 정상적으로 처리되었습니다");
				model.addAttribute("targetURL", "secondhand_list");
				return "fail_location";	
			} else {
				model.addAttribute("msg", "끌어올리기 실패");
				return "fail_back";
			}
			
		}
		
		
		
		
		
		
		
		//상품삭제 처리(DELETE)
		@GetMapping("secondhandDelete")
		public String secondhandDelete(
				@RequestParam int secondhand_idx, 
				@RequestParam(defaultValue = "1") int pageNum,
//				@RequestParam String member_id,
				SecondhandVO secondhand,
				HttpSession session, Model model
				) {
		
			//미로그인시 "로그인필수"출력 후 이전페이지 돌아감
			String member_id = (String) session.getAttribute("member_id");
			System.out.println("member_id : +++++++++++++++++++++++++++++++++++"+ member_id);
			System.out.println("secondhand_idx : +++++++++++++++++++++++++++++++++++"+ secondhand_idx);

			if(member_id == null) {
				model.addAttribute("msg", "로그인이 필요한 작업입니다!");
				return "fail_back";
			}
			
			// 작성자 확인 작업 ---------------------------------------------
			 //SecondhandService - isSeller()작성자 판별요청
			// 파라미터:상품번호(secondhand_idx), 세션아이디 리턴타입:boolean(isProductRegister)
			// 단, 세션아이디가 "admin@gmail.com" 아닐 경우에만 수행
			System.out.println(secondhand.getSecondhand_idx());
			
			if(!member_id.equals("admin@gmail.com")) {
				boolean isBoardWriter = service.isBoardWriter(secondhand_idx, member_id);
				
				if(!isBoardWriter) {
					model.addAttribute("msg", "권한이 없습니다!");
					return "fail_back";
				}
			}
			
			// 글삭제작업 ----------------------------------------------------
			// SecondhandService - removeBoard() 호출하여 글 삭제요청
			// 파라미터 : 글번호, 리턴타입 : int(deleteCount)
			int deleteCount = service.removeSecondhand(secondhand_idx);
			
			// 삭제 실패 시 "삭제 실패!" 처리 후 이전페이지 이동
			// 아니면(삭제성공시), secondhand_list 서블릿 요청(파라미터 : 페이지번호)
			if(deleteCount == 0) {
				model.addAttribute("msg", "삭제 실패!");
				return "fail_back";	
			}
			
			return "redirect:/secondhand_list?pageNum=" + pageNum;
			
		}
		
		
		
		
		
		//판매자페이지
		@GetMapping("secondhandSeller")
		public String secondhand_seller_page(HttpSession session, 
				@RequestParam String member_id, 
				Model model) {
			
			
			
			String sId = (String) session.getAttribute("member_id");
			System.out.println(sId);
		
			
			//			String sId = (String) session.getAttribute("sId");
			//			System.out.println(" sId : +++++++++++++++++++++++++++++++++++"+ sId);
			//
			//			session.setAttribute("sId", session.getAttribute(sId));
			//			System.out.println(" sId : +++++++++++++++++++++++++++++++++++"+ sId);

			//판매자의 정보 조회작업
			//필요정보 - 판매자 프로필, 판매자 닉네임, 판매자 주소
			//상세페이지의 sellerInfo재사용 -> xml에서 조건주기(파라미터값으로 secondhand_idx값 있을경우/없을경우 구분하는 동적쿼리)
			MemberVO sellerInfo_sellerPage = service.getSellerInfo_sellerPage(member_id);
			System.out.println("판매자페이지***********&&&&&&&&&&&&&&&& 판매자정보 : " + sellerInfo_sellerPage);
			model.addAttribute("seller",sellerInfo_sellerPage);
			
			
			//List<HashMap<String, String>> selectSeller;
			
			//---------------------------------------------------------------------------------------------------------------------
			
			//판매자의 판매물품 목록 조회작업 (거래상태별) - 상세페이지의 getsellerProductList()재사용
			
			//판매상태 판별 방법 2
			//1. 뷰페이지에서 넘겨받기? -> 파라미터로 넘겨주고 xml에서 동적쿼리
			//2. 뷰페이지에서 판별하기? -> 판매자의 전체 판매목록 넘겨받아, 뷰페이지에서 dealStatus가 '판매중'인 상품 목록만 표시하기
			
			
			//기본(판매자의 판매 상품 전체목록조회)
			List<HashMap<String, String>> sellerProductList = service.getSellerProductList(member_id);
			model.addAttribute("sellerProductList",sellerProductList);
			//System.out.println(sellerProductList);
			
			//판매자의 판매중/예약중 상품목록 조회
			List<HashMap<String, String>> dealProductList = service.getdealProductList(member_id);
			model.addAttribute("dealProductList",dealProductList);
			//System.out.println(dealProductList);
			//판매자의 판매완료 상품목록 조회
			List<HashMap<String, String>> soldOutProductList = service.getsoldOutProductList(member_id);
			model.addAttribute("soldOutProductList",soldOutProductList);
			//System.out.println(soldOutProductList);
			
			
			
			//판매자의 판매물품 개수 조회작업 (거래상태별) -  상세페이지의 getsellerProductListCount()재사용
			//판매상태 판별 방법 2
			//1. 뷰페이지에서 넘겨받기? -> 파라미터로 넘겨주고 xml에서 동적쿼리
			//2. 뷰페이지에서 판별하기? -> 판매자의 전체 판매목록 넘겨받아, 뷰페이지에서 dealStatus가 '판매중'인 상품 목록만 표시하기
			
			//판매자의 전체 판매물품 개수
			int sellerProduct = service.getSellerProductCount(member_id);
			model.addAttribute("sellerProduct", sellerProduct);
			//판매자의 판매중,예약중 상품목록 개수
			int dealProductCount = service.getdealProductCount(member_id);
			model.addAttribute("dealProductCount", dealProductCount);
			//판매자의 판매완료 상품목록 개수
			int soldOutProductCount = service.getsoldOutProductCount(member_id);
			model.addAttribute("soldOutProductCount", soldOutProductCount);
			
//			System.out.println("&&&&&&&&&&&&&&&&&&&&&&&&"+ sellerProduct);

//			
			
			
			//---------------------------------------------------------------------------------------------------------------------			
//			//판매자가 받은 리뷰 조회(list)
//			//SecondService.getReviewList() - 파라미터:member_id /  리턴타입:List<HashMap<String,String>>
//			//필요정보 - 리뷰작성한 회원의 닉네임/프로필이미지/리뷰내용/리뷰날짜/
			List<HashMap<String,String>> reviewList = service.getReviewList(member_id);
			model.addAttribute("reviewList", reviewList);
			System.out.println("++++++++++++++++++++++리뷰리스트조회 : " + reviewList);
			
//			//판매자가 받은 리뷰 개수 조회(int)
			int reviewListCount = service.getReviewListCount(member_id);
			model.addAttribute("reviewListCount", reviewListCount);
			System.out.println("++++++++++++++++++++++리뷰개수조회 : " + reviewListCount);
			
			
			return "secondhand/secondhand_seller_page";
		}
		
		
		
		// 신고하기 작업--------------------------------------------------------------------
		//신고하기 팝업 이동(모달?)
		@GetMapping("reportPopup")
		public String reportPopup() {
			return "secondhand/report_popup";
		}
		
		//신고 등록작업(INSERT)
		@ResponseBody
		@RequestMapping(value = "reportContent", method = {RequestMethod.GET, RequestMethod.POST})
		public String report(@RequestParam Map<String,String> map) {
			System.out.println("전달된 신고 타입 : " + map.get("reportType"));
			System.out.println("전달된 신고 사유 : " + map.get("reportReason"));
			System.out.println("전달된 신고 상품번호 : " + map.get("secondhand_idx"));
			System.out.println("전달된 신고된 회원아이디 : " + map.get("member_id"));
			System.out.println("전달된 신고한 회원아이디 : " + map.get("report_member_id"));
			
			String reportType = map.get("reportType");
			String reportReason = map.get("reportReason");
			String secondhand_idx = map.get("secondhand_idx");
			String member_id = map.get("member_id");
			String report_member_id = map.get("report_member_id");
			
			//전달받은 신고사유 구분하여 신고테이블 insert
			int insertCount = service.registReport(reportType, 
					reportReason, 
					secondhand_idx, 
					member_id,
					report_member_id);
			
			System.out.println(insertCount);
			if(insertCount>0) {
				return "success";	
			} else {
				return "fail";
			}
		}
	
		
		
		
		
		
//		// 페이지 - 찜보여주기
		@RequestMapping(value = "likeProductShow", method = {RequestMethod.GET, RequestMethod.POST})
		@ResponseBody
		public LikeVO likeMovieShow(HttpSession session) {
			// 찜한 영화 있을 경우 찜하기 표시하기(비회원이 아닐 때)
			String member_id = (String) session.getAttribute("member_id");
			

			if (member_id != null) {
//				System.out.println("어디서 문제니 : member_id " + member_id);
//				System.out.println("어디서 문제니 : member_type " + session.getAttribute("member_type"));
				
				// 찜한 영화 찾기
				// LikeService - getLikeMovie()
				// 파라미터 : member_id		리턴타입 : List<LikeVO>(likeList)
				LikeVO likeList = service.getLikeProduct(member_id); 
				System.out.println(likeList);
//						
//				if(likeList != null) {
					// 모델에 저장 (-> 메인, 영화목록, 영화디테일)
					// 세션x : 찜하기 목록이 업데이트 될때마다 달라지므로 페이지마다 조회해서 파라미터로 받을 예정
//				} else {
//					
//				}
				return likeList;
			}
			return null;
		}
//		
		
		
//		찜기능
		@RequestMapping(value = "likeProduct", method = {RequestMethod.GET, RequestMethod.POST})
		@ResponseBody
		public Integer likeProduct(
				// 찜 구현 시 필요한 파라미터
				String member_id, 
				int secondhand_idx, 
				boolean isLike
				, LikeVO productLike
				) {
			
			// 넘어온 파라미터 확인
			System.out.println("member_id : " + member_id + ", secondhand_idx : " + secondhand_idx + ", isLike : " + isLike);
			
			// isLike의 값에 따라
			// FALSE (찜 안된 영화 -> 찜) : INSERT
			// 	 LikeService - checkLikeMovie()		파라미터 : MovieLikeVO(movieLike)		리턴타입 : int(insertCount)
			// TRUE (찜 된 영화 -> 찜 취소) : DELETE
			//	 LikeService - unCheckLikeMovie()		파라미터 : MovieLikeVO(movieLike)		리턴타입 : int(deleteCount)
			if(!isLike) {
				// 찜 기능(insert)
				int insertCount = service.checkLikeProduct(productLike);
				System.out.println("찜 된 영화 갯수 : " + insertCount);
				
				return insertCount;
			} else {
				// 찜 취소(delete)
				int deleteCount = service.unCheckLikeProduct(productLike);
				System.out.println("취소된 영화 갯수 : " + deleteCount);
				
				return deleteCount;
			}
			
		}


		
		
		
		
		
		
		
		
		
		
		
		
}


