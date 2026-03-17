Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82DA3F8DEB;
	Tue, 17 Mar 2026 18:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773770989; cv=none; b=fxrre951u5rqmo0gpO3mWtBi6/kQf02QVwCHR+m9Al3WYLiVeP7HwK3/g8OOtiz+Fti8mKfPV3uL2Z2QkzraS74pRYDge41DO6BqK73upWK9rX2dhZ3ND6guQXKBbgUiQUyE56+2sgN+QbOIykq58f3ya9pzwvU8zkfAxT+iSIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773770989; c=relaxed/simple;
	bh=LUcFzGUiEZD4bIprs6ndA9LAE1KebeM/BqrpXPUV0iY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QG4G1ksoVSRUD/bwvDtjMiJAVmGr5QdG/azEgBErvwHh61lETdsnAu1GePoGo21/E4YqPtIiEeZt1NdP6JYJ6FRjPRzNLxMgpMfXk7Rqz50ZXxnhI+QtWOBg+yJxrtSy/w0YUsBBQVhrbw8VdJgF8YKiK8HTpKO3GZpBQK7iOis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oL3beYMF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oL3beYMF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94438C2BCB1;
	Tue, 17 Mar 2026 18:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773770989;
	bh=LUcFzGUiEZD4bIprs6ndA9LAE1KebeM/BqrpXPUV0iY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oL3beYMFmzSXQZspVzBMqlm4aB81VpvnHsOx0FQEn5NLSlIbPiDX4X/rEFDnAr6zh
	 uSy68UX27KW2xxaZ8AOG4zI6ah2EU9FZOiDMmCtOZWGUwI7k9Mp9l8SHqLUbKrF13t
	 lfU4fnxfPiBapM8+sN52VaAeE6kSsHp9WnG8lZ7VdxYfSQ7UupnuYT9TkjgazcGo4b
	 Ntg+/W7azhNpbYacjrDG5WhVAAF6mW2R5xmF79SCJ7/ROwoKsNgMprtLODX50iZpSO
	 wo7Rpo8N1TaL6yjjxGRqOACg7FQJb1HZnXAsStpgx/8W7bzrmevGfVu732wdkgjLQw
	 6cCjwRmza6HFg==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1w2YrT-0000000H5Sz-309C;
	Tue, 17 Mar 2026 19:09:47 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 12/22] docs: c_lex: properly implement a sub() method for CMatch
Date: Tue, 17 Mar 2026 19:09:32 +0100
Message-ID: <dbc45b86db18783289d94cfdbba4b72792c47929.1773770483.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1773770483.git.mchehab+huawei@kernel.org>
References: <cover.1773770483.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Implement a sub() method to do what it is expected, parsing
backref arguments like \0, \1, \2, ...

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/lib/python/kdoc/c_lex.py | 272 +++++++++++++++++++++++++++++++--
 1 file changed, 259 insertions(+), 13 deletions(-)

diff --git a/tools/lib/python/kdoc/c_lex.py b/tools/lib/python/kdoc/c_lex.py
index 5da472734ff7..20e50ff0ecd5 100644
--- a/tools/lib/python/kdoc/c_lex.py
+++ b/tools/lib/python/kdoc/c_lex.py
@@ -16,6 +16,8 @@ Other errors are logged via log instance.
 import logging
 import re
 
+from copy import copy
+
 from .kdoc_re import KernRe
 
 log = logging.getLogger(__name__)
@@ -284,6 +286,172 @@ class CTokenizer():
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
+
+                    #
+                    # Discard first begin
+                    #
+                    if not groups_list[0]:
+                        continue
+                elif tok.kind == CToken.END:
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
+                    self.log.error(fr"Can't handle \1..\n on {sub_str}")
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
+            if tok.kind in [CToken.PUNC, CToken.ENDSTMT] and delim == tok.value:
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
+            log.error(fr"{self.sub_str} groups are up to {pos} instead of {self.max_group}")
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
+
 class CMatch:
     """
     Finding nested delimiters is hard with regular expressions. It is
@@ -309,10 +477,10 @@ class CMatch:
     will ignore the search string.
     """
 
-    # TODO: add a sub method
 
-    def __init__(self, regex):
-        self.regex = KernRe(regex)
+    def __init__(self, regex, delim="("):
+        self.regex = KernRe("^" + regex + r"\b")
+        self.start_delim = delim
 
     def _search(self, tokenizer):
         """
@@ -335,7 +503,6 @@ class CMatch:
         """
 
         start = None
-        offset = -1
         started = False
 
         import sys
@@ -351,15 +518,24 @@ class CMatch:
 
                 continue
 
-            if not started and tok.kind == CToken.BEGIN:
-                started = True
-                continue
+            if not started:
+                if tok.kind == CToken.SPACE:
+                    continue
+
+                if tok.kind == CToken.BEGIN and tok.value == self.start_delim:
+                    started = True
+                    continue
+
+                # Name only token without BEGIN/END
+                if i > start:
+                    i -= 1
+                yield start, i
+                start = None
 
             if tok.kind == CToken.END and tok.level == stack[-1][1]:
                 start, level = stack.pop()
-                offset = i
 
-                yield CTokenizer(tokenizer.tokens[start:offset + 1])
+                yield start, i
                 start = None
 
         #
@@ -367,9 +543,12 @@ class CMatch:
         # This is meant to solve cases where the caller logic might be
         # picking an incomplete block.
         #
-        if start and offset < 0:
-            print("WARNING: can't find an end", file=sys.stderr)
-            yield CTokenizer(tokenizer.tokens[start:])
+        if start and stack:
+            if started:
+                s = str(tokenizer)
+                log.warning(f"can't find a final end at {s}")
+
+            yield start, len(tokenizer.tokens)
 
     def search(self, source):
         """
@@ -386,8 +565,75 @@ class CMatch:
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
+
+    def sub(self, sub_str, source, count=0):
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
+        # Detect if sub_str contains sub arguments
+
+        args_match = CTokenArgs(sub_str)
+
+        new_tokenizer = CTokenizer()
+        pos = 0
+        n = 0
+
+        #
+        # NOTE: the code below doesn't consider overlays at sub.
+        # We may need to add some extra unit tests to check if those
+        # would cause problems. When replacing by "", this should not
+        # be a problem, but other transformations could be problematic
+        #
+        for start, end in self._search(tokenizer):
+            new_tokenizer.tokens += tokenizer.tokens[pos:start]
+
+            new = CTokenizer(tokenizer.tokens[start:end + 1])
+
+            new_tokenizer.tokens += args_match.tokens(new)
+
+            pos = end + 1
+
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
+
+    def __repr__(self):
+        """
+        Returns a displayable version of the class init.
+        """
+
+        return f'CMatch("{self.regex.regex.pattern}")'
-- 
2.52.0

