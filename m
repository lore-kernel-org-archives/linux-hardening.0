Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9F33AD53A;
	Thu, 12 Mar 2026 07:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773299554; cv=none; b=h6XisaRhwAYxw77AKH7NnPBvqHa9M1QXt/fHG0RikxySDWujaUjFrWu0TMMli9P0NnIIRsGrFYSmVXMLIgxOiUipYkA2nwWXNRg15osLEnYASfFiMSCYSEF4Uu3qWCDdtGY1jvTqB5BboMTYTuZnH7yjHEEY+AkeRCN+jnD14W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773299554; c=relaxed/simple;
	bh=2ZlwXMaSRC68Pnv5x980Sgp39v0FitI5caNfm6ZBkZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OyZTaYS/b2NO35HoUglz6eFTtpbw8xlX1r3HWM782EfUu7GprX81+z4JTm2FIADxvVhHK2QxZlJNuPefkooAx3Rm9XPKkq1kuAmE01RSqrd2rezBUkf/gfXutgGd9NeFukEpMcPHNk/sUTDnEgKbh8E9625lo0JgJDEoe64FdZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZkPKmdYW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZkPKmdYW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C573C4AF0B;
	Thu, 12 Mar 2026 07:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773299553;
	bh=2ZlwXMaSRC68Pnv5x980Sgp39v0FitI5caNfm6ZBkZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZkPKmdYW1a08Lkss0/YNU8mZr0LxJLyAd9oHRJeJoa96fzAquTofCi0c7nmRGuWai
	 NUiCLmxUq07dlnj1tfB4CnjK3QhChFrO9HbckfW7B/4lLT8L056ecIx58vjwV2aiHx
	 4fmy5FFRRvHCTV0i3bHhulM3KcbGBXF8OK4/ZtyJAKNVtIsjpYsWyqVDJqZQfjHAoC
	 G6iuuwnNYA8DrSlRgCrwmm455AaLhh8gkEJZuvqj7j/HQHUSjYouhEuzPxfho1TFIg
	 RtQRpm3GYXGKga3OLykYzeGe6pf+0zmWdfzPe9IR0Cw+v/8leoSj01WEj+G/5NDRcE
	 M48y7VYf2VPPA==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1w0aDf-000000077h9-2gOm;
	Thu, 12 Mar 2026 08:12:31 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH v2 13/20] docs: c_lex: properly implement a sub() method for CMatch
Date: Thu, 12 Mar 2026 08:12:21 +0100
Message-ID: <4c88a55b21910b1bae6838d74c8ab6b32e5c8213.1773297828.git.mchehab+huawei@kernel.org>
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

Change the sub() method to do what it is expected, parsing
backref arguments like \0, \1, \2, ...

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/lib/python/kdoc/c_lex.py | 240 +++++++++++++++++++++++++++------
 1 file changed, 202 insertions(+), 38 deletions(-)

diff --git a/tools/lib/python/kdoc/c_lex.py b/tools/lib/python/kdoc/c_lex.py
index e986a4ad73e3..98031cb7907c 100644
--- a/tools/lib/python/kdoc/c_lex.py
+++ b/tools/lib/python/kdoc/c_lex.py
@@ -10,6 +10,8 @@ Those help caching regular expressions and do matching for kernel-doc.
 
 import re
 
+from copy import copy
+
 from .kdoc_re import KernRe
 
 class CToken():
@@ -36,6 +38,8 @@ class CToken():
     NAME = 14       #: A name. Can be an ID or a type.
     SPACE = 15      #: Any space characters, including new lines
 
+    BACKREF = 16  #: Not a valid C sequence, but used at sub regex patterns.
+
     MISMATCH = 255  #: an error indicator: should never happen in practice.
 
     # Dict to convert from an enum interger into a string.
@@ -107,6 +111,8 @@ TOKEN_LIST = [
 
     (CToken.SPACE,   r"[\s]+"),
 
+    (CToken.BACKREF, r"\\\d+"),
+
     (CToken.MISMATCH,r"."),
 ]
 
@@ -245,6 +251,167 @@ class CTokenizer():
         return out
 
 
+class CTokenArgs:
+    """
+    Ancillary class to help using backrefs from sub matches.
+
+    If the highest backref contain a "+" at the last element,
+    the logic will be greedy, picking all other delims.
+
+    This is needed to parse struct_group macros with end with ``MEMBERS...``.
+    """
+    def __init__(self, sub_str):
+        self.sub_groups = set()
+        self.max_group = -1
+        self.greedy = None
+
+        for m in KernRe(r'\\(\d+)([+]?)').finditer(sub_str):
+            group = int(m.group(1))
+            if m.group(2) == "+":
+                if self.greedy and self.greedy != group:
+                    raise ValueError("There are multiple greedy patterns!")
+                self.greedy = group
+
+            self.sub_groups.add(group)
+            self.max_group = max(self.max_group, group)
+
+        if self.greedy:
+            if self.greedy != self.max_group:
+                raise ValueError("Greedy pattern is not the last one!")
+
+            sub_str = KernRe(r'(\\\d+)[+]').sub(r"\1", sub_str)
+
+        self.sub_str = sub_str
+        self.sub_tokeninzer = CTokenizer(sub_str)
+
+    def groups(self, new_tokenizer):
+        """
+        Create replacement arguments for backrefs like:
+
+        ``\0``, ``\1``, ``\2``, ...``\n``
+
+        It also accepts a ``+`` character to the highest backref. When used,
+        it means in practice to ignore delimins after it, being greedy.
+
+        The logic is smart enough to only go up to the maximum required
+        argument, even if there are more.
+
+        If there is a backref for an argument above the limit, it will
+        raise an exception. Please notice that, on C, square brackets
+        don't have any separator on it. Trying to use ``\1``..``\n`` for
+        brackets also raise an exception.
+        """
+
+        level = (0, 0, 0)
+
+        if self.max_group < 0:
+            return level, []
+
+        tokens = new_tokenizer.tokens
+
+        #
+        # Fill \0 with the full token contents
+        #
+        groups_list = [ [] ]
+
+        if 0 in self.sub_groups:
+            inner_level = 0
+
+            for i in range(0, len(tokens)):
+                tok = tokens[i]
+
+                if tok.kind == CToken.BEGIN:
+                    inner_level += 1
+                    continue
+
+                if tok.kind == CToken.END:
+                    inner_level -= 1
+                    if inner_level < 0:
+                        break
+
+                if inner_level:
+                    groups_list[0].append(tok)
+
+        if not self.max_group:
+            return level, groups_list
+
+        delim = None
+
+        #
+        # Ignore everything before BEGIN. The value of begin gives the
+        # delimiter to be used for the matches
+        #
+        for i in range(0, len(tokens)):
+            tok = tokens[i]
+            if tok.kind == CToken.BEGIN:
+                if tok.value == "{":
+                    delim = ";"
+                elif tok.value == "(":
+                    delim = ","
+                else:
+                    raise ValueError(fr"Can't handle \1..\n on {sub_str}")
+
+                level = tok.level
+                break
+
+        pos = 1
+        groups_list.append([])
+
+        inner_level = 0
+        for i in range(i + 1, len(tokens)):
+            tok = tokens[i]
+
+            if tok.kind == CToken.BEGIN:
+                inner_level += 1
+            if tok.kind == CToken.END:
+                inner_level -= 1
+                if inner_level < 0:
+                    break
+
+            if tok.kind == CToken.PUNC and delim == tok.value:
+                pos += 1
+                if self.greedy and pos > self.max_group:
+                    pos -= 1
+                else:
+                    groups_list.append([])
+
+                    if pos > self.max_group:
+                        break
+
+                    continue
+
+            groups_list[pos].append(tok)
+
+        if pos < self.max_group:
+            raise ValueError(fr"{self.sub_str} groups are up to {pos} instead of {self.max_group}")
+
+        return level, groups_list
+
+    def tokens(self, new_tokenizer):
+        level, groups = self.groups(new_tokenizer)
+
+        new = CTokenizer()
+
+        for tok in self.sub_tokeninzer.tokens:
+            if tok.kind == CToken.BACKREF:
+                group = int(tok.value[1:])
+
+                for group_tok in groups[group]:
+                    new_tok = copy(group_tok)
+
+                    new_level = [0, 0, 0]
+
+                    for i in range(0, len(level)):
+                        new_level[i] = new_tok.level[i] + level[i]
+
+                    new_tok.level = tuple(new_level)
+
+                    new.tokens += [ new_tok ]
+            else:
+                new.tokens += [ tok ]
+
+        return new.tokens
+
 class CMatch:
     """
     Finding nested delimiters is hard with regular expressions. It is
@@ -270,31 +437,9 @@ class CMatch:
     will ignore the search string.
     """
 
-    # TODO: make CMatch handle multiple match groups
-    #
-    # Right now, regular expressions to match it are defined only up to
-    #       the start delimiter, e.g.:
-    #
-    #       \bSTRUCT_GROUP\(
-    #
-    # is similar to: STRUCT_GROUP\((.*)\)
-    # except that the content inside the match group is delimiter-aligned.
-    #
-    # The content inside parentheses is converted into a single replace
-    # group (e.g. r`\0').
-    #
-    # It would be nice to change such definition to support multiple
-    # match groups, allowing a regex equivalent to:
-    #
-    #   FOO\((.*), (.*), (.*)\)
-    #
-    # it is probably easier to define it not as a regular expression, but
-    # with some lexical definition like:
-    #
-    #   FOO(arg1, arg2, arg3)
 
     def __init__(self, regex):
-        self.regex = KernRe(regex)
+        self.regex = KernRe("^" + regex + r"\b")
 
     def _search(self, tokenizer):
         """
@@ -317,7 +462,6 @@ class CMatch:
         """
 
         start = None
-        offset = -1
         started = False
 
         import sys
@@ -339,9 +483,8 @@ class CMatch:
 
             if tok.kind == CToken.END and tok.level == stack[-1][1]:
                 start, level = stack.pop()
-                offset = i
 
-                yield CTokenizer(tokenizer.tokens[start:offset + 1])
+                yield start, i
                 start = None
 
         #
@@ -349,9 +492,9 @@ class CMatch:
         # This is meant to solve cases where the caller logic might be
         # picking an incomplete block.
         #
-        if start and offset < 0:
+        if start and stack:
             print("WARNING: can't find an end", file=sys.stderr)
-            yield CTokenizer(tokenizer.tokens[start:])
+            yield start, len(tokenizer.tokens)
 
     def search(self, source):
         """
@@ -368,13 +511,15 @@ class CMatch:
             tokenizer = CTokenizer(source)
             is_token = False
 
-        for new_tokenizer in self._search(tokenizer):
+        for start, end in self._search(tokenizer):
+            new_tokenizer = CTokenizer(tokenizer.tokens[start:end + 1])
+
             if is_token:
                 yield new_tokenizer
             else:
                 yield str(new_tokenizer)
 
-    def sub(self, sub, line, count=0):
+    def sub(self, sub_str, source, count=0):
         """
         This is similar to re.sub:
 
@@ -398,20 +543,39 @@ class CMatch:
             is_token = False
             tokenizer = CTokenizer(source)
 
+        # Detect if sub_str contains sub arguments
+
+        args_match = CTokenArgs(sub_str)
+
         new_tokenizer = CTokenizer()
-        cur_pos = 0
+        pos = 0
+        n = 0
+
+        #
+        # NOTE: the code below doesn't consider overlays at sub.
+        # We may need to add some extra unit tests to check if those
+        # would cause problems. When replacing by "", this should not
+        # be a problem, but other transformations could be problematic
+        #
         for start, end in self._search(tokenizer):
-            new_tokenizer.tokens += tokenizer.tokens[cur_pos:start]
-#            new_tokenizer.tokens += [sub_str]
+            new_tokenizer.tokens += tokenizer.tokens[pos:start]
 
-            cur_pos = end + 1
+            new = CTokenizer(tokenizer.tokens[start:end + 1])
 
-        if cur_pos:
-            new_tokenizer.tokens += tokenizer.tokens[cur_pos:]
+            new_tokenizer.tokens += args_match.tokens(new)
 
-        print(new_tokenizer.tokens)
+            pos = end + 1
 
-        return str(new_tokenizer)
+            n += 1
+            if count and n >= count:
+                break
+
+        new_tokenizer.tokens += tokenizer.tokens[pos:]
+
+        if not is_token:
+            return str(new_tokenizer)
+
+        return new_tokenizer
 
     def __repr__(self):
         """
-- 
2.53.0

