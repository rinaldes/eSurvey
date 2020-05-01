function changeField(){
	if($("#question").val() == "Radio Button Grid"){
		radio_button_grid();
	}else if($("#question").val() == "CheckBox Grid"){
		checkbox_grid();
	}else if($("#question").val() == "TextBox Grid"){
		textbox_grid();
	}
}

function radio_button_grid(){
	delete_html();
	html_replace = "<div id='row_origin'><div class='form-group'> <label class='col-lg-3 control-label'>Row 1 Label</label> <div class='col-lg-8'> <input type='text' placeholder='' class='form-control'> <span class='input-group-btn add-on'> <button class='btn btn-primary' type='button' onclick='tambahRow(0);'><i class='fa fa-plus'></i></button> </span></div> </div> </div> <div id='tambah_row'></div> <hr> <div id='column_origin'><div class='form-group'> <label class='col-lg-3 control-label'>Column 1 Label</label> <div class='col-lg-8'> <input type='text' placeholder='' class='form-control'> <span class='input-group-btn add-on'> <button class='btn btn-primary' type='button' onclick='tambahColumn();'><i class='fa fa-plus'></i></button> </span></div> </div> </div></div> <div id='tambah_column'></div>";
	$("#question_field").html(html_replace);
	autoHeigth();

}

function delete_html(){
	$("#question_field").html("");
	$("#advance_setting").html("");
}

function checkbox_grid(){
	delete_html();
	html_replace = "<div id='row_origin'><div class='form-group'> <label class='col-lg-3 control-label'>Row 1 Label</label> <div class='col-lg-8'> <input type='text' placeholder='' class='form-control'> <span class='input-group-btn add-on'> <button class='btn btn-primary' type='button' onclick='tambahRow(0);'><i class='fa fa-plus'></i></button> </span></div> </div> </div> <div id='tambah_row'></div> <hr> <div id='column_origin'><div class='form-group'> <label class='col-lg-3 control-label'>Column 1 Label</label> <div class='col-lg-8'> <input type='text' placeholder='' class='form-control'> <span class='input-group-btn add-on'> <button class='btn btn-primary' type='button' onclick='tambahColumn();'><i class='fa fa-plus'></i></button> </span></div> </div> </div></div> <div id='tambah_column'></div>";
	$("#question_field").html(html_replace);

	advance_setting = "<div class='panel box'><header class='panel-heading'><span class='tools'><a href='javascript:;' class='fa fa-minus-square'></a></span>Advanceds Setting</header><div class='panel-body'><div class='form-group'>   <div class='col-lg-12 checkbox'><input type='checkbox' checked='' ><label>Data Validation</label></div></div><div class='form-group'>   <div class='col-lg-2'><select class='form-control' id='question' name='question'><option value='Select At Least'>Select At Least</option><option value='Select At Most'>Select At Most</option><option value='Select Exactly'>Select Exactly</option></select></div><div class='col-lg-2'><input type='text' class='form-control' placeholder=''></div><div class='col-lg-8'><input type='text' class='form-control' placeholder=''></div></div></div></div>";
	$("#advance_setting").html(advance_setting);
	autoHeigth();
}

function textbox_grid(){
	alert('textbox_grid');
}

function tambahRow(a){
	var n = $('#tambah_row div').length/2+2;
	html_replace = "<div class='form-group' id='row_"+a+"'> <label class='col-lg-3 control-label'>Row "+n+" Label</label> <div class='col-lg-8'> <input type='text' placeholder='' class='form-control'> <span class='input-group-btn add-on'> <button class='btn btn-primary' type='button' onclick='kurangRow("+a+");'><i class='fa fa-minus'></i></button> </span></div> </div>"
	$("#tambah_row").append(html_replace);
	$('#row_origin button').attr('onclick', 'tambahRow('+(a+1)+')');
	autoHeigth();
}

function tambahColumn(a){
	var n = $('#tambah_column div').length/2+2;
	html_replace = "<div class='form-group' id='column_"+a+"'> <label class='col-lg-3 control-label'>Column "+n+" Label</label> <div class='col-lg-8'> <input type='text' placeholder='' class='form-control'> <span class='input-group-btn add-on'> <button class='btn btn-primary' type='button' onclick='kurangColumn("+a+");'><i class='fa fa-minus'></i></button> </span></div> </div>"
	$("#tambah_column").append(html_replace);
	$('#column_origin button').attr('onclick', 'tambahColumn('+(a+1)+')');
	autoHeigth();
}

function kurangRow(id){
	$('#row_'+ id).remove();
	var n = $('#tambah_row label').length;
	for(var a = 0; a<n;a++){
		$('#tambah_row label:eq('+a+')').html('Row '+(a+2)+' Label')
	}
}

function kurangColumn(id){
	$('#column_'+ id).remove();
	var n = $('#tambah_column label').length;
	for(var a = 0; a<n;a++){
		$('#tambah_column label:eq('+a+')').html('column '+(a+2)+' Label')
	}
}

function autoHeigth(){
	$("#form_question").parent('section').parent('div').attr('style', 'height:'+$("#wizard").height()+'px;');
}







