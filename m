Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C32B3F8DE1;
	Tue, 17 Mar 2026 18:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773770989; cv=none; b=e0bS3ihUnFGcRQIHCdpMUarVsH0K380b0M/Bxpm+P71R/df+G+FHKWhRIM14B5BOx9Lp9c2nIyMvgQB1jS95/n4m20o8nAgtU5T8zsKt17H3cFnoTbk5NYPBY44pr8fGS7NTY8zdGCjocLeR5cq+QH3lcE5JufysQ/CzOSutxt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773770989; c=relaxed/simple;
	bh=DE2bgHoSxjCADPPtYN1w1qD6MKNDV4mXxiXZgZKnIBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qedA3G6MuCV9EOmGyc/6P8ZT3PjFfNuH3IEweJcwq9XiwSwItzRmf7/U6fyhcDb9BwPNeGgFptsl/ctOzMofsCQm+bdri2tcMsLeuDobSghaXNX+V5HzCvz5A+68My/2irCq5+dwp4eTxWHka+7DICZCiOM+YH018/gq7DCuDTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUB/P2pp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUB/P2pp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB4FC4CEF7;
	Tue, 17 Mar 2026 18:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773770989;
	bh=DE2bgHoSxjCADPPtYN1w1qD6MKNDV4mXxiXZgZKnIBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TUB/P2pp2s+U2KB2hgmk1MqkaD1NbNkXF4ajY2mgNQnJXVsj25cBYiZO4X7J/Cnx5
	 Bp7N22OVFJC5sZ+8ZTWo0Hzg2JcLcAqBeZqjhJe/9YY/8aa0k4C3aRBwbYl5yrchS8
	 QE1Y536ui8utmmxCFqH5wOtdwJOw4ADmgSoNzCvEmxp41P1u6VuIoCBjUeHQ9ffuhF
	 uDz04aig1plRvZYzOVBRetaa8vD0vLGOx78pBw7F+JZosxsHeb6XvBPTqRvj0bJGNz
	 5+073evKGRjCwv5e3X1oaWZiuSD6ItSG0RP461mRkbeX8Vh0Vqw7uyYawpcH8Fnudd
	 No/T9au2TF2XQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1w2YrT-0000000H5QY-1E68;
	Tue, 17 Mar 2026 19:09:47 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/22] docs: kdoc: create a CMatch to match nested C blocks
Date: Tue, 17 Mar 2026 19:09:30 +0100
Message-ID: <fa818ea164216b17520b588e3f12b81499b76dd7.1773770483.git.mchehab+huawei@kernel.org>
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
 tools/lib/python/kdoc/c_lex.py | 121 ++++++++++++++++++++++++++++++---
 1 file changed, 111 insertions(+), 10 deletions(-)

diff --git a/tools/lib/python/kdoc/c_lex.py b/tools/lib/python/kdoc/c_lex.py
index 9d726f821f3f..5da472734ff7 100644
--- a/tools/lib/python/kdoc/c_lex.py
+++ b/tools/lib/python/kdoc/c_lex.py
@@ -273,20 +273,121 @@ class CTokenizer():
 
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
+    # TODO: add a sub method
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
-- 
2.52.0

