Similarity search for Jahia xCM
===============================

This is a custom similarity search module for the Jahia xCM platform that offers 
a module to create a list of nodes similar to the currently displayed one.

Licensing
---------
This module is free software; you can redistribute it and/or 
modify it under the terms of the GNU General Public License 
as published by the Free Software Foundation; either version 2 
of the License, or (at your option) any later version

Disclaimer
----------
This module was developed by Benjamin Papez and is distributed in the hope that
it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty
of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

The status of this development is a "Prototype" and is not targeted to be deployed
and run on a production instance of Jahia xCM.

Requirements
------------
Module is targeted to be deployed to Jahia xCM version 6.5 (or later).

Description
-----------
Jahia is focusing to put semantic technologies in the upcoming releases. Some solutions
are already available for Jahia 6.5 . For instance there is a Jackrabbit custom feature, which
allows searching for nodes, which are similar to an existing node (see `SimilaritySearch <http://wiki.apache.org/jackrabbit/SimilaritySearch>`_).

The feature uses the `MoreLikeThis <http://javasourcecode.org/html/open-source/lucene/lucene-2.4.1/org/apache/lucene/search/similar/MoreLikeThis.html>`_ class of Lucene. 
Read `this article <http://cephas.net/blog/2008/03/30/how-morelikethis-works-in-lucene/>`_ to learn how 
it works. Jackrabbit simply takes the node's fulltext field in the index to compare the terms with that from other nodes. 

This custom module integrates this feature into Jahia and provides a component, which can be
dropped into a template and will then display a list of similar nodes like the currently displayed
one. 

Usage
-----
Deploy the module to your Jahia server. Then in the studio you can drop the component into a
template, like for instance the news template. You can choose the node type, which should be used
in the query to find similar node types. If you do not choose a node type, the primary node type of the
displayed node will be taken automatically. You can also set the maximum number of similar nodes, which
should be displayed and in the Layout tab, you can choose the subview template to display the similar
nodes' list. If you have chosen a node type in the Content tab, then the subview template list may 
contain more specific templates for the chosen node type.
   