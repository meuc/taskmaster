//= require maxibear
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(function(){
	$(document).on("click", ".add-user-button", function() {
		var last = $(".add-user-field").last();
		var clone = last.clone();
		clone.find("input").val("");
		last.after(clone);
	});
	
	$(document).on("click", ".add-user-field button", function() {
		$(this).parents(".add-user-field").remove();
	});
	
	$(document).on("click", "input[type=checkbox][data-task-id]", function(){
		var id = $(this).attr("data-task-id");
		
		// AJAX
		 $.ajax({
			 // browsers only support get and post
		   type: "POST",
		   url: "/tasks/"+id+"/toggle_completed",
		   dataType: "json",
			 // Ruby says, patch is the right thing, so we change it like this:
		   data: {
		     _method: "PATCH"
		   },
			 error: function () {
				 alert("Error toggling task");
			 }
		 });
	});
	
	$(document).on("click", ".profile", function(e) {
		e.preventDefault();
		$(".profile-sub").toggle();
	});
	
	$(document).on("click", ".edit-toggler", function() {
		$(".task-controls").toggle();
	});
	
	
	$(document).on("click", "#Check_all",function(){
	    $('input:checkbox').not(this).prop('checked', this.checked);
	});
});

