package com.dltrdb.jc.pz;

import java.io.IOException;
import java.io.PrintWriter;
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
		DateFormat time1=new SimpleDateFormat("yyyyMMddHHmmss");
		String tag=time1.format(date);
		Long hd1[]=new Long[pz_hd1.length];
	    Long hd2[]=new Long[pz_hd1.length];
	    Long hd[]=new Long[pz_hd1.length];
	    int pz[]=new int[pz_hd1.length];
	    ResultSet rs;
	    int js=0;
		try {
			BasicDataSource bs=new BasicDataSource();
			bs.setUrl(DB_URL);
			bs.setDriverClassName(DB_DRIVER);
			bs.setUsername(DB_NAME);
			bs.setPassword(DB_PASS);
			conn=bs.getConnection();
			
			psmt=conn.prepareStatement("select pz_hd,pz_hde from pz_kc where pz_hd=? and pz_num=?");
			System.out.println("-------查询输入号段是否存在于库存表：查询开始------");
			System.out.println("传入参数数量："+pz_hd1.length+"其中有空参数1个");
			System.out.println(pz_hd1[0]=="");
			for(int i=0;i<pz_hd1.length;i++) {
				hd1[i]=Long.valueOf(pz_hd1[i]);
				pz[i]=Integer.valueOf(pzzl[i]);
				System.out.println("数据查询循环次数："+i+"----数据库查询首号段："+hd1[i]+"----数据库查询凭证种类："+pz[i]);
			psmt.setLong(1, hd1[i]);
			psmt.setInt(2, pz[i]);
			rs=psmt.executeQuery();
			while(rs.next()) {
				js+=1;
				System.out.println(rs.getLong("pz_hd"));
			}
			}
			
			System.out.println("数据库查询存在号段合计数："+js+"--传入参数数量："+(pz_hd1.length));
			
		if(js!=(pz_hd1.length)) {
			System.out.println("提交号段全部或部分不存在于库存表：查询结束");
			System.out.println("---------------------");
			response.sendRedirect("pzck.jsp?action=0");
		}else {
			System.out.println("---------------------");
			System.out.println("提交号段全部存在于库存表：添加数据操作开始");
			//2、添加凭证出库数据表
			conn.setAutoCommit(false);
			//if(!result1) {
				psmt=conn.prepareStatement("insert into pz_ck(pz_num,pz_hd,pz_count,lqr,zy,cksj,pz_hde,lqjg,tag) values(?,?,?,?,?,?,?,?,?)");
				for(int i=0;i<pzzl.length;i++) {
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
				psmt.setString(9,tag);
				psmt.addBatch();
				}
				int[] rows = psmt.executeBatch();
				int row=rows.length;
				if(row>0)
				System.out.println("1，添加凭证出库数据表完成！");
				//3.更新凭证库存表
				psmt=conn.prepareStatement("update pz_kc set pz_hd=? where pz_hd=? and pz_num=?");
				for(int i=0;i<pzzl.length;i++) {
					hd1[i]=Long.valueOf(pz_hd1[i]);
					hd2[i]=Long.valueOf(pz_hd2[i]);
				/*if(name>pz_hd2) {
				psmt.setLong(1, pz_hd2+1);
				}else {
					psmt.setLong(1, pz_hd2);
				}*/
				psmt.setLong(1, hd2[i]+1);	
				psmt.setLong(2, hd1[i]);
				psmt.setString(3, pzzl[i]);
				psmt.addBatch();
				}
				int[] rows2=psmt.executeBatch();
				int row2=rows2.length;
				 if(row2>0) {
					System.out.println("2.更新凭证库存表完成！！");
				 }
				 psmt=conn.prepareStatement("insert into pz_print(name) values(?)");
				 psmt.setString(1, tag);
				 boolean row1=psmt.execute();
				 if(!row1) {
						System.out.println("3.添加凭证待打印表成功");
					}
	 
			 conn.commit();
			 System.out.println("提交号段相关操作完成：数据添加结束");
				System.out.println("---------------------");
			 response.sendRedirect("pzck.jsp?action=1");
		}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			try {
				conn.rollback();
			} catch (SQLException e1) {
				
			}
			e.printStackTrace();
		}catch(NumberFormatException e) {
			response.sendRedirect("pzck.jsp?action=1");
		}
		finally {
			
				try {
					if(conn!=null)conn.close();
					if(psmt!=null)psmt.close();
					
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					
				}
		}
		
	}

}
