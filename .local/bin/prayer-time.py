import argparse
import aladhan

# Create an ArgumentParser object
parser = argparse.ArgumentParser()

# Define positional arguments
parser.add_argument('country')
parser.add_argument('city')

# Parse the arguments
args = parser.parse_args()

location = aladhan.City(f'{args.city}', f'{args.country}') 
client = aladhan.Client(location)

adhans = client.get_today_times()

print(f"Today's Prayer Times for {args.city}, {args.country}")
print("======================================")
for adhan in adhans:
    print("{: <15} | {: <15}".format(adhan.get_en_name(), adhan.readable_timing(show_date=False)))
