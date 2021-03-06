<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ page isELIgnored="false" %>
<html xmlns="http://www.w3.org/1999/xhtml">

<%
String dps_dvs = request.getParameter("dps_dvs");
String prov = request.getParameter("provider");
String delServer = request.getParameter("deliveryServer");
String files = request.getParameter("files");

%> 
<head>
	<title> Video Player Viewer</title> 
<script type="text/javascript" src="JWPlayer/jwplayer.js"></script>
<link rel="stylesheet" type="text/css" href="skins/six.css"> </link>
<link rel="stylesheet" type="text/css" href="skins/demostyle.css"> </link>
</head>	

<!-- START OF THE PLAYER EMBEDDING TO COPY-PASTE -->

	<div align="center">
		<div id="mediaplayer">
			<img src="../images/icons/ico_loading.gif" id="loadingImage" style="margin:1em auto; border:0px; width:32px;"/>
		</div>
	</div> 


<div id="fullPlaylist" style="width:680px;">


<div class="ListItems" style="position:inherit;">
<div id="list" style="position:relative;">&nbsp;</div>
<script type="text/javascript"> 
var autoStart = ${bean.autoStart}; 
		var prov = '<%=prov%>';
		var metadata = ${bean.metadata}; 
		var audioView = ${bean.audioView};
		var defVolume = '${bean.volume}';
		var defSkin =  '${bean.skin}';
		var delServer = '${delServer}';
		var dps_dvs = '<%=dps_dvs%>';
		var files = '<%=files%>';

		var playListPosition = "right";
		var controllbarPosition = "bottom";
		var autoPlay = "";
		var lst = new Array(); 
		var fileslist = new Array();
 
		//creating playlist
		var i=0; 
		while (files.length>0) {			
			lst[i] = {		
			file: delServer+files.substring(0,files.indexOf(",")),
			type: files.substring(files.indexOf(".")+1,files.indexOf(";")),
			title: files.substring(files.indexOf(",")+1,files.indexOf(";"))
			};
		

			files = files.substring(files.indexOf(";")+1, files.length);
			i=i+1;
		}
		//set default audio playlist parameters
		if(!audioView && prov == "AUDIO") {
			playListPosition = "bottom";
			controllbarPosition = "top";
		}
		autoStart=true;
		if(autoStart) {
			autoPlay = "list";
		}

		//adding plugins
		var pluginLst;
		if(audioView && prov == "AUDIO" && metadata) {
			pluginLst = {
				'revolt-1': {},
				'metaviewer-1': {
					'position': 'right',  
					'size': '200'
				},
				'timeslidertooltipplugin-3': {}
			}
		} else if(audioView && prov == "AUDIO") {
			pluginLst = {
				'revolt-1': {},
				'timeslidertooltipplugin-3': {}
			}
		} else if(metadata){
			pluginLst = {
				'metaviewer-1': {
					'position': 'right',
					'size': '200'
				},
				'timeslidertooltipplugin-3': {}
			}
		} else {
			pluginLst = {
				'timeslidertooltipplugin-3': {}
			}
		}


var playerInstance = jwplayer("mediaplayer");
playerInstance.setup({
  playlist: lst,
  "playlist.position": playListPosition,
  "playlist.size": 385,
  height: 385,
  width: 1000,
  volume: defVolume,
  autostart: autoStart,
  repeat: autoPlay,
  provider: "http",
  skin: {
  name: "six"
  },	
			plugins: pluginLst
});
var div = document.getElementsByTagName("div");
for(var i in div) {
	if(div[i].className == "contentWrap") {
		div[i].className = "";
	}
};

var list = document.getElementById("list");
var html = list.innerHTML;

playerInstance.on('ready',function(){
var playlist = playerInstance.getPlaylist();
for (var index=0;index<playlist.length;index++){
var playindex = index +1;
list.innerHTML = html;
}

});
function playThis(index) {
playerInstance.playlistItem(index);
}
</script>
</html>
