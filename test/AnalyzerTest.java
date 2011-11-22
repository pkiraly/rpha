import java.io.IOException;

import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.SimpleAnalyzer;
import org.apache.lucene.analysis.StopAnalyzer;
import org.apache.lucene.analysis.WhitespaceAnalyzer;
import org.apache.lucene.analysis.standard.StandardAnalyzer;

import com.kirunews.rpha.util.DigitAnalyzer;

import junit.framework.TestCase;

public class AnalyzerTest extends TestCase {
	private static Analyzer[] analyzers = new Analyzer[] {
		new WhitespaceAnalyzer(),
		new SimpleAnalyzer(),
		new StopAnalyzer(),
		new StandardAnalyzer(),
		new DigitAnalyzer(),
	};

	public void testDifferentAnalyzers() throws IOException {
		String[] examples = {
			"Ps  31= 32",
			"AH,52,3",
			"001,010,100",
		};
		
		for (int i = 0; i < examples.length; i++) {
			analyzeDiff(examples[i]);
		}
	}

	private static void analyzeDiff(String text) throws IOException {
		System.out.println("Analyzing \"" + text + "\"");
		for (int i = 0; i < analyzers.length; i++) {
			Analyzer analyzer = analyzers[i];
			String name = analyzer.getClass().getName();
			name = name.substring(name.lastIndexOf(".") + 1);
			System.out.println(" " + name + ":");
			System.out.print(" ");
			AnalyzerUtils.displayTokens(analyzer, text);
			System.out.println("\n");
		}
	}
}
