Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256E2426ED8;
	Mon,  2 Mar 2026 16:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772469672; cv=none; b=fjhIxCShxGSXYokAImQ0qPpZc8POrGpdaYhKicedafcZFQNbukFEHuwpzcU+4CbNJSPTrvUDjokfNC8+YysPpICSieyJUlGMoyqkSv6+zp6wo/7RQEBw+2nJA29djIlBVK6pt/D+TyddbQnngvkwJw1q3S5xE30c/Dc5D/8gfDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772469672; c=relaxed/simple;
	bh=5Li4bPNf54tBE9w7pNezt1RbIizsyzOaZvi5OGnyIRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fje1wRFS8bXx0wFl6CpV3S97ekHRMy9V1zqAx2KdpM+WAhTYvzRXwTV+I6Dw29qhU4/w73pRu6AzEPORDFc+71MmfgoyP+RJyUAU6pIjHJMxMd4TeLk9qIO9SojMeQk3Slpg0Y7+HE9U4taKGMldsu3XY3MlVMnO8k8KoUqMww4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDoqCOPE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDoqCOPE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE60DC2BCAF;
	Mon,  2 Mar 2026 16:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772469672;
	bh=5Li4bPNf54tBE9w7pNezt1RbIizsyzOaZvi5OGnyIRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kDoqCOPEBP9CVRmG+uWmRhE2CnUEUUJGrD1kT7q0eOiEmgqr+iU4mRjNLpSdloSgi
	 xDxprJ7zyGmLTTzaNSj0Od9exHRwwScrDsfZA7wQbIGsIqSRNmqbbv4y4K4NJN/BG1
	 R77pH90i7g0lYkO0jaFhEvG0hYXHZazIZn67f80o3vdYtLD8xNIAhtg2GO5Gl1idtY
	 m/WYYMaEErOlfRIz8gnyAuEhKv6NEWXz/S2p7z9KAxiY6eMCKdGMmgYHbGU1yFJRse
	 TgNZg2gDxV7r+FKONY+mhE5Ag8uqGyXzqkcIikuSBfztozpdRay3nk25fmICEtaEHV
	 8m+bSDr4Qi1PQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vx6KT-000000003Fh-3EF9;
	Mon, 02 Mar 2026 17:41:09 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 16/18] docs: kdoc_re: Change NestedMath args replacement to \0
Date: Mon,  2 Mar 2026 17:40:59 +0100
Message-ID: <46e383118be9d9e432e3814fe819ebb12261d7b4.1772469446.git.mchehab+huawei@kernel.org>
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

Future patches will allow parsing each argument instead of the
hole set. Prepare for it by changing the replace all args from
\1 to \0.

No functional changes.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 tools/lib/python/kdoc/kdoc_parser.py | 2 +-
 tools/lib/python/kdoc/kdoc_re.py     | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index 503a18212747..0f90c16cb51a 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -85,7 +85,7 @@ struct_nested_prefixes = [
     (re.compile(r"__cond_acquires_shared\s*\("), ""),
     (re.compile(r"__acquires_shared\s*\("), ""),
     (re.compile(r"__releases_shared\s*\("), ""),
-    (re.compile(r'\bSTRUCT_GROUP\('), r'\1'),
+    (re.compile(r'\bSTRUCT_GROUP\('), r'\0'),
 ]
 
 #
diff --git a/tools/lib/python/kdoc/kdoc_re.py b/tools/lib/python/kdoc/kdoc_re.py
index 00afa5bccd6d..ea4f6f3d9e42 100644
--- a/tools/lib/python/kdoc/kdoc_re.py
+++ b/tools/lib/python/kdoc/kdoc_re.py
@@ -188,7 +188,7 @@ class NestedMatch:
     # except that the content inside the match group is delimiter-aligned.
     #
     # The content inside parentheses is converted into a single replace
-    # group (e.g. r`\1').
+    # group (e.g. r`\0').
     #
     # It would be nice to change such definition to support multiple
     # match groups, allowing a regex equivalent to:
@@ -291,7 +291,7 @@ class NestedMatch:
 
         if the sub argument contains::
 
-            r'\1'
+            r'\0'
 
         it will work just like re: it places there the matched paired data
         with the delimiter stripped.
@@ -310,9 +310,9 @@ class NestedMatch:
             # Value, ignoring start/end delimiters
             value = line[end:pos - 1]
 
-            # replaces \1 at the sub string, if \1 is used there
+            # replaces \0 at the sub string, if \0 is used there
             new_sub = sub
-            new_sub = new_sub.replace(r'\1', value)
+            new_sub = new_sub.replace(r'\0', value)
 
             out += new_sub
 
-- 
2.52.0

