Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03C43AD509;
	Thu, 12 Mar 2026 07:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773299554; cv=none; b=qiLrSxfvLiz2RPDTvKFU6ukyM6y5rdLlgxS7ePj67mGQk08SxgS4DNRNDwcw61tls3eoW001nSQV/V2b8o6juJXULaWtb/aRNMvHE6UUFOzPXzgjt1vtbdfrpXEOEZIqsUgUCUayj07Q4BcPGMsfuFPdBBHub7jVUVADLjmPMZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773299554; c=relaxed/simple;
	bh=H4IWlHfCRm/9kMM9kyWHhyYxEDQxSEyHhWFeVtOIZww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C7HN4hn27bs3SORpcaxHAUq+RN3/KoDbmS8JPJMs0E/XF6niXcOn70U/m/71bz782DLgJxJSS5JGSp6xTudGhMsvnSP1wHO+v3MNN6kLKlb7LGGlRyBxEEJtexXJU7ZtXw8hqQCE/bDWxzVOCXNli7B1znQnALF3q1XrEhLXd7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0WVh6Xw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0WVh6Xw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70AD2C4AF0D;
	Thu, 12 Mar 2026 07:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773299553;
	bh=H4IWlHfCRm/9kMM9kyWHhyYxEDQxSEyHhWFeVtOIZww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l0WVh6Xw9sG8qxNXc+v9jsaSHIF7fB6437iMDyMuBJnDjV4leQS+ATrh5OOr4TpsH
	 tlnHzHE/6byWaGkHu5FoQDPciwg+n7sJWjBv+jsM2kQTR73OMyooA929fagR6gifds
	 M/NVejEcy0tE9270/OAI1LRijZvwSBBNKx7tLivXkLR4zTDspyopotFPmyRmCedh5O
	 FT5j360ZsFD9X55u06n5z5M+E2SLixFce1pWAXrGhk1gY0JrtNYYGJZ5Air59pFTLx
	 bAFGSjiURafoQ5lWAEwcr4ZAkyPup3420p5fVS4eQBTg26vSLj9jEdd787HZMDRe5B
	 Nzq9FNRzNNACQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1w0aDf-000000077hN-31vY;
	Thu, 12 Mar 2026 08:12:31 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 16/20] docs: kdoc_re: get rid of NestedMatch class
Date: Thu, 12 Mar 2026 08:12:24 +0100
Message-ID: <f1618cace1b0c67245d110e7eb6345a6259eebf9.1773297828.git.mchehab+huawei@kernel.org>
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

Now that everything was converted to CMatch, we can get rid of
the previous NestedMatch implementation.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/lib/python/kdoc/kdoc_re.py | 202 -------------------------------
 1 file changed, 202 deletions(-)

diff --git a/tools/lib/python/kdoc/kdoc_re.py b/tools/lib/python/kdoc/kdoc_re.py
index ba601a4f5035..6f3ae28859ea 100644
--- a/tools/lib/python/kdoc/kdoc_re.py
+++ b/tools/lib/python/kdoc/kdoc_re.py
@@ -140,205 +140,3 @@ class KernRe:
         """
 
         return self.last_match.groups()
-
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
2.53.0

