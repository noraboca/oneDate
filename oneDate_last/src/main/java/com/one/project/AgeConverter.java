package com.one.project;

import java.util.Calendar;

public class AgeConverter {

	public int getAge(String timestamp) {
		String[] arr = timestamp.split("-");
		String[] arr2 = arr[2].split(" ");	
		
		int birthYear = Integer.parseInt(arr[0]);
		int birthMonth = Integer.parseInt(arr[1]);
		int birthDay = Integer.parseInt(arr2[0]);
	
		 Calendar current = Calendar.getInstance();
	        int currentYear  = current.get(Calendar.YEAR);
	        int currentMonth = current.get(Calendar.MONTH) + 1;
	        int currentDay   = current.get(Calendar.DAY_OF_MONTH);
	      
	        int age = currentYear - birthYear;
	        // 생일 안 지난 경우 -1
	        if (birthMonth * 100 + birthDay > currentMonth * 100 + currentDay) 
	            age--;
	      

		return age;
	}
}
