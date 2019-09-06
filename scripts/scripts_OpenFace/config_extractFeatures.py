# Define all top level dirs, which contain subject-specific dirs
toplevel_dir_1 = "/Volumes/psychology/a/Adapt/Studies/EASE/raw_data/video_diaries/video_diaries_fall2016_rotated"
toplevel_dir_2 = "/Volumes/psychology/a/Adapt/Studies/EASE/raw_data/video_diaries/video_diaries_winter2017_rotated"

# List all top level dirs
toplevel_dirs = [toplevel_dir_1, toplevel_dir_2]

# List all extensions separated with a comma (as a tuple), for ex ".mp4", ".mov"
ext = ".mp4",".avi",".mov"
years = ["2016", "2017"]


time_re_1 = "[0-2]{1}" + "[0-9]{1}" + "-" + "[0-5]{1}" + "[0-9]{1}" + "-" + "[0-5]{1}" + "[0-9]{1}"
time_re_2 = "[0-2]{1}" + "[0-9]{1}" + "-" + "[0-5]{1}" + "[0-9]{1}"
time_re_3 = "[0-2]{1}" + "[0-9]{1}" + "[0-5]{1}" + "[0-9]{1}" + "[0-5]{1}" + "[0-9]{1}"
time_re_4 = "[0-2]{1}" + "[0-9]{1}" + "[0-5]{1}" + "[0-9]{1}"

# Note: list these in the order you want to check them 
# (so if one is a substring but you prefer the bigger string, list the bigger string first)
time_formats = [time_re_1, time_re_2, time_re_3, time_re_4]


