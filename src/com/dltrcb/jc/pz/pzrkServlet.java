package com.dltrcb.jc.pz;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

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
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		final String DB_URL="jdbc:mysql://localhost:3307/jc_pz";
		final String DB_NAME="root";
		final String DB_PASS="rC949hrNrY6qZrEP";	
		final String DB_DRIVER="com.mysql.jdbc.Driver";
	 
		Connection conn=null;
		PreparedStatement psmt=null;
		 Long hd1[]=new Long[21];
	        Long hd2[]=new Long[21];
	        int[] num=new int[21];
	        int[] pznum=new int[21];
	    request.setCharacterEncoding("utf-8");
		try {
			String[] pzzl=request.getParameterValues("pzzl");
		String[] pz_hd1=request.getParameterValues("pzhd1");
		String[] pz_hd2=request.getParameterValues("pzhd2");
		String[] pz_num=request.getParameterValues("pznum");
		//Integer pz_count=((int)(pz_hd2-pz_hd1))+1;
		String jbr=request.getParameter("jbr");
		String zy=request.getParameter("zy");
		java.util.Date date=new java.util.Date();
		DateFormat time=new SimpleDateFormat("yyyy年MM月dd日");
		DateFormat time1=new SimpleDateFormat("yyyyMMddHHmmss");
		String rksj=time.format(date);
		String tag=time1.format(date);
		
			Class.forName(DB_DRIVER);
			conn=DriverManager.getConnection(DB_URL, DB_NAME, DB_PASS);
			conn.setAutoCommit(false);
			psmt=conn.prepareStatement("insert into pz_kc(pz_num,pz_hd,rksj,pz_hde,zy,jbr,tag,pz_count) values(?,?,?,?,?,?,?,?)");
			for(int i=0;i<pzzl.length;i++) {
				num[i]=Integer.valueOf(pzzl[i]);
				hd1[i]=Long.valueOf(pz_hd1[i]);
				hd2[i]=Long.valueOf(pz_hd2[i]);
				pznum[i]=Integer.valueOf(pz_num[i]);
			psmt.setInt(1,num[i]);
			psmt.setLong(2,hd1[i]);
			psmt.setString(3,rksj);
			psmt.setLong(4,hd2[i]);
			psmt.setString(5,zy);
			psmt.setString(6,jbr);
			psmt.setString(7,tag);
			psmt.setInt(8,pznum[i]);
			psmt.addBatch();
			}
			int[] rows=psmt.executeBatch();
			int row=rows.length;
			if(row>0) {
				System.out.println("添加"+row+"调数据！");
				psmt=conn.prepareStatement("insert into pz_print(name,pz_tag,date,jg_num) values(?,?,?,?)");
				psmt.setString(1, tag);
				psmt.setInt(2, 0);
				psmt.setString(3, rksj);
				psmt.setInt(4, 77001);
				boolean row1=psmt.execute();
				if(row1) {
					System.out.println("添加凭证待打印表成功");
				}
				 conn.commit();
				response.sendRedirect("pzrk.jsp?action=1");
			}else {
				response.sendRedirect("pzrk.jsp?action=0");
			}
				
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			} 
			e.printStackTrace();
		}catch (NumberFormatException e) {
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
