//= require maxibear
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(function(){
	$(document).on("click", ".add-user-button", function(){
		var last = $(".add-user-field").last();
		var clone = last.clone();
		clone.find("input").val("");
		last.after(clone);
	});
	
	$(document).on("click", ".add-user-field button", function(){
		$(this).parents(".add-user-field").remove();
	});
});