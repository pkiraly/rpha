import java.util.Calendar;
import java.util.Date;

import junit.framework.TestCase;


public class DateTest extends TestCase {
	public void testDate() {
		Date date = new Date();
		System.out.println(date.getHours());
	}

	public void testCalendar() {
		int hour = Calendar.getInstance().get(Calendar.HOUR_OF_DAY);
		System.out.println(hour);
	}

	public void testDateUtil() {
		String time = DateUtil.getTime();
		System.out.println(time);
	}
}

class DateUtil {
	public static String getTime() {
		int h = Calendar.getInstance().get(Calendar.HOUR_OF_DAY);
		int m = Calendar.getInstance().get(Calendar.MINUTE);
		int s = Calendar.getInstance().get(Calendar.SECOND);
		int l = Calendar.getInstance().get(Calendar.MILLISECOND);
		return h + ":" + m + ":" + s + "." + l; 
	}
}