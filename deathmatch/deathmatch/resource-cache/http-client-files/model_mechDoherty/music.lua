addEventHandler( 'onClientResourceStart', resourceRoot,
	function( )
		local uSound = playSound3D( 'http://radio.tatinf.ru:8800/dfm', -2050.9133300781, 168.4600982666, 28.8359375 ) 
		setSoundMaxDistance( uSound, 55)
	end
)