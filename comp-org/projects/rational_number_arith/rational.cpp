#include "rational.hpp"

void Rational::Rational(Rational a, Rational b)
{

}
Rational Rational::operator +(Rational &a)
{
	return a;
}
Rational Rational::operator -(Rational &a)
{
	return a;
}
Rational Rational::operator /(Rational &a)
{
	return a;
}
Rational Rational::operator *(Rational &a)
{
	return a;
}



int Rational::getNum1(int n){ this->num1 = n; }
int Rational::getNum2(int n){ this->num2 = n; }
int Rational::getDenom1(int n){ this->denom1 = n; }
int Rational::getDenom2(int n){ this->denom2 = n; }
int Rational::getNumResult(int n){ this->numResult = n; }
int Rational::getDenomResult(int n){ this->denomResult = n; }

	// Getters
int Rational::getNum1(void){ return this->num1; }
int Rational::getNum2(void){ return this->num2; }
int Rational::getDenom1(void){ return this->Denom1; }
int Rational::getDenom2(void){ return this->Denom2; }
int Rational::getNumResult(void){ return this->numResult; }
int Rational::getDenomResult(void){ return this->numDenomResult; }
