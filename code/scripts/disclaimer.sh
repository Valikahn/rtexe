#!/bin/bash
clear

##########################
##  DISCLAIMER MESSAGE  ##
##########################
echo "${red}WARNING:  DISCLAIMER - PLEASE READ!!!${clear}"
echo
echo "${green}This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License${clear}"
echo "${green}as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.${clear}"
echo
echo "${yellow}THE SOFTWARE IS PROVIDED ${red}AS IS${clear}${yellow}, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES${clear}"
echo "${yellow}OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS${clear}"
echo "${yellow}BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT${clear}"
echo "${yellow}OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.${clear}"
echo

echo "Do you agree with the discalimer statement above? [y,n]"
read disc

if [ "$disc" == "" ]; then
	clear
	echo "Invalid entry by user...Terminating program..."
	sleep 5
	exit
		
elif [[ "$disc" == "y" ]] || [[ "$disc" == "yes" ]]; then

	clear
	agreedisc=1
	echo "Thank you..."
	echo "Please wait while you're redirected..."
	sleep 5
fi