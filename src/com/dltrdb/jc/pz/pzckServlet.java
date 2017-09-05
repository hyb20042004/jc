package com.dltrdb.jc.pz;

import java.io.IOException;
import java.security.spec.DSAGenParameterSpec;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
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
		request.setCharacterEncoding("utf-8");
		String[] pzzl=request.getParameterValues("pzzl");
		String[] pz_hd1=request.getParameterValues("pzhd1");
		String[] pz_hd2=request.getParameterValues("pzhd2");
		String lqjg=request.getParameter("lqjg");
		String lqr=request.getParameter("lqr");
		String zy=request.getParameter("zy");
		java.util.Date date=new java.util.Date();
		DateFormat time=new SimpleDateFormat("yyyy年MM月dd日");
		String cksj=time.format(date);
		Long hd1[]=new Long[20];
	    Long hd2[]=new Long[20];
	    Long hd[]=new Long[20];
		
		try {
			BasicDataSource bs=new BasicDataSource();
			bs.setUrl(DB_URL);
			bs.setDriverClassName(DB_DRIVER);
			bs.setUsername(DB_NAME);
			bs.setPassword(DB_PASS);
			conn=bs.getConnection();
			/*//1。查询库存表与出库表
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
			System.out.println("1，数凭证库存查询完毕！");*/
			//2、添加凭证出库数据表
			conn.setAutoCommit(false);
			//if(!result1) {
				psmt=conn.prepareStatement("insert into pz_ck(pz_num,pz_hd,pz_count,lqr,zy,cksj,pz_hde,lqjg) values(?,?,?,?,?,?,?,?)");
				for(int i=1;i<pzzl.length;i++) {
				hd1[i]=Long.valueOf(pz_hd1[i]);
				hd2[i]=Long.valueOf(pz_hd2[i]);
				Integer pz_count=((int)(hd2[i]-hd1[i]))+1;	
				psmt.setString(1, pzzl[i]);
				psmt.setLong(2, hd1[i]);
				psmt.setInt(3, pz_count);
				psmt.setString(4, lqr);
				psmt.setString(5, zy);
				psmt.setString(6, cksj);
				psmt.setLong(7, hd2[i]);
				psmt.setString(8,lqjg);
				psmt.addBatch();
				}
				int[] rows = psmt.executeBatch();
				int row=rows.length;
				if(row>0)
				System.out.println("2，添加凭证出库数据表完成！");
				//3.更新凭证库存表
				psmt=conn.prepareStatement("update pz_kc set pz_hd=?,cksj=? where pz_hd=?");
				for(int i=1;i<pzzl.length;i++) {
					hd1[i]=Long.valueOf(pz_hd1[i]);
					hd2[i]=Long.valueOf(pz_hd2[i]);
				/*if(name>pz_hd2) {
				psmt.setLong(1, pz_hd2+1);
				}else {
					psmt.setLong(1, pz_hd2);
				}*/
				psmt.setLong(1, hd2[i]+1);	
				psmt.setString(2,cksj);
				psmt.setLong(3, hd1[i]);
				psmt.addBatch();
				}
				int[] rows2=psmt.executeBatch();
				int row2=rows2.length;
				 if(row2>0)
					System.out.println("3.更新凭证库存表完成！！");
			/*}else {
				System.out.println("凭证出库表中存在记录！");
				response.sendRedirect("pzck.jsp");
			}*/
				 //response.sendRedirect("pzck.jsp");
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
