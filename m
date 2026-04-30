Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2C72874E3
	for <linux-hardening@vger.kernel.org>; Thu, 30 Apr 2026 20:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777582447; cv=none; b=nS1WHkV3o5JKqWk8Y5R2L0n7KwugkTxGcjB7OR3Y9YwgGjYQpx64zE/s1nn0LQfhyBcsSVSG3yM3DCk5xfvaLKWU4cZk4zzGTeirUVQsD/Cz2Qm08RhgRgXW3CnPtTe+Dk63/+ibXIWRZwvXw/fijn4qEClb/5OcbdXPvFkaonc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777582447; c=relaxed/simple;
	bh=4roFchEhtSbCDXojNznern++MIpuoNGAFKyhJ3XOlHI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c3KSqOGeGFSUVzAILlmnlaV3iV6lbsFx03QHtueMmE55U0+s3jULQ6H6chzEkCW2d+S5mpY8a8/ThbttgmmFRgElyhsbOyHuJdJrAaMsF6sVmIVnkDjA8l6946dOMmmfgir2xD8ngT/gPeVgKAaY9XuXY+s6DYG9Z6uXA7Y8xuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lpznURGO; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lpznURGO"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777582433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=s2LlSdsAZtAhOtjhMfF/55AEOwafgazKcU2RXpVeNFA=;
	b=lpznURGOfQAtoAwMD+iDGPzQuFNLC7mhKOmatbFu/Rv4P5XO+ZReZxqKF5V0REb8taUe8/
	iS3UC7SlWSLmFEuS7iTt2/ePUZLUb1CtbGMemge4RLKSfgYm0g6Tndu7KFVZlVT7N1kER9
	K9pLCJY7Wiff52sqw8R0F68GFGTeasM=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] string: use strnlen in strlcat
Date: Thu, 30 Apr 2026 22:50:53 +0200
Message-ID: <20260430205050.400822-4-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=765; i=thorsten.blum@linux.dev; h=from:subject; bh=4roFchEhtSbCDXojNznern++MIpuoNGAFKyhJ3XOlHI=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJmfD6xaOtGc+behWUjXipN5PxxOr77ZsvNB1IyPfCpiG 7JjGl6qdJSyMIhxMciKKbI8mPVjhm9pTeUmk4idMHNYmUCGMHBxCsBEznAz/NOpOu2saSAyKeJr TlHsy9vaGotMH5ypmpzrGbaNr1mCbyYjw+9l695FPVsmVfz9zeUnHSLv+nIyRewmPlu7Km3CMw2 VE1wA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use strnlen() to limit the destination scan to the provided buffer size.
Remove the redundant comment.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 lib/string.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/lib/string.c b/lib/string.c
index b632c71df1a5..7b67e186d898 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -251,12 +251,11 @@ EXPORT_SYMBOL(strncat);
 #ifndef __HAVE_ARCH_STRLCAT
 size_t strlcat(char *dest, const char *src, size_t count)
 {
-	size_t dsize = strlen(dest);
+	size_t dsize = strnlen(dest, count);
 	size_t len = strlen(src);
 	size_t res = dsize + len;
 
-	/* This would be a bug */
-	BUG_ON(dsize >= count);
+	BUG_ON(dsize == count);
 
 	dest += dsize;
 	count -= dsize;
