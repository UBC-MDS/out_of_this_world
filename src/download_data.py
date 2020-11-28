"""The script downloads the data from url: http://www.nuforc.org/webreports/ndxlBC.html maintanined by National UFO Reporting Center (NUFORC) and saves it in feather format.
Currently the script deals with the reports made in British Columbia, Canada.

Usage: src/download_data.py --location=<location> --output_file=<output_file>

Options:
--location=<location>       The location code of data. For example: 'BC' for British Columbia.
--output_file=<output_file> The file name along with the path of the location to save the data

Example:
For single state location:       python src/download_data.py --location=BC --output_file=data/raw/aliens.feather
For multiple states location:    python src/download_data.py --location='BC WA' --output_file=data/raw/aliens.feather
"""

import pandas as pd
from docopt import docopt
import feather


arg = docopt(__doc__)

def main(location, output_file, supported_loc={"BC", "WA"}):
    """Downloads data from the url and saves the dataframe in feather format

    Parameters
    ===========
    location: str
        Location id(s) of the page to fetch the data. For example 'BC', 'WA'
    output_file: str
        File name along with the path for saving the data
    supported_loc: set
        Set conatains string of all supported location ids. 
    """


    loc_ids = location.split(" ")
    location_df = list()


    for loc_id in loc_ids:
        if loc_id not in supported_loc:
            raise Exception("{} location not supported. Location should be from: ".format(loc_id) + str(supported_loc))
        try:
            url = "http://www.nuforc.org/webreports/ndxl"+loc_id+".html"
            location_df.append(pd.read_html(url)[0])
        except:
            raise Exception("URL " + url + " is not reachable")


    aliens_df = pd.concat(location_df, ignore_index=True)

    if output_file.split(".")[-1] == "feather":
        try:
            feather.write_dataframe(aliens_df, output_file)
        except:
            raise NotADirectoryError(output_file + "path does not exists.")
    elif output_file.split(".")[-1] == "csv":
        try:
            aliens_df.to_csv(output_file, index=False)
        except:
            raise NotADirectoryError(output_file + "path does not exists.")
    else:
        raise Exception("File format not supported")


if __name__ == "__main__":
    main(arg["--location"], arg["--output_file"])
