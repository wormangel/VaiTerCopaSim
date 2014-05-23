$(document).ready(function(){
	
	$('#btn_toggle_favorite').click(function(){
	
		var fav_uid = $(this).data('uid');
		var action = $(this).data('action');
		
		var btn = $('#btn_toggle_favorite');
		var caption = $('#btn_toggle_favorite_caption');
		var spinner = $('#btn_toggle_favorite_spinner');
		
		if (action != 'add' & action != 'remove') {
			return; // Trying to hack, huh? ;)
		}
	
		caption.hide()
		spinner.show()
		if (action == 'add') {
			$.ajax({url: "/favorites/create?uid=" + fav_uid,
				success: function(data){
					// Change the button to the delete one
					spinner.hide();
					caption.text('Remover dos favoritos');
					caption.show();
					btn.removeClass('btn-warning');
					btn.addClass('btn-danger');
					btn.data('action', 'remove');
				},
				error: function(data){
					alert(data.responseJSON.message);
				}
			});
		} else  {
			$.ajax({url: "/favorites/destroy?uid=" + fav_uid,
				success: function(data){
					// Change the button to the delete one
					spinner.hide();
					caption.text('Adicionar aos favoritos');
					caption.show();
					btn.removeClass('btn-danger');
					btn.addClass('btn-warning');
					btn.data('action', 'add');
				},
				error: function(data){
					alert(data.responseJSON.message);
				}
			});
		}
	});
});