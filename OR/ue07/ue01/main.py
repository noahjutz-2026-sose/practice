import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

df = pd.read_csv(
    "bier127.tsp",
    skiprows=6,  # skip metadata lines
    skipfooter=1,  # skip EOF line
    header=None,
    sep=r"\s+",  # handle variable whitespace
    engine="python",  # needed for skipfooter + regex sep
    names=["node", "x", "y"],
    index_col="node",
)

coords = df[["x", "y"]].to_numpy()

diff = coords[:, np.newaxis, :] - coords[np.newaxis, :, :]

d = np.sqrt(np.sum(diff**2, axis=-1))

print(d)
