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
<script language="javascript" src="js/jquery-1.12.3.min.js"></script>
<script language="javascript" src="js/addel.jquery.js"></script>
<script>
$(document).ready(function () {
	$('.addel').addel({
		classes: {
			target: 'target'
		},
		animation: {
			duration: 300
		}
	}).on('addel:delete', function (event) {
		if (false) {
			event.preventDefault();
		}
	});
});
</script>
<script language="javascript">
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
<div class="container"><div class="addel">	
 <table width="100%" border="2" cellpadding="2" cellspacing="2" bordercolor="#000000">
 	<tr>
	  <td width="4%" rowspan="2" align="center"><p><strong>
      凭证<br />
      录入<br />          
      </strong></p></td>
		<td height="80" colspan="2" valign="top">		
  			<table width="100%" border="0">
                              <tr>
                                <td height="32" align="center" bgcolor="#00923F"><span class="STYLE4">出库凭证种类</span></td>
                                <td align="center" bgcolor="#00923F"><span class="STYLE4">出库凭证数量</span></td>
                                <td align="center" bgcolor="#00923F"><span class="STYLE4">出库凭证首号</span></td>
                                <td align="center" bgcolor="#00923F"><span class="STYLE4">出库凭证尾号</span></td>
                                <td align="center" bgcolor="#00923F"><span class="STYLE4">操作</span></td>
                              </tr>
		 	 </table>
			<div class="form-group target"> 
			 <div class="input-group">
                 <table width="100%" id="tb">
                       <tr>
                          <td align="center"><select name="pzzl" class="pzzl"></select></td>
                          <td align="center"><input type="text" name="pznum" class="input" /></td>
                          <td align="center"><input type="text" name="pzhd1" class="input" onblur="updateSum(),pz_search()"/></td>
                          <td align="center"><input name="pzhd2" type="text" class="singleTotal" disabled="disabled" /></td>
                          <td align="center"><button type="button" class="btn btn-danger addel-delete">删行</button></td>
                       </tr>
				</table>
			</div> 
		 </div>	    
	</td>
 	</tr>
 	<tr>
 	  <td width="91%" align="center"><div id="result" height="150" width="200"></div></td>
 	  <td width="100" align="center"><button type="button" class="btn btn-success btn-block addel-add">增加凭证</button>	 </td>
 	</tr>
	<tr>
        <td height="31" align="center"><p><strong>
      信息<br />
      录入<br />          
      </strong></p></td>
        <td colspan="2" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0">
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
        </table></td>
	</tr>
	<tr>
	  <td height="27" colspan="3" align="center"><input type="button" name="Input" value="提交" onclick="pz_submit()"/>
        <input type="reset" name="Input" value="重置" /></td>
	  </tr>
</table>
 
</div></div>
</form>
</body>
<script type="text/javascript"> 
window.onload=pz_list(),p_alert()

    function updateSum() {
       var totalSum = 0;
        $("td input.singleTotal").each(function() {
        	  var p = $(this).parent().parent();
             var sum = 0;
             sum = parseInt(p.find("input:eq(0)").val()) + parseInt(p.find("input:eq(1)").val()); 
           // alert($(this).val(sum));
            $(this).val(sum-1)
           //totalSum += sum;
        });
      //$("td input#total").val(totalSum);
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
	alert("提交表单文本框存在"+(count)+"处空值，下拉框存在"+(count1)+"处未选择，请检查！");
	}else{
 	$("#pzck").submit();
}
}
function pz_search(){ 
var pzhd1="";
	var pzhd2="";
	var pzzl1="";//函数 login(); 
	$("#result").empty();	
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
