Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36BA3C6A39;
	Thu, 12 Mar 2026 14:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327300; cv=none; b=cYhkbJASn++jV9Rj2ZfZdBDfL/SZhNPNYf9wLydrXvWxhYZtF250M9+wSHZ4CK5NnnxrAKwn4DhWGc2Ry47rvqFqF0Zcjy4OAE8V8/FcI5V4xQHpMIDX5733Z8spCYB4X3V++vfs+TOhbmLfbzhnM75Ic8zSr8j4H53hQe3d8DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327300; c=relaxed/simple;
	bh=FKx+LuqHphjlRc7PLbBh2Hde6kXDY4N4TxpuHIl+h8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cU/+eu6Vcmi4rIQk9c4ACDvckJAUsYg+avkF7Xw1Yb+y9EpmEtAKdiVuZxz460lGefx+9xLw2tt6DmIKbRmeMDUIQW7J7NVDubgaF1+HbWC0ovGGV/+VVT3r3IJr5diKqNimMKiO16vBelWsdZmLzrGMJrFQs929cYCGjcKVkCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qe71MJgV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qe71MJgV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A02C19424;
	Thu, 12 Mar 2026 14:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773327300;
	bh=FKx+LuqHphjlRc7PLbBh2Hde6kXDY4N4TxpuHIl+h8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qe71MJgVQKU2PbZw0gUvRVIXC56p2sldelaWf1bVQN3FHOzUGklqbQDPeYRR9XrKL
	 h07sZsn4bM4zA4x8WXBocxEH+ORFcb7f2H4DT3KRTurlLxBxafHKDTdB7FYARbrXqQ
	 +zU69teR6S9nPbWuh3eM5L1wI22zElJkyJUkS34iewpssgBzL6EXpyEGRVV1hZaTEO
	 P8tL/gF81N61pTG4Qd/DIFZaMWyqQkiPqrb54wbzBxRnYo2m4SnfFVOHYdQ9FTVvQi
	 Ota96PGyZ8M/ieny8lo/uI093O614PV465kJNJg5kfA7Vt7RMM9jkVxVPbZpaVqIMA
	 NSGSNDhEmqXpQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1w0hRC-00000008y5B-26JQ;
	Thu, 12 Mar 2026 15:54:58 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 16/28] docs: kdoc_re: get rid of NestedMatch class
Date: Thu, 12 Mar 2026 15:54:36 +0100
Message-ID: <f1618cace1b0c67245d110e7eb6345a6259eebf9.1773326442.git.mchehab+huawei@kernel.org>
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
2.52.0

