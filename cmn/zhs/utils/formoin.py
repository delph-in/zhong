import sys, glob
import datetime

today = datetime.date.today()
log_files = glob.glob(sys.argv[1]+"/*.log")
log_files.sort()
for log_file in log_files:
	f = open(log_file)
	logs = f.read()
	f.close()

	prefix = log_file.replace(".log", "")
	prefix = prefix[prefix.rfind("/")+1:]
	print(prefix)

	buf = "|| CHANGE || "
	buf += str(today)
	buf += " || "
	ps = -1.0
	for e in logs.split("\n\n"):
		e = e.replace("[31m", "")
		e = e.replace("[32m", "")
		e = e.replace("[33m", "")
		e = e.replace("[0m", "")
		log = e.strip().split("\n")

		if len(log) < 5: continue	

		p = log[3].strip().split(":")
		pg = p[1].strip()
		pg = pg[pg.find("(")+1:pg.find(")")]
		pu = p[2].strip()
		pu = pu[pu.find("(")+1:pu.find(")")]
		
		if ps < 0.0: ps = float(pg)
		
		r = log[4].strip().split(":")
		rg = r[1].strip()
		rg = rg[rg.find("(")+1:rg.find(")")]
		ru = r[2].strip()
		ru = ru[ru.find("(")+1:ru.find(")")]

		if not rg[0].isdigit(): rg = "0.0"
		if not ru[0].isdigit(): ru = "0.0"
	
		buf += str(round(float(pg) * 100, 2)) + " (" + str(round(float(rg), 2)) + ")" 
		if pu[0] != "-": buf += " / " + str(round(float(pu) * 100, 2)) + " (" + str(round(float(ru), 2)) + ")" 

		buf += " || "


	#for generation
	gen_file = log_file.replace(".log", ".gen")
	f = open(gen_file)
	[gen, total] = f.read().strip().split()
	f.close()
	if total == "0": 
		buf += " 0.0 || 0.0 ||"
	else:	
		gs = round(float(gen) / float(total) * 100, 2)
		buf += str(gs) + " || "

		#for end-to-end
		es = round(ps * gs, 2)
		buf += str(es) + " ||"

	print(buf+"\n")




	
		
		



