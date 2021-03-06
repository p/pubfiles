#!/usr/bin/env python3

import sys, sqlite3, time as _time, os.path

if len(sys.argv) != 2:
    print('Usage: adjust.py /path/to/fossil/repo')
    exit(10)

repo_path = sys.argv[1]
conn = sqlite3.connect(repo_path)
c = conn.cursor()

now = int(_time.time())

ticket_options = {
    'type_choices': ['Bug', 'Feature', 'Task', 'Question'],
    'priority_choices': ['High', 'Normal', 'Low'],
    'severity_choices': ['Severe', 'Important', 'Minor'],
    'resolution_choices': ['Open', 'Fixed', 'Rejected', 'Obsolete', 'Duplicate'],
    'status_choices': ['Open', 'Closed', 'Postponed'],
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
    'Open Tickets': dict(sqlcode='''
SELECT
case priority
when 'High' then '#f2dcdc'
when 'Normal' then '#cfe8bd'
when 'Low' then '#cacae5'
else '#ffffff' end as bgcolor,
  substr(tkt_uuid,1,10) AS '#',
  date(tkt_ctime) as created,
  date(tkt_mtime) AS updated,
  type,
  title
FROM ticket
where status in ('Open', 'Verified')
order by priority != 'High', priority != 'Normal', tkt_ctime
    ''', cols='''
#ffffff Priority:
#f2dcdc High
#cfe8bd Normal
#cacae5 Low
    '''),
    'Recently Fixed Tickets': dict(sqlcode='''
SELECT
case date(tkt_mtime)
when date('now') then '#fcf8cf'
when date('now', '-1 day') then '#cfe7fc'
when date('now', '-2 days') then '#fccffa'
when date('now', '-3 days') then '#cffcd5'
when date('now', '-4 days') then '#e7cffc'
else '#fcdecf' end bgcolor,
  substr(tkt_uuid,1,10) AS '#',
  date(tkt_ctime) as created,
  date(tkt_mtime) AS updated,
  type,
  title
FROM ticket
where status in ('Closed') and resolution in ('Fixed')
and date(tkt_mtime) > date('now', '-7 days')
order by tkt_mtime desc
    ''', cols='''
#ffffff Closed:
#fcf8cf Today
#cfe7fc Yesterday
#fccffa 2 days ago
#cffcd5 3 days ago
#e7cffc 4 days ago
#fcdecf 5+ days ago
    '''),
    'Recently Fixed Tickets - Lite': dict(sqlcode='''
SELECT
case date(tkt_mtime)
when date('now') then '#fcf8cf'
when date('now', '-1 day') then '#cfe7fc'
when date('now', '-2 days') then '#fccffa'
when date('now', '-3 days') then '#cffcd5'
when date('now', '-4 days') then '#e7cffc'
else '#fcdecf' end bgcolor,
  title
FROM ticket
where status in ('Closed') and resolution in ('Fixed')
and date(tkt_mtime) > date('now', '-7 days')
order by tkt_mtime
    ''', cols='''
#ffffff Closed:
#fcf8cf Today
#cfe7fc Yesterday
#fccffa 2 days ago
#cffcd5 3 days ago
#e7cffc 4 days ago
#fcdecf 5+ days ago
    '''),
}

for name in reports:
    reports[name]['sqlcode'] = reports[name]['sqlcode'].strip()
    reports[name]['cols'] = reports[name]['cols'].strip()

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
        c.execute('update reportfmt set sqlcode=?, cols=?, mtime=?, owner=? where title=?',
            (reports[name]['sqlcode'], reports[name]['cols'], 'now', 'predefined', name))
    else:
        c.execute('insert into reportfmt (owner, title, mtime, sqlcode, cols) values (?, ?, ?, ?, ?)',
            ('predefined', name, 'now', reports[name]['sqlcode'], reports[name]['cols']))

conn.commit()
c.close()
