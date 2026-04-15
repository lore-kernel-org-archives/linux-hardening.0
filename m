Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335B52D1303
	for <linux-hardening@vger.kernel.org>; Wed, 15 Apr 2026 12:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776256028; cv=none; b=MjBaSsvJYXZ2YEzgobIgV0h+3fzOCH8Gcxcyx1QABsUsrLnB5nsHJOvshumGiM2xbKXkZddFFzVGwBKmKjcHqXEneeKQBuYwdz2i6z8/Sv3WWfLMI3u4YwsojPmxWtqU84zZx66pQPFkmy2QzAdP4Z2TIhSUvvVXmB/hffi2hiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776256028; c=relaxed/simple;
	bh=PRdNEVKlER3EhuO8MoENAEJfXHr7gcOKzROOoi08T+g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XOSmlveLc3tfyJRy0IlL5tQ9yT9hDttm2fswv2qGRYHgIOV1qyr6gdnn+kMFgWDFfgWJlXfZao9FD56cZbxNvJ9vG7OCDPSCDoa6fe46ietJSAKheAUkTpuMchYILgunPoB6Vmc3qAPbi9bghZiXQ5vXgYNcZGkhw52G71C3ZuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=D5XICtxm; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D5XICtxm"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776256015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YwV/DAxh34EhOmkw7GpaiTkHBm2P4+xVNeretb73iuc=;
	b=D5XICtxmlaK9aSzvVSRLwSTw6gD1g7zQkqgGPprrp8V/jQwunozeiqfEDhzvuZe+XVR21M
	so1H6TrS9n1457VGUvxHrypZiNPSR2SD1yX+cTewESe0JTASt+EqYX7/89DCuDhdIhelwv
	8KwQnThpVhGNCbh6P9IC/ZVrtC2E57s=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] lib/string_helpers: drop redundant allocation in kasprintf_strarray
Date: Wed, 15 Apr 2026 14:25:43 +0200
Message-ID: <20260415122542.370926-4-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1261; i=thorsten.blum@linux.dev; h=from:subject; bh=PRdNEVKlER3EhuO8MoENAEJfXHr7gcOKzROOoi08T+g=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJn3m4/d38aicsjLj7PF6Wi2U79A2I/qHzsTi+smtv2Ku M1bv+xTRykLgxgXg6yYIsuDWT9m+JbWVG4yidgJM4eVCWQIAxenAEykW5vhf6a1ZO5Pu8vuff85 E5ceq3OyPvljruLaoqaUpzw3feadKGb4zaITnqb0pkxwusW11pOL2Jw4dnaKihyYohprp1ok4m3 JAgA=
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

kasprintf_strarray() returns an array of N strings and kfree_strarray()
also frees N entries.  However, kasprintf_strarray() currently allocates
N+1 char pointers.  Allocate exactly N pointers instead of N+1.

Also update the kernel-doc for @n.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 lib/string_helpers.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 169eaf583494..6a8db441b6fd 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -752,7 +752,7 @@ EXPORT_SYMBOL_GPL(kstrdup_and_replace);
  * kasprintf_strarray - allocate and fill array of sequential strings
  * @gfp: flags for the slab allocator
  * @prefix: prefix to be used
- * @n: amount of lines to be allocated and filled
+ * @n: number of strings to be allocated and filled
  *
  * Allocates and fills @n strings using pattern "%s-%zu", where prefix
  * is provided by caller. The caller is responsible to free them with
@@ -765,7 +765,7 @@ char **kasprintf_strarray(gfp_t gfp, const char *prefix, size_t n)
 	char **names;
 	size_t i;
 
-	names = kcalloc(n + 1, sizeof(char *), gfp);
+	names = kcalloc(n, sizeof(char *), gfp);
 	if (!names)
 		return NULL;
 
