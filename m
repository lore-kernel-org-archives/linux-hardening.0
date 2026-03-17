Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568F93F9F2A;
	Tue, 17 Mar 2026 18:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773770991; cv=none; b=Ln7OyD8Bm9TwxM0s0tOzv44zeFhOZHD3jDCxXZT64yFoKCt3iH23KgcCICdqh+wgBvRulfGMp0FBpRAHVf6WXqT0pb0Igw5S6Xdmrw1jzqR2vjaY4ZJoGfa48exSFWp81Z7jxgChVV5juo+XdElYBW73TZTEbsz5XzJayNVYMnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773770991; c=relaxed/simple;
	bh=to0W2pmEulg+FP9A5LEaz371Z48eT+uPf4OqaF42Mc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R2aRJOHQBk06h3kmJHErQjJHL5vLqCRREXpJbOdFLBnuBwGYQWmR5BeAtTaZ5qdabokG2UZZ5HLIiG882fonljpKdyt+XQ6Yz1Lg9bqMTRmPSm5qznlwpNZq5f0LA1VwNWwjhoYDPve5zKc/03rlzurj3wN1fnIEYIvkacKZlsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sh3c5Rx6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sh3c5Rx6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 392ADC2BC9E;
	Tue, 17 Mar 2026 18:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773770991;
	bh=to0W2pmEulg+FP9A5LEaz371Z48eT+uPf4OqaF42Mc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sh3c5Rx6BcxG1vFD5Mz1ndZrpFiawuxYkqhEbvZIqbuesBVo1bS5FkfFXlqDWCivo
	 S/bDhj7g/AdiVu5dqQyzR/thUeWqNYUuxlwAnnnGKA7uIDG4iWzOgj2fzySIGf0q+6
	 ge4AeIHZ1PosEOts4KRWEvMaX0fPLzdjlt/izt8pD2x6TtYVThm7eFa2+HJoOBDVA+
	 xYmeXVTQN3kuaKbD38QUUSxfSqvIKsiLRNyiMQLJMGFj23Di5HJKOEqaQDpNU/85kY
	 9+HFKdmvWl1NqfKW8kcasXXXhKEFqG+4yUhp4Ouf1845AeJMoyjW3hEBqWLaOVQ6fd
	 2PIONIZzfaKEw==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1w2YrV-0000000H5eS-24Aj;
	Tue, 17 Mar 2026 19:09:49 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v3 21/22] docs: kdoc_parser: avoid tokenizing structs everytime
Date: Tue, 17 Mar 2026 19:09:41 +0100
Message-ID: <1cc2a4286ebf7d4b2d03fcaf42a1ba9fa09004b9.1773770483.git.mchehab+huawei@kernel.org>
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

Most of the rules inside CTransforms are of the type CMatch.

Don't re-parse the source code every time.

Doing this doesn't change the output, but makes kdoc almost
as fast as before the tokenizer patches:

    # Before tokenizer patches
    $ time ./scripts/kernel-doc . -man >original 2>&1

    real    0m42.933s
    user    0m36.523s
    sys     0m1.145s

    # After tokenizer patches
    $ time ./scripts/kernel-doc . -man >before 2>&1

    real    1m29.853s
    user    1m23.974s
    sys     0m1.237s

    # After this patch
    $ time ./scripts/kernel-doc . -man >after 2>&1

    real    0m48.579s
    user    0m45.938s
    sys     0m0.988s

    $ diff -s before after
    Files before and after are identical

Manually checked the differences between original and after
with:

    $ diff -U0 -prBw original after|grep -v Warning|grep -v "@@"|less

They're due:
  - whitespace fixes;
  - struct_group are now better handled;
  - several badly-generated man pages from broken inline kernel-doc
    markups are now fixed.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/lib/python/kdoc/kdoc_parser.py  |  1 -
 tools/lib/python/kdoc/xforms_lists.py | 30 +++++++++++++++++++++------
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index 8b2c9d0f0c58..f6c4ee3b18c9 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -737,7 +737,6 @@ class KernelDoc:
         #
         # Go through the list of members applying all of our transformations.
         #
-        members = trim_private_members(members)
         members = self.xforms.apply("struct", members)
 
         #
diff --git a/tools/lib/python/kdoc/xforms_lists.py b/tools/lib/python/kdoc/xforms_lists.py
index 2056572852fd..5a62d4a450cb 100644
--- a/tools/lib/python/kdoc/xforms_lists.py
+++ b/tools/lib/python/kdoc/xforms_lists.py
@@ -5,7 +5,7 @@
 import re
 
 from kdoc.kdoc_re import KernRe
-from kdoc.c_lex import CMatch
+from kdoc.c_lex import CMatch, CTokenizer
 
 struct_args_pattern = r'([^,)]+)'
 
@@ -16,6 +16,12 @@ class CTransforms:
     into something we can parse and generate kdoc for.
     """
 
+    #
+    # NOTE:
+    #      Due to performance reasons, place CMatch rules before KernRe,
+    #      as this avoids running the C parser every time.
+    #
+
     #: Transforms for structs and unions.
     struct_xforms = [
         # Strip attributes
@@ -124,13 +130,25 @@ class CTransforms:
         "var": var_xforms,
     }
 
-    def apply(self, xforms_type, text):
+    def apply(self, xforms_type, source):
         """
-        Apply a set of transforms to a block of text.
+        Apply a set of transforms to a block of source.
+
+        As tokenizer is used here, this function also remove comments
+        at the end.
         """
         if xforms_type not in self.xforms:
-            return text
+            return source
+
+        if isinstance(source, str):
+            source = CTokenizer(source)
 
         for search, subst in self.xforms[xforms_type]:
-            text = search.sub(subst, text)
-        return text
+            #
+            # KernRe only accept strings.
+            #
+            if isinstance(search, KernRe):
+                source = str(source)
+
+            source = search.sub(subst, source)
+        return str(source)
-- 
2.52.0

