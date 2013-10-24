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

			$(this).snOpinion 'geoIp'

			$('#opinion-name').live 'keyup', () ->
				_this.snOpinion 'checkName', $(this).val()

			$('#opinion-phone').live 'keyup', () ->
				_this.snOpinion 'checkPhone', $(this).val()

			$('#push-opinion').live 'click', () ->
				$('#wall-opinion')
					.show()
					.css(
						width: $(document).width()
						height: $(document).height()
						)
				$('#modal-opinion').show()

			$('.modal-header a.close').live 'click', () ->
				$('#wall-opinion').hide()
				$('#modal-opinion').hide()

			$('#modal-close').live 'click', () ->
				$('#wall-opinion').hide()
				$('#modal-opinion').hide()

			$('#modal-send').live 'click', () ->
				if $(this).snOpinion('check')
					$('.opinion-success p').show()
					$('.opinion-error p').hide()

					$('#modal-send').hide()
					_this.snOpinion 'send'
				else
					$('.opinion-success p').hide()
					$('.opinion-error p').show()


		send: () ->
			sn = $(this).data 'sn'

			$(this).snOpinion 'addToBase'
			$(this).snOpinion 'addToGit'


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
				url:'http://www.standart-n.ru/external/ajax_claim.php'
				type:'GET'
				data:
					act:'add'
					name:$('#opinion-name').val()
					tel:$('#opinion-phone').val()
					email:$('#opinion-email').val()
					comment:$('#opinion-comment').val()
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
				$('#opinion-name').val() + ' ' +
				$('#opinion-phone').val() + ' ' +
				$('#opinion-email').val() + ' ' +
				sn.geo.city + ' ' +
				$('#opinion-comment').val() + ' '

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
			
			$(this).snOpinion('checkName',$('#opinion-name').val()) && $(this).snOpinion('checkPhone',$('#opinion-phone').val())



		checkName: (val = '') ->
			flag = $(this).snOpinion 'flagName', val

			if flag
				$('#validate-name .validate-true').show()
				$('#validate-name .validate-false').hide()
			else
				$('#validate-name .validate-true').hide()
				$('#validate-name .validate-false').show()

			flag

		checkPhone: (val = '') ->
			flag = $(this).snOpinion 'flagPhone', val

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

			if !(/\+?\d{1,3}(?:\s*\(\d+\)\s*)?(?:(?:\-\d{1,3})+\d|[\d\-]{4,}|(?:\s\d{1,3})+\d)/i).test(phone)
				flag = false

			flag





	$.fn.snOpinion = (sn = {}) ->
		if methods[sn] 
			methods[sn].apply @,Array.prototype.slice.call arguments,1
		else 
			if typeof sn=='object' || !sn
				methods.init.apply @,arguments
			else 
				$.error 'Метод '+sn+' не существует'