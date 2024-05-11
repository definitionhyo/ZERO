package com.itwillbs.zero.service;

import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import com.itwillbs.zero.handler.BankValueGenerator;
import com.itwillbs.zero.vo.BankAccountDetailVO;
import com.itwillbs.zero.vo.ResponseDepositVO;
import com.itwillbs.zero.vo.ResponseTokenVO;
import com.itwillbs.zero.vo.ResponseUserInfoVO;
import com.itwillbs.zero.vo.ResponseWithdrawVO;

@Service
public class BankApiClient {

	// classpath:/config/appdata.properties 파일 내의 속성값 자동 주입
	// 주의! @Value 어노테이션 선언 시 패키지명 : org.springframework.beans.factory.annotation
	@Value("${base_url}")
	private String baseUrl;
	
	@Value("${client_id}")
	private String clientId;
	
	@Value("${client_secret}")
	private String clientSecret;
	
	private RestTemplate restTemplate;	// @Autowired 어노테이션 사용 불가(스프링에서 관리하는 Bean 객체가 아님)
	
	@Autowired
	private BankValueGenerator valueGenerator;
	
	// 로그 출력을 위한 변수 선언 => getLogger() 메서드 파라미터로 로그 처리할 현재 클래스 지정
	private static final Logger logger = LoggerFactory.getLogger(BankApiClient.class);
	
	// 2.1.2. 토큰발급 API - 사용자 토큰발급 API (3-legged)
	public ResponseTokenVO requestToken(Map<String, String> authResponse) {
		
		String url = "https://testapi.openbanking.or.kr/oauth/2.0/token";
//		String url = baseUrl + "/oauth/2.0/token";
		
		// 1. 헤더, 바디 생성
		HttpHeaders httpHeaders = new HttpHeaders();
		
		// 2. 헤더에 정보 추가
		httpHeaders.add("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");
		
		
		// 3. 요청에 필요한 파라미터 설정
		MultiValueMap<String, String> parameters = new LinkedMultiValueMap<String, String>();
		
		parameters.add("code", authResponse.get("code")); // 응답데이터 활용
		parameters.add("client_id", "4066d795-aa6e-4720-9383-931d1f60d1a9"); // @Value 어노테이션으로 포함한 속성값
		parameters.add("client_secret", "36b4a668-94ba-426d-a291-771405e498e4"); // @Value 어노테이션으로 포함한 속성값
		parameters.add("redirect_uri", "http://localhost:8089/zero/callback"); // 기존 콜백 URL 그대로 활용
//		parameters.add("redirect_uri", "http://c5d2302t1.itwillbs.com/ZERO/callback"); // 기존 콜백 URL 그대로 활용
		parameters.add("grant_type", "authorization_code"); // 고정값
		
//		parameters.add("code", authResponse.get("code")); // 응답데이터 활용
//		parameters.add("client_id", clientId); // @Value 어노테이션으로 포함한 속성값
//		parameters.add("client_secret", clientSecret); // @Value 어노테이션으로 포함한 속성값
////		parameters.add("redirect_uri", "http://localhost:8089/zero/callback"); // 기존 콜백 URL 그대로 활용
//		parameters.add("redirect_uri", "http://c5d2302t1.itwillbs.com/ZERO/callback"); // 기존 콜백 URL 그대로 활용
//		parameters.add("grant_type", "authorization_code"); // 고정값
		logger.info("□□□□□□ parameters : " + parameters.toString());
		
		// 4. 요청에 사용될 헤더와 파라미터 정보를 갖는 HttpEntity 객체 생성
		// => 제네릭타입으로 요청 파라미터 타입 지정
		HttpEntity<MultiValueMap<String, String>> httpEntity = 
				new HttpEntity<MultiValueMap<String,String>>(parameters, httpHeaders);
		
		// 5. REST 방식 요청을 수행하기 위해서는 RestTemplate 객체 생성
		restTemplate = new RestTemplate();
		
		// 6. RestTemplate 객체의 exchange() 메서드 호출
		ResponseEntity<ResponseTokenVO> responseEntity =
				restTemplate.exchange(url, HttpMethod.POST, httpEntity, ResponseTokenVO.class);
		
		// 7. 응답받은 ResponseEntity
		logger.info("□□□□□□ ResponseEntity.getBody() : " + responseEntity.getBody());
		logger.info("□□□□□□ ResponseEntity.getStatusCode() : " + responseEntity.getStatusCode());
		
		// 8. 응답 데이터 리턴
		// => ResponseEntity 객체의 제네릭타입인 ResponseTokenVO 타입 객체는
		//    ResponseEntity 객체의 getBody() 메서드로 리턴받을 수 있다! 
		return responseEntity.getBody();
	}

	// 2.2. 사용자/계좌 관리 
	// - 2.2.1. 사용자정보조회 API - GET
	public ResponseUserInfoVO requestUserInfo(String access_token, String user_seq_no) {
		
		String url = "https://testapi.openbanking.or.kr/v2.0/user/me";
//		String url = baseUrl + "/v2.0/user/me";
		
		// 1. 헤더 생성
		HttpHeaders httpHeaders = new HttpHeaders();
		
		// 2. 헤더에 정보 추가
		httpHeaders.add("Authorization", "Bearer" + access_token);
		
		// 3. 요청에 필요한 파라미터 설정
		UriComponents uriComponents = UriComponentsBuilder.fromHttpUrl(url).queryParam("user_seq_no", user_seq_no).build();
		
		// 4. 요청에 사용될 헤더와 파라미터를 갖는 HttpEntity 객체 생성
		HttpEntity<String> httpEntity = new HttpEntity<String>(httpHeaders);
		
		// 5. Rest 방식 요청을 위해 RestTemplate 객체 생성
		RestTemplate restTemplate = new RestTemplate();
		
		// 6. RestTemplate 객체의 exchage() 메서드 호출 -> HTTP 요청 수행
		ResponseEntity<ResponseUserInfoVO> responseEntity = restTemplate.exchange(uriComponents.toString(), HttpMethod.GET, httpEntity, ResponseUserInfoVO.class);
		
		logger.info("□□□□□□ 사용자정보조회 ResponseEntity.getBody() : " + responseEntity.getBody());
		
		return responseEntity.getBody();
	}

	
	// 2.3. 조회서비스(사용자) - 2.3.1. 잔액조회 API - GET
	public BankAccountDetailVO requestAccountDetail(Map<String, String> map) {
		
		String bank_tran_id = valueGenerator.getBankTranId();
		String tran_dtime = valueGenerator.getTranDTime();
		logger.info("□□□□□□ 은행고유번호 bank_tran_id : " + bank_tran_id);
		logger.info("□□□□□□ 거래요청일시 tran_dtime : " + tran_dtime);
		
		
		// 잔액조회 요청 API 의 URL 생성 - GET 방식
		String url = "https://testapi.openbanking.or.kr/v2.0/account/balance/fin_num";
//		String url = baseUrl + "/v2.0/account/balance/fin_num";
		
		// 1. 헤더 설정(org.springframework.http.HttpHeaders 클래스 활용)을 위한 HttpHeaders 객체 생성
		HttpHeaders httpHeaders = new HttpHeaders();
		
		// 2. 헤더에 정보 추가(Authorization 항목으로 엑세스 토큰 전달("Bearer 엑세스토큰" 형식)
		httpHeaders.add("Authorization", "Bearer " + map.get("access_token"));
		
		// 3. 요청에 사용될 헤더와 파라미터 정보를 갖는 HttpEntity 객체 생성
		HttpEntity<String> httpEntity = new HttpEntity<String>(httpHeaders);

		// 4. 요청에 필요한 파라미터 설정
		UriComponents uriComponents = UriComponentsBuilder.fromHttpUrl(url)
															.queryParam("bank_tran_id", bank_tran_id)
															.queryParam("fintech_use_num", map.get("fintech_use_num"))
															.queryParam("tran_dtime", tran_dtime)
															.build();
		
		// 5. REST 방식 요청을 수행하기 위해 RestTemplate 객체 생성
		restTemplate = new RestTemplate();
		
		// 6. RestTemplate 객체의 exchange() 메서드 호출하여 HTTP 요청 수행
		// => 파라미터 : 요청 URL 과 파라미터가 저장된 UriComponents 객체(단, 문자열로 변환 필요), 
		//               요청메서드(HttpMethod.XXX), HttpEntity 객체, 응답데이터 저장 클래스타입(.class 필수)
		// => 리턴타입 : ResponseEntity<T> => 제네릭타입은 exchange() 메서드의 마지막 파라미터인 클래스타입 사용
		ResponseEntity<BankAccountDetailVO> responseEntity = 
				restTemplate.exchange(uriComponents.toString(), HttpMethod.GET, httpEntity, BankAccountDetailVO.class);
		logger.info("□□□□□□ 잔액조회API responseEntity.getBody() : " + responseEntity.getBody());
		
		return responseEntity.getBody();
	}

	
	// 2.5. 이체서비스 - 2.5.1. 출금이체 API 요청을 위한 폼 생성(PDF p74)
	public ResponseWithdrawVO requestWithdraw(Map<String, String> map) {
		// 출금이체 요청 API 의 URL 생성 - POST 방식
		String url = "https://testapi.openbanking.or.kr/v2.0/transfer/withdraw/fin_num";
//		String url = baseUrl + "/v2.0/transfer/withdraw/fin_num";
		
		// 헤더 생성
		// => Content-Type 속성 JSON 형식으로 변경
		HttpHeaders httpHeaders = new HttpHeaders();
//					httpHeaders.add("Authorization", "Bearer " + map.get("access_token")); // Bearer 토큰 설정
//					httpHeaders.add("Content-Type", "application/json; charset=UTF-8"); // JSON 타입 요청 헤더 설정
		
		// 위의 코드와 동일한 작업을 수행하는 또 다른 방법
		httpHeaders.setBearerAuth(map.get("access_token")); // Bearer 토큰 설정
		httpHeaders.setContentType(MediaType.APPLICATION_JSON); // JSON 타입 요청 헤더 설정
		
		// 요청 파라미터를 JSON 형식으로 생성하기 - org.json 패키지
		JSONObject jo = new JSONObject();
		jo.put("bank_tran_id", valueGenerator.getBankTranId());
		jo.put("cntr_account_type", "N"); // 약정 계좌/계정 구분(N:계좌, C:계정 => N 고정)
		jo.put("cntr_account_num", "50000012"); // 약정계좌 계좌번호
		jo.put("dps_print_content", "ZERO충전테스트");	// 입금계좌 인자내역 : 핀테크 기관 입장에서 입금해주는 것!
		jo.put("fintech_use_num", map.get("fintech_use_num")); // 출금계좌 핀테크이용번호(전달받은 값)
		jo.put("tran_amt", map.get("zpayAmount"));	// 거래금액
//		jo.put("tran_amt", "50000");	// 거래금액
		jo.put("tran_dtime", valueGenerator.getTranDTime());	// 거래 요청 일시
		jo.put("req_client_name", "신혜진");	// 송금인 실명
		jo.put("req_client_fintech_use_num", map.get("fintech_use_num"));
		jo.put("req_client_num", "1");
		jo.put("transfer_purpose", "TR");	// 이체 용도(TR : 송금)
		// 아래 3개 정보는 피싱 등의 사고 발생 시 지급 정지를 위한 정보(검증을 수행하지 않음)
		jo.put("recv_client_name", "제로");	// 수취인 실명
		jo.put("recv_client_bank_code", "002");
		jo.put("recv_client_account_num", "123123123");
		logger.info("□□□□□□ 출금이체 요청 JSON 데이터 : " + jo.toString());
		
		
		// 3. 요청에 사용될 헤더와 파라미터 정보를 갖는 HttpEntity 객체 생성
		// => 파라미터 데이터로 JSONObject 객체를 문자열로 변환하여 전달 
		HttpEntity<String> httpEntity = new HttpEntity<String>(jo.toString(), httpHeaders);
		
		
		// 4. POST 요청 시 
		RestTemplate restTemplate = new RestTemplate();
		ResponseEntity<ResponseWithdrawVO> responseEntity = 
				restTemplate.postForEntity(url, httpEntity, ResponseWithdrawVO.class);
		logger.info("□□□□□□ 출금이체결과 ResponseEntity.getBody() : " + responseEntity.getBody());
		
		return responseEntity.getBody();
	}
	
	
	// 2.5. 이체서비스 - 2.5.2. 입금이체 API 요청을 위한 폼 생성(PDF p83)
	public ResponseDepositVO requestDeposit(Map<String, String> map) {
		// 입금이체 요청 API 의 URL 생성 - POST 방식
		String url = "https://testapi.openbanking.or.kr/v2.0/transfer/deposit/fin_num";
//		String url = baseUrl + "/v2.0/transfer/deposit/fin_num";
		
		// 헤더 생성
		// => Content-Type 속성 JSON 형식으로 변경
		HttpHeaders httpHeaders = new HttpHeaders();
		httpHeaders.setBearerAuth(map.get("access_token")); // Bearer 토큰 설정
		httpHeaders.setContentType(MediaType.APPLICATION_JSON); // JSON 타입 요청 헤더 설정
		
		// 1개 입금정보를 저장할 JSONObject 객체 생성
		JSONObject joReq = new JSONObject();
		joReq.put("tran_no", "1"); // 거래순번
		joReq.put("bank_tran_id", valueGenerator.getBankTranId());
		joReq.put("fintech_use_num", map.get("fintech_use_num")); // 입금계좌 핀테크이용번호(전달받은 값)
		joReq.put("print_content", "ZERO 환급테스트"); // 입금계좌 인자내역(테스트 데이터 등록)
		joReq.put("tran_amt",  map.get("zpayAmount")); // 거래금액(테스트 데이터 등록)
//		joReq.put("tran_amt", "1000"); // 거래금액(테스트 데이터 등록)
		joReq.put("req_client_name", "제로"); // 거래를 요청한 사용자 이름(송금인)
//		joReq.put("req_client_bank_code", "002"); // 
		joReq.put("req_client_fintech_use_num", map.get("fintech_use_num")); // 거래를 요청한 사용자 핀테크번호
		joReq.put("req_client_num", "1"); //  // 거래를 요청한 사용자 번호(아이디처럼 사용되는 번호, 임의부여)
		joReq.put("transfer_purpose", "TR"); // 출금(송금)
		
		// 입금 정보를 배열로 관리할 JSONArray 객체 생성
		JSONArray jaReqList = new JSONArray();
		jaReqList.put(joReq);
		
		// 요청 파라미터를 JSON 형식으로 생성하기 - org.json 패키지 클래스 활용
		JSONObject jo = new JSONObject();
		jo.put("cntr_account_type", "N"); // 약정 계좌/계정 구분(N:계좌, C:계정 => N 고정)
		jo.put("cntr_account_num", "50000012"); // 약정계좌 계좌번호(테스트데이터 출금계좌 항목에 등록할 계좌번호)
		jo.put("wd_pass_phrase", "NONE"); // 테스트용은 "NONE" 값 고정
		jo.put("wd_print_content", "신혜진고객환급"); // 출금계좌인자내역
//		jo.put("wd_print_content", map.get("req_client_name") + "고객환급"); // 출금계좌인자내역
		jo.put("name_check_option", "on"); // 수취인성명 검증 여부(on:검증함) - 생략 시 기본값 on
		jo.put("tran_dtime", valueGenerator.getTranDTime()); // 거래요청일시
		jo.put("req_cnt", "1"); // 입금요청건수("1" 고정)
		jo.put("req_list", jaReqList);// 입금정보목록 - JSONArray 객체
		
		logger.info("□□□□□□ 입금이체 요청 JSON 데이터 : " + jo.toString());
		
		// 3. 요청에 사용될 헤더와 파라미터 정보를 갖는 HttpEntity 객체 생성
		// => 파라미터 데이터로 JSONObject 객체를 문자열로 변환하여 전달 
		HttpEntity<String> httpEntity = new HttpEntity<String>(jo.toString(), httpHeaders);
		// 4. POST 요청 시 JSON 데이터를 전송하기 위해 RestTemplate 객체의 postForEntity() 메서드 호출
		// => 리턴타입 : ResponseEntity<T> => 제네릭타입은 리턴되는 데이터를 관리하는 클래스 타입으로 지정
		//               (ResponseWithdrawVO 타입)
		// => 파라미터 : URL, HttpEntity 객체(요청 데이터 포함), 응답데이터 관리 클래스타입
		restTemplate = new RestTemplate();
		ResponseEntity<ResponseDepositVO> responseEntity = 
				restTemplate.postForEntity(url, httpEntity, ResponseDepositVO.class);
		logger.info("□□□□□□ 입금이체결과 ResponseEntity.getBody() : " + responseEntity.getBody());
		
		return responseEntity.getBody();
	}

}
