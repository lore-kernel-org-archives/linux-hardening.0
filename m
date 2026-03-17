Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8356318121;
	Tue, 17 Mar 2026 18:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773770457; cv=none; b=K1WNgdON5FPF0ZG8T8ywTLq35G3f2DrriF0YJHVXE/XmHZehhsLD/HaMK9f5GwcfKsPRVtjGIw/p9P69fcuGaYy+x0GzUqzzv5iIvwHmCihWhCwKxcgNdrAvALsRoOKbqfwq9gRwYAyeBKeJEG7tvHL97ZnPBRpmycxfjJaBG0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773770457; c=relaxed/simple;
	bh=1h0LwC6y35Zrab7lLwO8WqaaGJkYFjg0b4+fiD6TlVA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AzPQQWEUm4w2ATUzA6SGwGgqnR4s9haMtY0nNNN0Pmh2VSVomaar0I3Lfzh69JlvQVQXhhnCv6hH1X+SZiYTeAKbdHBEyjfvxSMy5tCpQ99P16emh35AlgJ4rKk2SCk53c3jcBky57duddfRl0MSnqCdUbF2iGcp+lYqhW0JqhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DdnDPLKR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DdnDPLKR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03C2AC4CEF7;
	Tue, 17 Mar 2026 18:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773770457;
	bh=1h0LwC6y35Zrab7lLwO8WqaaGJkYFjg0b4+fiD6TlVA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DdnDPLKR8gMnQBHtsLrahGUrA5eTfe89G8zbNtj/8/kN0TSomrYBo+r8Ytru9budv
	 v8TRZYhSigrma93MBfBb3LSsGCq9PM57pQXeEdabsBn9A4nEY8h/R2dSH8D4VFTdoJ
	 J+vI2XjUTHe8ZUAwHEpVeW/R2jvs8mdCltl1voIIV08wYF8qWYj+v5MuJVZeRcNtHN
	 UUJdZEJ2gcnA4yTyDGXBMT6mgNVTCUX6l4uYlP2iV82p9f1ejiEMxXTNwv5mhdbaEP
	 +U1Yv9LpJswIoXPvclwMjNajGcqKW46fBL5p/6no78sspJu8u6+b1GcmI7vck9ZRGa
	 Xs2+X2pJw99NQ==
Received: from localhost ([::1])
	by mail.kernel.org with esmtp (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1w2Yis-0000000H3jE-3SHS;
	Tue, 17 Mar 2026 19:00:54 +0100
Date: Tue, 17 Mar 2026 19:00:53 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Kees Cook <kees@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>, Randy Dunlap <rdunlap@infradead.org>,
 Shuah Khan <skhan@linuxfoundation.org>, Vincent Mailhol
 <mailhol@kernel.org>
Subject: Re: [PATCH v2 00/28] kernel-doc: use a C lexical tokenizer for
 transforms
Message-ID: <20260317190053.12cc2eee@localhost>
In-Reply-To: <87tsue9y7h.fsf@trenco.lwn.net>
References: <cover.1773326442.git.mchehab+huawei@kernel.org>
	<87tsue9y7h.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Mar 2026 11:12:50 -0600
Jonathan Corbet <corbet@lwn.net> wrote:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> > Sorry for respamming this one too quick. It ends that v1 had some
> > bugs causing it to fail on several cases. I opted to add extra
> > patches in the end. This way, it better integrates with kdoc_re.
> > As part of it, now c_lex will output file name when reporting
> > errors. With that regards, only more serious errors will raise
> > an exception. They are meant to indicate problems at kernel-doc
> > itself. Parsing errors are now using the same warning approach
> > as kdoc_parser.
> >
> > I also added a filter at Ctokenizer __str__() logic for the
> > string convertion to drop some weirdness whitespaces and uneeded
> > ";" characters at the output.
> >
> > Finally, v2 address the undefined behavior about private: comment
> > propagation.
> >
> > This patch series change how kdoc parser handles macro replacements.  
> 
> So I have at least glanced at the whole series now; other than the few
> things I pointed out, I don't find a whole lot to complain about.  I do
> worry about adding another 2000 lines to kernel-doc, even if more than
> half of them are tests.  But hopefully it leads to a better and more
> maintainable system.
> 
> We're starting to get late enough in the cycle that I'm a bit leery of
> applying this work for 7.1.  What was your thinking on timing?

I'm sending now a v3. It basically address your points, which
reduced the series to 22 patches.

I'm adding the diff between the two versions here, as it may help
checking what changed. I'll also document the main changes at
patch 00/22.

-- 
Thanks,
Mauro

diff --git a/tools/lib/python/kdoc/c_lex.py b/tools/lib/python/kdoc/c_lex.py
index 95c4dd5afe77..b6d58bd470a9 100644
--- a/tools/lib/python/kdoc/c_lex.py
+++ b/tools/lib/python/kdoc/c_lex.py
@@ -50,7 +50,7 @@ class CToken():
     STRING = 1      #: A string, including quotation marks.
     CHAR = 2        #: A character, including apostophes.
     NUMBER = 3      #: A number.
-    PUNC = 4        #: A puntuation mark: ``;`` / ``,`` / ``.``.
+    PUNC = 4        #: A puntuation mark: / ``,`` / ``.``.
     BEGIN = 5       #: A begin character: ``{`` / ``[`` / ``(``.
     END = 6         #: A end character: ``}`` / ``]`` / ``)``.
     CPP = 7         #: A preprocessor macro.
@@ -62,8 +62,9 @@ class CToken():
     TYPEDEF = 13    #: A ``typedef`` keyword.
     NAME = 14       #: A name. Can be an ID or a type.
     SPACE = 15      #: Any space characters, including new lines
+    ENDSTMT = 16    #: End of an statement (``;``).
 
-    BACKREF = 16  #: Not a valid C sequence, but used at sub regex patterns.
+    BACKREF = 17    #: Not a valid C sequence, but used at sub regex patterns.
 
     MISMATCH = 255  #: an error indicator: should never happen in practice.
 
@@ -104,37 +105,42 @@ class CToken():
 
         return f"CToken(CToken.{name}, {value}, {self.pos}, {self.level})"
 
-#: Tokens to parse C code.
-TOKEN_LIST = [
+#: Regexes to parse C code, transforming it into tokens.
+RE_SCANNER_LIST = [
+    #
+    # Note that \s\S is different than .*, as it also catches \n
+    #
     (CToken.COMMENT, r"//[^\n]*|/\*[\s\S]*?\*/"),
 
     (CToken.STRING,  r'"(?:\\.|[^"\\])*"'),
     (CToken.CHAR,    r"'(?:\\.|[^'\\])'"),
 
-    (CToken.NUMBER,  r"0[xX][0-9a-fA-F]+[uUlL]*|0[0-7]+[uUlL]*|"
-                     r"[0-9]+(\.[0-9]*)?([eE][+-]?[0-9]+)?[fFlL]*"),
+    (CToken.NUMBER,  r"0[xX][\da-fA-F]+[uUlL]*|0[0-7]+[uUlL]*|"
+                     r"\d+(?:\.\d*)?(?:[eE][+-]?\d+)?[fFlL]*"),
 
-    (CToken.PUNC,    r"[;,\.]"),
+    (CToken.ENDSTMT, r"(?:\s+;|;)"),
+
+    (CToken.PUNC,    r"[,\.]"),
 
     (CToken.BEGIN,   r"[\[\(\{]"),
 
     (CToken.END,     r"[\]\)\}]"),
 
-    (CToken.CPP,     r"#\s*(define|include|ifdef|ifndef|if|else|elif|endif|undef|pragma)\b"),
+    (CToken.CPP,     r"#\s*(?:define|include|ifdef|ifndef|if|else|elif|endif|undef|pragma)\b"),
 
     (CToken.HASH,    r"#"),
 
     (CToken.OP,      r"\+\+|\-\-|\->|==|\!=|<=|>=|&&|\|\||<<|>>|\+=|\-=|\*=|/=|%="
-                     r"|&=|\|=|\^=|=|\+|\-|\*|/|%|<|>|&|\||\^|~|!|\?|\:|\@"),
+                     r"|&=|\|=|\^=|[=\+\-\*/%<>&\|\^~!\?\:]"),
 
     (CToken.STRUCT,  r"\bstruct\b"),
     (CToken.UNION,   r"\bunion\b"),
     (CToken.ENUM,    r"\benum\b"),
-    (CToken.TYPEDEF, r"\bkinddef\b"),
+    (CToken.TYPEDEF, r"\btypedef\b"),
 
-    (CToken.NAME,    r"[A-Za-z_][A-Za-z0-9_]*"),
+    (CToken.NAME,    r"[A-Za-z_]\w*"),
 
-    (CToken.SPACE,   r"[\s]+"),
+    (CToken.SPACE,   r"\s+"),
 
     (CToken.BACKREF, r"\\\d+"),
 
@@ -142,7 +148,7 @@ TOKEN_LIST = [
 ]
 
 def fill_re_scanner(token_list):
-    """Ancillary routine to convert TOKEN_LIST into a finditer regex"""
+    """Ancillary routine to convert RE_SCANNER_LIST into a finditer regex"""
     re_tokens = []
 
     for kind, pattern in token_list:
@@ -157,7 +163,8 @@ RE_CONT = KernRe(r"\\\n")
 RE_COMMENT_START = KernRe(r'/\*\s*')
 
 #: tokenizer regex. Will be filled at the first CTokenizer usage.
-RE_SCANNER = fill_re_scanner(TOKEN_LIST)
+RE_SCANNER = fill_re_scanner(RE_SCANNER_LIST)
+
 
 class CTokenizer():
     """
@@ -170,10 +177,39 @@ class CTokenizer():
     # This class is inspired and follows the basic concepts of:
     #   https://docs.python.org/3/library/re.html#writing-a-tokenizer
 
+    def __init__(self, source=None, log=None):
+        """
+        Create a regular expression to handle RE_SCANNER_LIST.
+
+        While I generally don't like using regex group naming via:
+            (?P<name>...)
+
+        in this particular case, it makes sense, as we can pick the name
+        when matching a code via RE_SCANNER.
+        """
+
+        self.tokens = []
+
+        if not source:
+            return
+
+        if isinstance(source, list):
+            self.tokens = source
+            return
+
+        #
+        # While we could just use _tokenize directly via interator,
+        # As we'll need to use the tokenizer several times inside kernel-doc
+        # to handle macro transforms, cache the results on a list, as
+        # re-using it is cheaper than having to parse everytime.
+        #
+        for tok in self._tokenize(source):
+            self.tokens.append(tok)
+
     def _tokenize(self, source):
         """
-        Interactor that parses ``source``, splitting it into tokens, as defined
-        at ``self.TOKEN_LIST``.
+        Iterator that parses ``source``, splitting it into tokens, as defined
+        at ``self.RE_SCANNER_LIST``.
 
         The interactor returns a CToken class object.
         """
@@ -214,29 +250,6 @@ class CTokenizer():
             yield CToken(kind, value, pos,
                          brace_level, paren_level, bracket_level)
 
-    def __init__(self, source=None, log=None):
-        """
-        Create a regular expression to handle TOKEN_LIST.
-
-        While I generally don't like using regex group naming via:
-            (?P<name>...)
-
-        in this particular case, it makes sense, as we can pick the name
-        when matching a code via RE_SCANNER.
-        """
-
-        self.tokens = []
-
-        if not source:
-            return
-
-        if isinstance(source, list):
-            self.tokens = source
-            return
-
-        for tok in self._tokenize(source):
-            self.tokens.append(tok)
-
     def __str__(self):
         out=""
         show_stack = [True]
@@ -278,18 +291,10 @@ class CTokenizer():
 
                 # Do some cleanups before ";"
 
-                if (tok.kind == CToken.SPACE and
-                    next_tok.kind == CToken.PUNC and
-                    next_tok.value == ";"):
-
+                if tok.kind == CToken.SPACE and next_tok.kind == CToken.ENDSTMT:
                     continue
 
-                if (tok.kind == CToken.PUNC and
-                    next_tok.kind == CToken.PUNC and
-                    tok.value == ";" and
-                    next_tok.kind == CToken.PUNC and
-                    next_tok.value == ";"):
-
+                if tok.kind == CToken.ENDSTMT and next_tok.kind == tok.kind:
                     continue
 
             out += str(tok.value)
@@ -368,9 +373,13 @@ class CTokenArgs:
 
                 if tok.kind == CToken.BEGIN:
                     inner_level += 1
-                    continue
 
-                if tok.kind == CToken.END:
+                    #
+                    # Discard first begin
+                    #
+                    if not groups_list[0]:
+                        continue
+                elif tok.kind == CToken.END:
                     inner_level -= 1
                     if inner_level < 0:
                         break
@@ -414,7 +423,7 @@ class CTokenArgs:
                 if inner_level < 0:
                     break
 
-            if tok.kind == CToken.PUNC and delim == tok.value:
+            if tok.kind in [CToken.PUNC, CToken.ENDSTMT] and delim == tok.value:
                 pos += 1
                 if self.greedy and pos > self.max_group:
                     pos -= 1
@@ -458,6 +467,7 @@ class CTokenArgs:
 
         return new.tokens
 
+
 class CMatch:
     """
     Finding nested delimiters is hard with regular expressions. It is
diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index 3b99740ebed3..f6c4ee3b18c9 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -13,9 +13,8 @@ import sys
 import re
 from pprint import pformat
 
+from kdoc.c_lex import CTokenizer, tokenizer_set_log
 from kdoc.kdoc_re import KernRe
-from kdoc.c_lex import tokenizer_set_log
-from kdoc.c_lex import CTokenizer
 from kdoc.kdoc_item import KdocItem
 
 #
diff --git a/tools/unittests/test_tokenizer.py b/tools/unittests/test_tokenizer.py
index 6a0bd49df72e..5634b4a7283e 100755
--- a/tools/unittests/test_tokenizer.py
+++ b/tools/unittests/test_tokenizer.py
@@ -76,13 +76,13 @@ TESTS_TOKENIZER = {
         "expected": [
             CToken(CToken.NAME, "int"),
             CToken(CToken.NAME, "a"),
-            CToken(CToken.PUNC, ";"),
+            CToken(CToken.ENDSTMT, ";"),
             CToken(CToken.COMMENT, "// comment"),
             CToken(CToken.NAME, "float"),
             CToken(CToken.NAME, "b"),
             CToken(CToken.OP, "="),
             CToken(CToken.NUMBER, "1.23"),
-            CToken(CToken.PUNC, ";"),
+            CToken(CToken.ENDSTMT, ";"),
         ],
     },
 
@@ -103,7 +103,7 @@ TESTS_TOKENIZER = {
             CToken(CToken.BEGIN, "[", brace_level=1, bracket_level=1),
             CToken(CToken.NUMBER, "10", brace_level=1, bracket_level=1),
             CToken(CToken.END, "]", brace_level=1),
-            CToken(CToken.PUNC, ";", brace_level=1),
+            CToken(CToken.ENDSTMT, ";", brace_level=1),
             CToken(CToken.NAME, "func", brace_level=1),
             CToken(CToken.BEGIN, "(", brace_level=1, paren_level=1),
             CToken(CToken.NAME, "a", brace_level=1, paren_level=1),
@@ -117,7 +117,7 @@ TESTS_TOKENIZER = {
             CToken(CToken.NAME, "c", brace_level=1, paren_level=2),
             CToken(CToken.END, ")", brace_level=1, paren_level=1),
             CToken(CToken.END, ")", brace_level=1),
-            CToken(CToken.PUNC, ";", brace_level=1),
+            CToken(CToken.ENDSTMT, ";", brace_level=1),
             CToken(CToken.END, "}"),
         ],
     },


