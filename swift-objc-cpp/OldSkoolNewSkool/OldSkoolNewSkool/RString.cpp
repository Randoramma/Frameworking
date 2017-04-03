#include <sstream>
#include <cctype>

#include "RString.h"

#ifdef WINCE
#ifndef UNDER_CE
#include <windows.h>
#endif
#endif

namespace RString
{

	RString::RString(void)
	{
	}

	RString::~RString(void)
	{
	}

	void RString::replaceAll(string& context, const string& from,
		const string& to) 
	{
		size_t lookHere = 0;
		size_t foundHere;
		while((foundHere = context.find(from, lookHere))
			!= string::npos) 
		{
				context.replace(foundHere, from.size(), to);
				lookHere = foundHere + to.size();
		}
	} 

#ifdef WINCE
	TCHAR* RString::stringToTChar(string s)
	{
		size_t size_string = (strlen(s.c_str()) + 1);
		TCHAR *sTChar = (TCHAR*) malloc( (size_string * sizeof(TCHAR)) ); //TCHARS are double wide!
		mbstowcs(sTChar, s.c_str(), size_string);

		return(sTChar);
	}

	string RString::tCharToString(TCHAR* t)
	{
		DWORD dataSize = (wcslen( t ) + 1);
		char *tChArray = ( char* )malloc( dataSize * sizeof ( char ) );
		wcstombs( tChArray, ( LPCTSTR )t, dataSize );
		string s (tChArray);
		free( tChArray );

		return(s);
	}
#endif


#ifdef SURVEYLAB_MFC_STR
	string RString::cStringToString(CString& cstring)
	{
		string s = (CStringA(cstring));

		return s;
	}
#endif

	bool RString::contains(string stringToSearch, string isInString)
	{
		bool contains = false;
		string::size_type loc = stringToSearch.find( isInString);
		if( loc == string::npos ) 
		{
			//Did not find
			contains = false;
		}
		else
		{
			//Found 
			contains = true;
		}

		return contains;
	}

	bool RString::isDouble(string s)
	{
		double d;
		bool success;
		istringstream myStream(s);

		if (myStream >> d)
		{
			success = true;
		}
		else
		{
			success = false;
		}

		return(success);
	}

	bool RString::isInteger(string s)
	{
		bool isInt = true;
		unsigned int i = 0;
		if(s.length() >= 1)
		{
			//First char can be "-" or a digit
			if( ( isdigit(s.at(0)) == 0) && (s.at(0) != '-') )
			{
				isInt = false;
			}
			else
			{
				// true
			}

			for(i = 1; i < s.length(); i++)
			{
				if( isdigit(s.at(i)) == 0 )
				{
					isInt = false;
				}
				else
				{
					// true
				}
			}
		}
		else
		{
			isInt = false;
		}

		return(isInt);
	}

	bool RString::isStringDoubleInRange(double lowerRange, double upperRange, string s)
	{
		bool isStringANumberInGivenRange = false;

		if(isDouble(s) == true)
		{
			double d;
			istringstream myStream(s);
			myStream >> d;
			if( (d >= lowerRange) && (d <= upperRange))
			{
				isStringANumberInGivenRange = true;
			}
			else
			{
				// false
			}
		}
		else
		{
			// false
		}

		return(isStringANumberInGivenRange);
	}

	bool RString::isStringIntegerInRange(int lowerRange, int upperRange, string s)
	{
		bool isStringANumberInGivenRange = false;

		if(isInteger(s) == true)
		{
			int i;
			istringstream myStream(s);
			myStream >> i;
			if( (i >= lowerRange) && (i <= upperRange))
			{
				isStringANumberInGivenRange = true;
			}
			else
			{
				// false
			}
		}
		else
		{
			// false
		}

		return(isStringANumberInGivenRange);
	}

	bool RString::isStringIntegerInGreaterThanOrEqualTo(int num, string value)
	{
		bool isStringAnIntegerInGreaterThanOrEqualTo = false;

		if(isInteger(value) == true)
		{
			int i;
			istringstream myStream(value);
			myStream >> i;
			if( i >= num ) 
			{
				isStringAnIntegerInGreaterThanOrEqualTo = true;
			}
			else
			{
				// false
			}
		}
		else
		{
			// false
		}

		return(isStringAnIntegerInGreaterThanOrEqualTo);
	}

	string RString::intToString(int i)
	{
		stringstream ss;

		ss << i;

		return ss.str();
	}
	
	float RString::stringToFloat(string s)
	{
		float f;
		stringstream ss;
		ss << s;
		ss >> f;

		return(f);
	}
	
	int RString::stringToInt(string s)
	{
		int i;
		stringstream ss;
		ss << s;
		ss >> i;

		return(i);
	}

	int RString::stringToIntFromHex(string s)
	{
		int i;
		stringstream ss;
		ss.setf(ios::hex,ios::basefield);

		ss << s;
		ss >> i;

		ss.setf(ios::dec,ios::basefield);

		return(i);
	}

	double RString::stringToDouble(string s)
	{
		double d;
		stringstream ss;
		ss << s;
		ss >> d;

		return(d);
	}
	
	string RString::doubleToString(double d, int precision)
	{
		stringstream ss;
		ss.setf(ios::fixed, ios::floatfield);
		ss.precision( precision );
		ss << d;
		return (ss.str());
	}

#ifdef WINCE
	string RString::wordToString(WORD w, int width, char fill)
	{
		stringstream ss;
		ss.width(width);
		ss.fill(fill);

		ss << w;

		return ss.str();
	}
#endif

	#pragma warning(disable: 4786)
	vector<string> RString::split(string strToSplit, char delim)
	{

		vector<string> result;
		string strToProcess (strToSplit);

		//find first occurrance of delimiter
		int delimPosition;
		delimPosition = (int)strToProcess.find_first_of( delim, 0 );

		while(delimPosition != string::npos)
		{
			//Copy portion of string before delim into result vector
			string sub = strToProcess.substr(0, delimPosition );
			result.push_back( sub );

			//erase process part of string
			strToProcess.erase( 0, ( delimPosition + 1 ) );

			//look for next delim
			delimPosition = (int)strToProcess.find_first_of( delim, 0 );
		}

		//deal with the case where we don't find any delims
		//Return the original string
		//And the last bit after a delim 
		if(delimPosition == string::npos)
		{
			result.push_back( strToProcess );
		}
		else
		{
			// Ok
		}

		return(result);

	}
#pragma warning(default: 4786) 

	const char* RString::getField(vector<string>& fields, unsigned int index)
	{
		const char* result = NULL;

		if(index < fields.size())
		{
			result = fields.at(index).c_str();
		}
		else
		{
			// Index is greater than number of fields provided.
		}

		return result;
	}
}
