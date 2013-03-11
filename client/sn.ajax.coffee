$ ->
	methods= 
		init:(options) ->
		sendRequest:(options) ->
			options={} if !options
			def=
				type:'json'
				debug:false
				action:'submit'
				login:$('#inputLogin').val()
				password:$('#inputPassword').val()
				page:$('#page').val()
				id:''
				message:''
			$.extend true,def,options
			def.type='text' if def.debug
			sn=$(@).data('sn');
			$.ajax 
				url:'index.php'
				type:'POST'
				data:
					action:def.action
					page:def.page
					login:def.login
					password:def.password
					id:def.id
					message:def.message
					key:sn.result.key
				dataType:def.type
				timeout:10000
				beforeSend: ->
					$("#loading").show()
				success: (s) ->
					if typeof s=='object'
						$.extend true,sn.result,s
					else 
						alert s if def.debug
						sn.result=s
					$(@).data('sn',sn)
					if typeof sn.result=='object'
						alert sn.result.alert if sn.result.alert
						$(@).snEvents href:'#'+sn.result.callback if sn.result.callback
					$("#loading").hide()
				error: (XMLHttpRequest,textStatus,error) ->
				
	$.fn.snAjax= (sn) ->
		sn={} if !sn
		if methods[sn] 
			methods[sn].apply @,Array.prototype.slice.call arguments,1
		else 
			if typeof sn=='object' || !sn
				methods.init.apply @,arguments
			else 
				$.error 'Метод '+sn+' не существует'



