#!/bin/bash
clear

##########################
##  DISCLAIMER MESSAGE  ##
##########################
echo "WARNING:  DISCLAIMER - PLEASE READ!!!"
echo
echo "This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version."
echo
echo "THE SOFTWARE IS PROVIDED AS IS$, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE."
echo

confirm() {
    # call with a prompt string or use a default
    read -r -p "${Are you sure? [y/N]} " disc
    case "$disc" in
        [nN][oO][nN]) 
            echo "Invalid entry by user...Terminating program..."
	        sleep 5
			exit 1
	        ;;
        *)
            agreedisc=1
			echo "Thank you..."
			echo "Please wait while you're redirected..."
			sleep 5
            ;;
    esac
}
