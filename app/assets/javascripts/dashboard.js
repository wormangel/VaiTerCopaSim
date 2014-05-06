$(document).ready(function(){

		var json_node = $('#hdn').attr('value');
		var stickers = JSON.parse(json_node);

		function displayAlert(){
			reset_result_area();
			$('#modal_add_duplicates').modal();
			$('#sticker_number').focus();
		}
		
		function analyzeInput(){
			var input_val = $('#sticker_number').val();
			
			var tokens = input_val.split(/[\s,-]+/);
			var sticker = get_sticker_from_json(input_val);
			
			reset_result_area();
			if (sticker != undefined) {
				$('.sticker_image').attr('src', '/img/stickers/' + sticker['number'] + '.jpg');
				
				display_result_area(true);
			} else {
				display_result_area(false);
			}
			
			$('#sticker_number').val("");
			$('#sticker_number').focus();
			
		}
		
		
		
		function display_result_area(success) {
			if (success) {
				$('#success_area').show();
				$('.sticker').show();
				$('#failure_area').hide();				
			} else {
				$('#failure_area').show();
				$('#success_area').hide();
				$('.sticker').hide();
			}
			$('#result_area').fadeIn("slow")
		}
		
		function reset_result_area(){
			$('#success_area').hide();
			$('#failure_area').hide();
			$('#result_area').hide();
			$('.sticker').hide();
		}
		
		function get_sticker_from_json(number){
			number = number.toUpperCase();
			return stickers[number];
		}

		$('#duplicates_btn').click(function(){
			displayAlert();
		});
		
		$('#sticker_number').keyup(function(e){
			var input_length = $('#sticker_number').val().length;
			if ((e.keyCode == 13 && input_length != 0)) {// Enter was pressed
				analyzeInput();
			}
		});
})