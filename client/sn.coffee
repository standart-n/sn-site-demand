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

			_this = this

			# $('#push-demand').hide()

			$(this).snDemand 'geoIp'

			$('#demand-name').live 'keyup', () ->
				$(_this).snDemand 'checkName', $(this).val()

			$('#demand-phone').live 'keyup', () ->
				$(_this).snDemand 'checkPhone', $(this).val()

			$('#demand-company').live 'keyup', () ->
				$(_this).snDemand 'checkCompany', $(this).val()

			$('#demand-comment').live 'keyup', () ->
				$(_this).snDemand 'checkComment', $(this).val()

			$('#push-demand').live 'click', () ->
				$('#wall-demand')
					.show()
					.css(
						width: $(document).width()
						height: $(document).height()
						)
				$('#modal-demand').show()

			$('.modal-header a.close').live 'click', () ->
				$('#wall-demand').hide()
				$('#modal-demand').hide()

			$('#modal-close').live 'click', () ->
				$('#wall-demand').hide()
				$('#modal-demand').hide()

			$('#modal-send').live 'click', () ->
				if $(this).snDemand('check')
					$('.demand-success p').show()
					$('.demand-error p').hide()

					$('#modal-send').hide()
					$(_this).snDemand 'send'
				else
					$('.demand-success p').hide()
					$('.demand-error p').show()


		send: () ->
			sn = $(this).data 'sn'

			$(this).snDemand 'addToBase'
			$(this).snDemand 'addToGit'


		geoIp: () ->
			_this = this
			sn = $(this).data 'sn'

			$.ajax
				url: 				'http://j.maxmind.com/app/geoip.js'
				dataType: 			'script'
				timeout: 			5000
				success: () ->
					sn.geo =
						lat: 		geoip_latitude()
						lon: 		geoip_longitude()
						city: 		geoip_city()
						region: 	geoip_region()
						country: 	geoip_country_name()

					$(_this).data 'sn', sn


		addToBase: () ->

			sn = $(this).data 'sn'

			dp = $('[name="demand-type"]:checked').val()
			sector = $('[name="demand-type-' + dp + '"]').val()


			$.ajax
				url:				'http://www.standart-n.ru/external/ajax_claim.php'
				type:				'GET'
				data:
					act:			'add'
					name:			$('#demand-name').val()
					tel:			$('#demand-phone').val()
					email:			$('#demand-email').val()
					comment:		$('#demand-comment').val()
					company:		$('#demand-company').val()
					department: 	sector
					skype:			''
					icq:			''
					site:			''
					lat:			sn.geo.lat
					lon:			sn.geo.lon
					city:			sn.geo.city
					region:			sn.geo.region
					country:		sn.geo.country
				dataType:			'text'
				timeout:			5000

		addToGit: () ->

			sn = $(this).data 'sn'

			dp = $('[name="demand-type"]:checked').val()
			sector = $('[name="demand-type-' + dp + '"]').val()

			message = '' +
				sector + ' ' +
				$('#demand-company').val() + ' ' +
				$('#demand-name').val() + ' ' +
				$('#demand-phone').val() + ' ' +
				$('#demand-email').val() + ' ' +
				$('#demand-comment').val() + ' '
				sn.geo.city + ' ' +

			$.ajax
				url: 'http://git.st-n.ru/'
				type: 'GET'
				data:
					action: 'addClaim'
					msg: message
				dataType: 'text'
				timeout: 1000

		check: () ->

			flag = true

			flag = false if !$(this).snDemand 'checkName',		$('#demand-name').val()
			flag = false if !$(this).snDemand 'checkPhone',		$('#demand-phone').val()
			flag = false if !$(this).snDemand 'checkCompany',	$('#demand-company').val()
			flag = false if !$(this).snDemand 'checkComment',	$('#demand-comment').val()
			
			flag


		checkName: (val = '') ->
			flag = $(this).snDemand 'flagName', val

			if flag
				$('#validate-name .validate-true').show()
				$('#validate-name .validate-false').hide()
			else
				$('#validate-name .validate-true').hide()
				$('#validate-name .validate-false').show()

			flag


		checkCompany: (val = '') ->
			flag = $(this).snDemand 'flagCompany', val

			if flag
				$('#validate-company .validate-true').show()
				$('#validate-company .validate-false').hide()
			else
				$('#validate-company .validate-true').hide()
				$('#validate-company .validate-false').show()

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


		checkComment: (val = '') ->
			flag = $(this).snDemand 'flagComment', val

			if flag
				$('#validate-comment .validate-true').show()
				$('#validate-comment .validate-false').hide()
			else
				$('#validate-comment .validate-true').hide()
				$('#validate-comment .validate-false').show()

			flag


		flagName: (val = '') ->
			flag = true
			
			if val is ""
				flag = false
			
			if val.length < 2 or val.length > 30
				flag = false
			
			if !(/[^a-z0-9\.\,\"\?\!\;\:\#\$\%\&\(\)\*\+\-\/\<\>\=\@\[\]\\\^\_\{\}\|\~]+/i).test(val)
				flag = false

			flag


		flagCompany: (val = '') ->
			flag = true
			
			if val is ""
				flag = false
			
			if val.length < 2 or val.length > 30
				flag = false
			
			flag


		flagComment: (val = '') ->
			flag = true
			
			if val is ""
				flag = false
			
			if val.length < 2
				flag = false
			
			flag



		flagPhone: (val = '') ->
			flag = true

			if val is "" or val is "+7"
				flag = false

			if val.length < 4 or val.length > 30
				flag = false

			if !(/\+?\d{1,3}(?:\s*\(\d+\)\s*)?(?:(?:\-\d{1,3})+\d|[\d\-]{4,}|(?:\s\d{1,3})+\d)/i).test(val)
				flag = false

			flag





	$.fn.snDemand = (sn = {}) ->
		if methods[sn] 
			methods[sn].apply @,Array.prototype.slice.call arguments,1
		else 
			if typeof sn is 'object' or !sn
				methods.init.apply @,arguments
			else 
				$.error 'Метод #{sn} не существует'

