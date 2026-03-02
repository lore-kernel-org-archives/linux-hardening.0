Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7483421EED;
	Mon,  2 Mar 2026 16:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772469669; cv=none; b=Gh+bJXNEg8FGPT2YhS2miAos+Y/Y6w+sT8Ghh+yvcqM0RqI1nARHX6HawUgDEKn46bIol6Wtn1LAPmSuaqaoXmoCwt1aaJYXuqE0b030e+l4ArynW4vxYS5COFrspNURJQWPvO9PYFByXJYlFG4XYhTknRQjSkOXpeTATnUDKK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772469669; c=relaxed/simple;
	bh=3YzxxHgVjkBet+RBKm4GWxqcg0N/we4EFRl+qm5WAOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MpxaK6gqWGCIz9rLCnksvQ02wuTtebmFORb1ZsQq3M/lYr4QDcgKYtCOB/naHwBoSrA3IxGcMu1f8aSUVHwR3PUkuadrIKZsGYb5ajkOJdmue+E16vlLnuAqktI1MnHfi1E7M2aHx34Hg8PLTY4ESXcNx5eWAaoFUCrYIH4qO+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHssqK16; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHssqK16"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B81C2BCAF;
	Mon,  2 Mar 2026 16:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772469669;
	bh=3YzxxHgVjkBet+RBKm4GWxqcg0N/we4EFRl+qm5WAOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hHssqK16wou1zOz3yoo/HO9erjhMozloQ4bEl4tLNbPxPwyKeJq6DOCLEiZurlEhX
	 zFWaVC4a5sRcuEjNrVbcn7U56lR0vNhzqWqpa+OBAC6haKtYDVFPnZMwYxAgCSJS+B
	 eh5JsQU3J0Xja1ha+IN0h7188xwZYz4uYkmook3gYroMc7Be1/F06NCEfM00ZoJbxG
	 Gb5oZOkX/1ZXSfczB6hMvjS22hM8C9fl8SULfXAFK4YxcYbe9KcIHmItu8dEBN/uI7
	 B65+FVNQf9QOOrKRy9B2VVzkGQLlkGlkQTWWo624bk9R3sWpvQNrgE4XsLhocs+vbo
	 BfLM7ZuR5k8fQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vx6KR-0000000032F-2n4B;
	Mon, 02 Mar 2026 17:41:07 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 05/18] docs: kdoc_parser: fix variable regexes to work with size_t
Date: Mon,  2 Mar 2026 17:40:48 +0100
Message-ID: <8230715239929cf9d475ab81ca1df7de65d82d06.1772469446.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1772469446.git.mchehab+huawei@kernel.org>
References: <cover.1772469446.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

The regular expressions meant to pick variable types are too
naive: they forgot that the type word may contain underlines.

It also means that we need to change the regex which detects
var attributes to handle "const".

Co-developed-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 tools/lib/python/kdoc/kdoc_parser.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index 9643ffb7584a..9c9443281c40 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -981,8 +981,9 @@ class KernelDoc:
         """
         VAR_ATTRIBS = [
             "extern",
+            "const",
         ]
-        OPTIONAL_VAR_ATTR = "^(?:" + "|".join(VAR_ATTRIBS) + ")?"
+        OPTIONAL_VAR_ATTR = r"^(?:\b(?:" +"|".join(VAR_ATTRIBS) +r")\b\s*)*"
 
         #
         # Store the full prototype before modifying it
@@ -1018,14 +1019,14 @@ class KernelDoc:
 
         default_val = None
 
-        r= KernRe(OPTIONAL_VAR_ATTR + r"\w.*\s+(?:\*+)?([\w_]+)\s*[\d\]\[]*\s*(=.*)?")
+        r= KernRe(OPTIONAL_VAR_ATTR + r"[\w_]*\s+(?:\*+)?([\w_]+)\s*[\d\]\[]*\s*(=.*)?")
         if r.match(proto):
             if not declaration_name:
                 declaration_name = r.group(1)
 
             default_val = r.group(2)
         else:
-            r= KernRe(OPTIONAL_VAR_ATTR + r"(?:\w.*)?\s+(?:\*+)?(?:[\w_]+)\s*[\d\]\[]*\s*(=.*)?")
+            r= KernRe(OPTIONAL_VAR_ATTR + r"(?:[\w_]*)?\s+(?:\*+)?(?:[\w_]+)\s*[\d\]\[]*\s*(=.*)?")
         if r.match(proto):
             default_val = r.group(1)
 
-- 
2.52.0

