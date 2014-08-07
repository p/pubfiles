#!/usr/bin/env python

import sys, sqlite3, time as _time, os.path

repo_path = sys.argv[1]
conn = sqlite3.connect(repo_path)
c = conn.cursor()

now = int(_time.time())

ticket_options = {
    'type_choices': ['Bug', 'Feature', 'Task', 'Question'],
    'priority_choices': ['High', 'Normal', 'Low'],
    'severity_choices': ['Severe', 'Important', 'Minor'],
    'resolution_choices': ['Open', 'Fixed', 'Rejected'],
    'status_choices': ['Open', 'Closed'],
    'subsystem_choices': [],
}

configs = [
    # show links without javascript
    ['auto-hyperlink', 0],
    # no need for captcha
    ['require-captcha', 0],
    # show timeline in local time
    ['timeline-utc', 0],
]

pages = [
    'ticket-editpage',
    'ticket-newpage',
    'ticket-viewpage',
]

reports = {
    'Open Tickets': '''
SELECT
  substr(tkt_uuid,1,10) AS '#',
  datetime(tkt_mtime) AS 'mtime',
  type,
  status,
  subsystem,
  title
FROM ticket
where status in ('Open', 'Verified')
    ''',
}

# ---

def build_ticket_common(ticket_options):
    result = ''
    for key in ticket_options:
        result += 'set %s {\n%s\n}\n' % (key, "\n".join('  ' + key for key in ticket_options[key]))
    return result.strip()

configs.append(['ticket-common', build_ticket_common(ticket_options)])

for page in pages:
    with open(os.path.join(os.path.dirname(__file__), 'templates', '%s.html' % page)) as f:
        content = f.read()
    configs.append([page, content])

for name, value in configs:
    c.execute('''replace into config (name, value, mtime) values (?, ?, ?)''',
        (name, value, now))

def fetchfirst(c):
    row = c.fetchone()
    if row is None:
        return None
    else:
        return row[0]

for name in reports:
    c.execute('select rn from reportfmt where title=?', (name,))
    rn = fetchfirst(c)
    if rn:
        c.execute('update reportfmt set sqlcode=?, mtime=?, owner=?',
            (reports[name], 'now', 'predefined'))
    else:
        c.execute('insert into reportfmt (owner, title, mtime, sqlcode) values (?, ?, ?, ?)',
            ('predefined', name, 'now', reports[name]))

conn.commit()
c.close()
