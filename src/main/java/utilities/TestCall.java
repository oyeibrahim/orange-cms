package utilities;

public class TestCall {
	
	int count = 0;
	
	public void Prime() {
		UtilityMethods um = new UtilityMethods();
		String tempCode = um.getRandomAlphaNumericString(7).toUpperCase();
		System.out.println(tempCode);
		count++;
	}


}
