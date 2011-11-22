import java.util.regex.Matcher;
import java.util.regex.Pattern;

import junit.framework.TestCase;


public class AttributeRegexTest extends TestCase {
	private static Pattern subFieldPattern = Pattern.compile("<(v\\d+)(( (.+?)=\"(.*?)\")+)/>");
	private static Pattern attributePattern = Pattern.compile("^ (.+?)=\"(.*?)\"");

	public void testAttributePattern() {
		String field = "<v51 value=\"29:0658/1  P:0052\" forrasTipusKod=\"29\" itemMainId=\"0658\"" +
				" itemSubnote=\"/\" itemSubId=\"1\" page=\"0052\" pageSubnote=\"\"" +
				" pageSubid=\"\" v101=\"RMK1\" itemId=\"06581\"/>";
		Matcher m = subFieldPattern.matcher(field);
		if(m.find()){
			System.out.println(m.group(1));
			System.out.println(m.group(2));
			String attributes = m.group(2);
			int prevLength = 0;
			while(attributes.length() > 0 && prevLength != attributes.length()) {
				prevLength = attributes.length();
				
				System.out.println(attributes);
				m = attributePattern.matcher(attributes);
				if(m.find()) {
					System.out.println(m.group(1) + "=" + m.group(2));
					int i = m.end();
					System.out.println(m.end());
					attributes = attributes.substring(i);
				}
			}
		}
		
	}
}
