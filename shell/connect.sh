sudo ifconfig ra0 up							 
sudo iwpriv ra0 set EncrypType=WEP 
sudo iwpriv ra0 set Key1=EFEFEFEFEF
sudo iwpriv ra0 set DefaultKeyID=1 
sudo iwpriv ra0 set SSID=mojacet	 
dhclient ra0											 