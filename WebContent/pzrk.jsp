<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>无标题文档</title>
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
    <td height="42" align="center"><span class="STYLE1">凭证入库</span></td>
  </tr>
  <tr>
    <td height="176">
	凭证种类：
      <label>
	  
      <select name="pzzl" id="pzzl">
        <option value="101" selected="selected">存折</option>
        <option value="102">金牛卡</option>
      </select>
      <br />
      <br />
      凭证号段：
      <input name="pzhd1" type="text" id="pzhd1" />
    至 
    <input name="pzhd2" type="text" id="pzhd2" />
    <br />
      <br />
      经 办 人：
      <input name="jbr" type="text" id="jbr" />
      <br />
      <br />
      摘 &nbsp;要 ：
      <input name="zy" type="text" id="zy" />
      <br />
      <br />
      </label> 
      入库时间：      
      <input name="rksj" type="text" id="cksj" value="<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date())%>" disabled="disabled"/></td>
  </tr>
  <tr>
    <td align="center"><label>
      <input type="submit" name="Submit" value="提交" />
      <input type="reset" name="Submit2" value="重置" />
    </label></td>
  </tr>
</table></form>
</body>
</html>
