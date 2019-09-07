import os
import re
import subprocess
import config_extractFeatures as cfg

# Main function
def main():
    """
    Run the things.
    """
    for tld in cfg.toplevel_dirs:
    	sub_list = sorted(os.listdir(tld))
    	for sub in sub_list:
    		sub_path = os.path.join(tld,sub)
    		if os.path.isdir(sub_path):
    			sess_dirs = sorted(os.listdir(sub_path))
    			for sess in sess_dirs:
    				vid_path = os.path.join(tld,sub,sess)
    				if os.path.isdir(vid_path):
    					vids = sorted(os.listdir(vid_path))
    					for v in vids:
    						if v.endswith(cfg.ext):
    							date_str, date_end_idx = extractDate(v,sub)
    							time_str = extractTime(v,date_end_idx)
    							output_name = sub + "_" + date_str + "_" + time_str
    							print(output_name)
    							out_path = os.path.join(cfg.out_dir,output_name + ".csv")
    							if not os.path.isfile(out_path):
    								# command to bash
    								print("Analyzing video %s of participant %s\n" % (v,sub))
    								bashCommand = [cfg.open_face_cmd_path,'-f', os.path.join(vid_path,v), '-aus', '-of', output_name, '-out_dir', cfg.out_dir]
    								subprocess.check_output(bashCommand)

def extractDate(filename,dev_id):
	"""    
	Generate date string from video filename
	"""
	
	foundDate = False
	for yr in cfg.years:
		yr_first_re = yr + "-" + "[0-1]{1}" + "[0-9]{1}" + "-" + "[0-3]{1}" + "[0-9]{1}"
		yr_last_re = "[0-3]{1}" + "[0-9]{1}" + "-" + "[0-1]{1}" + "[0-9]{1}" + "-" + yr
		if re.search(yr_first_re,filename):
			foundDate = True
			date_str = re.search(yr_first_re,filename).group(0)
			idx = [m.end(0) for m in re.finditer(yr_first_re,filename)]
			date_end_idx = idx[0]
		elif re.search(yr_last_re,filename):
			foundDate = True
			#get xx-xx-20xx
			#translate to year first format
			date_str_flipped = re.search(yr_last_re,filename).group(0)
			mo = date_str_flipped[3:5]
			day = date_str_flipped[0:2]
			date_str = yr + "-" + mo + "-" + day
			idx = [m.end(0) for m in re.finditer(yr_last_re,filename)]
			date_end_idx = idx[0]

	if not foundDate:
		print("WARNING: Date not found in file %s" % filename)
		date_str = "0000-00-00"
		date_end_idx = 0


	return date_str, date_end_idx

	 
	

def extractTime(filename,date_end_idx):
	"""    
	Generate time from video filename, which may have varying format in filename
	Assumes time is after the date in the filename. If not date was found, no restrictions.
	"""    
	# Only look after end of date_str
	short_filename = filename[date_end_idx:]
	foundTime = False
	
	i=0
	while not foundTime:
		form = cfg.time_formats[i]
		
		if re.search(form,short_filename):
			foundTime = True
			time_str = re.search(form,short_filename).group(0)
			
			# Prep the sec suffix
			if len(time_str)<6:
				sec_suffix = "-00"
			else:
				sec_suffix = "-" + time_str[-2:]
			
			# Construct time str
			if time_str[2]=="-":
				time_str = time_str[0:5] + sec_suffix
			else:
				time_str = time_str[0:2] + "-" + time_str[2:4] + sec_suffix
		
		elif i+1<len(cfg.time_formats):
			i=i+1
		else:
			print("WARNING: Time not found in file %s" % filename)
			time_str = "00-00-00"
			foundTime = True

	return time_str



	

main()