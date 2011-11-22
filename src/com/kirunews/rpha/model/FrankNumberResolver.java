package com.kirunews.rpha.model;

import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;

/**
 * Resolve Frank number and rhyme scheme
 * @author kiru
 */
public class FrankNumberResolver {
	
	/**
	 * The map is a hash for Frank's number and rhyme scheme
	 */
	private static Map<Integer, String> map = new HashMap<Integer, String>();

	private static Map<String, Integer> reversedMap = new HashMap<String, Integer>();

	static {
		map.put(  1, "aaa");
		map.put(  2, "aaaaa");
		map.put(  3, "aaaaaa");
		map.put(  4, "aaaaaaa");
		map.put(  5, "aaaaaaaa");
		map.put(  6, "aaaaaaaaa");
		map.put(  7, "aaaaaaaaaa");
		map.put(  9, "aaaaaaaaaaaa");
		map.put( 27, "aaaabb");
		map.put( 31, "aaaabbb");
		map.put( 32, "aaaabbbb");
		map.put( 62, "aaabb");
		map.put( 63, "aaabba");
		map.put( 71, "aaabbbb");
		map.put(130, "aabb");
		map.put(161, "aabbcc");
		map.put(168, "aabbccdd");
		map.put(193, "aabccb");
		map.put(196, "aabccbddb");
		map.put(421, "ababcddc");
		
		for(Entry<Integer, String> i : map.entrySet()) {
			reversedMap.put(i.getValue(), i.getKey());
		}
		
	};
	
	public static String get(Integer frankNumber) {
		return map.get(frankNumber);
	}

	public static Integer get(String rhymeScheme) {
		return reversedMap.get(rhymeScheme);
	}
}
