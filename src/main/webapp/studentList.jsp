<%@page import="java.util.ArrayList"%>
<%@page import="com.limscompany.dto.studentDto"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>모든 학생 리스트</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");	
		
		String sql = "SELECT * FROM student"; // 모든 학생레코드 가져오기
		
		String driverName = "com.mysql.jdbc.Driver"; //MySQL JDBC 드라이버 이름
		String url = "jdbc:mysql://localhost:3306/abc_school"; //MySQL이 설치된 주소와 연결할 DB(스키마) 이름
		String username = "root"; //계정 이름 -> 관리자 계정 이름
		String password = "12345"; //계정 비밀번호 -> 관리자 계정 비밀번호

		Connection conn = null;  //DB와의 커넥션을 초기값 null로 해서 생성
		Statement stmt = null;  //SQL문을 실행시켜주는 객체
		ResultSet rs = null;  //select문 실행 시 db에서 반환해주는 결과 레코드를 받아주는 자료 타입
		
		try {
			Class.forName(driverName);
			conn = DriverManager.getConnection(url, username, password);
			stmt = conn.createStatement();
			
			rs = stmt.executeQuery(sql); //sql문 db에서 실행 -> 성공 ResultSet 객체(rs)로 반환되는 값을 받아야 함
			int hakbun = 0;
			String name = "";
			String addr = "";
			int grade = 0;
			
			List<studentDto> studentList = new ArrayList<studentDto>();
					
			
			out.println("---- 학생 정보 조회 결과 ----"+"<br><br>");
			while(rs.next()) {
				hakbun = rs.getInt("hakbun"); //학년
				name = rs.getString("name");  //이름
				grade = rs.getInt("grade"); //학년
				addr = rs.getString("address"); //주소
				
				// 생성자 2가지 이용 방법
				//studentDto studentDto = new studentDto(hakbun, name, grade, addr);  
				studentDto studentDto = new studentDto();
				studentDto.setHakbun(hakbun);
				studentDto.setName(name);
				studentDto.setGrade(grade);
				studentDto.setAddress(addr);
				
				studentList.add(studentDto);
				
				//out.println(hakbun+"/"+name+"/"+grade+"/"+addr+"<br>");
			}

			for (int i=0;i<studentList.size();i++) {  // size() 가 length
				out.println(studentList.get(i).getHakbun()+"/");
				out.println(studentList.get(i).getName()+"/");
				out.println(studentList.get(i).getGrade()+"/");
				out.println(studentList.get(i).getAddress()+"<br>");
			}
			
		} catch (Exception e) {
			out.println("DB 에러발생!! 회원 조회 실패!");
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (stmt != null) {
					stmt.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}	
	
	%>

</body>
</html>