Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED7A3AD505;
	Thu, 12 Mar 2026 07:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773299553; cv=none; b=n4XyHCsortbtZ9bQrwhuoL76XoB6aHQAgVl3lBeSiJbKviEFUMIQOI4hARy0Vj4zcC1YQo5ZrLOsqldWdAtIouH9UvkAvD8Lca4m7+1ysPYkwvhlft1vNTaHycNRPDMs6Z4VYwBUTzvh04LmpL8tHDMaqB0//PltsgHepPKYLO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773299553; c=relaxed/simple;
	bh=jMjtadqVu+g0IuJqU6X2U6Jm2wUokvvloT0ZwKYQV5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rbs0djCcTYue9CMavjuHs65kWsec9SIaqwDchM0Yec200Ua16uOONX65AejRzMUxgzHnMufukSM83KdQ/syGVcYEhH7u9iuXg/2L86lEwNqW+yukdclp1UHi6iKXfJTM0x8nWNEfF/4s9Nw6rAWTiOs6aWTIV/rqMxZX6GdMkP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpfVBA7m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpfVBA7m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61EA4C19424;
	Thu, 12 Mar 2026 07:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773299553;
	bh=jMjtadqVu+g0IuJqU6X2U6Jm2wUokvvloT0ZwKYQV5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fpfVBA7mtXCDygsA6sOa5Rv0B+aL8HWyR4QLieSOvYQfRaFDs9YHLLwUPCI/UmKAv
	 58zSQlXJL+5mN0rlytcZkx6KJ5kkLVBxgxCIRzLAUCcEB6vKDvrzwq6lyFlbobv6bg
	 VWUx08PrJ1AJBfIR9Og7L0r9NGk/f9BcZ8yAdM89nUBtsyiQ9jEqIMVl6qing1nuPT
	 hWKjfRvsv+Urlyc/fI1nCzeW/5TAVQDVV3YiZW4xlvhVMHaKUWRejjhqJGBrmcymgF
	 juISIWhGUzwL2WEMnVmgptlBrQjGet3tHJfuLk8biKLVX+66cEy1vcEe45276yy9vS
	 hJrEntptKJ07Q==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1w0aDf-000000077gi-2SJp;
	Thu, 12 Mar 2026 08:12:31 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH v2 11/20] docs: kdoc: create a CMatch to match nested C blocks
Date: Thu, 12 Mar 2026 08:12:19 +0100
Message-ID: <06d21e2c38a313aec8f7c8a6df4674c41c47c23b.1773297828.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773297828.git.mchehab+huawei@kernel.org>
References: <cover.1773297828.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

The NextMatch code is complex, and will become even more complex
if we add there support for arguments.

Now that we have a tokenizer, we can use a better solution,
easier to be understood.

Yet, to improve performance, it is better to make it use a
previously tokenized code, changing its ABI.

So, reimplement NextMatch using the CTokener class. Once it
is done, we can drop NestedMatch.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/lib/python/kdoc/c_lex.py    | 222 +++++++++++++++++++++++++++---
 tools/unittests/test_tokenizer.py |   3 +-
 2 files changed, 203 insertions(+), 22 deletions(-)

diff --git a/tools/lib/python/kdoc/c_lex.py b/tools/lib/python/kdoc/c_lex.py
index 38f70e836eb8..e986a4ad73e3 100644
--- a/tools/lib/python/kdoc/c_lex.py
+++ b/tools/lib/python/kdoc/c_lex.py
@@ -58,14 +58,13 @@ class CToken():
 
         return CToken.MISMATCH
 
+
     def __init__(self, kind, value=None, pos=0,
                  brace_level=0, paren_level=0, bracket_level=0):
         self.kind = kind
         self.value = value
         self.pos = pos
-        self.brace_level = brace_level
-        self.paren_level = paren_level
-        self.bracket_level = bracket_level
+        self.level = (bracket_level, paren_level, brace_level)
 
     def __repr__(self):
         name = self.to_name(self.kind)
@@ -74,8 +73,7 @@ class CToken():
         else:
             value = self.value
 
-        return f"CToken({name}, {value}, {self.pos}, " \
-               f"{self.brace_level}, {self.paren_level}, {self.bracket_level})"
+        return f"CToken(CToken.{name}, {value}, {self.pos}, {self.level})"
 
 #: Tokens to parse C code.
 TOKEN_LIST = [
@@ -105,20 +103,30 @@ TOKEN_LIST = [
     (CToken.ENUM,    r"\benum\b"),
     (CToken.TYPEDEF, r"\bkinddef\b"),
 
-    (CToken.NAME,      r"[A-Za-z_][A-Za-z0-9_]*"),
+    (CToken.NAME,    r"[A-Za-z_][A-Za-z0-9_]*"),
 
     (CToken.SPACE,   r"[\s]+"),
 
     (CToken.MISMATCH,r"."),
 ]
 
+def fill_re_scanner(token_list):
+    """Ancillary routine to convert TOKEN_LIST into a finditer regex"""
+    re_tokens = []
+
+    for kind, pattern in token_list:
+        name = CToken.to_name(kind)
+        re_tokens.append(f"(?P<{name}>{pattern})")
+
+    return KernRe("|".join(re_tokens), re.MULTILINE | re.DOTALL)
+
 #: Handle C continuation lines.
 RE_CONT = KernRe(r"\\\n")
 
 RE_COMMENT_START = KernRe(r'/\*\s*')
 
 #: tokenizer regex. Will be filled at the first CTokenizer usage.
-re_scanner = None
+RE_SCANNER = fill_re_scanner(TOKEN_LIST)
 
 class CTokenizer():
     """
@@ -149,7 +157,7 @@ class CTokenizer():
         paren_level = 0
         bracket_level = 0
 
-        for match in re_scanner.finditer(source):
+        for match in RE_SCANNER.finditer(source):
             kind = CToken.from_name(match.lastgroup)
             pos = match.start()
             value = match.group()
@@ -175,7 +183,7 @@ class CTokenizer():
             yield CToken(kind, value, pos,
                          brace_level, paren_level, bracket_level)
 
-    def __init__(self, source):
+    def __init__(self, source=None):
         """
         Create a regular expression to handle TOKEN_LIST.
 
@@ -183,20 +191,18 @@ class CTokenizer():
             (?P<name>...)
 
         in this particular case, it makes sense, as we can pick the name
-        when matching a code via re_scanner().
+        when matching a code via RE_SCANNER.
         """
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
 
         self.tokens = []
+
+        if not source:
+            return
+
+        if isinstance(source, list):
+            self.tokens = source
+            return
+
         for tok in self._tokenize(source):
             self.tokens.append(tok)
 
@@ -237,3 +243,179 @@ class CTokenizer():
                     out += str(tok.value)
 
         return out
+
+
+class CMatch:
+    """
+    Finding nested delimiters is hard with regular expressions. It is
+    even harder on Python with its normal re module, as there are several
+    advanced regular expressions that are missing.
+
+    This is the case of this pattern::
+
+            '\\bSTRUCT_GROUP(\\(((?:(?>[^)(]+)|(?1))*)\\))[^;]*;'
+
+    which is used to properly match open/close parentheses of the
+    string search STRUCT_GROUP(),
+
+    Add a class that counts pairs of delimiters, using it to match and
+    replace nested expressions.
+
+    The original approach was suggested by:
+
+        https://stackoverflow.com/questions/5454322/python-how-to-match-nested-parentheses-with-regex
+
+    Although I re-implemented it to make it more generic and match 3 types
+    of delimiters. The logic checks if delimiters are paired. If not, it
+    will ignore the search string.
+    """
+
+    # TODO: make CMatch handle multiple match groups
+    #
+    # Right now, regular expressions to match it are defined only up to
+    #       the start delimiter, e.g.:
+    #
+    #       \bSTRUCT_GROUP\(
+    #
+    # is similar to: STRUCT_GROUP\((.*)\)
+    # except that the content inside the match group is delimiter-aligned.
+    #
+    # The content inside parentheses is converted into a single replace
+    # group (e.g. r`\0').
+    #
+    # It would be nice to change such definition to support multiple
+    # match groups, allowing a regex equivalent to:
+    #
+    #   FOO\((.*), (.*), (.*)\)
+    #
+    # it is probably easier to define it not as a regular expression, but
+    # with some lexical definition like:
+    #
+    #   FOO(arg1, arg2, arg3)
+
+    def __init__(self, regex):
+        self.regex = KernRe(regex)
+
+    def _search(self, tokenizer):
+        """
+        Finds paired blocks for a regex that ends with a delimiter.
+
+        The suggestion of using finditer to match pairs came from:
+        https://stackoverflow.com/questions/5454322/python-how-to-match-nested-parentheses-with-regex
+        but I ended using a different implementation to align all three types
+        of delimiters and seek for an initial regular expression.
+
+        The algorithm seeks for open/close paired delimiters and places them
+        into a stack, yielding a start/stop position of each match when the
+        stack is zeroed.
+
+        The algorithm should work fine for properly paired lines, but will
+        silently ignore end delimiters that precede a start delimiter.
+        This should be OK for kernel-doc parser, as unaligned delimiters
+        would cause compilation errors. So, we don't need to raise exceptions
+        to cover such issues.
+        """
+
+        start = None
+        offset = -1
+        started = False
+
+        import sys
+
+        stack = []
+
+        for i, tok in enumerate(tokenizer.tokens):
+            if start is None:
+                if tok.kind == CToken.NAME and self.regex.match(tok.value):
+                    start = i
+                    stack.append((start, tok.level))
+                    started = False
+
+                continue
+
+            if not started and tok.kind == CToken.BEGIN:
+                started = True
+                continue
+
+            if tok.kind == CToken.END and tok.level == stack[-1][1]:
+                start, level = stack.pop()
+                offset = i
+
+                yield CTokenizer(tokenizer.tokens[start:offset + 1])
+                start = None
+
+        #
+        # If an END zeroing levels is not there, return remaining stuff
+        # This is meant to solve cases where the caller logic might be
+        # picking an incomplete block.
+        #
+        if start and offset < 0:
+            print("WARNING: can't find an end", file=sys.stderr)
+            yield CTokenizer(tokenizer.tokens[start:])
+
+    def search(self, source):
+        """
+        This is similar to re.search:
+
+        It matches a regex that it is followed by a delimiter,
+        returning occurrences only if all delimiters are paired.
+        """
+
+        if isinstance(source, CTokenizer):
+            tokenizer = source
+            is_token = True
+        else:
+            tokenizer = CTokenizer(source)
+            is_token = False
+
+        for new_tokenizer in self._search(tokenizer):
+            if is_token:
+                yield new_tokenizer
+            else:
+                yield str(new_tokenizer)
+
+    def sub(self, sub, line, count=0):
+        """
+        This is similar to re.sub:
+
+        It matches a regex that it is followed by a delimiter,
+        replacing occurrences only if all delimiters are paired.
+
+        if the sub argument contains::
+
+            r'\0'
+
+        it will work just like re: it places there the matched paired data
+        with the delimiter stripped.
+
+        If count is different than zero, it will replace at most count
+        items.
+        """
+        if isinstance(source, CTokenizer):
+            is_token = True
+            tokenizer = source
+        else:
+            is_token = False
+            tokenizer = CTokenizer(source)
+
+        new_tokenizer = CTokenizer()
+        cur_pos = 0
+        for start, end in self._search(tokenizer):
+            new_tokenizer.tokens += tokenizer.tokens[cur_pos:start]
+#            new_tokenizer.tokens += [sub_str]
+
+            cur_pos = end + 1
+
+        if cur_pos:
+            new_tokenizer.tokens += tokenizer.tokens[cur_pos:]
+
+        print(new_tokenizer.tokens)
+
+        return str(new_tokenizer)
+
+    def __repr__(self):
+        """
+        Returns a displayable version of the class init.
+        """
+
+        return f'CMatch("{self.regex.regex.pattern}")'
diff --git a/tools/unittests/test_tokenizer.py b/tools/unittests/test_tokenizer.py
index efb1d1687811..3081f27a7786 100755
--- a/tools/unittests/test_tokenizer.py
+++ b/tools/unittests/test_tokenizer.py
@@ -30,8 +30,7 @@ def tokens_to_list(tokens):
         if tok.kind == CToken.SPACE:
             continue
 
-        tuples += [(tok.kind, tok.value,
-                    tok.brace_level, tok.paren_level, tok.bracket_level)]
+        tuples += [(tok.kind, tok.value, tok.level)]
 
     return tuples
 
-- 
2.53.0

