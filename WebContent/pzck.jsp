<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>达拉特旗信用联社——凭证出库</title>
<style type="text/css">
<!--
.tr {
	margin-left: auto;
	margin-right: auto;
}
.STYLE4 {color: #FFFFFF; font-weight: bold; }
-->
</style>
<%String action=null;
 action=request.getParameter("action"); %>
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
function p_alert(){
	var action=<%=action%>;
	if(action=="1"){
		alert("凭证出库成功");
	}else if(action=="0"){
		alert("所输入凭证号段全部或部分未在库存表中，不能出库！");
	}
}
</script>

</head>

<body>

<form action="pzckServlet" method="post" name="pzck" id="pzck">
<table width="100%" border="1" align="center" cellpadding="1" cellspacing="1" bordercolor="#00923F">
  <tr>
    <td width="23" height="88" rowspan="2" align="center" valign="middle"><strong>
      凭证<br />
      录入<br />          
      </strong></td>
    <td height="66" colspan="2" align="center" valign="top">
	<table id="tab11" style="display: none" width="100%">
		<tbody>
			<tr>
				<td height="30" align="center">
					<input type="text" name="NO" size="2" value="1" /></td>
				<td align="center">
					<select name="pzzl" class="pzzl"></select></td>
				<div class="s_div">
				<td align="center"><input name="pznum" type="text" id="add1" value=""/></td>
				<td align="center"><input type="text" name="pzhd1" id="add2" value="" onblur="pz_sum()"></td>
				</div>
				<td align="center"><input type="text" name="pzhd2" class="sum" value=""/></td>
				<td><input type="button" id="Button1" onClick="deltr(this)" value="删行">				</td>
			</tr>
		</tbody>
	</table>
	<table id="dynamicTable" width="100%" border="0" cellspacing="0" cellpadding="0">
		<thead>
			<tr>
				<td height="30" align="center" bgcolor="#00923F"><span class="STYLE4">ID</span></td>
				<td align="center" bgcolor="#00923F"><span class="STYLE4">出库凭证种类</span></td>
				<td align="center" bgcolor="#00923F" class="STYLE4">出库凭证数量</td>
				<td align="center" bgcolor="#00923F"><span class="STYLE4">出库凭证首号</span></td>
				<td align="center" bgcolor="#00923F"><span class="STYLE4">出库凭证尾号</span></td>
				<td align="center" bgcolor="#00923F"><span class="STYLE4">操作</span></td>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td height="30" align="center">
					<input type="text" name="NO" size="2" value="1" /></td>
				<td align="center">
					<select name="pzzl" class="pzzl"></select></td>
				<div class="s_div">
					<td align="center"><input type="text" name="pznum" id="add1" value=""/></td>
					<td align="center"><input type="text" name="pzhd1" id="add2" value="" onblur="pz_sum()"/></td>
				</td>
				</div>
				<td align="center"><input type="text" name="pzhd2" class="sum" value=""/>
				<td><input type="button" id="Button2" onClick="deltr(this)" value="删行"></td>
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
    <td height="89" width="23" align="center" valign="middle"><strong>
      信息<br />
      录入</strong></td>
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
            <td height="30" align="center"><select name="lqjg" id="lqjg" value="">
            </select></td>
            <td align="center"><input name="lqr" type="text" id="lqr" /></td>
            <td align="center"><input name="zy" type="text" id="zy" /></td>
            </tr>
        </tbody>
      </table>     </td>
  </tr>
  <tr>
    <td colspan="3" align="center"><label>
      <input type="button" name="" value="提交" onclick="pz_submit()"/>
      <input type="reset" name="" value="重置" />
    </label></td>
  </tr>
</table>
</form>
</body>
<script type="text/javascript"> 
window.onload=pz_list(),p_alert()
function pz_sum(){
	$(document).ready(function(){ 
		var i=0;
		$("input[id][name^='pz']").each(function(){
			
			i+=$(this).val()*1;
			
		});	
		$(".sum").val(i);
		
});
}
function pz_submit(){
	var count=0;
	var count1=0;
$('input').each(function(){
	if($(this).val()==""){
		count=count+1;
	}
	
});
$('select').each(function(){
	if($(this).val()==""){
		count1=count1+1;
	}
	
});//取框中的用户名 
if((count-3)>0 || (count1-1)>0){
	alert("提交表单文本框存在"+(count-3)+"处空值，下拉框存在"+(count1-1)+"处未选择，请检查！");
	}else{
 	$("#pzck").submit();
}
}
function pz_search(){ 
var pzhd1="";
	var pzhd2="";
	var pzzl1="";//函数 login(); 
$('input[name="pzhd1"]').each(function(){
	pzhd1=$(this).val();
});//取框中的用户名 
$('select[name="pzzl"]').each(function(){
	pzzl1=$(this).val();
});
$('input[name="pzhd2"]').each(function(){
	pzhd2=$(this).val();
});
$.ajax({ //一个Ajax过程 
type: "post", //以post方式与后台沟通 
url : "searchServlet", //与此servlet页面沟通 
data: {
	pzhd : pzhd1,
	pzhde : pzhd2,
	pzzl: pzzl1
}, //发给servlet的数据有两项，分别是上面传来的pzhd1和pzhd2
success: function(data){//如果调用成功
$('#result').html(data); 
//servlet中的返回值显示在预定义的result定位符位置 
} 
}); 
} 

function pz_list(){ 
	$(document).ready(function () {
		  $.ajax({
		    timeout: 3000,
		    async: false,
		    type: "POST",
		    url: "loadpzServlet",
		    dataType: "json",
		    success: function (data) {
		    $(".pzzl").empty(); 
			$(".pzzl").append("<option value=''>----请选择凭证种类----</option>");
		    $.each(data.pzzl,function(i,iteam){
				$(".pzzl").append("<option value="+i+">" +i+"--"+iteam + "</option>");
		      });
		    $("#lqjg").empty(); 
			$("#lqjg").append("<option value=''>----请选择领取机构----</option>");
		    $.each(data.jg,function(i,iteam){
				$("#lqjg").append("<option value="+i+">" +i+"--"+iteam + "</option>");
		      });
		    }
		  });
		});
} 
</script> 
</html>
