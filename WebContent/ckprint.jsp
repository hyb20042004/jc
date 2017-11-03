<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.logging.SimpleFormatter"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.awt.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.*"%>
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>凭证出库打印</title>



<style type="text/css">
<!--
.p_tr {
	border-bottom-style: solid;
	border-bottom-width: thin;
	border-bottom-color: #000000;
	border-top-width: thin;
	border-top-style: solid;
	border-top-color: #000000;
}
.STYLE3 {color: #000000}
.STYLE5 {border-bottom-style: solid; border-bottom-width: thin; border-bottom-color: #000000; border-top-width: thin; border-top-style: solid; border-top-color: #000000; font-weight: bold; }
-->
</style>
<script language="javascript" src="js/LodopFuncs.js"></script>
<script language="javascript" src="js/jquery1.7.js"></script>
</head>

<body>
<%
final String DB_URL="jdbc:mysql://localhost:3307/jc_pz";
final String DB_NAME="root";
final String DB_PASS="rC949hrNrY6qZrEP";	
final String DB_DRIVER="com.mysql.jdbc.Driver";
int hj=0;
String lqr=null,jbr=null;
String zy=null;

Connection conn=null;
PreparedStatement psmt=null;
request.setCharacterEncoding("utf-8");
String name=request.getParameter("action");
String lqjg=new String(request.getParameter("lqjg").getBytes("ISO-8859-1"),"utf-8").trim();
String cksj=new String(request.getParameter("cksj").getBytes("ISO-8859-1"),"utf-8").trim();
try {
	Class.forName(DB_DRIVER);
	conn=DriverManager.getConnection(DB_URL, DB_NAME, DB_PASS);
	psmt=conn.prepareStatement("select * from (pz_ck inner join pz_list on pz_ck.pz_num=pz_list.id) inner join pz_admin on pz_ck.jbr=pz_admin.number where pz_ck.tag=?");
	psmt.setString(1,name);
    ResultSet rs=psmt.executeQuery();
	%>
<table width="95%" border="0">
  <tr>
    <td height="23" align="right"><input name="p_tag" type="hidden" id="p_tag" value="<%=name%>"><input name="Input" type="button" value="确认提交并打印" onclick="pz_sumbit4(),CreateOneFormPage()"/></td>
  </tr>
</table>

<div id="div1">
<table width="95%" border="0" cellpadding="3" cellspacing="3">
<tbody>
  <tr>
    <td colspan="1"><span class="STYLE3">单位（人）：<%=lqjg %></span> &nbsp;&nbsp;&nbsp;&nbsp;（出库）</td>
    <td colspan="2" align="center"><span class="STYLE3">日期：<%=cksj %></span></td>
    <td colspan="2" align="right"><span class="STYLE3">批次号：<%=name %></span></td>
  </tr>
  </tbody>
</table>
</div>
<div id="div2">
<table width="95%" border="0" cellpadding="3" cellspacing="3">
<thead>
 <tr class="p_tr">
    <td width="23%" align="center" class="p_tr"><strong>凭证名称</strong></td>
    <td width="29%" align="center" class="p_tr"><strong>凭证号段</strong></td>
    <td width="23%" align="center" class="p_tr"><strong>核发数量</strong></td>
    <td width="11%" align="center" class="p_tr"><strong>单位</strong></td>
    <td width="14%" align="center" class="p_tr"><strong>备注</strong></td>
  </tr>
  </thead>
  <tbody>

    <%
    	while(rs.next()){
    	lqr=rs.getString("pz_ck.lqr");
    	jbr=rs.getString("pz_admin.name");
    	zy=rs.getString("pz_ck.zy");
    	hj+=rs.getInt("pz_ck.pz_count");
        %>
      <tr>
        <td width="23%" align="center"><%=rs.getString("pz_list.pz_name")%></td>
        <td width="29%" align="center"><%=rs.getLong("pz_ck.pz_hd")%> — <%=rs.getLong("pz_ck.pz_hde")%></td>
        <td width="23%" align="center"><%=rs.getInt("pz_ck.pz_count")%></td>
        <td width="11%" align="center"><%=rs.getString("pz_list.pz_dw")%></td>
        <td width="14%" align="center">&nbsp;</td>
      </tr>
      <%} %>
	  </tbody>
	  <tfoot>
  <tr>
    <td align="center" class="p_tr"><strong>合计</strong></td>
    <td class="p_tr">&nbsp;</td>
    <td align="center" class="p_tr"><strong><%=hj %></strong></td>
    <td class="p_tr">&nbsp;</td>
    <td class="p_tr">&nbsp;</td>
  </tr>
  </tfoot>
</table>
</div>
<div id="div3">
<table width="95%" border="0">
<tbody>
  <tr>
    <td width="30%"><span class="STYLE3">经办人（签章）：<%=jbr%></span></td>
    <td width="34%"><span class="STYLE3">复核人（签章）：</span></td>
    <td width="36%"><span class="STYLE3">（单位、人盖章）：<%=lqr %></span></td>
  </tr>
  </tbody>
</table>
</div>
<%
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
}finally{
	try {
		if(conn!=null)conn.close();
		if(psmt!=null)psmt.close();
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		
	}
}

	
%>
<script language="javascript" type="text/javascript">   
        var LODOP; //声明为全局变量 
	function prn1_preview() {	
		CreateOneFormPage();	
		LODOP.PREVIEW();	
	};
	function prn1_print() {		
		CreateOneFormPage();
		LODOP.PRINT();	
	};
	function prn1_printA() {		
		CreateOneFormPage();
		LODOP.PRINTA(); 	
	};	
	function CreateOneFormPage(){
		var LODOP=getLodop();  
		LODOP.PRINT_INIT("有价单证、重要空白凭证领用（缴回）单.开始打印");
		LODOP.SET_PREVIEW_WINDOW(2,0,0,800,600,"有价单证、重要空白凭证领用（缴回）单.开始打印");
		LODOP.SET_PRINT_PAGESIZE(1,2100,1000,"");
		var strStyle="<style>.p_tr {border-bottom-style: solid;border-bottom-width: thin;border-bottom-color: #000000;border-top-width: thin;border-top-style: solid;border-top-color: #000000;}</style>"
		LODOP.ADD_PRINT_TABLE(80,"3%","90%",150,strStyle+document.getElementById("div2").innerHTML);
		LODOP.SET_PRINT_STYLEA(0,"Vorient",3);		
		LODOP.ADD_PRINT_HTM(53,"3%","90%",109,strStyle+document.getElementById("div1").innerHTML);
		LODOP.SET_PRINT_STYLEA(0,"ItemType",1);
		LODOP.SET_PRINT_STYLEA(0,"LinkedItem",1);	
	    LODOP.ADD_PRINT_HTM(253,"3%","90%",54,strStyle+document.getElementById("div3").innerHTML);
		LODOP.SET_PRINT_STYLEA(0,"ItemType",1);
		LODOP.SET_PRINT_STYLEA(0,"LinkedItem",1);	
		LODOP.PRINTA();
	};		
	function pz_sumbit4(){ 
		var name=$("#p_tag").val();
		//取框中的用户名 
		//alert(name);
			$.ajax({ //一个Ajax过程 
		type: "post", //以post方式与后台沟通 
		url : "ptagServlet", //与此servlet页面沟通 
		data: {
			p_tag : 1,
			name : name
		}, 
		success: function(data){//如果调用成功
			parent.href='print.jsp';
		}
		});  
	}
</script>
</body>
</html>
