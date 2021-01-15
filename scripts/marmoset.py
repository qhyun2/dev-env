#!/usr/bin/python3

# This Python script is a wrapper for /u/cs_build/bin/marmoset
# It exists for backward compatibility with the old marmoset_submit.

import sys,subprocess

# Location of the new Marmoset Command Line Interface (CLI) tool
marmoset_cli_path = "/u/cs_build/bin/marmoset"

# This function prints a help message and exits.
def print_help_and_quit(exit_code = 1):
    print("For help on submitting to Marmoset from the command line, please")
    print("see the output of this command below:")
    print()
    print("  %s submit --help" % marmoset_cli_path)
    print()
    subprocess.run([marmoset_cli_path, 'submit', '--help'])
    print()
    sys.exit(exit_code)

# The /u/cs_build/bin/marmoset submit tool is run like this:
# /u/cs_build/bin/marmoset <some options...> submit <some more options...>
# We have to figure out which options go before 'submit' and which ones go after.
# This function splits arguments into options that go before and after submit
# and returns the result in a 2-tuple.
def split_arguments(arguments, start=1):
    before_submit_options = []
    after_submit_options = []
    index = start
    while index < len(arguments):

        arg = arguments[index]

        if arg.lower() in ['-h', '--h', '-help', '--help']:
            print_help_and_quit()

        if arg == 'submit':
            index += 1
            continue

        # Check for arguments that go before the 'submit'
        before_submit_keywords = ['--username', '-u', '--semester', '-s']
        if arg.startswith(tuple(map(lambda s: s+'=', before_submit_keywords))):
            before_submit_options.append(arg)
            index += 1; continue
        if arg in before_submit_keywords:
            if (index+1) < len(arguments):
                before_submit_options.append("%s=%s" % (arg, arguments[index+1]))
                index += 2; continue
            else:
                index += 1; continue

        # All other arguments go after the 'submit'
        if arg in ['--zipargs', '-z']:
            if (index+1) < len(arguments):
                after_submit_options.append("%s=%s" % (arg, arguments[index+1]))
                index += 2; continue
            else:
                index += 1; continue
        after_submit_options.append(arg)
        index += 1
    return (before_submit_options, after_submit_options)

# # Tests for split_arguments
# def split_arguments_test(argv, expected_before, expected_after):
#     assert split_arguments(argv) == (expected_before, expected_after)
# split_arguments_test(['marmoset_submit'], [], [])
# split_arguments_test(['marmoset_submit', 'CS123', 'A1P2', 'my code.cpp'], \
#     [], ['CS123', 'A1P2', 'my code.cpp'])
# split_arguments_test(['marmoset_submit', '--username=jsmith', '--zipargs=-r', 'CS123', 'A1P2', 'my code.cpp'], \
#     ['--username=jsmith'], ['--zipargs=-r', 'CS123', 'A1P2', 'my code.cpp'])
# split_arguments_test(['marmoset_submit', '--username=jsmith', '-s', 'Fall 2019', 'CS123', 'A1P2', 'my code.cpp'], \
#     ['--username=jsmith', '-s=Fall 2019'], ['CS123', 'A1P2', 'my code.cpp'])
# split_arguments_test(['marmoset_submit', '-u', 'jsmith', '-z', '-s 630', '--semester', 'Fall 2019', 'CS123', 'A1P2', 'f1.cpp', 'f 2.cpp'], \
#     ['-u=jsmith', '--semester=Fall 2019'], ['-z=-s 630', 'CS123', 'A1P2', 'f1.cpp', 'f 2.cpp'])
# split_arguments_test(['marmoset_submit', '-u'], [], [])
# split_arguments_test(['marmoset_submit', 'CS123', 'A1', 'file1.cpp', 'file2.cpp', '--username'], \
#     [], ['CS123', 'A1', 'file1.cpp', 'file2.cpp'])
# split_arguments_test(['marmoset_submit', 'CS123', 'A1', 'file1.cpp', 'file2.cpp', '--username', 'jsmith'], \
#     ['--username=jsmith'], ['CS123', 'A1', 'file1.cpp', 'file2.cpp'])

# Script starts here
before_submit_options, after_submit_options = split_arguments(sys.argv)
process = subprocess.Popen(["ssh", "uw"] + [marmoset_cli_path] + before_submit_options + ['submit'] + after_submit_options, stdout=subprocess.PIPE)
output, error = process.communicate()
print(output.decode('utf8'))
