/*
 MIT
 http://www.opensource.org/licenses/mit-license.php
*/
(function(a){a.fn.extend({grider:function(g){return this.each(function(){new a.Grider(this,g)})}});a.Grider=function(g,f){function y(b){a(g).find("tr:first").addClass("noedit");if(f.countRow&&f.countRowAdd){var d=a(g).find("th:first").attr("class"),d=""!=d?' class="'+d+'"':"";a(g).find("tr.noedit:first").prepend("<th "+d+">"+f.countRowText+"</th>");a(g).find("tr:not(.noedit)").each(function(c,b){var d=c+1;a(b).prepend("<td>"+d+"</td>")})}for(var d=a(g).find("tr:not(.noedit):first td").length,c=0;c<
d;c++)z(b.rows[0].cells[c],c);A();for(c=0;c<d;c++)G(b.rows[0].cells[c]),H(b.rows[0].cells[c]);q&&f.initCalc&&a(g).find("tr:not(.noedit)").each(function(a,c){var b=a+1,d;for(d in e)e[d].formula&&t(e[d].name,b)});for(var r in e)e[r].summary&&s(r);f.addRow&&(a(g).append(f.addRowText),a(g).find("caption a.add").click(function(){u();a(this).parents(".scrollable").animate({scrollTo:".scrollable tr:last-child"})}));f.delRow&&(a(g).find("tr:not(.noedit)").each(function(c,b){a(b).append(f.delRowText)}),a(g).find("a.delete").live("click",
function(){B(this);return!0}));C();f.addRowWithTab&&D()}function D(){a(g).find("tr:not(.noedit):last a.delete").live("keydown",function(a){9==a.keyCode&&u()})}function A(){var b=a(g).find("tr:not(.noedit):first")[0],d;for(d in e){var c=a(b).find("td:eq("+e[d].pos+")")[0],c=a(c).find("select")[0]||a(c).find("input:not(:submit)")[0]||a(c).find("select")[0];try{type=c.nodeName.toLowerCase()}catch(f){type=!1}if(type)switch(type){case "input":e[d].type="input:"+c.type;break;case "select":e[d].type="select";
break;case "textarea":e[d].type="textarea";break;default:e[d].type="input:text"}else e[d].type=""}}function z(b,d){var c=a(b).attr("col");c&&(e[c]={pos:d,name:c})}function H(b){var d=a(b).attr("summary"),c=!1;b=a(b).attr("col");if("sum"==d||"avg"==d||"max"==d||"min"==d||"count"==d)e[b].summary=d,c=!0;if(!v&&c){var f='<tr class="summary noedit">';a(g).find("tr:not(.noedit):first td").each(function(c,b){var d=a(b).attr("style")?' style="'+a(b).attr("style")+'"':"";f+="<td"+d+"></td>"});f+="</tr>";a(g).append(f);
v=!0}}function s(b){var d=e[b].summary,c=parseInt(e[b].pos)+1,r=a(g).find("tr:not(.noedit) td:nth-child("+c+")"),k=0,l=0,h=null,p=null;if("count"!=d){var m=0;r.each(function(c,f){m=""==e[b].type?1*a(f).html():1*a(f).find(e[b].type).val();switch(d){case "sum":l+=m;break;case "avg":l+=m;break;case "max":h?h<m&&(h=m):h=m;break;case "min":p?p>m&&(p=m):p=m}});switch(d){case "sum":k=l;break;case "avg":k=l/r.length;break;case "max":k=h;break;case "min":k=p}}else k=r.length;k=k.toFixed(f.decimals);a(g).find("tr.summary td:nth-child("+
c+")").html(k)}function w(b){var d=b.target||b.srcElement;if(1==d.nodeType){b=a(d).parents("tr")[0].rowIndex;var d=a(d).parents("td")[0].cellIndex,d=E(d,"pos"),c;for(c in e)if(e[c].formula)try{var f="\\b"+d.name+"\\b",f=RegExp(f);f.test(e[c].formula)&&t(c,b)}catch(k){}}}function G(b){q=!0;var d=a(b).attr("formula");b=a(b).attr("col");if(d){e[b].formula=d;for(var c in e)b="\\b"+c+"\\b",b=RegExp(b),b.test(d)&&""!=e[c].type&&(e[c].event=!0)}}function C(){for(h in e)if(e[h].event){var b="tr td:nth-child("+
(parseInt(e[h].pos)+1)+") "+e[h].type;"input:text"==e[h].type||"textarea"==e[h].type||"select"==e[h].type?(a(g).find(b).unbind("change"),a(g).find(b).change(function(a){w(a)})):"input:checkbox"==e[h].type&&(a(g).find(b).unbind("click"),a(g).find(b).click(function(a){w(a)}))}}function t(b,d){var c=e[b].formula.match(/\b[a-z_-]+[0-9]*\b/ig),h=e[b].formula,k=a(g).find("tr:eq("+d+")"),l;for(l in c)/^\d+$/.test(l)||delete c[l];var n=[];for(l in c){try{var p="td:nth-child("+(e[c[l]].pos+1)+") "+e[c[l]].type}catch(m){}var q=
0;"input:checkbox"==e[c[l]].type?q=a(k).find(p).attr("checked")?1:0:"input:text"==e[c[l]].type&&(q=parseFloat(a(k).find(p).val())||0);h=h.replace(RegExp("\\b"+c[l]+"\\b"),q);n.push(c[l])}c=eval(h);c=c.toFixed(f.decimals);k=a(k).find("td:nth-child("+(e[b].pos+1)+")");""==e[b].type?a(k).html(c):a(k).find(type).html(c);k=0;for(c=n.length;k<c;k++)e[n[k]].summary&&s(n[k]);s(b)}function E(a,d){for(var c in e)if(a==e[c][d])return e[c]}function F(){if(!f.formPos||""==f.formPos){var b=a(g).find("tr:not(.noedit):last").find("input, select, textarea")[0]||
!1;b.name&&(f.formPos=b.name.replace(/^.*\[([0-9]+)\].*$/ig,"$1")||"");f.addedRow=!0}f.formPos++}

//add new row
function u(){
	var b=a(g).find("tr:not(.noedit):first").clone();

	b.find('input').each(function(){
		if($(this).is('[dgp-onlyfornew]')){
		$(this).attr('dgp-new', 1);
	}
	});

	F();
	0<a(b).find("input, select, textarea").length&&(a(b).find("input, textarea, select").each(function(c,b){
	var d="",d=""!==f.formPos?b.name.replace(/\[[0-9]+\]/i,"["+f.formPos+"]"):b.name;"checkbox"==b.type||"radio"==b.type?a(b).attr({name:d,checked:!1}):a(b).attr({name:d,value:""});a(b)}),a(b).find("input:radio, input:checkbox").attr("checked",
!1));e[h]&&""==e[h].type&&e[h].formula&&a(b).find("td:eq("+e[h].pos+")").html("");if(f.countRow){var d=parseInt(a(g).find("tr:not(.noedit):last td:eq("+f.countRowCol+")").html())+1;a(b).find("td:eq("+f.countRowCol+")").html(d)}a(g).find("tr:not(.noedit):first").before(b);x();C();for(var c in e)e[c].summary&&s(e[c].name)
}

function B(b){if(1<a(g).find("tr:not(.noedit)").length){if(f.rails){var d=a(b).parents("tr").eq(0).prev("input:hidden[name$='[id]']");if(0<d.length){F();var c=a(d).attr("name"),h=
a(d).val();n1=c.replace(/^(.*)(\[[0-9]+\])(\[id\])$/,"$1["+f.formPos+"]$3");n2=c.replace(/^(.*)(\[[0-9]+\])(\[id\])$/,"$1["+f.formPos+"][_delete]");a(d).remove();a(g).prepend('<span><input type="hidden" name="'+n1+'" value="'+h+'" /><input type="hidden" value="1" name="'+n2+'"</span>')}}a(b).parents("tr").eq(0).remove();f.countRow&&x()}for(var k in e)e[k].summary&&s(k)}

function x(){
	var b=parseInt(f.countRowCol)+1;

	a(g).find("tr:not(.noedit) td:nth-child("+b+")").each(function(b,c){
		var e=b+1;a(c).html(e)
	});
	
	setTimeout(function(){
		var s_index = 0;
		$tr=a(g).find("tr");
		$tr.each(function(b,c){

			$input=a(c).find("input[data-gride-pattern]");
			
			$input.each(function(c,e){
				$text_name = a(e).attr("data-gride-pattern");
			
				if(a(e).is('[dgp-onlyfornew]')){
					if(a(e).is('[dgp-new]')){
						$text_name = $text_name.replace(/%i1/g,b-1);
						$text_name = $text_name.replace(/%i2/g,c-1);
						$text_name = $text_name.replace(/%s1/g,s_index);
						a(e).attr("name",$text_name);
					}
				}else{
					$text_name = $text_name.replace(/%i1/g,b-1);
					$text_name = $text_name.replace(/%i2/g,c-1);
					$text_name = $text_name.replace(/%s1/g,s_index);
					a(e).attr("name",$text_name);
				}
			});
			s_index++;
		});
	},1E3);
}

var n=Grider.defaults;if(f)for(var h in n)f[h]="boolean"==typeof n[h]&&"boolean"==typeof f[h]?f[h]:f[h]||n[h];else f=n;var e={},v=!1,q=!1;f=f||{};y(g);return{cols:e,config:f,summaryRow:v,table:g,formulaSet:q,calculateFormula:t,
setGrider:y,setColumn:z,fireCellEvent:w,setColType:A,findColBy:E,addRow:u,addRowWithTab:D,delRow:B,rowNumber:x}};a.Grider.events=function(){return"nuevo"}})(jQuery);Grider={defaults:{initCalc:!0,addRow:!0,addRowWithTab:!0,delRow:!0,decimals:2,addRowText:'<caption><div class="btn-group"><a class="add btn btn-success">Add Row</a></div></caption>',delRowText:'<td><a class="delete">delete</a></td>',countRow:!1,countRowText:"N\u00ba",countRowCol:0,countRowAdd:!1,addedRow:!1,rails:!1}};