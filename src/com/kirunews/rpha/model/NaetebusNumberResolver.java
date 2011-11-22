package com.kirunews.rpha.model;

import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;

/**
 * Resolve Naetebus number and rhyme scheme
 * @author kiru
 */
public class NaetebusNumberResolver {
	
	/**
	 * The map is a hash for Naetebus's number and rhyme scheme
	 */
	private static Map<String, String> map = new HashMap<String, String>();

	private static Map<String, String> schemes = new HashMap<String, String>();

	static {
		map.put("I.",       "12aaaaaaaaaaaaaaaaaaaa");
		map.put("II.",      "12aaaaaaaaaa");
		map.put("III.",     "7aaaaaa");
		map.put("IV.",      "10aaaaa");
		map.put("V.",       "12aaaaa"); 
		map.put("VI.",      "8aaaa");
		map.put("VII.",     "10aaaa");
		map.put("VIII.",    "12aaaa"); 
		map.put("IX.",      "12aaaa=6abababab");
		map.put("X.",       "14aaaa");
		map.put("XI.",      "16aaaa");
		map.put("XII.",     "16aaaa=8abababab");
		map.put("XIII.",    "12aaaaB (B refrénsor)");
		map.put("XIV.",     "8aaaa4b12b");
		map.put("XV.",      "12aaaabβ (ahol β változó refrén)");
		map.put("XVI.",     "8aaaabbbb");
		map.put("XVII.",    "12aaaabbbbb");
		map.put("XVIII.",   "10aaaabbbcc");
		map.put("XIX.",     "14aaaaB=6a8b6a8b6a8c6a8c14D");
		map.put("XX.",      "6aaa");
		map.put("XXI.",     "12aaa");
		map.put("XXII.",    "8a4a4a8b8a4a4a8b8b8a4b4b8a");
		map.put("XXIII.",   "8aaabcccb");
		map.put("XXIV.",    "4aabaab");
		map.put("XXV.",     "6aa5β6aa5β (ahol β változó refrén, Salamon és Markalf párbeszédénél a beszélő megnevezése az általa mondott kétsoros bölcsesség után)");
		map.put("XXVI.",    "6aabaab");
		map.put("XXVII.",   "8aa4b8aa4b");
		map.put("XXVIII.",  "8aa6b8aa6b");
		map.put("XXIX.",    "8aabaab");
		map.put("XXX.",     "5aabaab7babab");
		map.put("XXXI.",    "7aabaabbabab");
		map.put("XXXII.",   "8aabaabbabab");
		map.put("XXXIII.",  "10aabaabbabab");
		map.put("XXXIV.",   "5aabaabbbabba");
		map.put("XXXV.",    "6aabaabbbabba");
		map.put("XXXVI.",   "8aabaabbbabba");
		map.put("XXXVII.",  "12aabaabbbabba");
		map.put("XXXVIII.", "6aabaabC");
		map.put("XXXIX.",   "8aa6b8aa6b8c6d8c6d");
		map.put("XL.",      "8aabb");
		map.put("XLI.",     "10aabb");
		map.put("XLII.",    "12aabb");
		map.put("XLIII.",   "8Γaabb (ahol Γ olyan kezdő refrénsor, ami idézet (egy teológiai, talán bibliai idézet (téma az Utolsó Ítélet) francia fordítása, aminek mindig kommentárja a következő négy sor)");
		map.put("XLIV.",    "8aabbcc");
		map.put("XLV.",     "8ααbbcc (ahol α változó refrén)");
		map.put("XLVI.",    "8aabbccdd");
		map.put("XLVII.",   "8ααbbccdd");
		map.put("XLVIII.",  "8aabbccdD (D állandó refrén)");
		map.put("XLIX.",    "8aabbccddee");
		map.put("L.",       "10aabbccddee");
		map.put("LI.",      "8aabbccddeeff");
		map.put("LII.",     "8aabbccddeefF");
		map.put("LIII.",    "12aabbccddeeffgg");
		map.put("LIV.",     "8aabbccddeeeeffgghhii");
		map.put("LV.",      "8aabbccddeeffgghhiikk (sic !)");
		map.put("LVI.",     "8aabbccddeeffgghhiikkllmmnnoo");
		map.put("LVII.",    "8aabbccddeeffgghhiikkllmmnnooppqqrrss");
		map.put("LVIII.",   "6aabbcddeec");
		map.put("LIX.",     "4aabccb");
		map.put("LX.",      "4aa6b4cc6b");
		map.put("LXI.",     "5aabccb");
		map.put("LXII.",    "6aabccb");
		map.put("LXIII.",   "8aa4b8cc4b");
		map.put("LXIV.",    "8aa6b8cc6b");
		map.put("LXV.",     "8aabccb");
		map.put("LXVI.",    "6aabccbD (D refrén)");
		map.put("LXVII.",   "8aabccbδδβεεβ (8 versszakból csak a 2-7-ben van meg a refrén, a többiben más a szöveg a strófa második, görög betűs részében, de azonos a szerkezet. A b rím pedig állandó.)");
		map.put("LXVIII.",  "5aabγddbγ (ez is Salamon és Markalf, váltakozó refrénekkel)");
		map.put("LXIX.",    "8a6b8a6b");
		map.put("LXX.",     "8abab");
		map.put("LXXI.",    "12abab");
		map.put("LXXII.",   "7abababab");
		map.put("LXXIII.",  "8abababab");
		map.put("LXXIV.",   "10abababab");
		map.put("LXXV.",    "8abababab2c14c");
		map.put("LXXVI.",   "8ababbab");
		map.put("LXXVII.",  "8ababbaba");
		map.put("LXXVIII.", "8ababbcbc");
		map.put("LXXIX.",   "8ababbcc");
		map.put("LXXX.",    "10ababbcc");
		map.put("LXXXI.",   "5abab10bccc");
		map.put("LXXXII.",  "8ababb4c8cc");
		map.put("LXXXIII.", "7ababccdd");
		map.put("LXXXIV.",  "8ababccdd");
		map.put("LXXXV.",   "Különböző strófaszerkezetet tartalmazó művek");
		map.put("LXXXVI.",  "A drámairodalom strófaszerkezetei");
		
		for(Entry<String, String> i : map.entrySet()) {
			schemes.put(i.getValue(), i.getKey());
		}
	};
	
	public static String get(String neatebusNumber) {
		return map.get(neatebusNumber);
	}

	public static String getCode(String rhymeScheme) {
		return schemes.get(rhymeScheme);
	}
}
