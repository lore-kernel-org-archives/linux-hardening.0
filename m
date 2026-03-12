Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C600137CD30;
	Thu, 12 Mar 2026 14:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327301; cv=none; b=YZ1NfW3+5+Tx5J2iYA8etrs6g9AifUGgCjUPp5MiGwgW12/uIpvI/pEgJR3tk8MRyIjz02SmExVHL9v0ZVA/ifUf88jWgIt9EnLkP0qMJXX7eFhZROfb/7tz7lSXCmzYxc4X/etXVKoh0s8Lj+HR+gW6LLwi1izBLQthlj//bHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327301; c=relaxed/simple;
	bh=VTrfpIcoDJoiKg/0Gp5KrZ4qMcYV14/HT00S5tsu8cc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sUHLrkEOh3oYRAaFHa6KHtUK0VUAUWA+fpjhByI1zrud3827ogQLB33X4+1Ctq9bQcevvn9yR9KMvUlF7XgOxC/7Jism2IRBIIFCPF0+/JocZVicnpWQhzV8LGkOezdOCmzKltFuhQb/4cqODWmRoW4E+eSykov0UDXXs6vCLm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oEToEVgC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oEToEVgC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB882C4CEF7;
	Thu, 12 Mar 2026 14:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773327301;
	bh=VTrfpIcoDJoiKg/0Gp5KrZ4qMcYV14/HT00S5tsu8cc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oEToEVgCfiFaJt6RWONliPJKP4rX+18J/CWNLJJy3BtXeeBLx0jB/IhGSjdZqglws
	 ce12A/ffTP1RmfJ/u3tRVvLeLHSa1i/JK9x/WhbT4FCTJ6+1yNBbU/WVSOBWbO4T4Y
	 lfeHAljHsqBmmrnwKjybgJLW9a9xNPMq4bFIv26NVV5dcBLOCtrHtNoRI3cQW23Kwo
	 +5DQLM9HvE9RP1FmeyV+Rlqy+FpzStd1rh22Kamvsophc194nh/S9AHiLpuszI8mEr
	 ubRGTGVTUHd1+VJOj99OG+AI/vIn/C0k08hdULcsAv6agL67jVdqtzIFInPozqLopW
	 xFmKB4zoqrMpw==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1w0hRD-00000008yE8-3g0O;
	Thu, 12 Mar 2026 15:54:59 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 23/28] docs: c_lex: setup a logger to report tokenizer issues
Date: Thu, 12 Mar 2026 15:54:43 +0100
Message-ID: <da59e827fd20de22045db29d4490d919ed4fbf8c.1773326442.git.mchehab+huawei@kernel.org>
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

Report file that has issues detected via CMatch and CTokenizer.

This is done by setting up a logger that will be overriden by
kdoc_parser, when used on it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/lib/python/kdoc/c_lex.py       | 36 ++++++++++++++++++++++++----
 tools/lib/python/kdoc/kdoc_parser.py |  3 +++
 2 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/tools/lib/python/kdoc/c_lex.py b/tools/lib/python/kdoc/c_lex.py
index bc70b55f0dbe..596510bb4e95 100644
--- a/tools/lib/python/kdoc/c_lex.py
+++ b/tools/lib/python/kdoc/c_lex.py
@@ -6,14 +6,39 @@
 Regular expression ancillary classes.
 
 Those help caching regular expressions and do matching for kernel-doc.
+
+Please notice that the code here may rise exceptions to indicate bad
+usage inside kdoc to indicate problems at the replace pattern.
+
+Other errors are logged via log instance.
 """
 
+import logging
 import re
 
 from copy import copy
 
 from .kdoc_re import KernRe
 
+log = logging.getLogger(__name__)
+
+def tokenizer_set_log(logger, prefix = ""):
+    """
+    Replace the module‑level logger with a LoggerAdapter that
+    prepends *prefix* to every message.
+    """
+    global log
+
+    class PrefixAdapter(logging.LoggerAdapter):
+        """
+        Ancillary class to set prefix on all message logs.
+        """
+        def process(self, msg, kwargs):
+            return f"{prefix}{msg}", kwargs
+
+    # Wrap the provided logger in our adapter
+    log = PrefixAdapter(logger, {"prefix": prefix})
+
 class CToken():
     """
     Data class to define a C token.
@@ -169,7 +194,7 @@ class CTokenizer():
             value = match.group()
 
             if kind == CToken.MISMATCH:
-                raise RuntimeError(f"Unexpected token '{value}' on {pos}:\n\t{source}")
+                log.error(f"Unexpected token '{value}' on {pos}:\n\t{source}")
             elif kind == CToken.BEGIN:
                 if value == '(':
                     paren_level += 1
@@ -189,7 +214,7 @@ class CTokenizer():
             yield CToken(kind, value, pos,
                          brace_level, paren_level, bracket_level)
 
-    def __init__(self, source=None):
+    def __init__(self, source=None, log=None):
         """
         Create a regular expression to handle TOKEN_LIST.
 
@@ -349,7 +374,7 @@ class CTokenArgs:
                 elif tok.value == "(":
                     delim = ","
                 else:
-                    raise ValueError(fr"Can't handle \1..\n on {sub_str}")
+                    self.log.error(fr"Can't handle \1..\n on {sub_str}")
 
                 level = tok.level
                 break
@@ -383,7 +408,7 @@ class CTokenArgs:
             groups_list[pos].append(tok)
 
         if pos < self.max_group:
-            raise ValueError(fr"{self.sub_str} groups are up to {pos} instead of {self.max_group}")
+            log.error(fr"{self.sub_str} groups are up to {pos} instead of {self.max_group}")
 
         return level, groups_list
 
@@ -503,7 +528,8 @@ class CMatch:
         # picking an incomplete block.
         #
         if start and stack:
-            print("WARNING: can't find an end", file=sys.stderr)
+            s = str(tokenizer)
+            log.warning(f"can't find a final end at {s}")
             yield start, len(tokenizer.tokens)
 
     def search(self, source):
diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index 0da95b090a34..3ff17b07c1c9 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -14,6 +14,7 @@ import re
 from pprint import pformat
 
 from kdoc.kdoc_re import KernRe
+from kdoc.c_lex import tokenizer_set_log
 from kdoc.c_lex import CTokenizer
 from kdoc.kdoc_item import KdocItem
 
@@ -253,6 +254,8 @@ class KernelDoc:
         self.config = config
         self.xforms = xforms
 
+        tokenizer_set_log(self.config.log, f"{self.fname}: CMatch: ")
+
         # Initial state for the state machines
         self.state = state.NORMAL
 
-- 
2.52.0

