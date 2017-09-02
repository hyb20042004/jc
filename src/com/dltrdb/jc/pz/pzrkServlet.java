package com.dltrdb.jc.pz;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * Servlet implementation class pzrkServlet
 */
@WebServlet("/pzrkServlet")
public class pzrkServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public pzrkServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		final String DB_URL="jdbc:mysql://localhost:3306/jc_pz";
		final String DB_NAME="root";
		final String DB_PASS="";	
		final String DB_DRIVER="com.mysql.jdbc.Driver";
	 
		Connection conn=null;
		PreparedStatement psmt=null;
		Integer pz_num=Integer.parseInt(request.getParameter("pzzl"));
		Long pz_hd1=Long.parseLong(request.getParameter("pzhd1"));
		Long pz_hd2=Long.parseLong(request.getParameter("pzhd2"));
		Integer pz_count=((int)(pz_hd2-pz_hd1))+1;
		String time=request.getParameter("rksj");
		
		try {
			Class.forName(DB_DRIVER);
			conn=DriverManager.getConnection(DB_URL, DB_NAME, DB_PASS);
			psmt=conn.prepareStatement("insert into pz_kc(pz_num,pz_hd,rksj,pz_hde) values(?,?,?,?,?)");
			psmt.setInt(1,pz_num);
			psmt.setLong(2,pz_hd1);
			psmt.setString(3, time);
			psmt.setLong(4,pz_hd2);
			int row=psmt.executeUpdate();
			if(row>0) {
				
				System.out.println("添加"+row+"调数据！");
				response.sendRedirect("pzrk.jsp");
			}else {
				System.out.println("SQL执行异常");
			}
				
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			try {
				if(conn!=null)conn.close();
				if(psmt!=null)psmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				
			}
		}
			
		}
				
	}
