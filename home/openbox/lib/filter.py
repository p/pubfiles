import pyratemp
import req, helpers
import sys

template = pyratemp.Template(filename=sys.argv[1])
print template(r=req.Req(), h=helpers.Helpers())
