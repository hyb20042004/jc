<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.logging.SimpleFormatter"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.awt.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.*"%>
<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>�ޱ����ĵ�</title>
<script language="javascript" src="js/LodopFuncs.js"></script>


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
</head>

<body>
<%
request.setCharacterEncoding("gb2312");
String[] pzzl=request.getParameterValues("pzzl");
String[] pzhd1=request.getParameterValues("pzhd1");
String[] pzhd2=request.getParameterValues("pzhd2");
String lqjg=request.getParameter("lqjg");
String lqr=request.getParameter("lqr");
String zy=request.getParameter("zy");
Date date=new Date();
DateFormat time=new SimpleDateFormat("yyyy��MM��dd��");
String datenow=time.format(date);

//����������׼���������
/* session.setAttribute("pzzl", pzzl);
session.setAttribute("pzhd1", pzhd1);
session.setAttribute("pzhd2", pzhd2);
session.setAttribute("lqjg", lqjg);
session.setAttribute("lqr",lqr);
session.setAttribute("zy",zy);
session.setAttribute("cksj",datenow); */

%>
<table width="100%" border="0">
  <tr>
    <td height="23" align="right"><input name="Input" type="button" value="ȷ���ύ����ӡ" onclick="javascript:prn1_preview();"/></td>
  </tr>
</table>
<form id="form1" action="pzckServlet" method="post" name="form1">
<table width="100%" border="0" align="center">
  <tr>
    <td colspan="3" align="center"><span class="STYLE2">���ɹ�ũ���������������ũ�����ú�������<br />
�м۵�֤����Ҫ�հ�ƾ֤���ã��ɻأ��� </span></td>
  </tr>
  <tr>
    <td><span class="STYLE3">��λ(��)��<%=lqjg %></span></td>
    <td align="center"><span class="STYLE3"></span></td>
    <td align="right"><span class="STYLE3">���ڣ�<%=datenow %></span></td>
  </tr>
  <tr>
    <td height="74" colspan="3">
    <table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolor="#000000" class="STYLE4">
      <tr>
        <td width="7%" rowspan="2" align="center" class="p_tr">ƾ֤<br />
          ����</td>
        <td colspan="2" align="center" class="p_tr"><p>����</p></td>
        <td width="7%" rowspan="2" align="center" class="p_tr">��λ</td>
        <td colspan="2" align="center" class="p_tr">����</td>
        <td width="12%" rowspan="2" align="center" class="p_tr"><p>�˷�<br />
          ����</p></td>
        <td width="8%" rowspan="2" align="center" class="p_tr">��ע</td>
      </tr>
      <tr>
        <td width="7%" align="center" class="p_tr">����</td>
        <td width="7%" align="center" class="p_tr">�ɻ�</td>
        <td width="4%" align="center" class="p_tr">��</td>
        <td width="4%" align="center" class="p_tr">ֹ</td>
        </tr>
        <%
        Long hd1[]=new Long[20];
        Long hd2[]=new Long[20];
        Long hd[]=new Long[20];
       int hj=0;
        //String hd4[]=new String[20];
        for(int i=1;i<pzzl.length;i++){ 
        hd1[i]=Long.valueOf(pzhd1[i]);
        hd2[i]=Long.valueOf(pzhd2[i]);
        hd[i]=(hd2[i]-hd1[i])+1;
        hj+=hd[i];
       // hd4[i]=String.valueOf(hd[i]);
        %>
      <tr>
        <td align="center" class="p_tr"><%=pzzl[i]%></td>
        <td align="center" class="p_tr"><%=hd[i]%></td>
        <td align="center" class="p_tr">&nbsp;</td>
        <td align="center" class="p_tr">&nbsp;</td>
        <td align="center" class="p_tr"><%=pzhd1[i] %></td>
        <td align="center" class="p_tr"><%=pzhd2[i] %></td>
        <td align="center" class="p_tr"><%=hd[i]%></td>
        <td align="center" class="p_tr">&nbsp;</td>
      </tr>
      <%} %>
      <tr>
        <td height="17" align="center" class="p_tr">�ϼ�</td>
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
    <td><span class="STYLE3">�����ˣ�ǩ�£���         </span></td>
    <td><span class="STYLE3">�����ˣ�ǩ�£���</span></td>
    <td align="right"><span class="STYLE3">����λ���˸��£���<%=lqr %>&nbsp;&nbsp;&nbsp;&nbsp;</span></td>
  </tr>
</table>
</form>
<script language="javascript" type="text/javascript">   
        var LODOP; //����Ϊȫ�ֱ��� 
	function prn1_preview() {	
		CreateOneFormPage();	
		LODOP.PREVIEW();	
		document.getElementById("form1").submit();  
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
		LODOP.PRINT_INIT("�м۵�֤����Ҫ�հ�ƾ֤���ã��ɻأ���");
		LODOP.SET_PREVIEW_WINDOW(2,1,0,800,600,"�м۵�֤����Ҫ�հ�ƾ֤���ã��ɻأ���.��ʼ��ӡ");
		LODOP.SET_PRINT_PAGESIZE(1,"191mm","96mm","");
		LODOP.ADD_PRINT_HTM(0,0,"100%","100%",document.getElementById("form1").innerHTML);
	};	                     
</script>
</body>
</html>
