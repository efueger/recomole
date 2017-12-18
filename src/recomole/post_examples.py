#!/usr/bin/env python
# -*- coding: utf-8 -*-
# -*- mode: python -*-
"""
:mod:`recomole.post_examples` -- post example content for help pages

=============
Post Examples
=============

Functions to create html (javascript) code to execute post calls and
show response. Designed to be used on help pages for services.

the main functions are
* create_post_examples
  Creates html based on provided examples

* create_post_examples_from_dir
  Read examples from a dir and creates html (javascript) based on them.

example of usage:

    create_post_examples('/post', [('example1', 'post-content-1'),
                                   ('example2', 'post-content-2')
                                   ('example3', 'post-content-3')])
"""
import logging
import os


logger = logging.getLogger(__name__)


def create_post_examples(post_page, examples, title=None):
    """
    Creates htmlcode that can post examples(selected from a dropdown
    menu) and show result.

    :param post_page:
        url to post to
    :param examples:
        list of examples. Each example is a tuple containing
        example-name, and content - (name, content)
    :param title:
        Title of example page. default is None.

    :returns:
        html and javascript code generated with examples.
    """
    html = [__title(title),
            '<script type="text/javascript">',
            'var data = {};',
            __create_example_data(examples),
            '',
            'function display_example(example){',
            '  document.getElementById(\'request\').value = data[example]',
            '}',
            '',
            'function send_request(data){',
            '  var request = new XMLHttpRequest();',
            '  request.open("POST", "%s");' % post_page,
            '  request.onreadystatechange = function(e){',
            '    if (e.target.readyState === 4){',
            '      document.getElementById(\'responseHeader\').innerHTML = "Result:";',
            '      document.getElementById(\'curlLine\').innerHTML = "<br><br><b>curl</b>:  curl -P -v -H \\\"Content-Type: Application/json\\\" -d " + data + "\\\"$ENDPOINT\\\"<br><br";',
            '      document.getElementById(\'responseBox\').style.border = "2px double LightGray";',
            '      var jsObj = JSON.parse(e.target.responseText);',
            '      document.getElementById(\'response\').innerHTML = JSON.stringify(jsObj, null, 4);',
            '    }',
            '  };',
            '  request.send(data);',
            '}',
            '',
            '</script>',
            '',
            '  <h4>request:</h4>',
            '  <textarea id="request" rows="20" cols="80">',
            '  </textarea><br>',
            '',
            '<select id="optionList" onchange="display_example(document.getElementById(\'optionList\').value);">',
            '  <option selected="selected">vælg eksempel</option>',
            __create_options(examples),
            '</select>',
            '',
            '<button onclick="send_request(document.getElementById(\'request\').value)">Try</button>',
            '<div id="curlLine"></div><h4 id="responseHeader"></h4><div id="responseBox" style="width:580px;padding:5px"><pre><code id="response"></code></pre></div>']

    return '\n'.join(html)


def __create_example_data(examples):
    """ creates map from examples (javascript) """
    html = []
    for name, call in examples:
        html.append('data["%s"] = "%s";' % (name, call))
    return '\n'.join(html)


def __create_options(examples):
    """ creates options from examples (html) """
    html = []
    for name, call in examples:
        html.append('  <option value="%s">%s</option>' % (name, name))
    return '\n'.join(html)


def __title(title):
    """ creates title (html) """
    if title:
        return '<h3>%s</h3>\n' % title
    return ''


def create_post_examples_from_dir(post_page, directory, suffix=None, title=None):
    """
    Creates htmlcode that can post examples (selected from a dropdown
    menu) and show result. The examples are harvested from directory,
    where file basename, and file content are used as examples.

    :param post_page:
        url to post to
    :param examples:
        list of examples. Each example is a tuple containing
        example-name, and content - (name, content)
    :param title:
        Title of example page. default is None.
    :param directory:
        dir to read harvest files from
    :param suffix:
        If provided, only files that have this suffix are read

    :returns:
        html and javascript code generated with examples.
    """
    examples = sorted([e for e in read_examples_from_dir(directory, suffix=suffix)])
    return create_post_examples(post_page, examples, title=title)


def read_example_from_file(filepath):
    """ Reads examples from file returns tuples with file basename and file content """
    logger.debug("Reading example from file '%s'", filepath)
    with open(filepath) as fh:
        content = fh.read().replace('"', '\\"').replace('\n', '\\n')
        basename = os.path.basename(filepath)
        name = basename[:basename.rindex('.')]
        return name, content


def read_examples_from_dir(directory, suffix=None):
    """
    Reads all examples from directory recursivly, and generates tuples
    consisting of file basename, and file content.

    if suffix is provided, only files with the suffix are read.
    """
    logger.debug("Reading examples from dir '%s'", directory)
    for root, dirs, files in os.walk(directory):
        if suffix:
            files = [f for f in files if f.endswith(suffix)]
        for f in files:
            yield read_example_from_file(os.path.join(root, f))
