package com.dltrdb.jc.pz;

import java.io.IOException;
import java.security.spec.DSAGenParameterSpec;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.dbcp.dbcp.BasicDataSource;

import com.mysql.fabric.xmlrpc.base.Array;


/**
 * Servlet implementation class pzckServlet
 */
@WebServlet("/pzckServlet")
public class pzckServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public pzckServlet() {
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
	@SuppressWarnings("resource")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		final String DB_URL="jdbc:mysql://localhost:3306/jc_pz";
		final String DB_NAME="root";
		final String DB_PASS="";	
		final String DB_DRIVER="com.mysql.jdbc.Driver";
		Long name=null;
		Long num=null;
		Connection conn=null;
		PreparedStatement psmt=null;
		
		Integer pzzl=Integer.parseInt(request.getParameter("pzzl")); 
		Long pz_hd1=Long.parseLong(request.getParameter("pzhd1"));
		Long pz_hd2=Long.parseLong(request.getParameter("pzhd2"));
		Integer pz_count=((int)(pz_hd2-pz_hd1))+1;
		Integer lqjg=Integer.getInteger(request.getParameter("lqjg"));
		String lqr=request.getParameter("lqr");
		String zy=request.getParameter("zy");
		String cksj=request.getParameter("cksj");
		
		try {
			BasicDataSource bs=new BasicDataSource();
			bs.setUrl(DB_URL);
			bs.setDriverClassName(DB_DRIVER);
			bs.setUsername(DB_NAME);
			bs.setPassword(DB_PASS);
			conn=bs.getConnection();
			//1。查询库存表与出库表
			psmt=conn.prepareStatement("selecpt pz_hde from pz_kc where pz_hd=?");
			psmt.setLong(1, pz_hd1);
			//psmt.setInt(2, pzzl);
			ResultSet result=psmt.executeQuery();
			while(result.next()) {
				name=result.getLong("pz_hde");
			}
			psmt=conn.prepareStatement("select pz_hd,pz_hde from pz_ck where pz_hd=? or pz_hde=?");
			psmt.setLong(1, pz_hd1);
			psmt.setLong(2, pz_hd2);
			Boolean result1=psmt.execute();
			System.out.println("1，数凭证库存查询完毕！");
			//2、添加凭证出库数据表
			conn.setAutoCommit(false);
			if(!result1) {
				psmt=conn.prepareStatement("insert into pz_ck(pz_num,pz_hd,pz_count,lqr,zy,cksj,pz_hde,batch) values(?,?,?,?,?,?,?,?)");
				psmt.setInt(1, pzzl);
				psmt.setLong(2, pz_hd1);
				psmt.setInt(3, pz_count);
				psmt.setString(4, lqr);
				psmt.setString(5, zy);
				psmt.setString(6, cksj);
				//psmt.setInt(7,lqjg);
				psmt.setLong(7, pz_hd2);
				
				int row = psmt.executeUpdate();
				if(row>0)
				System.out.println("2，添加凭证出库数据表完成！");
				//3.更新凭证库存表
				psmt=conn.prepareStatement("update pz_kc set pz_hd=?,cksj=? where pz_hd=?");
				if(name>pz_hd2) {
				psmt.setLong(1, pz_hd2+1);
				}else {
					psmt.setLong(1, pz_hd2);
				}
				psmt.setString(2,cksj);
				psmt.setLong(3, pz_hd1);
				int row2=psmt.executeUpdate();
				 if(row2>0)
					System.out.println("3.更新凭证库存表完成！！");
			}else {
				System.out.println("凭证出库表中存在记录！");
				response.sendRedirect("pzck.jsp");
			}
			 conn.commit();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			try {
				conn.rollback();
			} catch (SQLException e1) {
				
			}
			e.printStackTrace();
		}finally {
			
				try {
					if(conn!=null)conn.close();
					if(psmt!=null)psmt.close();
					
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					
				}
		}
		
	}

}
