Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4E426560E;
	Tue,  8 Apr 2025 10:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744106999; cv=none; b=hyWhJQnTpJjakaLBlE7w6SBry/PLeF3QapWsx/ntzVyRRao3FB7FxbzxnyddqnZhjXLeR0UI1+JL5mdUlCTMSJm+lPf6xFAH/gkkLnR/+S+MDdZrZYmU8n9B676gHrmESn8HX71INjDw2/hI8goqnQcWaGujSKcaqjtCNftVlW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744106999; c=relaxed/simple;
	bh=SszucMXEdc/sou+xc8alSD8raZAiM5Q3h/x3KVgAi8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NCicaTa2QRjAk2M/YvS0EhRUwV0yofkOL0ZNsCXJoLDbQQktiKRS5D+fEWa5fm2w2NoWGcG29T3HuIiilq/y6IIwdQ1wkfEsUTnzaf5GapPDk4D+vH3Q+ZTMS/Y45ACIJ4kEa6wwDu+Rdfc4wQaF5OQQNpkiW2Z0XFBxNvJatCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPtVmZJv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPtVmZJv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE03C4CEF4;
	Tue,  8 Apr 2025 10:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744106999;
	bh=SszucMXEdc/sou+xc8alSD8raZAiM5Q3h/x3KVgAi8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oPtVmZJvNmTIb7w7HHWkz9iDfi6d02/FAg3jtko4psFSyMRVfVfnyC6kL0KfAnb0Q
	 0VIB/Xaz794TvZ/658FddqQhEvV64zboUdJEpjNFxZmZ5R5gaV7W39j3GcExZdlNRK
	 n+E1/4RNwu36sKUHLQw21mNtj0Q3upm8Wn4sUuGB99h14gaeQo3hs0bZ9Q5grbjglk
	 ACF3xo8+pZcY+z2P2vAlE6Owaa87fHoEaYFJRSuelF/eP6yDEXhccjKfYAqp7frlRj
	 JYUXCaTl0Wjt579tvKtITfGLRwhoeg9/YdkSHZZC4W83q9V47wPGomZQCqFbYBD9Gy
	 XmrZrwsj1hlfw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab@kernel.org>)
	id 1u25tt-00000008RWn-2ujm;
	Tue, 08 Apr 2025 18:09:49 +0800
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Sean Anderson <sean.anderson@linux.dev>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 32/33] scripts/kernel-doc.py: Rename the kernel doc Re class to KernRe
Date: Tue,  8 Apr 2025 18:09:35 +0800
Message-ID: <4e095ecd5235a3e811ddcf5bad4cfb92f1da0a4a.1744106242.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1744106241.git.mchehab+huawei@kernel.org>
References: <cover.1744106241.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>

Using just "Re" makes it harder to distinguish from the native
"re" class. So, let's rename it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/lib/kdoc/kdoc_output.py |  50 +++---
 scripts/lib/kdoc/kdoc_parser.py | 264 ++++++++++++++++----------------
 scripts/lib/kdoc/kdoc_re.py     |   4 +-
 3 files changed, 159 insertions(+), 159 deletions(-)

diff --git a/scripts/lib/kdoc/kdoc_output.py b/scripts/lib/kdoc/kdoc_output.py
index c352b7f8d3fd..86102e628d91 100755
--- a/scripts/lib/kdoc/kdoc_output.py
+++ b/scripts/lib/kdoc/kdoc_output.py
@@ -20,31 +20,31 @@ import re
 from datetime import datetime
 
 from kdoc_parser import KernelDoc, type_param
-from kdoc_re import Re
+from kdoc_re import KernRe
 
 
-function_pointer = Re(r"([^\(]*\(\*)\s*\)\s*\(([^\)]*)\)", cache=False)
+function_pointer = KernRe(r"([^\(]*\(\*)\s*\)\s*\(([^\)]*)\)", cache=False)
 
 # match expressions used to find embedded type information
-type_constant = Re(r"\b``([^\`]+)``\b", cache=False)
-type_constant2 = Re(r"\%([-_*\w]+)", cache=False)
-type_func = Re(r"(\w+)\(\)", cache=False)
-type_param_ref = Re(r"([\!~\*]?)\@(\w*((\.\w+)|(->\w+))*(\.\.\.)?)", cache=False)
+type_constant = KernRe(r"\b``([^\`]+)``\b", cache=False)
+type_constant2 = KernRe(r"\%([-_*\w]+)", cache=False)
+type_func = KernRe(r"(\w+)\(\)", cache=False)
+type_param_ref = KernRe(r"([\!~\*]?)\@(\w*((\.\w+)|(->\w+))*(\.\.\.)?)", cache=False)
 
 # Special RST handling for func ptr params
-type_fp_param = Re(r"\@(\w+)\(\)", cache=False)
+type_fp_param = KernRe(r"\@(\w+)\(\)", cache=False)
 
 # Special RST handling for structs with func ptr params
-type_fp_param2 = Re(r"\@(\w+->\S+)\(\)", cache=False)
+type_fp_param2 = KernRe(r"\@(\w+->\S+)\(\)", cache=False)
 
-type_env = Re(r"(\$\w+)", cache=False)
-type_enum = Re(r"\&(enum\s*([_\w]+))", cache=False)
-type_struct = Re(r"\&(struct\s*([_\w]+))", cache=False)
-type_typedef = Re(r"\&(typedef\s*([_\w]+))", cache=False)
-type_union = Re(r"\&(union\s*([_\w]+))", cache=False)
-type_member = Re(r"\&([_\w]+)(\.|->)([_\w]+)", cache=False)
-type_fallback = Re(r"\&([_\w]+)", cache=False)
-type_member_func = type_member + Re(r"\(\)", cache=False)
+type_env = KernRe(r"(\$\w+)", cache=False)
+type_enum = KernRe(r"\&(enum\s*([_\w]+))", cache=False)
+type_struct = KernRe(r"\&(struct\s*([_\w]+))", cache=False)
+type_typedef = KernRe(r"\&(typedef\s*([_\w]+))", cache=False)
+type_union = KernRe(r"\&(union\s*([_\w]+))", cache=False)
+type_member = KernRe(r"\&([_\w]+)(\.|->)([_\w]+)", cache=False)
+type_fallback = KernRe(r"\&([_\w]+)", cache=False)
+type_member_func = type_member + KernRe(r"\(\)", cache=False)
 
 
 class OutputFormat:
@@ -257,8 +257,8 @@ class RestFormat(OutputFormat):
     ]
     blankline = "\n"
 
-    sphinx_literal = Re(r'^[^.].*::$', cache=False)
-    sphinx_cblock = Re(r'^\.\.\ +code-block::', cache=False)
+    sphinx_literal = KernRe(r'^[^.].*::$', cache=False)
+    sphinx_cblock = KernRe(r'^\.\.\ +code-block::', cache=False)
 
     def __init__(self):
         """
@@ -299,14 +299,14 @@ class RestFormat(OutputFormat):
                     # If this is the first non-blank line in a literal block,
                     # figure out the proper indent.
                     if not litprefix:
-                        r = Re(r'^(\s*)')
+                        r = KernRe(r'^(\s*)')
                         if r.match(line):
                             litprefix = '^' + r.group(1)
                         else:
                             litprefix = ""
 
                         output += line + "\n"
-                    elif not Re(litprefix).match(line):
+                    elif not KernRe(litprefix).match(line):
                         in_literal = False
                     else:
                         output += line + "\n"
@@ -429,7 +429,7 @@ class RestFormat(OutputFormat):
             self.data += f"{self.lineprefix}**Parameters**\n\n"
 
         for parameter in parameterlist:
-            parameter_name = Re(r'\[.*').sub('', parameter)
+            parameter_name = KernRe(r'\[.*').sub('', parameter)
             dtype = args['parametertypes'].get(parameter, "")
 
             if dtype:
@@ -626,7 +626,7 @@ class ManFormat(OutputFormat):
             contents = "\n".join(contents)
 
         for line in contents.strip("\n").split("\n"):
-            line = Re(r"^\s*").sub("", line)
+            line = KernRe(r"^\s*").sub("", line)
             if not line:
                 continue
 
@@ -680,7 +680,7 @@ class ManFormat(OutputFormat):
                 # Pointer-to-function
                 self.data += f'".BI "{parenth}{function_pointer.group(1)}" " ") ({function_pointer.group(2)}){post}"' + "\n"
             else:
-                dtype = Re(r'([^\*])$').sub(r'\1 ', dtype)
+                dtype = KernRe(r'([^\*])$').sub(r'\1 ', dtype)
 
                 self.data += f'.BI "{parenth}{dtype}"  "{post}"' + "\n"
             count += 1
@@ -727,7 +727,7 @@ class ManFormat(OutputFormat):
         self.data += ".SH Constants\n"
 
         for parameter in parameterlist:
-            parameter_name = Re(r'\[.*').sub('', parameter)
+            parameter_name = KernRe(r'\[.*').sub('', parameter)
             self.data += f'.IP "{parameter}" 12' + "\n"
             self.output_highlight(args['parameterdescs'].get(parameter_name, ""))
 
@@ -769,7 +769,7 @@ class ManFormat(OutputFormat):
 
         # Replace tabs with two spaces and handle newlines
         declaration = definition.replace("\t", "  ")
-        declaration = Re(r"\n").sub('"\n.br\n.BI "', declaration)
+        declaration = KernRe(r"\n").sub('"\n.br\n.BI "', declaration)
 
         self.data += ".SH SYNOPSIS\n"
         self.data += f"{struct_type} {struct_name} " + "{" + "\n.br\n"
diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index 33f00c77dd5f..f60722bcc687 100755
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -16,7 +16,7 @@ import argparse
 import re
 from pprint import pformat
 
-from kdoc_re import NestedMatch, Re
+from kdoc_re import NestedMatch, KernRe
 
 
 #
@@ -29,12 +29,12 @@ from kdoc_re import NestedMatch, Re
 #
 
 # Allow whitespace at end of comment start.
-doc_start = Re(r'^/\*\*\s*$', cache=False)
+doc_start = KernRe(r'^/\*\*\s*$', cache=False)
 
-doc_end = Re(r'\*/', cache=False)
-doc_com = Re(r'\s*\*\s*', cache=False)
-doc_com_body = Re(r'\s*\* ?', cache=False)
-doc_decl = doc_com + Re(r'(\w+)', cache=False)
+doc_end = KernRe(r'\*/', cache=False)
+doc_com = KernRe(r'\s*\*\s*', cache=False)
+doc_com_body = KernRe(r'\s*\* ?', cache=False)
+doc_decl = doc_com + KernRe(r'(\w+)', cache=False)
 
 # @params and a strictly limited set of supported section names
 # Specifically:
@@ -44,22 +44,22 @@ doc_decl = doc_com + Re(r'(\w+)', cache=False)
 # while trying to not match literal block starts like "example::"
 #
 doc_sect = doc_com + \
-            Re(r'\s*(\@[.\w]+|\@\.\.\.|description|context|returns?|notes?|examples?)\s*:([^:].*)?$',
+            KernRe(r'\s*(\@[.\w]+|\@\.\.\.|description|context|returns?|notes?|examples?)\s*:([^:].*)?$',
                 flags=re.I, cache=False)
 
-doc_content = doc_com_body + Re(r'(.*)', cache=False)
-doc_block = doc_com + Re(r'DOC:\s*(.*)?', cache=False)
-doc_inline_start = Re(r'^\s*/\*\*\s*$', cache=False)
-doc_inline_sect = Re(r'\s*\*\s*(@\s*[\w][\w\.]*\s*):(.*)', cache=False)
-doc_inline_end = Re(r'^\s*\*/\s*$', cache=False)
-doc_inline_oneline = Re(r'^\s*/\*\*\s*(@[\w\s]+):\s*(.*)\s*\*/\s*$', cache=False)
-attribute = Re(r"__attribute__\s*\(\([a-z0-9,_\*\s\(\)]*\)\)",
+doc_content = doc_com_body + KernRe(r'(.*)', cache=False)
+doc_block = doc_com + KernRe(r'DOC:\s*(.*)?', cache=False)
+doc_inline_start = KernRe(r'^\s*/\*\*\s*$', cache=False)
+doc_inline_sect = KernRe(r'\s*\*\s*(@\s*[\w][\w\.]*\s*):(.*)', cache=False)
+doc_inline_end = KernRe(r'^\s*\*/\s*$', cache=False)
+doc_inline_oneline = KernRe(r'^\s*/\*\*\s*(@[\w\s]+):\s*(.*)\s*\*/\s*$', cache=False)
+attribute = KernRe(r"__attribute__\s*\(\([a-z0-9,_\*\s\(\)]*\)\)",
                flags=re.I | re.S, cache=False)
 
-export_symbol = Re(r'^\s*EXPORT_SYMBOL(_GPL)?\s*\(\s*(\w+)\s*\)\s*', cache=False)
-export_symbol_ns = Re(r'^\s*EXPORT_SYMBOL_NS(_GPL)?\s*\(\s*(\w+)\s*,\s*"\S+"\)\s*', cache=False)
+export_symbol = KernRe(r'^\s*EXPORT_SYMBOL(_GPL)?\s*\(\s*(\w+)\s*\)\s*', cache=False)
+export_symbol_ns = KernRe(r'^\s*EXPORT_SYMBOL_NS(_GPL)?\s*\(\s*(\w+)\s*,\s*"\S+"\)\s*', cache=False)
 
-type_param = Re(r"\@(\w*((\.\w+)|(->\w+))*(\.\.\.)?)", cache=False)
+type_param = KernRe(r"\@(\w*((\.\w+)|(->\w+))*(\.\.\.)?)", cache=False)
 
 
 class KernelDoc:
@@ -278,10 +278,10 @@ class KernelDoc:
 
         self.entry.anon_struct_union = False
 
-        param = Re(r'[\[\)].*').sub('', param, count=1)
+        param = KernRe(r'[\[\)].*').sub('', param, count=1)
 
         if dtype == "" and param.endswith("..."):
-            if Re(r'\w\.\.\.$').search(param):
+            if KernRe(r'\w\.\.\.$').search(param):
                 # For named variable parameters of the form `x...`,
                 # remove the dots
                 param = param[:-3]
@@ -335,7 +335,7 @@ class KernelDoc:
         # to ignore "[blah" in a parameter string.
 
         self.entry.parameterlist.append(param)
-        org_arg = Re(r'\s\s+').sub(' ', org_arg)
+        org_arg = KernRe(r'\s\s+').sub(' ', org_arg)
         self.entry.parametertypes[param] = org_arg
 
     def save_struct_actual(self, actual):
@@ -344,7 +344,7 @@ class KernelDoc:
         one string item.
         """
 
-        actual = Re(r'\s*').sub("", actual, count=1)
+        actual = KernRe(r'\s*').sub("", actual, count=1)
 
         self.entry.struct_actual += actual + " "
 
@@ -355,20 +355,20 @@ class KernelDoc:
         """
 
         # temporarily replace all commas inside function pointer definition
-        arg_expr = Re(r'(\([^\),]+),')
+        arg_expr = KernRe(r'(\([^\),]+),')
         while arg_expr.search(args):
             args = arg_expr.sub(r"\1#", args)
 
         for arg in args.split(splitter):
             # Strip comments
-            arg = Re(r'\/\*.*\*\/').sub('', arg)
+            arg = KernRe(r'\/\*.*\*\/').sub('', arg)
 
             # Ignore argument attributes
-            arg = Re(r'\sPOS0?\s').sub(' ', arg)
+            arg = KernRe(r'\sPOS0?\s').sub(' ', arg)
 
             # Strip leading/trailing spaces
             arg = arg.strip()
-            arg = Re(r'\s+').sub(' ', arg, count=1)
+            arg = KernRe(r'\s+').sub(' ', arg, count=1)
 
             if arg.startswith('#'):
                 # Treat preprocessor directive as a typeless variable just to fill
@@ -379,63 +379,63 @@ class KernelDoc:
                 self.push_parameter(ln, decl_type, arg, "",
                                     "", declaration_name)
 
-            elif Re(r'\(.+\)\s*\(').search(arg):
+            elif KernRe(r'\(.+\)\s*\(').search(arg):
                 # Pointer-to-function
 
                 arg = arg.replace('#', ',')
 
-                r = Re(r'[^\(]+\(\*?\s*([\w\[\]\.]*)\s*\)')
+                r = KernRe(r'[^\(]+\(\*?\s*([\w\[\]\.]*)\s*\)')
                 if r.match(arg):
                     param = r.group(1)
                 else:
                     self.emit_warning(ln, f"Invalid param: {arg}")
                     param = arg
 
-                dtype = Re(r'([^\(]+\(\*?)\s*' + re.escape(param)).sub(r'\1', arg)
+                dtype = KernRe(r'([^\(]+\(\*?)\s*' + re.escape(param)).sub(r'\1', arg)
                 self.save_struct_actual(param)
                 self.push_parameter(ln, decl_type, param, dtype,
                                     arg, declaration_name)
 
-            elif Re(r'\(.+\)\s*\[').search(arg):
+            elif KernRe(r'\(.+\)\s*\[').search(arg):
                 # Array-of-pointers
 
                 arg = arg.replace('#', ',')
-                r = Re(r'[^\(]+\(\s*\*\s*([\w\[\]\.]*?)\s*(\s*\[\s*[\w]+\s*\]\s*)*\)')
+                r = KernRe(r'[^\(]+\(\s*\*\s*([\w\[\]\.]*?)\s*(\s*\[\s*[\w]+\s*\]\s*)*\)')
                 if r.match(arg):
                     param = r.group(1)
                 else:
                     self.emit_warning(ln, f"Invalid param: {arg}")
                     param = arg
 
-                dtype = Re(r'([^\(]+\(\*?)\s*' + re.escape(param)).sub(r'\1', arg)
+                dtype = KernRe(r'([^\(]+\(\*?)\s*' + re.escape(param)).sub(r'\1', arg)
 
                 self.save_struct_actual(param)
                 self.push_parameter(ln, decl_type, param, dtype,
                                     arg, declaration_name)
 
             elif arg:
-                arg = Re(r'\s*:\s*').sub(":", arg)
-                arg = Re(r'\s*\[').sub('[', arg)
+                arg = KernRe(r'\s*:\s*').sub(":", arg)
+                arg = KernRe(r'\s*\[').sub('[', arg)
 
-                args = Re(r'\s*,\s*').split(arg)
+                args = KernRe(r'\s*,\s*').split(arg)
                 if args[0] and '*' in args[0]:
                     args[0] = re.sub(r'(\*+)\s*', r' \1', args[0])
 
                 first_arg = []
-                r = Re(r'^(.*\s+)(.*?\[.*\].*)$')
+                r = KernRe(r'^(.*\s+)(.*?\[.*\].*)$')
                 if args[0] and r.match(args[0]):
                     args.pop(0)
                     first_arg.extend(r.group(1))
                     first_arg.append(r.group(2))
                 else:
-                    first_arg = Re(r'\s+').split(args.pop(0))
+                    first_arg = KernRe(r'\s+').split(args.pop(0))
 
                 args.insert(0, first_arg.pop())
                 dtype = ' '.join(first_arg)
 
                 for param in args:
-                    if Re(r'^(\*+)\s*(.*)').match(param):
-                        r = Re(r'^(\*+)\s*(.*)')
+                    if KernRe(r'^(\*+)\s*(.*)').match(param):
+                        r = KernRe(r'^(\*+)\s*(.*)')
                         if not r.match(param):
                             self.emit_warning(ln, f"Invalid param: {param}")
                             continue
@@ -447,8 +447,8 @@ class KernelDoc:
                                             f"{dtype} {r.group(1)}",
                                             arg, declaration_name)
 
-                    elif Re(r'(.*?):(\w+)').search(param):
-                        r = Re(r'(.*?):(\w+)')
+                    elif KernRe(r'(.*?):(\w+)').search(param):
+                        r = KernRe(r'(.*?):(\w+)')
                         if not r.match(param):
                             self.emit_warning(ln, f"Invalid param: {param}")
                             continue
@@ -477,7 +477,7 @@ class KernelDoc:
             err = True
             for px in range(len(prms)):               # pylint: disable=C0200
                 prm_clean = prms[px]
-                prm_clean = Re(r'\[.*\]').sub('', prm_clean)
+                prm_clean = KernRe(r'\[.*\]').sub('', prm_clean)
                 prm_clean = attribute.sub('', prm_clean)
 
                 # ignore array size in a parameter string;
@@ -486,7 +486,7 @@ class KernelDoc:
                 # and this appears in @prms as "addr[6" since the
                 # parameter list is split at spaces;
                 # hence just ignore "[..." for the sections check;
-                prm_clean = Re(r'\[.*').sub('', prm_clean)
+                prm_clean = KernRe(r'\[.*').sub('', prm_clean)
 
                 if prm_clean == sects[sx]:
                     err = False
@@ -512,7 +512,7 @@ class KernelDoc:
 
         # Ignore an empty return type (It's a macro)
         # Ignore functions with a "void" return type (but not "void *")
-        if not return_type or Re(r'void\s*\w*\s*$').search(return_type):
+        if not return_type or KernRe(r'void\s*\w*\s*$').search(return_type):
             return
 
         if not self.entry.sections.get("Return", None):
@@ -535,20 +535,20 @@ class KernelDoc:
         ]
 
         definition_body = r'\{(.*)\}\s*' + "(?:" + '|'.join(qualifiers) + ")?"
-        struct_members = Re(type_pattern + r'([^\{\};]+)(\{)([^\{\}]*)(\})([^\{\}\;]*)(\;)')
+        struct_members = KernRe(type_pattern + r'([^\{\};]+)(\{)([^\{\}]*)(\})([^\{\}\;]*)(\;)')
 
         # Extract struct/union definition
         members = None
         declaration_name = None
         decl_type = None
 
-        r = Re(type_pattern + r'\s+(\w+)\s*' + definition_body)
+        r = KernRe(type_pattern + r'\s+(\w+)\s*' + definition_body)
         if r.search(proto):
             decl_type = r.group(1)
             declaration_name = r.group(2)
             members = r.group(3)
         else:
-            r = Re(r'typedef\s+' + type_pattern + r'\s*' + definition_body + r'\s*(\w+)\s*;')
+            r = KernRe(r'typedef\s+' + type_pattern + r'\s*' + definition_body + r'\s*(\w+)\s*;')
 
             if r.search(proto):
                 decl_type = r.group(1)
@@ -567,21 +567,21 @@ class KernelDoc:
         args_pattern = r'([^,)]+)'
 
         sub_prefixes = [
-            (Re(r'\/\*\s*private:.*?\/\*\s*public:.*?\*\/', re.S | re.I), ''),
-            (Re(r'\/\*\s*private:.*', re.S | re.I), ''),
+            (KernRe(r'\/\*\s*private:.*?\/\*\s*public:.*?\*\/', re.S | re.I), ''),
+            (KernRe(r'\/\*\s*private:.*', re.S | re.I), ''),
 
             # Strip comments
-            (Re(r'\/\*.*?\*\/', re.S), ''),
+            (KernRe(r'\/\*.*?\*\/', re.S), ''),
 
             # Strip attributes
             (attribute, ' '),
-            (Re(r'\s*__aligned\s*\([^;]*\)', re.S), ' '),
-            (Re(r'\s*__counted_by\s*\([^;]*\)', re.S), ' '),
-            (Re(r'\s*__counted_by_(le|be)\s*\([^;]*\)', re.S), ' '),
-            (Re(r'\s*__packed\s*', re.S), ' '),
-            (Re(r'\s*CRYPTO_MINALIGN_ATTR', re.S), ' '),
-            (Re(r'\s*____cacheline_aligned_in_smp', re.S), ' '),
-            (Re(r'\s*____cacheline_aligned', re.S), ' '),
+            (KernRe(r'\s*__aligned\s*\([^;]*\)', re.S), ' '),
+            (KernRe(r'\s*__counted_by\s*\([^;]*\)', re.S), ' '),
+            (KernRe(r'\s*__counted_by_(le|be)\s*\([^;]*\)', re.S), ' '),
+            (KernRe(r'\s*__packed\s*', re.S), ' '),
+            (KernRe(r'\s*CRYPTO_MINALIGN_ATTR', re.S), ' '),
+            (KernRe(r'\s*____cacheline_aligned_in_smp', re.S), ' '),
+            (KernRe(r'\s*____cacheline_aligned', re.S), ' '),
 
             # Unwrap struct_group macros based on this definition:
             # __struct_group(TAG, NAME, ATTRS, MEMBERS...)
@@ -616,10 +616,10 @@ class KernelDoc:
             # matched. So, the implementation to drop STRUCT_GROUP() will be
             # handled in separate.
 
-            (Re(r'\bstruct_group\s*\(([^,]*,)', re.S), r'STRUCT_GROUP('),
-            (Re(r'\bstruct_group_attr\s*\(([^,]*,){2}', re.S), r'STRUCT_GROUP('),
-            (Re(r'\bstruct_group_tagged\s*\(([^,]*),([^,]*),', re.S), r'struct \1 \2; STRUCT_GROUP('),
-            (Re(r'\b__struct_group\s*\(([^,]*,){3}', re.S), r'STRUCT_GROUP('),
+            (KernRe(r'\bstruct_group\s*\(([^,]*,)', re.S), r'STRUCT_GROUP('),
+            (KernRe(r'\bstruct_group_attr\s*\(([^,]*,){2}', re.S), r'STRUCT_GROUP('),
+            (KernRe(r'\bstruct_group_tagged\s*\(([^,]*),([^,]*),', re.S), r'struct \1 \2; STRUCT_GROUP('),
+            (KernRe(r'\b__struct_group\s*\(([^,]*,){3}', re.S), r'STRUCT_GROUP('),
 
             # Replace macros
             #
@@ -628,15 +628,15 @@ class KernelDoc:
             # it is better to also move those to the NestedMatch logic,
             # to ensure that parenthesis will be properly matched.
 
-            (Re(r'__ETHTOOL_DECLARE_LINK_MODE_MASK\s*\(([^\)]+)\)', re.S), r'DECLARE_BITMAP(\1, __ETHTOOL_LINK_MODE_MASK_NBITS)'),
-            (Re(r'DECLARE_PHY_INTERFACE_MASK\s*\(([^\)]+)\)', re.S), r'DECLARE_BITMAP(\1, PHY_INTERFACE_MODE_MAX)'),
-            (Re(r'DECLARE_BITMAP\s*\(' + args_pattern + r',\s*' + args_pattern + r'\)', re.S), r'unsigned long \1[BITS_TO_LONGS(\2)]'),
-            (Re(r'DECLARE_HASHTABLE\s*\(' + args_pattern + r',\s*' + args_pattern + r'\)', re.S), r'unsigned long \1[1 << ((\2) - 1)]'),
-            (Re(r'DECLARE_KFIFO\s*\(' + args_pattern + r',\s*' + args_pattern + r',\s*' + args_pattern + r'\)', re.S), r'\2 *\1'),
-            (Re(r'DECLARE_KFIFO_PTR\s*\(' + args_pattern + r',\s*' + args_pattern + r'\)', re.S), r'\2 *\1'),
-            (Re(r'(?:__)?DECLARE_FLEX_ARRAY\s*\(' + args_pattern + r',\s*' + args_pattern + r'\)', re.S), r'\1 \2[]'),
-            (Re(r'DEFINE_DMA_UNMAP_ADDR\s*\(' + args_pattern + r'\)', re.S), r'dma_addr_t \1'),
-            (Re(r'DEFINE_DMA_UNMAP_LEN\s*\(' + args_pattern + r'\)', re.S), r'__u32 \1'),
+            (KernRe(r'__ETHTOOL_DECLARE_LINK_MODE_MASK\s*\(([^\)]+)\)', re.S), r'DECLARE_BITMAP(\1, __ETHTOOL_LINK_MODE_MASK_NBITS)'),
+            (KernRe(r'DECLARE_PHY_INTERFACE_MASK\s*\(([^\)]+)\)', re.S), r'DECLARE_BITMAP(\1, PHY_INTERFACE_MODE_MAX)'),
+            (KernRe(r'DECLARE_BITMAP\s*\(' + args_pattern + r',\s*' + args_pattern + r'\)', re.S), r'unsigned long \1[BITS_TO_LONGS(\2)]'),
+            (KernRe(r'DECLARE_HASHTABLE\s*\(' + args_pattern + r',\s*' + args_pattern + r'\)', re.S), r'unsigned long \1[1 << ((\2) - 1)]'),
+            (KernRe(r'DECLARE_KFIFO\s*\(' + args_pattern + r',\s*' + args_pattern + r',\s*' + args_pattern + r'\)', re.S), r'\2 *\1'),
+            (KernRe(r'DECLARE_KFIFO_PTR\s*\(' + args_pattern + r',\s*' + args_pattern + r'\)', re.S), r'\2 *\1'),
+            (KernRe(r'(?:__)?DECLARE_FLEX_ARRAY\s*\(' + args_pattern + r',\s*' + args_pattern + r'\)', re.S), r'\1 \2[]'),
+            (KernRe(r'DEFINE_DMA_UNMAP_ADDR\s*\(' + args_pattern + r'\)', re.S), r'dma_addr_t \1'),
+            (KernRe(r'DEFINE_DMA_UNMAP_LEN\s*\(' + args_pattern + r'\)', re.S), r'__u32 \1'),
         ]
 
         # Regexes here are guaranteed to have the end limiter matching
@@ -689,8 +689,8 @@ class KernelDoc:
                     s_id = s_id.strip()
 
                     newmember += f"{maintype} {s_id}; "
-                    s_id = Re(r'[:\[].*').sub('', s_id)
-                    s_id = Re(r'^\s*\**(\S+)\s*').sub(r'\1', s_id)
+                    s_id = KernRe(r'[:\[].*').sub('', s_id)
+                    s_id = KernRe(r'^\s*\**(\S+)\s*').sub(r'\1', s_id)
 
                     for arg in content.split(';'):
                         arg = arg.strip()
@@ -698,7 +698,7 @@ class KernelDoc:
                         if not arg:
                             continue
 
-                        r = Re(r'^([^\(]+\(\*?\s*)([\w\.]*)(\s*\).*)')
+                        r = KernRe(r'^([^\(]+\(\*?\s*)([\w\.]*)(\s*\).*)')
                         if r.match(arg):
                             # Pointer-to-function
                             dtype = r.group(1)
@@ -717,15 +717,15 @@ class KernelDoc:
                         else:
                             arg = arg.strip()
                             # Handle bitmaps
-                            arg = Re(r':\s*\d+\s*').sub('', arg)
+                            arg = KernRe(r':\s*\d+\s*').sub('', arg)
 
                             # Handle arrays
-                            arg = Re(r'\[.*\]').sub('', arg)
+                            arg = KernRe(r'\[.*\]').sub('', arg)
 
                             # Handle multiple IDs
-                            arg = Re(r'\s*,\s*').sub(',', arg)
+                            arg = KernRe(r'\s*,\s*').sub(',', arg)
 
-                            r = Re(r'(.*)\s+([\S+,]+)')
+                            r = KernRe(r'(.*)\s+([\S+,]+)')
 
                             if r.search(arg):
                                 dtype = r.group(1)
@@ -735,7 +735,7 @@ class KernelDoc:
                                 continue
 
                             for name in names.split(','):
-                                name = Re(r'^\s*\**(\S+)\s*').sub(r'\1', name).strip()
+                                name = KernRe(r'^\s*\**(\S+)\s*').sub(r'\1', name).strip()
 
                                 if not name:
                                     continue
@@ -757,12 +757,12 @@ class KernelDoc:
                             self.entry.sectcheck, self.entry.struct_actual)
 
         # Adjust declaration for better display
-        declaration = Re(r'([\{;])').sub(r'\1\n', declaration)
-        declaration = Re(r'\}\s+;').sub('};', declaration)
+        declaration = KernRe(r'([\{;])').sub(r'\1\n', declaration)
+        declaration = KernRe(r'\}\s+;').sub('};', declaration)
 
         # Better handle inlined enums
         while True:
-            r = Re(r'(enum\s+\{[^\}]+),([^\n])')
+            r = KernRe(r'(enum\s+\{[^\}]+),([^\n])')
             if not r.search(declaration):
                 break
 
@@ -774,7 +774,7 @@ class KernelDoc:
         for clause in def_args:
 
             clause = clause.strip()
-            clause = Re(r'\s+').sub(' ', clause, count=1)
+            clause = KernRe(r'\s+').sub(' ', clause, count=1)
 
             if not clause:
                 continue
@@ -782,7 +782,7 @@ class KernelDoc:
             if '}' in clause and level > 1:
                 level -= 1
 
-            if not Re(r'^\s*#').match(clause):
+            if not KernRe(r'^\s*#').match(clause):
                 declaration += "\t" * level
 
             declaration += "\t" + clause + "\n"
@@ -807,24 +807,24 @@ class KernelDoc:
         """
 
         # Ignore members marked private
-        proto = Re(r'\/\*\s*private:.*?\/\*\s*public:.*?\*\/', flags=re.S).sub('', proto)
-        proto = Re(r'\/\*\s*private:.*}', flags=re.S).sub('}', proto)
+        proto = KernRe(r'\/\*\s*private:.*?\/\*\s*public:.*?\*\/', flags=re.S).sub('', proto)
+        proto = KernRe(r'\/\*\s*private:.*}', flags=re.S).sub('}', proto)
 
         # Strip comments
-        proto = Re(r'\/\*.*?\*\/', flags=re.S).sub('', proto)
+        proto = KernRe(r'\/\*.*?\*\/', flags=re.S).sub('', proto)
 
         # Strip #define macros inside enums
-        proto = Re(r'#\s*((define|ifdef|if)\s+|endif)[^;]*;', flags=re.S).sub('', proto)
+        proto = KernRe(r'#\s*((define|ifdef|if)\s+|endif)[^;]*;', flags=re.S).sub('', proto)
 
         members = None
         declaration_name = None
 
-        r = Re(r'typedef\s+enum\s*\{(.*)\}\s*(\w*)\s*;')
+        r = KernRe(r'typedef\s+enum\s*\{(.*)\}\s*(\w*)\s*;')
         if r.search(proto):
             declaration_name = r.group(2)
             members = r.group(1).rstrip()
         else:
-            r = Re(r'enum\s+(\w*)\s*\{(.*)\}')
+            r = KernRe(r'enum\s+(\w*)\s*\{(.*)\}')
             if r.match(proto):
                 declaration_name = r.group(1)
                 members = r.group(2).rstrip()
@@ -847,12 +847,12 @@ class KernelDoc:
 
         member_set = set()
 
-        members = Re(r'\([^;]*?[\)]').sub('', members)
+        members = KernRe(r'\([^;]*?[\)]').sub('', members)
 
         for arg in members.split(','):
             if not arg:
                 continue
-            arg = Re(r'^\s*(\w+).*').sub(r'\1', arg)
+            arg = KernRe(r'^\s*(\w+).*').sub(r'\1', arg)
             self.entry.parameterlist.append(arg)
             if arg not in self.entry.parameterdescs:
                 self.entry.parameterdescs[arg] = self.undescribed
@@ -947,10 +947,10 @@ class KernelDoc:
         ]
 
         for search, sub, flags in sub_prefixes:
-            prototype = Re(search, flags).sub(sub, prototype)
+            prototype = KernRe(search, flags).sub(sub, prototype)
 
         # Macros are a special case, as they change the prototype format
-        new_proto = Re(r"^#\s*define\s+").sub("", prototype)
+        new_proto = KernRe(r"^#\s*define\s+").sub("", prototype)
         if new_proto != prototype:
             is_define_proto = True
             prototype = new_proto
@@ -987,7 +987,7 @@ class KernelDoc:
         found = False
 
         if is_define_proto:
-            r = Re(r'^()(' + name + r')\s+')
+            r = KernRe(r'^()(' + name + r')\s+')
 
             if r.search(prototype):
                 return_type = ''
@@ -1004,7 +1004,7 @@ class KernelDoc:
             ]
 
             for p in patterns:
-                r = Re(p)
+                r = KernRe(p)
 
                 if r.match(prototype):
 
@@ -1071,11 +1071,11 @@ class KernelDoc:
         typedef_ident = r'\*?\s*(\w\S+)\s*'
         typedef_args = r'\s*\((.*)\);'
 
-        typedef1 = Re(r'typedef' + typedef_type + r'\(' + typedef_ident + r'\)' + typedef_args)
-        typedef2 = Re(r'typedef' + typedef_type + typedef_ident + typedef_args)
+        typedef1 = KernRe(r'typedef' + typedef_type + r'\(' + typedef_ident + r'\)' + typedef_args)
+        typedef2 = KernRe(r'typedef' + typedef_type + typedef_ident + typedef_args)
 
         # Strip comments
-        proto = Re(r'/\*.*?\*/', flags=re.S).sub('', proto)
+        proto = KernRe(r'/\*.*?\*/', flags=re.S).sub('', proto)
 
         # Parse function typedef prototypes
         for r in [typedef1, typedef2]:
@@ -1109,12 +1109,12 @@ class KernelDoc:
             return
 
         # Handle nested parentheses or brackets
-        r = Re(r'(\(*.\)\s*|\[*.\]\s*);$')
+        r = KernRe(r'(\(*.\)\s*|\[*.\]\s*);$')
         while r.search(proto):
             proto = r.sub('', proto)
 
         # Parse simple typedefs
-        r = Re(r'typedef.*\s+(\w+)\s*;')
+        r = KernRe(r'typedef.*\s+(\w+)\s*;')
         if r.match(proto):
             declaration_name = r.group(1)
 
@@ -1195,12 +1195,12 @@ class KernelDoc:
             decl_end = r"(?:[-:].*)"         # end of the name part
 
             # test for pointer declaration type, foo * bar() - desc
-            r = Re(fr"^{decl_start}([\w\s]+?){parenthesis}?\s*{decl_end}?$")
+            r = KernRe(fr"^{decl_start}([\w\s]+?){parenthesis}?\s*{decl_end}?$")
             if r.search(line):
                 self.entry.identifier = r.group(1)
 
             # Test for data declaration
-            r = Re(r"^\s*\*?\s*(struct|union|enum|typedef)\b\s*(\w*)")
+            r = KernRe(r"^\s*\*?\s*(struct|union|enum|typedef)\b\s*(\w*)")
             if r.search(line):
                 self.entry.decl_type = r.group(1)
                 self.entry.identifier = r.group(2)
@@ -1209,15 +1209,15 @@ class KernelDoc:
                 # Look for foo() or static void foo() - description;
                 # or misspelt identifier
 
-                r1 = Re(fr"^{decl_start}{fn_type}(\w+)\s*{parenthesis}\s*{decl_end}?$")
-                r2 = Re(fr"^{decl_start}{fn_type}(\w+[^-:]*){parenthesis}\s*{decl_end}$")
+                r1 = KernRe(fr"^{decl_start}{fn_type}(\w+)\s*{parenthesis}\s*{decl_end}?$")
+                r2 = KernRe(fr"^{decl_start}{fn_type}(\w+[^-:]*){parenthesis}\s*{decl_end}$")
 
                 for r in [r1, r2]:
                     if r.search(line):
                         self.entry.identifier = r.group(1)
                         self.entry.decl_type = "function"
 
-                        r = Re(r"define\s+")
+                        r = KernRe(r"define\s+")
                         self.entry.identifier = r.sub("", self.entry.identifier)
                         self.entry.is_kernel_comment = True
                         break
@@ -1230,12 +1230,12 @@ class KernelDoc:
             self.entry.section = self.section_default
             self.entry.new_start_line = ln + 1
 
-            r = Re("[-:](.*)")
+            r = KernRe("[-:](.*)")
             if r.search(line):
                 # strip leading/trailing/multiple spaces
                 self.entry.descr = r.group(1).strip(" ")
 
-                r = Re(r"\s+")
+                r = KernRe(r"\s+")
                 self.entry.descr = r.sub(" ", self.entry.descr)
                 self.entry.declaration_purpose = self.entry.descr
                 self.state = self.STATE_BODY_MAYBE
@@ -1272,7 +1272,7 @@ class KernelDoc:
         """
 
         if self.state == self.STATE_BODY_WITH_BLANK_LINE:
-            r = Re(r"\s*\*\s?\S")
+            r = KernRe(r"\s*\*\s?\S")
             if r.match(line):
                 self.dump_section()
                 self.entry.section = self.section_default
@@ -1318,7 +1318,7 @@ class KernelDoc:
             self.dump_section()
 
             # Look for doc_com + <text> + doc_end:
-            r = Re(r'\s*\*\s*[a-zA-Z_0-9:\.]+\*/')
+            r = KernRe(r'\s*\*\s*[a-zA-Z_0-9:\.]+\*/')
             if r.match(line):
                 self.emit_warning(ln, f"suspicious ending line: {line}")
 
@@ -1351,7 +1351,7 @@ class KernelDoc:
                 self.entry.declaration_purpose = self.entry.declaration_purpose.rstrip()
                 self.entry.declaration_purpose += " " + cont
 
-                r = Re(r"\s+")
+                r = KernRe(r"\s+")
                 self.entry.declaration_purpose = r.sub(' ',
                                                        self.entry.declaration_purpose)
 
@@ -1359,7 +1359,7 @@ class KernelDoc:
                 if self.entry.section.startswith('@') or        \
                    self.entry.section == self.section_context:
                     if self.entry.leading_space is None:
-                        r = Re(r'^(\s+)')
+                        r = KernRe(r'^(\s+)')
                         if r.match(cont):
                             self.entry.leading_space = len(r.group(1))
                         else:
@@ -1436,13 +1436,13 @@ class KernelDoc:
             is_void = True
 
         # Replace SYSCALL_DEFINE with correct return type & function name
-        proto = Re(r'SYSCALL_DEFINE.*\(').sub('long sys_', proto)
+        proto = KernRe(r'SYSCALL_DEFINE.*\(').sub('long sys_', proto)
 
-        r = Re(r'long\s+(sys_.*?),')
+        r = KernRe(r'long\s+(sys_.*?),')
         if r.search(proto):
-            proto = Re(',').sub('(', proto, count=1)
+            proto = KernRe(',').sub('(', proto, count=1)
         elif is_void:
-            proto = Re(r'\)').sub('(void)', proto, count=1)
+            proto = KernRe(r'\)').sub('(void)', proto, count=1)
 
         # Now delete all of the odd-numbered commas in the proto
         # so that argument types & names don't have a comma between them
@@ -1469,22 +1469,22 @@ class KernelDoc:
         tracepointargs = None
 
         # Match tracepoint name based on different patterns
-        r = Re(r'TRACE_EVENT\((.*?),')
+        r = KernRe(r'TRACE_EVENT\((.*?),')
         if r.search(proto):
             tracepointname = r.group(1)
 
-        r = Re(r'DEFINE_SINGLE_EVENT\((.*?),')
+        r = KernRe(r'DEFINE_SINGLE_EVENT\((.*?),')
         if r.search(proto):
             tracepointname = r.group(1)
 
-        r = Re(r'DEFINE_EVENT\((.*?),(.*?),')
+        r = KernRe(r'DEFINE_EVENT\((.*?),(.*?),')
         if r.search(proto):
             tracepointname = r.group(2)
 
         if tracepointname:
             tracepointname = tracepointname.lstrip()
 
-        r = Re(r'TP_PROTO\((.*?)\)')
+        r = KernRe(r'TP_PROTO\((.*?)\)')
         if r.search(proto):
             tracepointargs = r.group(1)
 
@@ -1501,43 +1501,43 @@ class KernelDoc:
         """Ancillary routine to process a function prototype"""
 
         # strip C99-style comments to end of line
-        r = Re(r"\/\/.*$", re.S)
+        r = KernRe(r"\/\/.*$", re.S)
         line = r.sub('', line)
 
-        if Re(r'\s*#\s*define').match(line):
+        if KernRe(r'\s*#\s*define').match(line):
             self.entry.prototype = line
         elif line.startswith('#'):
             # Strip other macros like #ifdef/#ifndef/#endif/...
             pass
         else:
-            r = Re(r'([^\{]*)')
+            r = KernRe(r'([^\{]*)')
             if r.match(line):
                 self.entry.prototype += r.group(1) + " "
 
-        if '{' in line or ';' in line or Re(r'\s*#\s*define').match(line):
+        if '{' in line or ';' in line or KernRe(r'\s*#\s*define').match(line):
             # strip comments
-            r = Re(r'/\*.*?\*/')
+            r = KernRe(r'/\*.*?\*/')
             self.entry.prototype = r.sub('', self.entry.prototype)
 
             # strip newlines/cr's
-            r = Re(r'[\r\n]+')
+            r = KernRe(r'[\r\n]+')
             self.entry.prototype = r.sub(' ', self.entry.prototype)
 
             # strip leading spaces
-            r = Re(r'^\s+')
+            r = KernRe(r'^\s+')
             self.entry.prototype = r.sub('', self.entry.prototype)
 
             # Handle self.entry.prototypes for function pointers like:
             #       int (*pcs_config)(struct foo)
 
-            r = Re(r'^(\S+\s+)\(\s*\*(\S+)\)')
+            r = KernRe(r'^(\S+\s+)\(\s*\*(\S+)\)')
             self.entry.prototype = r.sub(r'\1\2', self.entry.prototype)
 
             if 'SYSCALL_DEFINE' in self.entry.prototype:
                 self.entry.prototype = self.syscall_munge(ln,
                                                           self.entry.prototype)
 
-            r = Re(r'TRACE_EVENT|DEFINE_EVENT|DEFINE_SINGLE_EVENT')
+            r = KernRe(r'TRACE_EVENT|DEFINE_EVENT|DEFINE_SINGLE_EVENT')
             if r.search(self.entry.prototype):
                 self.entry.prototype = self.tracepoint_munge(ln,
                                                              self.entry.prototype)
@@ -1549,22 +1549,22 @@ class KernelDoc:
         """Ancillary routine to process a type"""
 
         # Strip newlines/cr's.
-        line = Re(r'[\r\n]+', re.S).sub(' ', line)
+        line = KernRe(r'[\r\n]+', re.S).sub(' ', line)
 
         # Strip leading spaces
-        line = Re(r'^\s+', re.S).sub('', line)
+        line = KernRe(r'^\s+', re.S).sub('', line)
 
         # Strip trailing spaces
-        line = Re(r'\s+$', re.S).sub('', line)
+        line = KernRe(r'\s+$', re.S).sub('', line)
 
         # Strip C99-style comments to the end of the line
-        line = Re(r"\/\/.*$", re.S).sub('', line)
+        line = KernRe(r"\/\/.*$", re.S).sub('', line)
 
         # To distinguish preprocessor directive from regular declaration later.
         if line.startswith('#'):
             line += ";"
 
-        r = Re(r'([^\{\};]*)([\{\};])(.*)')
+        r = KernRe(r'([^\{\};]*)([\{\};])(.*)')
         while True:
             if r.search(line):
                 if self.entry.prototype:
diff --git a/scripts/lib/kdoc/kdoc_re.py b/scripts/lib/kdoc/kdoc_re.py
index d28485ff94d6..e81695b273bf 100755
--- a/scripts/lib/kdoc/kdoc_re.py
+++ b/scripts/lib/kdoc/kdoc_re.py
@@ -14,7 +14,7 @@ import re
 re_cache = {}
 
 
-class Re:
+class KernRe:
     """
     Helper class to simplify regex declaration and usage,
 
@@ -59,7 +59,7 @@ class Re:
         Allows adding two regular expressions into one.
         """
 
-        return Re(str(self) + str(other), cache=self.cache or other.cache,
+        return KernRe(str(self) + str(other), cache=self.cache or other.cache,
                   flags=self.regex.flags | other.regex.flags)
 
     def match(self, string):
-- 
2.49.0

