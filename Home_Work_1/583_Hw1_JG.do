*Author: John Geissberger Jr. 
*Course: Econometrics 583
*Assignment: HW #1.
*Version Stata: 15.0


**This do file will produce solutions to homework #1. HW1 Seeks to ensure that students are familiar 
**with the stata commands neccessary to produce a random set of observations. 
**and seeks to illustrate the CLT Theorem and it's result. 

**Question #1 - Code Below. Comments detail stata commands for individuals who are
**unfamilar with Stata. 

**quietly command ensures that no output is sent to the terminal while the 
** following command is executing. Set is a general command that allows one
** to set certain parameters of a given system or a partiucular function. 

quietly set obs 30 

**Set seed simply sets the seed of the random number generator. 
set seed 10101

**Generate creates a new variable. In this particular case, a variable,x,
**will be created which will be set equal to a random number between the values 
**of (0,1)
generate x=runiform()

**Summarize will produce summary statistics and output a table to the Stata
**terminal for a given variable.
summarize x

** Question 1: Part a. What is the sample mean? 
** Answer: This code will produce a sample mean of x_bar =  .380269 

**histogram will produce a histogram for the variable x. 
quietly histogram x, width(0.1) xtitle(”x from one sample”)

** Question 1: Part b. Does the historgram look like a bell-shaped curve of 
** a normal distribution?

** Answer: No. The histogram produced does not look like a normal bell-shaped curve. 
**The distribution is close to being bi-modal and is not symmetric. 

**Question 2 - Attempts to illustrate the Central Limit Theorem's power.
**In order to illustrate the power of the Central Limit Theorem one will need
**to generate some random samples. In addition, for this specific assignment
**One will need to generate 10,000 random samples. 

**The code below will produce 10,000 random samples. 

** Question #2 - Code Below 

**The program command allows for one to write a function in stata. 
**Stata will run the commands that begin after the program command 
**all the way up to the end command. 

**rclass - dictates that results will be returned in r(). Therefore, some of
**the information received can be accessed later in r().

** When the command For summarize is ran typically a table will be outputed 
** detaling the summary statistics for that given variable.
** In addition, to that Stata will also save some of those values. 
** Since we have dicataed that those values be stored in r() one 
** can retrieve the mean of each sample and set it equal to 
** a scalar as shown by the command - return scalar meanforonesample = r(mean)

 program onesample, rclass 
	drop _all
	quietly set obs 30
	generate x = runiform() 
	summarize x
	return scalar meanforonesample = r(mean)
 end

 ** Now one will need to run this program, onesample, a total of 10,000
 ** times. The simulate command will exectue this. 
 ** Within the simulate command a variable, xbar, is being set 
 ** equal to the mean from the sample. The argument within 
 ** reps() determines how many times the program one sample will be ran. 
 ** nodots suppresses dots during calculation. 
 ** Lastly, :onesample ensures that the simulate command will run the 
 ** onesample program defined above.
 
 simulate xbar = r(meanforonesample),seed(10101)reps(10000)nodots:onesample
 
 ** As a result, xbar should be a vector with length 10,000 and each 
 ** entry should be a mean from each of the 10,000 iterations from 
 ** running the onesample program. 
 summarize xbar
 
 ** Lastly, one can create a histrogram of the sample means and 
 ** determine if the Central Limit Theorem holds for the uniform 
 ** distribution. This code should produce a bell-shaped curve, which
 ** looks like a normal distribution. 
 
 quietly histogram xbar, normal xtitle(”xbar from many samples”)
 
** Question #2: Part (a) - What is the value of the mean and variance ?

** Answer: This code should produce a mean of .499825 and a std dev = .0521404
** Thus, the variance is = .0521404^2 = 0.00271862131

** Question #2: Part (b) - Does it look like a normal distribution? How do explain this result?

** Answer: Yes, the histogram produced for Question two looks like a normal distribution. 
** This result was produced due to a large enough sample size and the other assumptions
** of the CLT Theorem holding true. Since the assumptions of the theorem held the outcome of 
** the thoerm could be produced. 

** The CLT assumes that a particular distribution is iid and that the 
** distribution has a finite mean and a finite variance. 
** The CLT then states that as random samples from a distribution 
** increase, n-> infinity, the distribution of the sample mean can be,
** approximated by the normal distribution and will approach the normal distribution. 
** However, one crucial apsect of this theorem is that the sample size n
** must be large enough in order for the theorem to hold. 
 
 
