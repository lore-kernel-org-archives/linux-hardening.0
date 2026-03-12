Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DD53C7E1D;
	Thu, 12 Mar 2026 14:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327302; cv=none; b=IdyPqWbzNNKO7TJ+f5q/g37ZDUKmL/doQQr/SbiE0trPcN1viJUEXbfQgy3oTH73oO3m19qQHrk5p3VmsQbFaUiO0h50FiIuguyMG1OeCk3E6ZRAQqv60VaSDbiOZwYGzGlZtvwDvb26SEotP1pxhMqwiQDNV4cFo67PZcU2Awg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327302; c=relaxed/simple;
	bh=IJSnRIO93NxR2KWmARf1NOwTNiZnK4e1wz54iqqYRaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NDxrzQAc2mgA3LHtG/rWSYpyrj72JtizI/YEeGR3JhM1uQgBrXfn/T1IeBnHRlXSrmsefzENL/+KIeaL4vCcb+8af3iyAj4ldsYtjUcfNQgmtaD7TQs/noopo3pHxcNG+6HyP4EmwmBIuuZs3UkafwjgNr8c5hcgKBnwRhsOtF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQ6/04TI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQ6/04TI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00EB8C4AF09;
	Thu, 12 Mar 2026 14:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773327302;
	bh=IJSnRIO93NxR2KWmARf1NOwTNiZnK4e1wz54iqqYRaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZQ6/04TIt//juwtwiLcMiyEexNQ+nq9ATNEWbgz53whRglhoqMGUs/RaH//iZRTyY
	 J+wdhlk4xbhgQ5Siu++Nj07XJdi9smoBEpVir1jQBzeRSOv+yCoEjZVGSzwPu9VbEI
	 +QKdFpVbxzMkkW4gfv4d+7KyJFuiI0fFdTsmWS7YTI6hKO3A1lEmDw9/YDj8VJg2uD
	 bdAtx0ogItpomJS/FN/c4x9N5lbCplrxMSND8UYrXLWPmK/SGrvFssLTQnBYEEmQTl
	 YPvehOk+jdhIBomJh54VRf6F/trJ+B31eSMx4P2PtP7LjHYLctbUjdEl9M6GtXh9XF
	 hkmF31ec0q1zw==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1w0hRE-00000008yGa-16kN;
	Thu, 12 Mar 2026 15:55:00 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 25/28] docs: c_lex: better handle BEGIN/END at search
Date: Thu, 12 Mar 2026 15:54:45 +0100
Message-ID: <37627b24590ac26f638ce2c460a5cd400bef14cb.1773326442.git.mchehab+huawei@kernel.org>
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

Currently, the logic is emitting warnings after finishing
to parse a prototype like:

    static inline unsigned \
        read_seqretry(const seqlock_t *sl, unsigned start)
        __releases_shared(sl) __no_context_analysis

The problem is that the last CMatch there doesn't have BEGIN/END,
but this is already expected.

Make the logic more restrict by:
    - ensure that BEGIN/END there refers to function-like calls,
      e.g. foo(...);
    - only emit a warning after BEGIN is detected.

Instead of hardcoding "(" delim, let the caller specify if a different
one would be required.

While here, remove an uneeded elsif.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/lib/python/kdoc/c_lex.py | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/tools/lib/python/kdoc/c_lex.py b/tools/lib/python/kdoc/c_lex.py
index 8beac59166fc..e641bace5d69 100644
--- a/tools/lib/python/kdoc/c_lex.py
+++ b/tools/lib/python/kdoc/c_lex.py
@@ -463,8 +463,9 @@ class CMatch:
     """
 
 
-    def __init__(self, regex):
+    def __init__(self, regex, delim="("):
         self.regex = KernRe("^" + regex + r"\b")
+        self.start_delim = delim
 
     def _search(self, tokenizer):
         """
@@ -506,15 +507,15 @@ class CMatch:
                 if tok.kind == CToken.SPACE:
                     continue
 
-                if tok.kind == CToken.BEGIN:
+                if tok.kind == CToken.BEGIN and tok.value == self.start_delim:
                     started = True
                     continue
-                else:
-                    # Name only token without BEGIN/END
-                    if i > start:
-                        i -= 1
-                    yield start, i
-                    start = None
+
+                # Name only token without BEGIN/END
+                if i > start:
+                    i -= 1
+                yield start, i
+                start = None
 
             if tok.kind == CToken.END and tok.level == stack[-1][1]:
                 start, level = stack.pop()
@@ -528,8 +529,10 @@ class CMatch:
         # picking an incomplete block.
         #
         if start and stack:
-            s = str(tokenizer)
-            log.warning(f"can't find a final end at {s}")
+            if started:
+                s = str(tokenizer)
+                log.warning(f"can't find a final end at {s}")
+
             yield start, len(tokenizer.tokens)
 
     def search(self, source):
-- 
2.52.0

