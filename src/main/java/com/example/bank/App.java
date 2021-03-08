package com.example.bank;

/**
 * Hello world!
 *
 */
public class App 
{
    public static void main( String[] args )
    {
        System.out.println( "Hello World!" );
        double result = SimpleInterest.calculateSimpleInterest(10000, 5, 7);
        System.out.println("The simple interest is:" + result); 
        
    }
    public static double calculateSimpleInterest(double amount,
            double years,
            double rate_of_interest) {
        double simple_interest;
        simple_interest = amount * years * rate_of_interest;
        return simple_interest;
    } 
    
          
    
    
}
