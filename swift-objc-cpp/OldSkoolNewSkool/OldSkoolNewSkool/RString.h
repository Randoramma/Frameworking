#pragma once

#include <iostream>
#include <stdlib.h>
#ifdef WINCE
#include <tchar.h>
#endif
#include <string>
#include <vector>

#ifdef SURVEYLAB_MFC_STR
#include <afx.h>
#endif

using namespace std;

namespace RString
{
	class RString
	{
	public:
		RString(void);

		~RString(void);

		/**
		* Purpose:
		* Replaces all the instances of one character with a different character
		* Parameters:
		* context: IN/OUT: String make find/replace
		* from: IN: String to look for and replace
		* to: IN: String to make replacement with
		*/
		static void replaceAll(string& context, 
			const string& from,
			const string& to);

		/**
		* Purpose:
		* Given a string converts it to a TCHAR*
		* Parameters:
		* s: IN: String to convert
		* Postconditions:
		* Returns the converted string as a TCHAR*. The user must
		* call free on TCHAR* when they are done using it.
		*/
#ifdef WINCE
		static TCHAR* stringToTChar(string s);
#endif

		/**
		* Purpose:
		* Given a TCHAR* convert it to a string.
		* Parameters:
		* t: IN: TCHAR* to convert to string
		* Postconditions:
		* Returns a string representing the passed in TCHAR*.
		*/
#ifdef WINCE
		static string tCharToString(TCHAR* t);
#endif

		/**
		* Purpose:
		* Converts integer to string.
		* Parameters:
		* i: IN: Integer to convert to string 
		* Postconditions:
		* Returns a string containing passed in integer
		*/
		static string intToString(int i);

		/**
		* Purpose:
		* Converts string to integer.
		* Parameters:
		* s: IN: string to convert to integer 
		* Postconditions:
		* Returns a integer containing passed in string
		*/
		static int stringToInt(string s);

		/**
		* Purpose:
		* Converts hex string to integer.
		* Parameters:
		* s: IN: hex string to convert to integer 
		* Postconditions:
		* Returns a integer containing passed in string
		*/
		static int stringToIntFromHex(string s);

		/**
		* Purpose:
		* Determines if string is an integer
		* Parameters:
		* s: IN: String to test for being an integer
		* Postconditions:
		* Returns true if the string is an integer. False otherwise.
		*/
		static bool isInteger(string s);


		/**
		* Purpose:
		* Determines if string is an double
		* Parameters:
		* s: IN: String to test for being an double
		* Postconditions:
		* Returns true if the string is an double. False otherwise.
		*/
		static bool isDouble(string s);

		/**
		* Purpose:
		* Determines if a string contains the other string
		* Parameters:
		* stringToSearch: IN: String to search
		* isInString: IN: String to search for in stringToSearch
		* Postconditions:
		* Returns true if the is in string is found in the string to search. False otherwise.
		*/
		static bool contains(string stringToSearch, string isInString);

		/**
		* Purpose:
		* Determine if a string is an integer within a given numeric range
		* Parameters:
		* lowerRange IN: lower limit of range
		* upperRange IN: upper limit of range
		* s: IN: string to check if it is within specified range
		* Postconditions:
		* Returns true if the string is an integer within the specified range. False otherwise.
		*/
		static bool isStringIntegerInRange(int lowerRange, int upperRange, string s);

		/**
		* Purpose:
		* Determine if a string is an double within a given numeric range
		* Parameters:
		* lowerRange IN: lower limit of range
		* upperRange IN: upper limit of range
		* s: IN: string to check if it is within specified range
		* Postconditions:
		* Returns true if the string is an double within the specified range. False otherwise.
		*/
		static bool isStringDoubleInRange(double lowerRange, double upperRange, string s);

		/**
		* Purpose:
		* Determine if a string is an integer greater than or equal to a given number
		* Parameters:
		* num IN: Number to see if string value is greater than or equal to.
		* s: IN: string to check if it is greater than or equal to the specified number
		* Postconditions:
		* Returns true if the string is an integer greater than or equal to
		* the given number. Returns false otherwise.
		*/
		static bool isStringIntegerInGreaterThanOrEqualTo(int num, string value);

		/**
		* Purpose:
		* Converts string to double.
		* Parameters:
		* s: IN: string to convert to double 
		* Postconditions:
		* Returns a double containing passed in string
		*/
		static double stringToDouble(string s);
		
		/**
		* Purpose:
		* Converts string to float.
		* Parameters:
		* s: IN: string to convert to float 
		* Postconditions:
		* Returns a float containing passed in string
		*/
		static float stringToFloat(string s);
		
		/**
		* Purpose:
		*	Converts double to string.
		* Preconditions:
		*	None
		* Parameters:
		*	d: IN: double to convert to string 
		*	precision: IN: number of decimal places to round to
		* Postconditions:
		*	Returns a string containing passed in double
		*/
		static string doubleToString(double d, int precision);
		/**
		* Purpose:
		*	Converts word to string.
		* Preconditions:
		*	None
		* Parameters:
		*	w: IN: word to convert to string 
		*	width: IN: minimum number of characters to fill to
		*	fill: IN: character to fill string with
		* Postconditions:
		*	Returns a string containing passed in word
		*/
		#ifdef WINCE
		static string wordToString(WORD w, int width, char fill);
		#endif
		/**
		* Purpose:
		* Splits a string given a character delimiter
		* Parameters:
		* strToSplit: IN: String to split
		* delim IN: Character to split on
		* Postconditions:
		* Returns a vector of strings split using the delimiter. 
		* If we do not find any delimiters we return the original string
		* in the vector.
		*/
		static vector<string> split(string strToSplit, char delim);


		/**
		* Purpose:
		* Extract a specified field from a vector of strings (typically as returned from the split method)
		* Parameters:
		* fields: vector of strings containing full set of fields to extract from
		* index: The 0 based index of the field to be extracted
		* Postconditions:
		* Returns a pointer to the extracted field, or NULL if the index is beyond the size of the vector
		*/
		static const char* getField(vector<string>& fields, unsigned int index);

#ifdef SURVEYLAB_MFC_STR
		static string cStringToString(CString& cstring);
#endif
	};

}
