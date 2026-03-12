Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E17386C28;
	Thu, 12 Mar 2026 14:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327299; cv=none; b=UGRsHuLPur7uo0068ueX0qzwEX9NPrtBsWC1ZSt005nnHP78CgFDgTBV7zPwBLIkv16Fhwry+XB6iMCqDwAFKl1bjnvExoEKnbiXEWjiS7efoy+f8VY4ltSTGG7wt1vYQcksvHb8+6jYTLOd/smpPyZFw14+Sb73hqxSTwcT+3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327299; c=relaxed/simple;
	bh=zOKHmzkMNv9adn5XjVfGPcBJEHVDbzJj2NJH579/y9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RhXd+ZWWsM4i89m/MWxFQk3kx+iSkY3cWfssTfCCVuQAJk3OpP/rtISBOv7jsNEtrfIHTCJ1i3zgvDnKFijqt6J6yT4lU/Msbq0KQey+Z3DWIiqI22xyHOSIlnNA/kCjy4cHHr9Ok9IrL2Kvojx9VasBCE/QEgrxDD4yTCb+2eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N23AUYDq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N23AUYDq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96CFFC2BC86;
	Thu, 12 Mar 2026 14:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773327298;
	bh=zOKHmzkMNv9adn5XjVfGPcBJEHVDbzJj2NJH579/y9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N23AUYDqgUHet8QaATG/YTctFPiwpBDRiC+VBbxMgvod0+XB9vfmm6pMYjsxNwjQy
	 PNjHI7MRzoNWnKMpKC1kDtvqIPKoTFdnAqchkTRQn6Arx7fjskAo4dksNeu40FVNW8
	 rJ7+sJSWcnzNC60TvHQtW1W2DTCUUkC/Y8LioILGqd4jRspnOB54rpwaDd2ydjS4L2
	 na3WEGLtuRW+TKqSP3mU+lg0y1Yz05BPkn2tpLAe05KauoTPruZNPtJW//AWzD3ohr
	 1ueklr3ZhN7gLGqfsp4hAFnQR0BRChPZ4TOhPq8jVsPO3Z3JhEtrmxFP+tZYMhYr6k
	 djSt5SRajnUKA==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1w0hRA-00000008xtf-2uD5;
	Thu, 12 Mar 2026 15:54:56 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 07/28] docs: kdoc: move C Tokenizer to c_lex module
Date: Thu, 12 Mar 2026 15:54:27 +0100
Message-ID: <6f325ef5c6be846c21b0c4df0f48bd0deeb236b0.1773326442.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1773326442.git.mchehab+huawei@kernel.org>
References: <cover.1773326442.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Place the C tokenizer on a different module.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/lib/python/kdoc/c_lex.py       | 239 +++++++++++++++++++++++++++
 tools/lib/python/kdoc/kdoc_parser.py |   3 +-
 tools/lib/python/kdoc/kdoc_re.py     | 233 --------------------------
 3 files changed, 241 insertions(+), 234 deletions(-)
 create mode 100644 tools/lib/python/kdoc/c_lex.py

diff --git a/tools/lib/python/kdoc/c_lex.py b/tools/lib/python/kdoc/c_lex.py
new file mode 100644
index 000000000000..a104c29b63fb
--- /dev/null
+++ b/tools/lib/python/kdoc/c_lex.py
@@ -0,0 +1,239 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+# Copyright(c) 2025: Mauro Carvalho Chehab <mchehab@kernel.org>.
+
+"""
+Regular expression ancillary classes.
+
+Those help caching regular expressions and do matching for kernel-doc.
+"""
+
+import re
+
+from .kdoc_re import KernRe
+
+class CToken():
+    """
+    Data class to define a C token.
+    """
+
+    # Tokens that can be used by the parser. Works like an C enum.
+
+    COMMENT = 0     #: A standard C or C99 comment, including delimiter.
+    STRING = 1      #: A string, including quotation marks.
+    CHAR = 2        #: A character, including apostophes.
+    NUMBER = 3      #: A number.
+    PUNC = 4        #: A puntuation mark: ``;`` / ``,`` / ``.``.
+    BEGIN = 5       #: A begin character: ``{`` / ``[`` / ``(``.
+    END = 6         #: A end character: ``}`` / ``]`` / ``)``.
+    CPP = 7         #: A preprocessor macro.
+    HASH = 8        #: The hash character - useful to handle other macros.
+    OP = 9          #: A C operator (add, subtract, ...).
+    STRUCT = 10     #: A ``struct`` keyword.
+    UNION = 11      #: An ``union`` keyword.
+    ENUM = 12       #: A ``struct`` keyword.
+    TYPEDEF = 13    #: A ``typedef`` keyword.
+    NAME = 14       #: A name. Can be an ID or a type.
+    SPACE = 15      #: Any space characters, including new lines
+
+    MISMATCH = 255  #: an error indicator: should never happen in practice.
+
+    # Dict to convert from an enum interger into a string.
+    _name_by_val = {v: k for k, v in dict(vars()).items() if isinstance(v, int)}
+
+    # Dict to convert from string to an enum-like integer value.
+    _name_to_val = {k: v for v, k in _name_by_val.items()}
+
+    @staticmethod
+    def to_name(val):
+        """Convert from an integer value from CToken enum into a string"""
+
+        return CToken._name_by_val.get(val, f"UNKNOWN({val})")
+
+    @staticmethod
+    def from_name(name):
+        """Convert a string into a CToken enum value"""
+        if name in CToken._name_to_val:
+            return CToken._name_to_val[name]
+
+        return CToken.MISMATCH
+
+    def __init__(self, kind, value, pos,
+                 brace_level, paren_level, bracket_level):
+        self.kind = kind
+        self.value = value
+        self.pos = pos
+        self.brace_level = brace_level
+        self.paren_level = paren_level
+        self.bracket_level = bracket_level
+
+    def __repr__(self):
+        name = self.to_name(self.kind)
+        if isinstance(self.value, str):
+            value = '"' + self.value + '"'
+        else:
+            value = self.value
+
+        return f"CToken({name}, {value}, {self.pos}, " \
+               f"{self.brace_level}, {self.paren_level}, {self.bracket_level})"
+
+#: Tokens to parse C code.
+TOKEN_LIST = [
+    (CToken.COMMENT, r"//[^\n]*|/\*[\s\S]*?\*/"),
+
+    (CToken.STRING,  r'"(?:\\.|[^"\\])*"'),
+    (CToken.CHAR,    r"'(?:\\.|[^'\\])'"),
+
+    (CToken.NUMBER,  r"0[xX][0-9a-fA-F]+[uUlL]*|0[0-7]+[uUlL]*|"
+                     r"[0-9]+(\.[0-9]*)?([eE][+-]?[0-9]+)?[fFlL]*"),
+
+    (CToken.PUNC,    r"[;,\.]"),
+
+    (CToken.BEGIN,   r"[\[\(\{]"),
+
+    (CToken.END,     r"[\]\)\}]"),
+
+    (CToken.CPP,     r"#\s*(define|include|ifdef|ifndef|if|else|elif|endif|undef|pragma)\b"),
+
+    (CToken.HASH,    r"#"),
+
+    (CToken.OP,      r"\+\+|\-\-|\->|==|\!=|<=|>=|&&|\|\||<<|>>|\+=|\-=|\*=|/=|%="
+                     r"|&=|\|=|\^=|=|\+|\-|\*|/|%|<|>|&|\||\^|~|!|\?|\:"),
+
+    (CToken.STRUCT,  r"\bstruct\b"),
+    (CToken.UNION,   r"\bunion\b"),
+    (CToken.ENUM,    r"\benum\b"),
+    (CToken.TYPEDEF, r"\bkinddef\b"),
+
+    (CToken.NAME,      r"[A-Za-z_][A-Za-z0-9_]*"),
+
+    (CToken.SPACE,   r"[\s]+"),
+
+    (CToken.MISMATCH,r"."),
+]
+
+#: Handle C continuation lines.
+RE_CONT = KernRe(r"\\\n")
+
+RE_COMMENT_START = KernRe(r'/\*\s*')
+
+#: tokenizer regex. Will be filled at the first CTokenizer usage.
+re_scanner = None
+
+class CTokenizer():
+    """
+    Scan C statements and definitions and produce tokens.
+
+    When converted to string, it drops comments and handle public/private
+    values, respecting depth.
+    """
+
+    # This class is inspired and follows the basic concepts of:
+    #   https://docs.python.org/3/library/re.html#writing-a-tokenizer
+
+    def _tokenize(self, source):
+        """
+        Interactor that parses ``source``, splitting it into tokens, as defined
+        at ``self.TOKEN_LIST``.
+
+        The interactor returns a CToken class object.
+        """
+
+        # Handle continuation lines. Note that kdoc_parser already has a
+        # logic to do that. Still, let's keep it for completeness, as we might
+        # end re-using this tokenizer outsize kernel-doc some day - or we may
+        # eventually remove from there as a future cleanup.
+        source = RE_CONT.sub("", source)
+
+        brace_level = 0
+        paren_level = 0
+        bracket_level = 0
+
+        for match in re_scanner.finditer(source):
+            kind = CToken.from_name(match.lastgroup)
+            pos = match.start()
+            value = match.group()
+
+            if kind == CToken.MISMATCH:
+                raise RuntimeError(f"Unexpected token '{value}' on {pos}:\n\t{source}")
+            elif kind == CToken.BEGIN:
+                if value == '(':
+                    paren_level += 1
+                elif value == '[':
+                    bracket_level += 1
+                else:  # value == '{'
+                    brace_level += 1
+
+            elif kind == CToken.END:
+                if value == ')' and paren_level > 0:
+                    paren_level -= 1
+                elif value == ']' and bracket_level > 0:
+                    bracket_level -= 1
+                elif brace_level > 0:    # value == '}'
+                    brace_level -= 1
+
+            yield CToken(kind, value, pos,
+                         brace_level, paren_level, bracket_level)
+
+    def __init__(self, source):
+        """
+        Create a regular expression to handle TOKEN_LIST.
+
+        While I generally don't like using regex group naming via:
+            (?P<name>...)
+
+        in this particular case, it makes sense, as we can pick the name
+        when matching a code via re_scanner().
+        """
+        global re_scanner
+
+        if not re_scanner:
+            re_tokens = []
+
+            for kind, pattern in TOKEN_LIST:
+                name = CToken.to_name(kind)
+                re_tokens.append(f"(?P<{name}>{pattern})")
+
+            re_scanner = KernRe("|".join(re_tokens), re.MULTILINE | re.DOTALL)
+
+        self.tokens = []
+        for tok in self._tokenize(source):
+            self.tokens.append(tok)
+
+    def __str__(self):
+        out=""
+        show_stack = [True]
+
+        for tok in self.tokens:
+            if tok.kind == CToken.BEGIN:
+                show_stack.append(show_stack[-1])
+
+            elif tok.kind == CToken.END:
+                prev = show_stack[-1]
+                if len(show_stack) > 1:
+                    show_stack.pop()
+
+                if not prev and show_stack[-1]:
+                    #
+                    # Try to preserve indent
+                    #
+                    out += "\t" * (len(show_stack) - 1)
+
+                    out += str(tok.value)
+                    continue
+
+            elif tok.kind == CToken.COMMENT:
+                comment = RE_COMMENT_START.sub("", tok.value)
+
+                if comment.startswith("private:"):
+                    show_stack[-1] = False
+                    show = False
+                elif comment.startswith("public:"):
+                    show_stack[-1] = True
+
+                continue
+
+            if show_stack[-1]:
+                    out += str(tok.value)
+
+        return out
diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index 6b181ead3175..e804e61b09c0 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -13,7 +13,8 @@ import sys
 import re
 from pprint import pformat
 
-from kdoc.kdoc_re import NestedMatch, KernRe, CTokenizer
+from kdoc.kdoc_re import NestedMatch, KernRe
+from kdoc.c_lex import CTokenizer
 from kdoc.kdoc_item import KdocItem
 
 #
diff --git a/tools/lib/python/kdoc/kdoc_re.py b/tools/lib/python/kdoc/kdoc_re.py
index 7bed4e9a8810..ba601a4f5035 100644
--- a/tools/lib/python/kdoc/kdoc_re.py
+++ b/tools/lib/python/kdoc/kdoc_re.py
@@ -141,239 +141,6 @@ class KernRe:
 
         return self.last_match.groups()
 
-class TokType():
-
-    @staticmethod
-    def __str__(val):
-        """Return the name of an enum value"""
-        return TokType._name_by_val.get(val, f"UNKNOWN({val})")
-
-class CToken():
-    """
-    Data class to define a C token.
-    """
-
-    # Tokens that can be used by the parser. Works like an C enum.
-
-    COMMENT = 0     #: A standard C or C99 comment, including delimiter.
-    STRING = 1      #: A string, including quotation marks.
-    CHAR = 2        #: A character, including apostophes.
-    NUMBER = 3      #: A number.
-    PUNC = 4        #: A puntuation mark: ``;`` / ``,`` / ``.``.
-    BEGIN = 5       #: A begin character: ``{`` / ``[`` / ``(``.
-    END = 6         #: A end character: ``}`` / ``]`` / ``)``.
-    CPP = 7         #: A preprocessor macro.
-    HASH = 8        #: The hash character - useful to handle other macros.
-    OP = 9          #: A C operator (add, subtract, ...).
-    STRUCT = 10     #: A ``struct`` keyword.
-    UNION = 11      #: An ``union`` keyword.
-    ENUM = 12       #: A ``struct`` keyword.
-    TYPEDEF = 13    #: A ``typedef`` keyword.
-    NAME = 14       #: A name. Can be an ID or a type.
-    SPACE = 15      #: Any space characters, including new lines
-
-    MISMATCH = 255  #: an error indicator: should never happen in practice.
-
-    # Dict to convert from an enum interger into a string.
-    _name_by_val = {v: k for k, v in dict(vars()).items() if isinstance(v, int)}
-
-    # Dict to convert from string to an enum-like integer value.
-    _name_to_val = {k: v for v, k in _name_by_val.items()}
-
-    @staticmethod
-    def to_name(val):
-        """Convert from an integer value from CToken enum into a string"""
-
-        return CToken._name_by_val.get(val, f"UNKNOWN({val})")
-
-    @staticmethod
-    def from_name(name):
-        """Convert a string into a CToken enum value"""
-        if name in CToken._name_to_val:
-            return CToken._name_to_val[name]
-
-        return CToken.MISMATCH
-
-    def __init__(self, kind, value, pos,
-                 brace_level, paren_level, bracket_level):
-        self.kind = kind
-        self.value = value
-        self.pos = pos
-        self.brace_level = brace_level
-        self.paren_level = paren_level
-        self.bracket_level = bracket_level
-
-    def __repr__(self):
-        name = self.to_name(self.kind)
-        if isinstance(self.value, str):
-            value = '"' + self.value + '"'
-        else:
-            value = self.value
-
-        return f"CToken({name}, {value}, {self.pos}, " \
-               f"{self.brace_level}, {self.paren_level}, {self.bracket_level})"
-
-#: Tokens to parse C code.
-TOKEN_LIST = [
-    (CToken.COMMENT, r"//[^\n]*|/\*[\s\S]*?\*/"),
-
-    (CToken.STRING,  r'"(?:\\.|[^"\\])*"'),
-    (CToken.CHAR,    r"'(?:\\.|[^'\\])'"),
-
-    (CToken.NUMBER,  r"0[xX][0-9a-fA-F]+[uUlL]*|0[0-7]+[uUlL]*|"
-                     r"[0-9]+(\.[0-9]*)?([eE][+-]?[0-9]+)?[fFlL]*"),
-
-    (CToken.PUNC,    r"[;,\.]"),
-
-    (CToken.BEGIN,   r"[\[\(\{]"),
-
-    (CToken.END,     r"[\]\)\}]"),
-
-    (CToken.CPP,     r"#\s*(define|include|ifdef|ifndef|if|else|elif|endif|undef|pragma)\b"),
-
-    (CToken.HASH,    r"#"),
-
-    (CToken.OP,      r"\+\+|\-\-|\->|==|\!=|<=|>=|&&|\|\||<<|>>|\+=|\-=|\*=|/=|%="
-                     r"|&=|\|=|\^=|=|\+|\-|\*|/|%|<|>|&|\||\^|~|!|\?|\:"),
-
-    (CToken.STRUCT,  r"\bstruct\b"),
-    (CToken.UNION,   r"\bunion\b"),
-    (CToken.ENUM,    r"\benum\b"),
-    (CToken.TYPEDEF, r"\bkinddef\b"),
-
-    (CToken.NAME,      r"[A-Za-z_][A-Za-z0-9_]*"),
-
-    (CToken.SPACE,   r"[\s]+"),
-
-    (CToken.MISMATCH,r"."),
-]
-
-#: Handle C continuation lines.
-RE_CONT = KernRe(r"\\\n")
-
-RE_COMMENT_START = KernRe(r'/\*\s*')
-
-#: tokenizer regex. Will be filled at the first CTokenizer usage.
-re_scanner = None
-
-class CTokenizer():
-    """
-    Scan C statements and definitions and produce tokens.
-
-    When converted to string, it drops comments and handle public/private
-    values, respecting depth.
-    """
-
-    # This class is inspired and follows the basic concepts of:
-    #   https://docs.python.org/3/library/re.html#writing-a-tokenizer
-
-    def _tokenize(self, source):
-        """
-        Interactor that parses ``source``, splitting it into tokens, as defined
-        at ``self.TOKEN_LIST``.
-
-        The interactor returns a CToken class object.
-        """
-
-        # Handle continuation lines. Note that kdoc_parser already has a
-        # logic to do that. Still, let's keep it for completeness, as we might
-        # end re-using this tokenizer outsize kernel-doc some day - or we may
-        # eventually remove from there as a future cleanup.
-        source = RE_CONT.sub("", source)
-
-        brace_level = 0
-        paren_level = 0
-        bracket_level = 0
-
-        for match in re_scanner.finditer(source):
-            kind = CToken.from_name(match.lastgroup)
-            pos = match.start()
-            value = match.group()
-
-            if kind == CToken.MISMATCH:
-                raise RuntimeError(f"Unexpected token '{value}' on {pos}:\n\t{source}")
-            elif kind == CToken.BEGIN:
-                if value == '(':
-                    paren_level += 1
-                elif value == '[':
-                    bracket_level += 1
-                else:  # value == '{'
-                    brace_level += 1
-
-            elif kind == CToken.END:
-                if value == ')' and paren_level > 0:
-                    paren_level -= 1
-                elif value == ']' and bracket_level > 0:
-                    bracket_level -= 1
-                elif brace_level > 0:    # value == '}'
-                    brace_level -= 1
-
-            yield CToken(kind, value, pos,
-                         brace_level, paren_level, bracket_level)
-
-    def __init__(self, source):
-        """
-        Create a regular expression to handle TOKEN_LIST.
-
-        While I generally don't like using regex group naming via:
-            (?P<name>...)
-
-        in this particular case, it makes sense, as we can pick the name
-        when matching a code via re_scanner().
-        """
-        global re_scanner
-
-        if not re_scanner:
-            re_tokens = []
-
-            for kind, pattern in TOKEN_LIST:
-                name = CToken.to_name(kind)
-                re_tokens.append(f"(?P<{name}>{pattern})")
-
-            re_scanner = KernRe("|".join(re_tokens), re.MULTILINE | re.DOTALL)
-
-        self.tokens = []
-        for tok in self._tokenize(source):
-            self.tokens.append(tok)
-
-    def __str__(self):
-        out=""
-        show_stack = [True]
-
-        for tok in self.tokens:
-            if tok.kind == CToken.BEGIN:
-                show_stack.append(show_stack[-1])
-
-            elif tok.kind == CToken.END:
-                prev = show_stack[-1]
-                if len(show_stack) > 1:
-                    show_stack.pop()
-
-                if not prev and show_stack[-1]:
-                    #
-                    # Try to preserve indent
-                    #
-                    out += "\t" * (len(show_stack) - 1)
-
-                    out += str(tok.value)
-                    continue
-
-            elif tok.kind == CToken.COMMENT:
-                comment = RE_COMMENT_START.sub("", tok.value)
-
-                if comment.startswith("private:"):
-                    show_stack[-1] = False
-                    show = False
-                elif comment.startswith("public:"):
-                    show_stack[-1] = True
-
-                continue
-
-            if show_stack[-1]:
-                    out += str(tok.value)
-
-        return out
-
 
 #: Nested delimited pairs (brackets and parenthesis)
 DELIMITER_PAIRS = {
-- 
2.52.0

