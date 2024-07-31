# BIDS-CITATIONS

This repository contains a Bash and a Python script to maintain a list of citations to the BIDS reference papers for the various modalities.

It is based on the corresponding code in <https://github.com/fieldtrip/automation>, which (using Jekyll) is used to maintain a list of all open-access publications on <https://www.fieldtriptoolbox.org/citations/> and to highlight the 5 most recent publications on the FieldTrip homepage <https://www.fieldtriptoolbox.org/#recent-citations>.


## Installation

Set up a new conda environment

    conda create -n=citations python=3.10
    conda activate citations

Install the required packages 

    pip install requests
    pip install PyYAML

Run the update script

    update-citations.sh
