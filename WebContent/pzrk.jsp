<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>�ޱ����ĵ�</title>
<style type="text/css">
<!--
.STYLE1 {
	font-size: 24px;
	font-weight: bold;
}
-->
</style>
</head>

<body>
<form action="pzrkServlet" method="post">
<table width="50%" border="1" align="center" cellpadding="2" cellspacing="2">
  <tr>
    <td height="42" align="center"><span class="STYLE1">ƾ֤���</span></td>
  </tr>
  <tr>
    <td height="176">
	ƾ֤���ࣺ
      <label>
	  
      <select name="pzzl" id="pzzl">
        <option value="101" selected="selected">����</option>
        <option value="102">��ţ��</option>
      </select>
      <br />
      <br />
      ƾ֤�ŶΣ�
      <input name="pzhd1" type="text" id="pzhd1" />
    �� 
    <input name="pzhd2" type="text" id="pzhd2" />
    <br />
      <br />
      �� �� �ˣ�
      <input name="jbr" type="text" id="jbr" />
      <br />
      <br />
      ժ &nbsp;Ҫ ��
      <input name="zy" type="text" id="zy" />
      <br />
      <br />
      </label> 
      ���ʱ�䣺      
      <input name="rksj" type="text" id="cksj" value="<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date())%>" disabled="disabled"/></td>
  </tr>
  <tr>
    <td align="center"><label>
      <input type="submit" name="Submit" value="�ύ" />
      <input type="reset" name="Submit2" value="����" />
    </label></td>
  </tr>
</table></form>
</body>
</html>
