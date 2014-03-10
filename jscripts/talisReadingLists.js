/*
#(c)#=====================================================================
#(c)#
#(c)#       Copyright 2008 ExLibris Group
#(c)#                       All Rights Reserved
#(c)#
#(c)#=====================================================================

**          Product : WebVoyage :: talisReadingLists js
**          Version : 2007.0.1
**          Created : 15-OCT-2013
**      Orig Author : Jamie Denman
**    Last Modified : 
** Last Modified By : 
*/

function insertReply(content) {
			var result;
			var list_url = "";
			var list_code = "";
			var list_title = "";
			var op = "";
			
			var myspan_s = "<li><span class='recordLinkBullet'>·</span>";
			var myspan_e = "</li>";
			
			result = content;

			//Turn Talis label off in case of no reading list for this item
			document.getElementById('talisRow').style.display = 'none'; 

			for(key in result)
  			{
			  //split the list code and title - display code as link and title as hint(title)
			  list_code = result[key].substr(0, result[key].indexOf(' '));
			  list_title = result[key].substr(result[key].indexOf(' ')+1);
			
			  //if list doesn't have a code use the title
			  if (!list_code.length > 0) {
				list_code = list_title;
			  }

			  list_url = myspan_s + "<a href='" + key + "' title='"+ list_title + "'>" + list_code +"<\a>" + myspan_e;

			  //verify we have some form of link and not junk!
			  if(list_url.indexOf("http") != -1) {
				op = op + list_url;   
			  }
			}
			//Turn Talis label back on
			if (op.length > 0) {
				document.getElementById('talisRow').style.display = ''; 
			}
    			document.getElementById('output').innerHTML = op;
		}

function getTalis(isbn) {
			var THIS_ISBN = isbn;
			var split_isbn = THIS_ISBN.split(" ");
			
			// create script element
			var script = document.createElement('script');
			// assing src with callback name
			script.src = "http://resourcelists.falmouth.ac.uk/isbn/" + split_isbn[0] + "/lists.json?cb=insertReply";
			// insert script to document and load content
			document.body.appendChild(script);
		}
