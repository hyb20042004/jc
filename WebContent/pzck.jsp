<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>达拉特旗信用联社——凭证出库</title>
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
.STYLE4 {color: #FFFFFF; font-weight: bold; }
-->
</style>
<script language="javascript" src="js/jquery1.7.js"></script>
<script language="javascript">
$(function () {
	var show_count = 20;   //要显示的条数
	var count = 1;    //递增的开始值，这里是你的ID
	$("#btn_addtr").click(function () {

		var length = $("#dynamicTable tbody tr").length;
		//alert(length);
		if (length < show_count)    //点击时候，如果当前的数字小于递增结束的条件
		{
			$("#tab11 tbody tr").clone().appendTo("#dynamicTable tbody");   //在表格后面添加一行
			changeIndex();//更新行号
		}
	});


});
function changeIndex() {
	var i = 1;
	$("#dynamicTable tbody tr").each(function () { //循环tab tbody下的tr
		$(this).find("input[name='NO']").val(i++);//更新行号
	});
}

function deltr(opp) {
	var length = $("#dynamicTable tbody tr").length;
	//alert(length);
	if (length <= 1) {
		alert("至少保留一行");
	} else {
		$(opp).parent().parent().remove();//移除当前行
		changeIndex();
	}
}
</script>

</head>

<body>
<form action="pzckServlet" method="post">
<table width="100%" border="1" align="center" cellpadding="2" cellspacing="2">
  <tr>
    <td height="32" colspan="3" align="center"><span class="STYLE1">凭证出库</span></td>
  </tr>
  <tr>
    <td width="23" height="88" rowspan="2" align="center" valign="middle">
      凭证<br />
      录入<br />          </td>
    <td height="66" colspan="2" align="center" valign="top">
	<table id="tab11" style="display: none" width="100%">
		<tbody>
			<tr>
				<td height="30" align="center">
					<input type="text" name="NO" size="2" value="1" /></td>
				<td align="center">
					<select name="pzzl" id="pzzl">
            <option value="101-存折" selected="selected">存折</option>
            <option value="102-金牛卡">金牛卡</option>
          </select></td>
				<td align="center">
					<input type="text" name="pzhd1" id="pzhd1"/></td>
				<td align="center">
					<input type="text" name="pzhd2" id="pzhd2" onchange="pz_search()"/></td>
				<td>
					<input type="button" id="Button1" onClick="deltr(this)" value="删行">				</td>
			</tr>
		</tbody>
	</table>

	<table id="dynamicTable" width="100%" border="0" cellspacing="0" cellpadding="0">
		<thead>
			<tr>
				<td height="30" align="center" bgcolor="#00923F"><span class="STYLE4">ID</span></td>
				<td align="center" bgcolor="#00923F"><span class="STYLE4">凭证种类</span></td>
				<td align="center" bgcolor="#00923F"><span class="STYLE4">凭证首号</span></td>
				<td align="center" bgcolor="#00923F"><span class="STYLE4">凭证尾号</span></td>
				<td align="center" bgcolor="#00923F"><span class="STYLE4">操作</span></td>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td height="30" align="center">
					<input type="text" name="NO" size="2" value="1" /></td>
				<td align="center">
					<select name="pzzl" id="pzzl">
            <option value="101-存折" selected="selected">存折</option>
            <option value="102-金牛卡">金牛卡</option>
          </select></td>
				<td align="center">
					<input type="text" name="pzhd1" id="pzhd1"/></td>
				<td align="center">
					<input type="text" name="pzhd2" id="pzhd2" onchange="pz_search()"/></td>
				<td>
					<input type="button" id="Button2" onClick="deltr(this)" value="删行">				</td>
			</tr>
		</tbody>
	</table></td>
    </tr>
  
  <tr>
    <td width="563" height="27" align="center"><div id="result" height="150"></div></td>
    <td width="77" height="27" align="center">
      <input name="button" type="button" id="btn_addtr" value="增加凭证" />    </td>
  </tr>
  <tr>
    <td height="89" width="23" align="center" valign="middle">
      信息<br />
      录入</td>
    <td height="89" colspan="2" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <thead>
          <tr>
            <td height="30" align="center" bgcolor="#00923F"><span class="STYLE4">领取机构</span></td>
            <td align="center" bgcolor="#00923F"><span class="STYLE4">领取人</span></td>
            <td align="center" bgcolor="#00923F"><span class="STYLE4">摘要</span></td>
            </tr>
        </thead>
        <tbody>
          <tr>
            <td height="30" align="center"><select name="lqjg" id="lqjg">
              <option value="营业部">77003—营业部</option>
              <option value="高头窑信用社">77014—高头窑信用社</option>
            </select></td>
            <td align="center"><input name="lqr" type="text" id="lqr" /></td>
            <td align="center"><input name="zy" type="text" id="zy" /></td>
            </tr>
        </tbody>
      </table>     </td>
  </tr>
  <tr>
    <td colspan="3" align="center"><label>
      <input type="submit" name="Submit" value="提交" />
      <input type="reset" name="Submit2" value="重置" />
    </label></td>
  </tr>
</table>
</form>
</body>
<script type="text/javascript"> 
function pz_search(){ 
var pzhd1="";
	var pzhd2="";//函数 login(); 
$('input[name="pzhd1"]').each(function(){
	pzhd1=$(this).val();
});//取框中的用户名 
$('input[name="pzhd2"]').each(function(){
	pzhd2=$(this).val();
});
$.ajax({ //一个Ajax过程 
type: "post", //以post方式与后台沟通 
url : "searchServlet", //与此servlet页面沟通 
data: {
	pzhd : pzhd1,
	pzhde : pzhd2
}, //发给servlet的数据有两项，分别是上面传来的pzhd1和pzhd2
success: function(data){//如果调用成功
$('#result').html(data); 
//servlet中的返回值显示在预定义的result定位符位置 
} 
}); 
} 
</script> 
</html>
