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
<title>无标题文档</title>



<style type="text/css">
<!--
.p_table {
	border: 2px solid #000000;
}
.p_tr {
	margin: 1px;
	padding: 1px;
	border: 1px solid #000000;
}
.STYLE2 {
	font-size: 18px;
	color: #000000;
}
.STYLE3 {color: #000000}
.STYLE4 {border: 2px solid #000000; color: #000000; }
-->
</style>
<script language="javascript" src="js/LodopFuncs.js"></script>
<script language="javascript" src="js/jquery1.7.js"></script>
</head>

<body>
<%
final String DB_URL="jdbc:mysql://localhost:3306/jc_pz";
final String DB_NAME="root";
final String DB_PASS="";	
final String DB_DRIVER="com.mysql.jdbc.Driver";
int hj=0;
String lqr=null;
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
	psmt=conn.prepareStatement("select * from pz_ck inner join pz_list on pz_ck.pz_num=pz_list.id where pz_ck.tag=?");
	psmt.setString(1,name);
    ResultSet rs=psmt.executeQuery();
	%>
<table width="100%" border="0">
  <tr>
    <td height="23" align="right"><input name="p_tag" type="hidden" id="p_tag" value="<%=name%>"><input name="Input" type="button" value="确认提交并打印" onclick="pz_sumbit(),prn1_preview()"/></td>
  </tr>
</table>
<form id="form1" action="pzckServlet" method="post" name="form1">
<table width="100%" border="0" align="center">
  <tr>
    <td colspan="3" align="center"><span class="STYLE2">内蒙古农村信用社达拉特旗农村信用合作联社<br />
有价单证、重要空白凭证领用（缴回）单 </span></td>
  </tr>
  <tr>
    <td><span class="STYLE3">单位(人)：<%=lqjg %></span></td>
    <td align="center"><span class="STYLE3"></span></td>
    <td align="right"><span class="STYLE3">日期：<%=cksj %></span></td>
  </tr>
  <tr>
    <td height="74" colspan="3">
    <table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolor="#000000" class="STYLE4">
      <tr>
        <td width="7%" rowspan="2" align="center" class="p_tr">凭证<br />
          名称</td>
        <td colspan="2" align="center" class="p_tr"><p>数量</p></td>
        <td width="7%" rowspan="2" align="center" class="p_tr">单位</td>
        <td colspan="2" align="center" class="p_tr">号码</td>
        <td width="12%" rowspan="2" align="center" class="p_tr"><p>核发<br />
          数量</p></td>
        <td width="8%" rowspan="2" align="center" class="p_tr">备注</td>
      </tr>
      <tr>
        <td width="7%" align="center" class="p_tr">领用</td>
        <td width="7%" align="center" class="p_tr">缴回</td>
        <td width="4%" align="center" class="p_tr">起</td>
        <td width="4%" align="center" class="p_tr">止</td>
        </tr>
        <%
    	while(rs.next()){
    	lqr=rs.getString("pz_ck.lqr");
    	zy=rs.getString("pz_ck.zy");
    	hj+=rs.getInt("pz_ck.pz_count");
        %>
      <tr>
        <td align="center" class="p_tr"><%=rs.getString("pz_list.pz_name")%></td>
        
        <td align="center" class="p_tr"><%=rs.getInt("pz_ck.pz_count")%></td>
        <td align="center" class="p_tr">&nbsp;</td>
        <td align="center" class="p_tr"><%=rs.getString("pz_list.pz_dw")%></td>
        <td align="center" class="p_tr"><%=rs.getLong("pz_ck.pz_hd")%></td>
        <td align="center" class="p_tr"><%=rs.getLong("pz_ck.pz_hde")%></td>
        <td align="center" class="p_tr"><%=rs.getInt("pz_ck.pz_count")%></td>
        <td align="center" class="p_tr">&nbsp;</td>
      </tr>
      <%} %>
      <tr>
        <td height="17" align="center" class="p_tr">合计</td>
        <td align="center" class="p_tr"><%=hj %></td>
        <td align="center" class="p_tr">&nbsp;</td>
        <td align="center" class="p_tr">&nbsp;</td>
        <td align="center" class="p_tr">&nbsp;</td>
        <td align="center" class="p_tr">&nbsp;</td>
        <td align="center" class="p_tr"><%=hj %></td>
        <td align="center" class="p_tr">&nbsp;</td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td><span class="STYLE3">经办人（签章）：         </span></td>
    <td><span class="STYLE3">复核人（签章）：</span></td>
    <td align="right"><span class="STYLE3">（单位、人盖章）：<%=lqr %>&nbsp;&nbsp;&nbsp;&nbsp;</span></td>
  </tr>
</table>
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
</form>
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
		LODOP=getLodop();  
		LODOP.PRINT_INIT("有价单证、重要空白凭证领用（缴回）单");
		LODOP.SET_PREVIEW_WINDOW(2,1,0,800,600,"有价单证、重要空白凭证领用（缴回）单.开始打印");
		LODOP.SET_PRINT_PAGESIZE(1,"191mm","96mm","");
		LODOP.ADD_PRINT_HTM(0,0,"100%","100%",document.getElementById("form1").innerHTML);
	};	 
	function pz_sumbit(){ 
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
