$ ->
	methods = 
		init: (options = {}) ->
			def=
				content:{}
				geo: 
					lat: ''
					lon: ''
					city: ''
					region: ''
					country: ''
				result:
					key:''

			$.extend true, def, options
			$(@).data 'sn', def

			_this = $(this)

			$(this).snDemand 'geoIp'

			$('#demand-name').live 'keyup', () ->
				_this.snDemand 'checkName', $(this).val()

			$('#demand-phone').live 'keyup', () ->
				_this.snDemand 'checkPhone', $(this).val()

			$('#push-demand').live 'click', () ->
				$('#modal-demand').show()

			$('.modal-header a.close').live 'click', () ->
				$('#modal-demand').hide()

			$('#modal-close').live 'click', () ->
				$('#modal-demand').hide()

			$('#modal-send').live 'click', () ->
				if $(this).snDemand('check')
					$('.demand-success').show()
					$('.demand-error').hide()

					_this.snDemand 'send'
				else
					$('.demand-success').hide()
					$('.demand-error').show()


		send: () ->
			sn = $(this).data 'sn'

			$(this).snDemand 'addToBase'
			$(this).snDemand 'addToGit'


		geoIp: () ->
			_this = $(this)
			sn = $(this).data 'sn'

			$.ajax
				url: 'http://j.maxmind.com/app/geoip.js'
				dataType: 'script'
				timeout: 5000
				success: () ->
					sn.geo =
						lat: geoip_latitude()
						lon: geoip_longitude()
						city: geoip_city()
						region: geoip_region()
						country: geoip_country_name()

					_this.data 'sn', sn


		addToBase: () ->

			sn = $(this).data 'sn'

			$.ajax
				url:'http://www.standart-n.ru/api/js/deGetClaim.js'
				type:'GET'
				data:
					act:'add'
					name:$('#demand-name').val()
					tel:$('#demand-phone').val()
					email:$('#demand-email').val()
					comment:$('#demand-comment').val()
					skype:''
					icq:''
					site:''
					lat:sn.geo.lat
					lon:sn.geo.lon
					city:sn.geo.city
					region:sn.geo.region
					country:sn.geo.country
				dataType:'text'
				timeout:5000

		addToGit: () ->

			sn = $(this).data 'sn'

			message = '' +
				$('#demand-name').val() + ' ' +
				$('#demand-phone').val() + ' ' +
				$('#demand-email').val() + ' ' +
				sn.geo.city + ' ' +
				$('#demand-comment').val() + ' '

			$.ajax
				url: 'http://git.st-n.ru/'
				type: 'GET'
				data:
					action: 'addClaim'
					msg: message
				dataType: 'text'
				timeout: 1000
				success: (s) ->
					alert s

		check: () ->
			
			$(this).snDemand('checkName',$('#demand-name').val()) && $(this).snDemand('checkPhone',$('#demand-phone').val())



		checkName: (val = '') ->
			flag = $(this).snDemand 'flagName', val

			if flag
				$('#validate-name .validate-true').show()
				$('#validate-name .validate-false').hide()
			else
				$('#validate-name .validate-true').hide()
				$('#validate-name .validate-false').show()

			flag

		checkPhone: (val = '') ->
			flag = $(this).snDemand 'flagPhone', val

			if flag
				$('#validate-phone .validate-true').show()
				$('#validate-phone .validate-false').hide()
			else
				$('#validate-phone .validate-true').hide()
				$('#validate-phone .validate-false').show()

			flag


		flagName: (name = '') ->
			flag = true
			
			if name == "" || name == "+7"
				flag = false
			
			if name.length < 2 || name.length > 30
				flag = false
			
			if !(/[^a-z0-9\.\,\"\?\!\;\:\#\$\%\&\(\)\*\+\-\/\<\>\=\@\[\]\\\^\_\{\}\|\~]+/i).test(name)
				flag = false

			flag




		flagPhone: (phone = '') ->
			flag = true

			if phone == "" || phone == "+7"
				flag = false

			if phone.length < 5 || phone.length > 30
				flag = false

			if !(/\+?\d{1,3}(?:\s*\(\d+\)\s*)?(?:(?:\-\d{1,3})+\d|[\d\-]{6,}|(?:\s\d{1,3})+\d)/i).test(phone)
				flag = false

			flag





	$.fn.snDemand = (sn = {}) ->
		if methods[sn] 
			methods[sn].apply @,Array.prototype.slice.call arguments,1
		else 
			if typeof sn=='object' || !sn
				methods.init.apply @,arguments
			else 
				$.error 'Метод '+sn+' не существует'