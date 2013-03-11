$ ->
	methods=
		init:(options) ->
			$(@).snConf main 
		main:(options) ->
			sn=$(@).data sn
			$.ajax
				url: 'sn-project/settings/main.json'
				async:false
				dataType:'json'
				success: (s) ->
					$.extend true,sn,s
					$(@).data 'sn',sn

	$.fn.snConf= (sn) ->
		sn={} if !sn
		if methods[sn]
			methods[sn].apply @,Array.prototype.slice.call arguments,1
		else 
			if typeof sn=='object' || !sn
				methods.init.apply @,arguments
			else 
				$.error 'Метод '+sn+' не существует'


