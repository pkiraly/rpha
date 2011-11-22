import com.kirunews.rpha.model.FrankNumberResolver;

import junit.framework.TestCase;


public class FrankTest extends TestCase {

	public void testFrank() throws Exception {
		assertEquals("aaaaaa", FrankNumberResolver.get(Integer.valueOf(3)));
		assertEquals("aaaaaa", FrankNumberResolver.get(3));
		assertEquals(Integer.valueOf(3), FrankNumberResolver.get("aaaaaa"));
		assertEquals(null, FrankNumberResolver.get(300));
	}
}
