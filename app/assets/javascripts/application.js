// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(document).ready(function(){

	$("#Lstats").hide();
	$("#Rstats").hide();

	$("#delete").click(function(){
		var del_id = $("#matchTitle").attr("data-id");
		$.ajax({
			url: "/destroy.json",
			type: "POST",
			data: { "id" : del_id },
			success: function(){
				get_next();
			}
		});
	});
	
	$("#approve").click(function(){
		var app_id = $("#matchTitle").attr("data-id");
		$.ajax({
			url: "/approve.json",
			type: "POST",
			data: { "id": app_id },
			success: function(){
				get_next();
			}
		});
		
	});

	$("#leftField").click(function(){
		var match_id = $("#matchTitle").attr("data-id");
		$("#leftField").css('border', '5px solid green');
		$("#Lstats").show();
		$("#Rstats").show();
		$.ajax({
			url: "/leftVote.json",
			type: "POST",
			data: { "id" : match_id},
			success: function() {
				setTimeout(new_match, 1500);
			}
		});
	});
	$("#rightField").click(function(){
		var match_id = $("#matchTitle").attr("data-id");
		$("#rightField").css('border', '5px solid green');
		$("#Lstats").show();
		$("#Rstats").show();
		$.ajax({
			url: "/rightVote.json",
			type: "POST",
			data: { "id" : match_id},
			success: function() {
				setTimeout(new_match, 1500);
			}
		});
	});
});
function new_match(){
	$.ajax({
		url: "/grab.json",
		type: "POST",
		success: function(result) {
			if (!result["valid"]) {
				$("#background").html("<p>No Matches!</p>");
			}
			else {
				$("#matchTitle").attr("data-id",result["id"]);
				$("#matchTitle").html(function() {
					return "Best " + result["title"];
				})
				$("#leftName").html(result["Ltitle"]);
				$("#rightName").html(result["Rtitle"]);
				$("#leftField img").attr("src",result["Lpic"]);
				$("#rightField img").attr("src",result["Rpic"]);
				$("#Lstats").html("<p>" + 
				Math.round(result["Lvotes"]*100 /
				(result["Lvotes"] + result["Rvotes"]))+ "%<br>"+
				"Total Votes: " + result["Lvotes"]+"</p>");
				$("#Rstats").html("<p>" + 
				Math.round(result["Rvotes"]*100 / 
				(result["Lvotes"] + result["Rvotes"]))+ "%<br>"+
				"Total Votes: " + result["Rvotes"]+"</p>");
				$("#leftField").css('border','5px solid black');
				$("#rightField").css('border','5px solid black');
				$("#Lstats").hide();
				$("#Rstats").hide();
			}
		}
	});
}	
function get_next(){
	$.ajax({
			url: "/next.json",
			type: "POST",
			success: function(result){
				if (!result["valid"]){
					$("#background").html("<p>All matches approved</p>");
				}else{
					$("#matchTitle").attr("data-id",result["id"]);
					$("#matchTitle").html(function() {
				return "Best " + result["title"];
					})
					$("#leftName").html(result["Ltitle"]);
					$("#rightName").html(result["Rtitle"]);
					$("#leftField img").attr("src",result["Lpic"]);
					$("#rightField img").attr("src",result["Rpic"]);
				}
			}
		});

}

