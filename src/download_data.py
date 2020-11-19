"""The script downloads the data from url: http://www.nuforc.org/webreports/ndxlBC.html maintanined by National UFO Reporting Center (NUFORC) and saves it in feather format.
Currently the script deals with the reports made in British Columbia, Canada.

Usage: src/download_data.py --output_file=<output_file>

Options:
--output_file=<output_file> The file name along with the path of the location to save the data

Example:
python src/download_data.py --output_file=data/raw/aliens.feather
"""

import pandas as pd
from docopt import docopt
import feather


arg = docopt(__doc__)

def main(output_file, url_path="http://www.nuforc.org/webreports/ndxlBC.html"):
    """Downloads data from the url and saves the dataframe in feather format

    Parameters
    ===========
    url_path: str
        URL of the webpage containing the data
    output_file: str
        file name along with the path for saving the data
    """

    aliens_df = pd.read_html(url_path)[0]
    feather.write_dataframe(aliens_df, output_file)


if __name__ == "__main__":
    main(arg["--output_file"])
