$(document).ready(function(){

		// Contains the information for each sticker
		var json_node = $('#hdn').attr('value');
		var stickers = JSON.parse(json_node);

		function display_modal(){
			$('#modal_add_stickers').modal();
			$('#textarea_sticker_numbers').focus();
		}
		
		function get_numbers_from_input(){
			var input_val = $('#textarea_sticker_numbers').val();
			
			var tokens = input_val.split(/[\s,\-]+|\(\d+\)/);
			var stickers = [];
			
			$.each(tokens, function(i, token) {
				var sticker = get_sticker_from_json(token);
				if (sticker != undefined) {
					stickers.push(sticker['number']);
				}				
			});
			
			return stickers;		
		}
		
		function add_stickers(stickers, type, success_callback, fail_callback) {
			var stickers_param = stickers.join(',');
			
			var type_param = type == "dupes" ? "duplicate" : "missing";
		
			$.ajax({url: "/collections/add_stickers?stickers=" + stickers_param + "&user=" + user_uid + "&type=" + type_param,
				success: function(data){
					$('#modal_add_stickers').modal('hide');
					if (success_callback) {
						success_callback(data, type_param);
					}
				},
				error: function(data) {
					if (fail_callback) {
						fail_callback(data, type_param);
					}
				}
			});
		}
		
		function get_sticker_from_json(number){
			number = number.toUpperCase();
			return stickers[number];
		}
		
		function update_dashboard(data, type_param){
		
			var stickers_container = type_param == "duplicate" ? $('#div_dupes_stickers_container') : $('#div_missing_stickers_container');
			stickers_container.hide();
			stickers_container.find('.sticker_placeholder').remove();
			stickers_container.find('.sticker_refresh_spinner').show();
			
			$.ajax({url: "/collections/get_stickers?user=" + user_uid + "&type=" + type_param,
				complete: function(data){
					$.each(data.responseJSON.stickers, function(i, sticker) {
						var sticker_info = sticker['sticker'];
						var newSticker = $('#sticker_placeholder_template').clone();
						newSticker.removeAttr('id');
						newSticker.find('.sticker_image').attr('src', images_prefix + sticker_info['image']);
						if ( type_param == 'duplicate' && sticker['qty'] > 1) {
							newSticker.find('.sticker_dupe_count').text(sticker['qty']);
						} else {
							newSticker.find('.sticker_dupe_count').remove();
						}
						newSticker.find('.sticker_number').text(sticker_info['number']);
						newSticker.addClass('sticker_placeholder');
						newSticker.show();
						
						stickers_container.append(newSticker);
					});
					
					var count_elem = type_param == 'duplicate' ? $('#dupes_count') : $('#missing_count');
					count_elem.text(data.responseJSON.total);
					stickers_container.find('.sticker_refresh_spinner').hide();
					stickers_container.show();
				}
			});
		}
		
		function error(data) {
			alert('miss');
		}
		
		// Callbacks
		
		// When user clicks on 'Adicionar figurinhas', display the add modal
		$('#btn_add_stickers').click(function(){
			display_modal();
		});
		
		$('#btn_add_dupes').click(function(){
			var stickers = get_numbers_from_input();
			
			if (stickers.length > 0) {
				add_stickers(stickers, 'dupes', update_dashboard, error);
			} else { // Did not find a sticker for any of the input values
			}
			
		});
		
		$('#btn_add_missing').click(function(){
			var stickers = get_numbers_from_input();
			
			if (stickers.length > 0) {
				add_stickers(stickers, 'missing', update_dashboard, error);
			} else { // Did not find a sticker for any of the input values
			}
			
		});
})