$ ->
	methods=
		init:(options) ->
			def=
				href:'none'
			$.extend true,def,options
			sn=$(this).data 'sn'
			href=def.href
			switch href.replace /(.*)#(.*)/,'$2'
				when "autoload" then
				when "signin"
					$("#signin-error").hide()
					$(this).snAjax 'sendRequest',(action:'signin',debug:false)
				when "afterSignin"
					if sn.result
						if sn.result.response
							if sn.result.claims
								$('#claims').html sn.result.claims
								$(this).snTriggers 'table'
							if sn.result.pagination
								$("#pagination").html sn.result.pagination
								$(this).snTriggers pagination
							$("#signin").empty()
						else
							$("#inputLogin").val ''
							$("#inputPassword").val ''
							$("#signin-error").show()
				when "submit"
					$(this).snAjax 'sendRequest',(action:'submit',debug:false)
				when "afterSubmit"
					if sn.result
						if sn.result.table
							$("#table").html sn.result.table
							$(this).snTriggers 'sort'
							$(this).snTriggers 'detail'
							$(this).snPlayer 'onClickPlay'
				when "close" then $(this).hide()


	$.fn.snEvents= (sn) ->
		sn={} if !sn
		if methods[sn]
			methods[sn].apply @,Array.prototype.slice.call arguments,1
		else 
			if typeof sn=='object' || !sn
				methods.init.apply @,arguments
			else 
				$.error 'Метод '+sn+' не существует'


