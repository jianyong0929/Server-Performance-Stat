#!/bin/ash

print_header(){
	echo "============================================================"
	echo " $1"
	echo "============================================================"
	echo ""
}

print_header "Server Performance Stats"
echo "Date: $(date)"
echo ""

print_header "CPU Usage"
cpu_usage=$(top -bn1 | grep "CPU:" | head -1 | awk '{print$2 + $4}')
echo "Total CPU Usage:  ${cpu_usage}%"
echo

print_header "Memory Usage"
mem_total=$(free -m | awk '/Mem:/ {print $2}')
mem_used=$(free -m | awk '/Mem:/ {print $3}')
mem_free=$(free -m | awk '/Mem:/ {print $4}')
mem_percent=$(echo "scale=2; ($mem_used*100/$mem_total)" | bc)
mem_free_percent=$(echo "scale=2; ($mem_free*100/$mem_total)" | bc)
echo "Total: ${mem_total}MB"
echo "Used: ${mem_used}MB"
echo "Free: ${mem_free}MB"
echo "Usage: ${mem_percent}%"
echo "Free (%): ${mem_free_percent}%"
echo

print_header "Top 5 Processes by CPU:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6 | tail -n 5
echo

print_header "Top 5 Processes by Memories:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6| tail -n 5
echo





