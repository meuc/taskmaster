//= require maxibear
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require Chart.min
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
	
	$(document).on("click", "input[type=checkbox][data-task-id]", function() {
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
	
	$(document).on("click", "#Check_all", function() {
		$('input:checkbox').not(this).prop('checked', this.checked);
	});
	
	$(document).on("click", ".stamp", function() {
		$(".stamp").removeClass("clicked-stamp");
		$(this).addClass("clicked-stamp");
	});
	
	$(document).on("click", ".stamp-toggle", function() {
		$(this).parents(".comments-wrap").find(".stamps-menu").toggle();
	});
	
	$(document).on("click", ".comment-toggler", function(e) {
		e.preventDefault();
		$(".comments-wrap").toggle();
	});
	
	$(document).on("click", ".speech-bubble", function() {
		$(this).parents(".task-list li").find(".comments-wrap").toggle();
	});	
	
	if (location.pathname == "/graphs") {
		$.ajax({
			type: "GET",
			url: "/graphs",
			dataType: "json",
			error: function() {
				alert("Error requesting data");
			},
			success: function(json) {
				showGraph(json);
			}
		});
	}
	
	function showGraph(json) {
		
		function values(obj) {
			var values = [];
			var keys = Object.keys(obj);
			for (var i = 0; i < keys.length; i++) {
				values.push(obj[keys[i]]);
			}
			return values;
		}	
		
		var ctx = $("#graph").get(0).getContext("2d");
		
		var gradient = ctx.createLinearGradient(0, 0, 0, 400);
		    gradient.addColorStop(.1, '#f17431');   
		    gradient.addColorStop(.55, '#144884');	
			
		var data = {
			labels: Object.keys(json),
			datasets: [
				{
					label: "My label",
					data: values(json),
					fillColor: gradient
				}
			]
		};
		
		var graph = Chart.defaults.global;
		graph.animationEasing = "easeOutCirc";
		graph.scaleLineColor = "#f17431";
		graph.scaleLineWidth = 2;
		graph.scaleFontFamily = "Arvo, serif";
		graph.scaleFontColor = "#144884"
		
		var myNewChart = new Chart(ctx).Bar(data, {
			barShowStroke: false,
			scaleShowVerticalLines: false,
			scaleGridLineColor: "rgba(241, 116, 49, 0.1)",
			barValueSpacing: 25
		});
		
	}
});

