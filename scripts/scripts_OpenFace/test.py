


open_face_cmd_path = '/Users/laurenkahn/Desktop/OpenFace/build/bin/FeatureExtraction'
out_dir = "/Volumes/psychology/a/Adapt/Studies/EASE/output/processed_video_diaries/openface_csv_output_2019_09_06/"
out_name = "test"
filename='/Volumes/psychology/a/Adapt/Studies/EASE/raw_data/video_diaries/video_diaries_fall2016_rotated/36f68296a2dce4f1/Week1_rotated/09-11-2016_2051.mp4'

bashCommand = [cfg.open_face_cmd_path,'-f', output_name, '-aus', '-out_dir', cfg.out_dir]
bashCommand = [open_face_cmd_path + ' -f ' + filename + ' -of ' + out_name + ' -aus -out_dir ' + out_dir]
bashCommand = [open_face_cmd_path,'-f',filename,'-of',out_name,'-aus','-out_dir',out_dir]
bashCommand = ['ls']


subprocess.check_output(bashCommand)

subprocess.check_output(['/Users/laurenkahn/Desktop/OpenFace/build/bin/FeatureExtraction -f /Volumes/psychology/a/Adapt/Studies/EASE/raw_data/video_diaries/video_diaries_fall2016_rotated/36f68296a2dce4f1/Week1_rotated/09-11-2016_2051.mp4 -of test -aus -out_dir /Volumes/psychology/a/Adapt/Studies/EASE/output/processed_video_diaries/openface_csv_output_2019_09_06/'],shell=True)
