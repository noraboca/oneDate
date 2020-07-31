package com.one.project;

import java.io.IOException;

import com.google.maps.GeoApiContext;
import com.google.maps.GeocodingApi;
import com.google.maps.errors.ApiException;
import com.google.maps.model.GeocodingResult;

public class GoogleGeoCoder {

	private static GeoApiContext context = new GeoApiContext.Builder()
			.apiKey("AIzaSyBgEkGa5dzNBnqG2aUboII1QQnNiIEYAx0")
			.build();

	
	public static double calcDistance(String address1, String address2) { 
//			throws ApiException, InterruptedException, IOException, ArrayIndexOutOfBoundsException, NullPointerException {
		GeocodingResult[] geoResult1 = null;
		GeocodingResult[] geoResult2 = null;
		try {
			geoResult1 = GeocodingApi.geocode(context,address1).await();
			geoResult2 = GeocodingApi.geocode(context,address2).await();

			
		} catch (ApiException | InterruptedException | IOException | ArrayIndexOutOfBoundsException | NullPointerException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		double x1 = geoResult1[0].geometry.location.lat;
		double y1 = geoResult1[0].geometry.location.lng;
		
		double x2 = geoResult2[0].geometry.location.lat;
		double y2 = geoResult2[0].geometry.location.lng;
		double result = distance(x1, y1, x2, y2, "km");
		
		return result;
	}
	
	private static double distance(double lat1, double lon1, double lat2, double lon2, String unit) {

		double theta = lon1 - lon2;
		double dist = Math.sin(deg2rad(lat1)) * Math.sin(deg2rad(lat2)) 
				+ Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) * Math.cos(deg2rad(theta));

		dist = Math.acos(dist);
		dist = rad2deg(dist);
		dist = dist * 60 * 1.1515;

		if (unit == "km") {
			dist = dist * 1.609344;
		} else if(unit == "m"){
			dist = dist * 1609.344;
		}

		return (dist);
	}


	// This function converts decimal degrees to radians
	private static double deg2rad(double deg) {
		return (deg * Math.PI / 180.0);
	}

	// This function converts radians to decimal degrees
	private static double rad2deg(double rad) {
		return (rad * 180 / Math.PI);
	}
}
