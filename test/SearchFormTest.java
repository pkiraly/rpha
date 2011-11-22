import com.kirunews.rpha.struts.form.SearchForm;

import junit.framework.TestCase;


public class SearchFormTest extends TestCase {

	public void testSimple() throws Exception {
		SearchForm form = new SearchForm();
		form.setSearchType("LUCENE");
		assertEquals(SearchForm.SearchTypes.LUCENE, form.getSearchType());
		form.setSearchType("NORMAL");
		assertEquals(SearchForm.SearchTypes.NORMAL, form.getSearchType());
		form.setSearchType("LISTS");
		assertEquals(SearchForm.SearchTypes.LISTS, form.getSearchType());
		form.setSearchType("NORMAL");
		assertEquals(SearchForm.SearchTypes.NORMAL, form.getSearchType());
	}
}
