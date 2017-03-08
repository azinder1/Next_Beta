var ajaxRequest;
var plotlist;
var plotlayers=[];
var polygon;
var marker = L.marker();
var coordinates
var featureLayer
var map

function initmap() {
	ajaxRequest=getXmlHttpObject();
	if (ajaxRequest==null) {
		alert ("This browser does not support HTTP Request");
		return;
	}
	var mapboxUrl = "https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoiYXppbmRlcjEiLCJhIjoiY2l6cnpsOTFsMDBjNDJ3bDl6azg0Z3dtNCJ9.GqnT7UDxuTaMux4WBs-39Q";

	var attribution ='Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, ' +
			'<a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, ' +
			'Imagery © <a href="http://mapbox.com">Mapbox</a>';


	var outdoorsLayer = L.tileLayer(mapboxUrl, {
		maxZoom: 23,
		attribution: attribution,
		id: 'mapbox.outdoors'
	});

	var satelliteLayer = L.tileLayer(mapboxUrl, {

		maxZoom: 19,
		attribution: attribution,
		id: 'mapbox.satellite'
	});

	var lightLayer = L.tileLayer(mapboxUrl, {
		maxZoom: 23,
		attribution: attribution,
		id: 'mapbox.light'
	});

	var osmLayer = L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
		maxZoom: 23,
		attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors',
		id: 'mapbox.light'
	});

	//TODO: add the ability to center map from script to support search
	 map = L.map("map", {
			center: [41.77131167976407, -103.00781250000001],
			zoom: 5,
			layers: [outdoorsLayer, satelliteLayer, osmLayer, lightLayer]});

	var tileLayers = {
			"OpenStreetMap": osmLayer,
			"Light": lightLayer,
			"Satellite": satelliteLayer,
			"Topo (3m resolution)": outdoorsLayer
			};

	L.control.layers(tileLayers, null, {position: 'topleft'}).addTo(map);
	L.control.scale().addTo(map);
	var myLayer = L.mapbox.featureLayer()
	  .loadURL('/routes.json')
	  .on('ready', function() {
	    myLayer.eachLayer(function(layer) {
	      map.fitBounds(myLayer.getBounds());
	      layer.bindPopup('<p>Name:' + layer.feature.properties.title + '</p> <p>Rating:'+layer.feature.properties.rating+'</p><a href="/coordinates/'+layer.feature.properties.id + '"'+ '>See Details</a>');
	    });
	  })
	  .addTo(map);

	map.on('click', onMapClick);
}


function getXmlHttpObject() {
	if (window.XMLHttpRequest) { return new XMLHttpRequest(); }
	if (window.ActiveXObject)  { return new ActiveXObject("Microsoft.XMLHTTP"); }
	return null;
}



function onMapClick(e) {
	lat = e.latlng.lat.toString();
	lng = e.latlng.lng.toString();
		$("input#coordinate_lat").val(lat);
		$("input#coordinate_lng").val(lng);


    marker
        .setLatLng(e.latlng)
        .addTo(map);
}