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
.tr {
	margin-left: auto;
	margin-right: auto;
}
-->
</style>
<script language="javascript" src="js/jquery1.7.js"></script>
<script language="javascript">
$(function () {
	var show_count = 20;   //Ҫ��ʾ������
	var count = 1;    //�����Ŀ�ʼֵ�����������ID
	$("#btn_addtr").click(function () {

		var length = $("#dynamicTable tbody tr").length;
		//alert(length);
		if (length < show_count)    //���ʱ�������ǰ������С�ڵ�������������
		{
			$("#tab11 tbody tr").clone().appendTo("#dynamicTable tbody");   //�ڱ��������һ��
			changeIndex();//�����к�
		}
	});


});
function changeIndex() {
	var i = 1;
	$("#dynamicTable tbody tr").each(function () { //ѭ��tab tbody�µ�tr
		$(this).find("input[name='NO']").val(i++);//�����к�
	});
}

function deltr(opp) {
	var length = $("#dynamicTable tbody tr").length;
	//alert(length);
	if (length <= 1) {
		alert("���ٱ���һ��");
	} else {
		$(opp).parent().parent().remove();//�Ƴ���ǰ��
		changeIndex();
	}
}
</script>

</head>

<body>
<form action="print.jsp" method="post">
<table width="50%" border="1" align="center" cellpadding="2" cellspacing="2">
  <tr>
    <td height="32" colspan="3" align="center"><span class="STYLE1">ƾ֤����</span></td>
  </tr>
  <tr>
    <td width="31" height="88" rowspan="2" align="center" valign="middle">
      ƾ֤<br />
      ¼��<br />          </td>
    <td width="497" height="66" colspan="2" align="center" valign="top">
	<table id="tab11" style="display: none" width="100%">
		<tbody>
			<tr>
				<td height="30" align="center">
					<input type="text" name="NO" size="2" value="1" /></td>
				<td align="center">
					<select name="pzzl" id="pzzl">
            <option value="101-����" selected="selected">����</option>
            <option value="102-��ţ��">��ţ��</option>
          </select></td>
				<td align="center">
					<input type="text" name="pzhd1" /></td>
				<td align="center">
					<input type="text" name="pzhd2" /></td>
				<td>
					<input type="button" id="Button1" onClick="deltr(this)" value="ɾ��">				</td>
			</tr>
		</tbody>
	</table>

	<table id="dynamicTable" width="100%" border="0" cellspacing="0" cellpadding="0">
		<thead>
			<tr>
				<td height="30" align="center" bgcolor="#CCCCCC">ID</td>
				<td align="center" bgcolor="#CCCCCC">ƾ֤����</td>
				<td align="center" bgcolor="#CCCCCC">ƾ֤�׺�</td>
				<td align="center" bgcolor="#CCCCCC">ƾ֤β��</td>
				<td align="center" bgcolor="#CCCCCC">����</td>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td height="30" align="center">
					<input type="text" name="NO" size="2" value="1" /></td>
				<td align="center">
					<select name="pzzl" id="pzzl">
            <option value="101-����" selected="selected">����</option>
            <option value="102-��ţ��">��ţ��</option>
          </select></td>
				<td align="center">
					<input type="text" name="pzhd1" /></td>
				<td align="center">
					<input type="text" name="pzhd2" /></td>
				<td>
					<input type="button" id="Button2" onClick="deltr(this)" value="ɾ��">				</td>
			</tr>
		</tbody>
	</table></td>
    </tr>
  
  <tr>
    <td height="27" colspan="2" align="center"><input type="button" id="btn_addtr" value="����ƾ֤"></td>
  </tr>
  <tr>
    <td height="89" width="31" align="center" valign="middle">
      ��Ϣ<br />
      ¼��</td>
    <td height="89" colspan="2" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <thead>
          <tr>
            <td height="30" align="center" bgcolor="#CCCCCC">��ȡ����</td>
            <td align="center" bgcolor="#CCCCCC">��ȡ��</td>
            <td align="center" bgcolor="#CCCCCC">ժҪ</td>
            </tr>
        </thead>
        <tbody>
          <tr>
            <td height="30" align="center"><select name="lqjg" id="lqjg">
              <option value="Ӫҵ��">77003��Ӫҵ��</option>
              <option value="��ͷҤ������">77014����ͷҤ������</option>
            </select></td>
            <td align="center"><input name="lqr" type="text" id="lqr" /></td>
            <td align="center"><input name="zy" type="text" id="zy" /></td>
            </tr>
        </tbody>
      </table>      
     </td>
  </tr>
  <tr>
    <td colspan="3" align="center"><label>
      <input type="submit" name="Submit" value="�ύ" />
      <input type="reset" name="Submit2" value="����" />
    </label></td>
  </tr>
</table>
</form>
</body>
</html>
