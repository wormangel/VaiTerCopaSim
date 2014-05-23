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
					
					update_fav_list();
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
					
					update_fav_list();
				},
				error: function(data){
					alert(data.message);
				}
			});
		}
	});
	
	function update_fav_list(){
		$('#fav_list_spinner').show();
		
		$.ajax({url: "/favorites/get_favs",
			success: function(data){
				var container = $('#fav_list');
				container.empty();
				
				if (data.favs.length > 0) {
					$.each(data.favs, function(i, fav) {
					
						var li = $('<li></li>');
						var a = $('<a href="/collections/compare/' + fav['favorite']['uid'] + '"></a>');
						var img = $('<img src="http://graph.facebook.com/' + fav['favorite']['uid'] + '/picture?type=small"></img>');
					
						a.append(img);
						a.append("   " + fav['favorite']['name']);
					
						li.append(a);
						container.append(li);
					});
				} else {
					var li = $('<li></li>');
					var span = $('<span class="navbar-text">Você não tem favoritos!</span>');
					
					li.append(span);
					container.append(li);
				}
				
				$('#fav_list_spinner').hide();
			},
			error: function(data){
				alert(data.message);
			}
		});
	}
});