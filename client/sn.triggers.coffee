$ ->
	methods=
		init: ->
			if $("#claims").html()!=""
				$(this).snTriggers 'table'
			if $("#pagination").html()!=""
				$(this).snTriggers 'pagination'
			if $("#signin").html()!=""
				$(this).snTriggers 'signin'
		signin: ->
			th=$(this)
			$("#fSignin").on "submit",(e) ->
				e.preventDefault()
				th.snEvents href:'#signin'
		table: ->
			th=$(this)
			$(".status").on "keyup",() ->
				th.snAjax 'sendRequest',
						action:'edit'
						id:$(this).data 'id'
						message:$(this).val()
						debug:false
			$(".status").on "blur",() ->
				th.snAjax 'sendRequest',
						action:'edit'
						id:$(this).data 'id'
						message:$(this).val()
						debug:false
		pagination: ->
			th=$(this)
			$("a#prev").on "click",(e) ->
				e.preventDefault()
				$("#page").val $("#page").val()*1-1
				th.snAjax 'sendRequest'
						action:'signin'
						debug:false
			$("a.list").on "click",(e) ->
				e.preventDefault()
				$("#page").val $(this).data "page"
				th.snAjax 'sendRequest'
						action:'signin'
						debug:false
			$("a#next").on "click",(e) ->
				e.preventDefault()
				$("#page").val $("#page").val()*1+1
				th.snAjax 'sendRequest'
						action:'signin'
						debug:false

	$.fn.snTriggers= (sn) ->
		sn={} if !sn
		if methods[sn]
			methods[sn].apply @,Array.prototype.slice.call arguments,1
		else 
			if typeof sn=='object' || !sn
				methods.init.apply @,arguments
			else 
				$.error 'Метод '+sn+' не существует'

