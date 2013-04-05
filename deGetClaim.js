/*standart-n.ru*/ 
var getClaim=jQuery.Class.create({		
init:function(de){$(document).ready(function() { getClaim_init(); getClaim_code(); getClaim_css();
	$("#"+de.btnId+" a").live("click",function(){
		getClaim_insertFrame();
	});
	$("#"+de.formId).live("submit",function(){ getClaim_insertFrame(); });
	$(de.object).live("click",function(){ 
	  if (de.link=="TRUE") {
		$("#"+de.id).html(getClaim_html());
		getClaim_css();
		$('#dement').animate({'top': '1px'},10,"linear",function(){ $("#"+de.nameId).focus(); });
	  }
	});
	$("#"+de.nameId).live("keypress",function(){
		getClaim_insert(de.icoClName,getClaim_checkName());
	});
	$("#"+de.telId).live("keypress",function(){
		getClaim_insert(de.icoClTel,getClaim_checkTel());
	});
});
function getClaim_insert(type,canyou) { de.code="";
	if (canyou=="TRUE") { de.code='<img src="'+de.icoOkSrc+'">'; } else { de.code='<img src="'+de.icoErrorSrc+'">'; }
	$("."+type).html(de.code);
}
function getClaim_code() { de.code="";
	de.code+='<div id="'+de.id+'">';
	de.code+=getClaim_html();
	de.code+='</div>';
	$(de.parent).html(de.code);
}
function getClaim_html() { de.html="";
	de.html+='<form id="'+de.formId+'" onsubmit="return false;">';
	de.html+='<div id="'+de.contentId+'">';
	de.html+=$(de.textArea).html(); $(de.textArea).css({'display':'none'});
	de.html+='</div>';
	de.html+='<div id="'+de.inputsId+'">';

	de.html+='<div class="'+de.labelCl+'">Обязательные поля:</div>';

	de.html+='<div class="'+de.lineCl+'">';
	de.html+='<div class="'+de.fieldCl+'">Ваше имя:</div>';
	de.html+='<div class="'+de.valueCl+'"><input id="'+de.nameId+'" class="'+de.inputsCl+'" type="text" maxlength="30" value=""></div>';
	de.html+='<div class="'+de.icoCl+' '+de.icoClName+'"></div>';
	de.html+='</div>';

	de.html+='<div class="'+de.lineCl+'">';
	de.html+='<div class="'+de.fieldCl+'">Ваш телефон:</div>';
	de.html+='<div class="'+de.valueCl+'"><input id="'+de.telId+'" class="'+de.inputsCl+'" type="text" maxlength="30" value="+7"></div>';
	de.html+='<div class="'+de.icoCl+' '+de.icoClTel+'"></div>';
	de.html+='</div>';

	de.html+='<div class="'+de.labelCl+'">Дополнительная информация:</div>';

	if (de.enterEmail=="TRUE") {
		de.html+='<div class="'+de.lineCl+'">';
		de.html+='<div class="'+de.imgService+'"><img src="'+de.icoEmailSrc+'"></div>';
		de.html+='<div class="'+de.fieldDopCl+'">e-mail:</div>';
		de.html+='<div class="'+de.valueCl+'"><input id="'+de.emailId+'" class="'+de.inputsCl+'" type="text" maxlength="30" value=""></div>';
		de.html+='<div class="'+de.icoClEmail+'"></div>';
		de.html+='</div>';
	}

	if (de.enterIcq=="TRUE") {
		de.html+='<div class="'+de.lineCl+'">';
		de.html+='<div class="'+de.imgService+'"><img src="'+de.icoICQSrc+'"></div>';
		de.html+='<div class="'+de.fieldDopCl+'">icq:</div>';
		de.html+='<div class="'+de.valueCl+'"><input id="'+de.icqId+'" class="'+de.inputsCl+'" type="text" maxlength="30" value=""></div>';
		de.html+='<div class="'+de.icoClICQ+'"></div>';
		de.html+='</div>';
	}

	if (de.enterSkype=="TRUE") {
		de.html+='<div class="'+de.lineCl+'">';
		de.html+='<div class="'+de.imgService+'"><img src="'+de.icoSkypeSrc+'"></div>';
		de.html+='<div class="'+de.fieldDopCl+'">skype:</div>';
		de.html+='<div class="'+de.valueCl+'"><input id="'+de.skypeId+'" class="'+de.inputsCl+'" type="text" maxlength="30" value=""></div>';
		de.html+='<div class="'+de.icoClSkype+'"></div>';
		de.html+='</div>';
	}

	if (de.enterSite=="TRUE") {
		de.html+='<div class="'+de.lineCl+'">';
		de.html+='<div class="'+de.imgService+'"><img src="'+de.icoSiteSrc+'"></div>';
		de.html+='<div class="'+de.fieldDopCl+'">web-site:</div>';
		de.html+='<div class="'+de.valueCl+'"><input id="'+de.siteId+'" class="'+de.inputsCl+'" type="text" maxlength="30" value="http://"></div>';
		de.html+='<div class="'+de.icoClSite+'"></div>';
		de.html+='</div>';
	}

	de.html+='</div>';
	de.html+='<div id="'+de.btnId+'"><a href="#de">'+de.btnText+'</a></div>';
	de.html+='<div id="'+de.shadowId+'"></div>';
	de.html+='<div id="'+de.submitId+'"><input type="submit"></div>';
	de.html+='<div id="'+de.resultId+'"></div>';
	de.html+='</form>';
	return de.html;
}
function getClaim_checkName() { de.flag="TRUE"; de.res="";
	de_name=$('#'+de.nameId).val();
	if ((de_name=="") || (de_name=="+7")) { de.flag="FALSE"; }
	if ((de_name.length<2) || (de_name.length>30)) { de.flag="FALSE"; }
	if (!(/[^a-z0-9\.\,\"\?\!\;\:\#\$\%\&\(\)\*\+\-\/\<\>\=\@\[\]\\\^\_\{\}\|\~]+/i).test(de_name)) { de.flag="FALSE"; }
	return de.flag;
}
function getClaim_checkTel() { de.flag="TRUE"; de.res="";
	de_tel=$('#'+de.telId).val();
	if ((de_tel=="") || (de_tel=="+7")) { de.flag="FALSE"; }
	if ((de_tel.length<5) || (de_tel.length>30)) { de.flag="FALSE"; }
	if (!(/\+?\d{1,3}(?:\s*\(\d+\)\s*)?(?:(?:\-\d{1,3})+\d|[\d\-]{6,}|(?:\s\d{1,3})+\d)/i).test(de_tel)) { de.flag="FALSE"; }
	return de.flag;
}
function getClaim_checkValue() { de.flag="FALSE";
	if ((getClaim_checkName()=="FALSE") || (getClaim_checkTel()=="FALSE")) { de.flag="FALSE"; } else { de.flag="TRUE"; }
	return de.flag;
}
function getClaim_send() {
	de_name=$('#'+de.nameId).val();
	de_tel=$('#'+de.telId).val();
	de_email=$('#'+de.emailId).val();
	de_skype=$('#'+de.skypeId).val();
	de_icq=$('#'+de.icqId).val();
	de_site=$('#'+de.siteId).val();
		$.ajax({
			url:"http://j.maxmind.com/app/geoip.js",
			dataType:"script",
			timeout:5000,
			success:function(answer){
				de_lat=geoip_latitude();
				de_lon=geoip_longitude();
				de_city=geoip_city();
				de_region=geoip_region();
				de_country_name=geoip_country_name();

				de.msg='Заявка! имя: '+de_name+' тел: '+de_tel;
				de.msggit=de_name+', '+de_tel;
				if (de.enterEmail!="FALSE") { if (de_email!="") { de.msg+=' email: '+de_email; de.msggit+=', '+de_email; } }
				if (de.enterSkype!="FALSE") { if (de_skype!="") { de.msg+=' skype: '+de_skype; } }
				if (de.enterIcq!="FALSE") { if (de_icq!="") { de.msg+=' icq: '+de_icq; } }
				if (de.enterSite!="FALSE") { if ((de_site!="") && (de_site!="http://")) { de.msg+=' сайт: '+de_site; } }
				if (de_city!=undefined) {
					de_city=de_city.replace(" ","+");
					if (de_city!="") {
					    de.msg+=' карта: http://maps.yandex.ru/?text='+de_city;
					    de.msggit+=', '+de_city;
					}
				}
				/*$.ajax({
					url:de.ajax_email,
					type:"GET",
					data:{ 
						email:de.email,
						msg:de.msg
					},
					dataType:"text",
					timeout:5000,
					beforeSend:function(){
						$("#"+de.resultId).html("Отправление сообщения...");
					}
				});*/
				$.ajax({
					url:"http://git.st-n.ru/",
					type:"GET",
					data:{ 
						action:'addClaim',
						msg:de.msggit
					},
					dataType:"text",
					timeout:1000,
					beforeSend:function(){
						$("#"+de.resultId).html("Отправление сообщения...");
					}
				});
				$.ajax({
					url:de.ajax_icq,
					type:"GET",
					data:{ 
						uin:de.icq,
						msg:de.msg
					},
					dataType:"text",
					timeout:5000
				});
				$("#"+de.shadowId).html(de.code);
				if (de.ajax!="FALSE") { 
					$.ajax({
						url:de.ajax,
						type:"GET",
						data:{ 
							act:"add",
							name:de_name,
							tel:de_tel,
							email:de_email,
							skype:de_skype,
							icq:de_icq,
							site:de_site,
							lat:de_lat,
							lon:de_lon,
							city:de_city,
							region:de_region,
							country:de_country_name
						},
						dataType:"text",
						timeout:5000,
						complete:function(answer){
							$("#"+de.resultId).html(de.msgSuccess);
							//alert(answer);
						}
					});
				}
			},
			error:function(){
				$("#"+de.resultId).html(de.msgError);
			}
		});
}
function getClaim_insertFrame() { 
	if (getClaim_checkValue()=="TRUE") { getClaim_send();
	} else { 
		de.res=de.msgError; 
	}
	$("#"+de.resultId).html(de.res);
}
function getClaim_init() {
    if (de.id==undefined) {de.id="getClaim";}
    if (de.icq==undefined) {de.icq="349855861";}
    if (de.email==undefined) {de.email="aleksnick01@gmail.com";}
    if (de.object==undefined) {de.object="#getClaim_object";}
    if (de.parent==undefined) {de.parent="body";}
    if (de.ajax==undefined) {de.ajax="FALSE";}
    if (de.ajax_icq==undefined) {de.ajax_icq="http://www.standart-n.ru/api/icq/";}
    if (de.ajax_email==undefined) {de.ajax_email="http://www.standart-n.ru/api/email/";}
    if (de.enterIcq==undefined) {de.enterIcq="TRUE";}
    if (de.enterEmail==undefined) {de.enterEmail="TRUE";}
    if (de.enterSkype==undefined) {de.enterSkype="TRUE";}
    if (de.enterSite==undefined) {de.enterSite="TRUE";}
	if (de.textArea==undefined) { de.textArea="#textArea"; }
    if (de.contentId==undefined) {de.contentId=de.id+"_content";}
    if (de.inputsId==undefined) {de.inputsId=de.id+"_inputs";}
    if (de.formId==undefined) {de.formId=de.id+"_form";}
    if (de.labelCl==undefined) {de.labelCl=de.id+"_label";}
    if (de.fieldCl==undefined) {de.fieldCl=de.id+"_field";}
    if (de.valueCl==undefined) {de.valueCl=de.id+"_value";}
    if (de.inputsCl==undefined) {de.inputsCl=de.id+"_inputs";}
    if (de.imgService==undefined) {de.imgService=de.id+"_service";}
    if (de.icoCl==undefined) {de.icoCl=de.id+"_ico";}
    if (de.icoClName==undefined) {de.icoClName=de.id+"_icoName";}
    if (de.icoClTel==undefined) {de.icoClTel=de.id+"_icoTel";}
    if (de.nameId==undefined) {de.nameId=de.id+"_name";}
    if (de.telId==undefined) {de.telId=de.id+"_tel";}
    if (de.emailId==undefined) {de.emailId=de.id+"_email";}
    if (de.skypeId==undefined) {de.skypeId=de.id+"_skype";}
    if (de.icqId==undefined) {de.icqId=de.id+"_icq";}
    if (de.siteId==undefined) {de.siteId=de.id+"_site";}
    if (de.shadowId==undefined) {de.shadowId=de.id+"_shadow";}
    if (de.resultId==undefined) {de.resultId=de.id+"_result";}
    if (de.frameId==undefined) {de.frameId=de.id+"_frame";}
    if (de.lineCl==undefined) {de.lineCl=de.id+"_line";}
    if (de.submitId==undefined) {de.submitId=de.id+"_submit";}
    if (de.btnId==undefined) {de.btnId=de.id+"_btn";}
    if (de.btnText==undefined) {de.btnText="Отправить";}
    if (de.btnPadding==undefined) {de.btnPadding="1px 15px 2px 15px";}    
    if (de.btnMargin==undefined) {de.btnMargin="0 0 0 100px";}    
    if (de.btnBorder==undefined) {de.btnBorder="#333 solid 1px";}    
    if (de.imgPath==undefined) {de.imgPath="http://www.standart-n.ru/api/img/deGetClaim/";}    
    if (de.btnBg==undefined) {de.btnBg="url("+de.imgPath+"btn_green.png) repeat-x left top";}
    if (de.icoOkSrc==undefined) {de.icoOkSrc=de.imgPath+"ok.png";}
    if (de.icoNameSrc==undefined) {de.icoNameSrc=de.imgPath+"name.png";}
    if (de.icoTelSrc==undefined) {de.icoTelSrc=de.imgPath+"tel.png";}
    if (de.icoEmailSrc==undefined) {de.icoEmailSrc=de.imgPath+"email.png";}
    if (de.icoSkypeSrc==undefined) {de.icoSkypeSrc=de.imgPath+"skype.png";}
    if (de.icoICQSrc==undefined) {de.icoICQSrc=de.imgPath+"icq.png";}
    if (de.icoSiteSrc==undefined) {de.icoSiteSrc=de.imgPath+"site.png";}
    if (de.icoErrorSrc==undefined) {de.icoErrorSrc=de.imgPath+"error.png";}
    if (de.imgLoader==undefined) {de.imgLoader=de.imgPath+"loader.gif";}
    if (de.link==undefined) {de.link="TRUE";}
    if (de.objPadding==undefined) {de.objPadding="1px 15px 2px 15px";}    
    if (de.objMargin==undefined) {de.objMargin="0";}    
    if (de.objBorder==undefined) {de.objBorder="#333 solid 1px";}    
    if (de.objBg==undefined) {de.objBg="url("+de.imgPath+"btn_green.png) repeat-x left top";}
    if (de.msgSuccess==undefined) {de.msgSuccess="Спасибо, Ваша заявка отправлена!<br>Наши менеджеры скоро свяжутся с Вами.";}
    if (de.msgError==undefined) {de.msgError="Ошибка, сообщение не отправлено!<br>Возможно, в данных была допущена ошибка.";}
}
function getClaim_css() {
	$('#'+de.id).css({
	'font-family':'Verdana, Sans-Serif',
	'font-size':'12px',
	'color':'#222',
	'display':'block',
	'float':'left',
	'width':'340px',
	'height':'auto',
	'padding':'0',
	'margin':'0',
	'border':'none',
	'background':'none'
	});
	$('.'+de.labelCl).css({
	'font-family':'Verdana, Sans-Serif',
	'font-size':'10px',
	'color':'#333',
	'display':'block',
	'float':'left',
	'width':'340px',
	'height':'auto',
	'padding':'0',
	'margin':'4px 0 4px 0',
	'border':'none',
	'clear':'both',
	'background':'none'
	});
	$('#'+de.inputsId).css({
	'margin':'10px 0 0 0'
	});
	$('.'+de.fieldCl).css({
	'display':'block',
	'float':'left',
	'font-size':'16px',
	'font-family':'Verdana, Sans-Serif',
	'color':'#000',
	'width':'130px',
	'padding':'1px 0 0 0'
	});
	$('.'+de.fieldDopCl).css({
	'display':'block',
	'float':'left',
	'font-size':'14px',
	'font-family':'Verdana, Sans-Serif',
	'color':'#111',
	'width':'90px',
	'padding':'4px 0 0 0'
	});
	$('.'+de.valueCl).css({
	'display':'block',
	'float':'left',
	'padding':'1px 0 0 0'
	});
	$('.'+de.lineCl).css({
	'display':'block',
	'float':'left',
	'padding':'0',
	'clear':'both'
	});
	$('.'+de.icoCl).css({
	'display':'block',
	'float':'left',
	'margin':'1px 0 0 4px',
	'padding':'0',
	'width':'16px'
	});
	$('.'+de.imgService).css({
	'display':'block',
	'float':'left',
	'margin':'1px 0 0 4px',
	'padding':'0',
	'width':'36px'
	});
	$('.'+de.inputsCl).css({
	'font-size':'14px',
	'font-family':'Verdana, Sans-Serif',
	'color':'#000',
	'width':'160px'
	});	
	$('#'+de.btnId).css({
	'display':'block',
	'clear':'both',
	'float':'left',
	'margin':'0 0 0 0'
	});
	$('#'+de.btnId+' a').css({
	'font-size':'14px',
	'font-family':'Verdana, Sans-Serif',
	'font-weight':'normal',
	'color':'#fff',
	'display':'block',
	'float':'left',
	'width':'auto',
	'height':'auto',
	'margin':de.btnMargin,
	'padding':de.btnPadding,
	'outline':'none',
	'border':de.btnBorder,
	'background':de.btnBg,
	'text-decoration':'none'
	});
	if (de.link=="TRUE") {
	$(de.object).css({
	'font-size':'14px',
	'font-family':'Verdana, Sans-Serif',
	'font-weight':'normal',
	'color':'#fff',
	'display':'block',
	'float':'left',
	'width':'auto',
	'height':'auto',
	'margin':de.objMargin,
	'padding':de.objPadding,
	'outline':'none',
	'border':de.objBorder,
	'background':de.objBg,
	'text-decoration':'none'
	});
	}
	$('#'+de.resultId).css({
	'font-size':'12px',
	'font-family':'Verdana, Sans-Serif',
	'font-weight':'bold',
	'color':'#000',
	'display':'block',
	'clear':'both',
	'float':'left',
	'margin':'10px 0 0 0'
	});
	$('#'+de.shadowId).css({
	'display':'none'
	});
	$('#'+de.submitId).css({
	'display':'none'
	});
}
return de;}
});
