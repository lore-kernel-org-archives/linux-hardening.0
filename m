Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD4E3093BB
	for <linux-hardening@vger.kernel.org>; Thu, 14 May 2026 16:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778777799; cv=none; b=M+rIPLASmrLDyQN+Ooj7mMV/Vi4cuBo11UkrPPMEsnBPbSs3wWIqvpmVCV4hWqgkeMJLGHB0EcsC0Bo/AIU3t+aB1s9oGcydjP/FF0BvkmrHoJG4ndrnrN606nuWZw+Zlay0PQ4Qkuq094XV1O6zeXQuxrblPjmu9eO5MVlrQeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778777799; c=relaxed/simple;
	bh=gzaa5iePAZiz1sg/wFSdpH4cQWwypXIWN8DbImMC8FY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=djO8neL2AL4eYGKM6XpgtgudSjNY7fDIBA6dwM5rRNOC4H3cFhJ2M1uSyjayaUoO1s5fl+l4Ymq2GJ65kRzNlV/vsq6h4KjHF3b0B61+PfcOxzAOyKdggJHV+2BmG3bzVV9WBwauZ03v/mcTMMBsR39HCpE7c625iwjoXL0yyoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X2aSQPsc; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X2aSQPsc"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778777795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tbv8ak9UNoJIeSwadmarn+te6qWkig7YLGlW6ok+WOk=;
	b=X2aSQPscD7WDuQpPNwdsEVlJXWx0t1Wfq97MwNMJ96CDCqk9ONFevQHUtj0Snb4SkbWkz4
	KidNKV9p+WpGnHCFwAUz8iSmZcZXAijIHN2midpnSh2bqw5eg7kAKdHT5P+amEy8PhLAfT
	LMNcSVBBfx/U7aPqeaqB2YMNTbKfUEY=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] string: use min in sized_strscpy
Date: Thu, 14 May 2026 18:56:03 +0200
Message-ID: <20260514165601.527883-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1128; i=thorsten.blum@linux.dev; h=from:subject; bh=gzaa5iePAZiz1sg/wFSdpH4cQWwypXIWN8DbImMC8FY=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFms/xYuXVEo578x9m7VodZtmYdfKUxndHu4eV8l29337 nXGtlarOkpZGMS4GGTFFFkezPoxw7e0pnKTScROmDmsTCBDGLg4BWAiHtcZGX4fn/ExtHvKzYZt rfK6f+d7puyImaX/fObzF7P9QrznpFgx/I8qqWhL+MTEWqb3o9wkpPfPMXXFkF75tzvats2YevJ hIC8A
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use min() and drop the limit variable to simplify sized_strscpy().

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 lib/string.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/lib/string.c b/lib/string.c
index b632c71df1a5..1f9297e9776a 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -21,6 +21,7 @@
 #include <linux/errno.h>
 #include <linux/limits.h>
 #include <linux/linkage.h>
+#include <linux/minmax.h>
 #include <linux/stddef.h>
 #include <linux/string.h>
 #include <linux/types.h>
@@ -125,11 +126,8 @@ ssize_t sized_strscpy(char *dest, const char *src, size_t count)
 	 * If src is unaligned, don't cross a page boundary,
 	 * since we don't know if the next page is mapped.
 	 */
-	if ((long)src & (sizeof(long) - 1)) {
-		size_t limit = PAGE_SIZE - ((long)src & (PAGE_SIZE - 1));
-		if (limit < max)
-			max = limit;
-	}
+	if ((long)src & (sizeof(long) - 1))
+		max = min(PAGE_SIZE - ((long)src & (PAGE_SIZE - 1)), max);
 #else
 	/* If src or dest is unaligned, don't do word-at-a-time. */
 	if (((long) dest | (long) src) & (sizeof(long) - 1))
