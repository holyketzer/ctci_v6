import sys

def is_open_tag(tag):
    return len(tag) > 1 and tag[0] == '<' and tag[1] != '/' and tag[-1] == '>'

def is_close_tag(tag):
    return len(tag) > 1 and tag[1] == '/'

def convert_to_open_tag(tag):
    return tag[0:1] + tag[2:]

def convert_to_close_tag(tag):
    return tag[0:1] + '/' + tag[1:]

x = int(sys.stdin.readline().strip())

for i in range(x):
    s = int(sys.stdin.readline().strip())

    all_tags = []
    tags = []
    invalid_closes = []

    for j in range(s):
        tag = sys.intern(sys.stdin.readline().strip().upper())
        all_tags.append(tag)

        if is_open_tag(tag):
            tags.append(tag)
        else:
            if len(tags) > 0 and tags[-1] == convert_to_open_tag(tag):
                del tags[-1]
            else:
                invalid_closes.append(tag)

    if len(tags) == 0 and len(invalid_closes) == 0:
        print('CORRECT')
    elif len(tags) + len(invalid_closes) == 1:
        if len(tags) > 0:
            print('ALMOST ' + tags[0])
        else:
            print('ALMOST ' + invalid_closes[0])
    else:
        tags = []
        invalid_opens = []

        for tag in reversed(all_tags):
            if is_close_tag(tag):
                tags.append(tag)
            else:
                if len(tags) > 0 and tags[-1] == convert_to_close_tag(tag):
                    del tags[-1]
                else:
                    invalid_opens.append(tag)

        if len(tags) == 0 and len(invalid_opens) == 0:
            print('CORRECT')
        elif len(tags) + len(invalid_opens) == 1:
            if len(tags) > 0:
                print('ALMOST ' + tags[0])
            else:
                print('ALMOST ' + invalid_opens[0])
        else:
            print('INCORRECT')
