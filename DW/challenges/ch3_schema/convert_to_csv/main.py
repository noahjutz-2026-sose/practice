import csv
from typing import cast

import pandas as pd
import pyreadstat

df, meta = pyreadstat.read_dta("~/Downloads/ZA2391_v17-0-0.dta")
df = cast(pd.DataFrame, df)

df.to_csv("/tmp/st_politbarometer_survey.csv", index=False)

questions = meta.column_names_to_labels
answers = meta.value_labels

with open("/tmp/st_politbarometer_questions.csv", "w") as f:
    writer = csv.writer(f)
    for k, v in questions.items():
        writer.writerow([k, v])

with open("/tmp/st_politbarometer_answers.csv", "w") as f:
    writer = csv.writer(f)
    for q, d in answers.items():
        for k, v in d.items():
            writer.writerow([q, k, v])
