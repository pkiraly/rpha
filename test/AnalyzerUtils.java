import java.io.IOException;
import java.io.StringReader;
import java.util.ArrayList;

import junit.framework.Assert;

import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.Token;
import org.apache.lucene.analysis.TokenStream;

public class AnalyzerUtils {
	public static Token[] tokensFromAnalysis(Analyzer analyzer, String text) throws IOException {
		TokenStream stream = analyzer.tokenStream("contents", new StringReader(text));
		ArrayList<Token> tokenList = new ArrayList<Token>();
		while (true) {
			Token token = stream.next();
			if (token == null) break;
			tokenList.add(token);
		}
		return (Token[]) tokenList.toArray(new Token[0]);
	}

	public static void displayTokens(Analyzer analyzer, String text) throws IOException {
		Token[] tokens = tokensFromAnalysis(analyzer, text);
		for (int i = 0; i < tokens.length; i++) {
			Token token = tokens[i];
			System.out.print("[" + token.termText() + "] ");
		}
	}
	
	public static void displayTokensWithFullDetails(Analyzer analyzer, 
			String text) throws IOException {
		Token[] tokens = tokensFromAnalysis(analyzer, text);
		displayTokenWithFullDetails(tokens);
	}

	public static void displayTokenWithFullDetails(Token[] tokens) throws IOException {

		int position = 0;
		for (int i = 0; i < tokens.length; i++) {
			Token token = tokens[i];
			int increment = token.getPositionIncrement();
			if (increment > 0) {
				position = position + increment;
				System.out.println();
				System.out.print(position + ": ");
			}
			System.out.print("[" + token.termText() + ":" 
					+ token.startOffset() + "->" 
					+ token.endOffset() + ":" 
					+ token.type() + "] ");
		}
	}
	
	public static boolean assertTokensEqual(Token[] tokens, String[] strings) {
		Assert.assertEquals(strings.length, tokens.length);
		for (int i = 0; i < tokens.length; i++) {
			Assert.assertEquals("index " + i, strings[i], tokens[i].termText());
		}
		return true;
	}

}
