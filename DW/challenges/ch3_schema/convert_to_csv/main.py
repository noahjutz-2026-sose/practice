import csv
from typing import cast

import pandas as pd
import pyreadstat

df, meta = pyreadstat.read_dta("~/Downloads/ZA2391_v17-0-0.dta")
df = cast(pd.DataFrame, df)

df.to_csv("/tmp/st_politbarometer_survey.csv", index=False)

column_labels = meta.column_names_to_labels
value_labels = meta.value_labels

with open("/tmp/st_meta_politbarometer_column_labels.csv", "w") as f:
    writer = csv.writer(f)
    for k, v in column_labels.items():
        writer.writerow([k, v])

with open("/tmp/st_meta_politbarometer_value_labels.csv", "w") as f:
    writer = csv.writer(f)
    for q, d in value_labels.items():
        for k, v in d.items():
            writer.writerow([q, k, v])
