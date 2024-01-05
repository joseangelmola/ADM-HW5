#!/bin/bash

## Node Connector
# I considered as important connectors among the nodes those that had as input and output references a length greater than 15.
# To do this I selected with the command 'select' the column of references and evaluated the length for each ID.
# After doing this I counted all the IDs thathad the length of the incoming and outgoing references greater than 15
connector_count=$(cat citation_graph.txt | jq -r 'map(select(.references | length > 15)) | length')
echo "Number of nodes acting as important connectors: $connector_count"


## Degree of Citation
# As for the degree of citation I calculated the average of the degrees there are for each ID by going to fill the sum variable and then dividing it by the total
average_degree=$(cat citation_graph.txt | jq -r '.[] | "\(.id) \(.references | length)"' | awk '{sum += $2} END {print sum/NR}')
echo "Average Degree of Citation: $average_degree"


## Average Shortest Path Length
# Extract IDs and references from the JSON file
ids=$(cat citation_graph.txt | jq -r '.[] | .id')
references=$(cat citation_graph.txt | jq -r '.[] | .references | .[]')

# Combine IDs and references into a list
all_nodes=$(echo -e "$ids\n$references")

# Count the total number of nodes
total_nodes=$(echo "$all_nodes" | sort -u | wc -l)

# Calculate the approximate average length
average_length=$((total_nodes / 2))

# Print the approximate average shortest path length
echo "Approximate average shortest path length: $average_length"