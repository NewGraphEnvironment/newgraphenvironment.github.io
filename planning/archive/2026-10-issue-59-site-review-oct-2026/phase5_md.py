import re, pathlib
alts = {
 "map-lulc-subbasins.jpg": "The Neexdzii Kwah divided into sub-basins, with the modelled floodplain, Highway 16 and the CN railway.",
 "TimePhoto_20220927_131549.JPG": "Cutthroat trout measured against a tape during fish sampling, September 2022.",
 "nrp_monthly_load.png": "Monthly phosphorus load in tonnes, particulate (PP) and total (TP): one grey line per year, the red line and band the central estimate and its spread.",
 "dunc_elevations.jpg": "Duncan Reservoir at full pool, 577 m, and low pool, 547 m, showing the drawdown zone exposed between them.",
 "hydrograph_res_vs_llogs2.png": "Seasonal pattern by year, 2013 to 2018: depth of withdrawal at Duncan Reservoir, and mean discharge at the LLOGS site.",
 "neexdzii_benthic_taxa.png": "Benthic invertebrate community composition at the 2025 Neexdzii Kwah sites.",
 "overview_zoomed_out.jpg": "The Sheep Creek watershed near Salmo, with the hydrometric stations and the Central Landfill and HB Mine tailings facility.",
 "nmds2.png": "Three-dimensional NMDS ordination of benthic invertebrate samples from Sheep Creek.",
 "IMG_9866_cutty.JPG": "Cutthroat trout held over a bucket during fish sampling, September 2022.",
 "fresh_subbasin.png": "Modelled coho spawning and rearing habitat across a sub-basin, with falls and coho observations.",
 "flooded_scenarios.png": "Floodplain scenarios from flooded, from the active channel margin to the valley bottom.",
 "drift_classified.png": "Land cover inside a floodplain classified for 2017, 2020 and 2023.",
 "fly_priority.png": "Historic airphoto footprints selected to cover a site with the fewest photos.",
 "cd_temperature_departure.png": "Temperature departure, 2015 to 2025 against 1951 to 1980, around Castlegar, Nelson and Creston.",
 "uav_cover.jpg": "Drone imagery of a stream reach.",
}
renames = {"overview_zoomed_out.png": "overview_zoomed_out.jpg", "dunc_elevations.png": "dunc_elevations.jpg", "map-lulc-subbasins.png": "map-lulc-subbasins.jpg"}
used = set()
for f in ["content/project/watershed_restoration_fish_passage/index.md", "content/project/aquatic_monitoring_assessment/index.md", "content/project/open_source_software/index.md"]:
    p = pathlib.Path(f); t = p.read_text()
    for a, b in renames.items(): t = t.replace("](" + a + ")", "](" + b + ")")
    def sub(m):
        name = m.group(1)
        if name in alts: used.add(name); return "![" + alts[name] + "](" + name + ")"
        raise SystemExit("no alt for " + name)
    t = re.sub(r"!\[\]\(([^)]+)\)", sub, t)
    lines = [l for l in t.split("\n") if l.strip() not in ("<br>", '<div style="clear: both;"></div>')]
    t = re.sub(r"\n{3,}", "\n\n", "\n".join(lines))
    t = re.sub(r'(<img src="/img/hex/[^"]+" alt="[^"]*")', r'\1 loading="lazy"', t)
    p.write_text(t)
missing = set(alts) - used
print("alts written:", len(used), "unused keys:", sorted(missing))
