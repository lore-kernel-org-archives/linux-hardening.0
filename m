Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F173F8E11;
	Tue, 17 Mar 2026 18:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773770990; cv=none; b=dmSZ4YRCV0MwxnI5uq7W0XVkb3a8MhFDdUXwibBdAPytm158ZBJ544Q1Rgh5rM3Y8WJm0KP4ObOqGWMOziTe3HDLnxBH0ScGqInvMb+LWSeRCDky/lYOCp25RaLcfSYPCBJCt9LUptHGBxJQ2flw1BmAbwQZdkDoyt1EzBqsO2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773770990; c=relaxed/simple;
	bh=PHXaltNZ4ol9wjdXwRcvdpg7f6YIjhlE0exg45N//uI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BayqnFcXGn61cA7zSAh3c4DfdbQnWphKBysR0hd4wjLeqZU4H2HZL1VuLk3gtx2+d6qZn/cOrfGTjtNc+lDXHFD/DjpHB87jDBeANsaA20+vtrJJwKjom4V+EXrenEs4JKjnQqS44xMPjxLIQlbNJliicMFVX8nGb+3pxOXlp8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZrXSmO8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZrXSmO8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C34CC2BC86;
	Tue, 17 Mar 2026 18:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773770990;
	bh=PHXaltNZ4ol9wjdXwRcvdpg7f6YIjhlE0exg45N//uI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gZrXSmO8eUuqNsR8v0KCMp8jF81KEFRbJbqAYCDJ2UpCdHIATyteYnkX450rkHfgY
	 V/R7LzUFsxScj+s2vqyXnulzQwxxKKx+sER7lhA+zDhYCX2l7YDlnOp04dtv88a+yD
	 ySZQygOHGu/y6AjAlx3CpV/tVr0b8HnxeOtGICymjfk3I0imb1FkhcxR6r9OXN076s
	 p7W+u2Ego4wP03zptj11rl/z6PvVZYvq0wEXoILGmFqJPHPB0UCd5MQXZt2YZiEP4H
	 X1eNtVqzrJmMm+wP0dRsUQ8At2CK36Wf2Q75nMF/5m8PMEMQQZ+N/MYnK+WBbK7rww
	 8GCpMF9EVnSbw==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1w2YrU-0000000H5Wi-1EkP;
	Tue, 17 Mar 2026 19:09:48 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v3 15/22] docs: kdoc_re: get rid of NestedMatch class
Date: Tue, 17 Mar 2026 19:09:35 +0100
Message-ID: <c82dd0d2c0ab330fc04925965091c448ccabb8fd.1773770483.git.mchehab+huawei@kernel.org>
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

Now that everything was converted to CMatch, we can get rid of
the previous NestedMatch implementation.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/lib/python/kdoc/kdoc_re.py | 201 -------------------------------
 1 file changed, 201 deletions(-)

diff --git a/tools/lib/python/kdoc/kdoc_re.py b/tools/lib/python/kdoc/kdoc_re.py
index 085b89a4547c..6f3ae28859ea 100644
--- a/tools/lib/python/kdoc/kdoc_re.py
+++ b/tools/lib/python/kdoc/kdoc_re.py
@@ -140,204 +140,3 @@ class KernRe:
         """
 
         return self.last_match.groups()
-
-#: Nested delimited pairs (brackets and parenthesis)
-DELIMITER_PAIRS = {
-    '{': '}',
-    '(': ')',
-    '[': ']',
-}
-
-#: compiled delimiters
-RE_DELIM = KernRe(r'[\{\}\[\]\(\)]')
-
-
-class NestedMatch:
-    """
-    Finding nested delimiters is hard with regular expressions. It is
-    even harder on Python with its normal re module, as there are several
-    advanced regular expressions that are missing.
-
-    This is the case of this pattern::
-
-            '\\bSTRUCT_GROUP(\\(((?:(?>[^)(]+)|(?1))*)\\))[^;]*;'
-
-    which is used to properly match open/close parentheses of the
-    string search STRUCT_GROUP(),
-
-    Add a class that counts pairs of delimiters, using it to match and
-    replace nested expressions.
-
-    The original approach was suggested by:
-
-        https://stackoverflow.com/questions/5454322/python-how-to-match-nested-parentheses-with-regex
-
-    Although I re-implemented it to make it more generic and match 3 types
-    of delimiters. The logic checks if delimiters are paired. If not, it
-    will ignore the search string.
-    """
-
-    # TODO: make NestedMatch handle multiple match groups
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
-
-    def __init__(self, regex):
-        self.regex = KernRe(regex)
-
-    def _search(self, line):
-        """
-        Finds paired blocks for a regex that ends with a delimiter.
-
-        The suggestion of using finditer to match pairs came from:
-        https://stackoverflow.com/questions/5454322/python-how-to-match-nested-parentheses-with-regex
-        but I ended using a different implementation to align all three types
-        of delimiters and seek for an initial regular expression.
-
-        The algorithm seeks for open/close paired delimiters and places them
-        into a stack, yielding a start/stop position of each match when the
-        stack is zeroed.
-
-        The algorithm should work fine for properly paired lines, but will
-        silently ignore end delimiters that precede a start delimiter.
-        This should be OK for kernel-doc parser, as unaligned delimiters
-        would cause compilation errors. So, we don't need to raise exceptions
-        to cover such issues.
-        """
-
-        stack = []
-
-        for match_re in self.regex.finditer(line):
-            start = match_re.start()
-            offset = match_re.end()
-            string_char = None
-            escape = False
-
-            d = line[offset - 1]
-            if d not in DELIMITER_PAIRS:
-                continue
-
-            end = DELIMITER_PAIRS[d]
-            stack.append(end)
-
-            for match in RE_DELIM.finditer(line[offset:]):
-                pos = match.start() + offset
-
-                d = line[pos]
-
-                if escape:
-                    escape = False
-                    continue
-
-                if string_char:
-                    if d == '\\':
-                        escape = True
-                    elif d == string_char:
-                        string_char = None
-
-                    continue
-
-                if d in ('"', "'"):
-                    string_char = d
-                    continue
-
-                if d in DELIMITER_PAIRS:
-                    end = DELIMITER_PAIRS[d]
-
-                    stack.append(end)
-                    continue
-
-                # Does the end delimiter match what is expected?
-                if stack and d == stack[-1]:
-                    stack.pop()
-
-                    if not stack:
-                        yield start, offset, pos + 1
-                        break
-
-    def search(self, line):
-        """
-        This is similar to re.search:
-
-        It matches a regex that it is followed by a delimiter,
-        returning occurrences only if all delimiters are paired.
-        """
-
-        for t in self._search(line):
-
-            yield line[t[0]:t[2]]
-
-    def sub(self, sub, line, count=0):
-        """
-        This is similar to re.sub:
-
-        It matches a regex that it is followed by a delimiter,
-        replacing occurrences only if all delimiters are paired.
-
-        if the sub argument contains::
-
-            r'\0'
-
-        it will work just like re: it places there the matched paired data
-        with the delimiter stripped.
-
-        If count is different than zero, it will replace at most count
-        items.
-        """
-        out = ""
-
-        cur_pos = 0
-        n = 0
-
-        for start, end, pos in self._search(line):
-            out += line[cur_pos:start]
-
-            # Value, ignoring start/end delimiters
-            value = line[end:pos - 1]
-
-            # replaces \0 at the sub string, if \0 is used there
-            new_sub = sub
-            new_sub = new_sub.replace(r'\0', value)
-
-            out += new_sub
-
-            # Drop end ';' if any
-            if pos < len(line) and line[pos] == ';':
-                pos += 1
-
-            cur_pos = pos
-            n += 1
-
-            if count and count >= n:
-                break
-
-        # Append the remaining string
-        l = len(line)
-        out += line[cur_pos:l]
-
-        return out
-
-    def __repr__(self):
-        """
-        Returns a displayable version of the class init.
-        """
-
-        return f'NestedMatch("{self.regex.regex.pattern}")'
-- 
2.52.0

