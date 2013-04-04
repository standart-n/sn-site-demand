$ ->
	methods = 
		init: (options = {}) ->
			def=
				content:{}
				result:
					key:''
			$.extend true,def,options
			$(@).data 'sn',def
			$(@).snTriggers()
			$(@).snEvents 'href':'#autoload'

	$.fn.sn = (sn = {}) ->
		if methods[sn] 
			methods[sn].apply @,Array.prototype.slice.call arguments,1
		else 
			if typeof sn=='object' || !sn
				methods.init.apply @,arguments
			else 
				$.error 'Метод '+sn+' не существует'