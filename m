Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950544C6D;
	Sun, 21 Jun 2026 12:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.190.126.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782043916; cv=none; b=S8t3DlJ1t+VHpdS6qVdn/ry5bcLIALDp1mJjen2dBhe2ocqTOLWOhcgFVyoge9RGfyH0TvSraleWZT1a2mkQAHbyqsXc6yZ+BtRkOuaIZVhjLK/yNZgGzDzVz3SfDv3cMeIVbtucqK3lFZynMfZfHpSi7mOm7IA2LOTDt6cILdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782043916; c=relaxed/simple;
	bh=TWMXte3g2eQPg5T2v2xRCQPQ0cdBuibgJHS8X738aBw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E4UKd3jGTSx/eoQ/Tp+of6lufP/FId1xdUiZ52bM/Itp2utT4UalmdDwoVi8Fl6TLcM9o2gWmc0aVrv09z0pMUwccvabSYvL3u1l7a0olLmBth/3cprzxjXhPOSIINKv7rpTTtj8vQX1kEzYte9HMWPelWXUcTpV4oS/fheE1lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=skgOde9M; arc=none smtp.client-ip=93.190.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="skgOde9M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782043909;
	bh=aWVUOJI+enMmOYcRg7TimLxnrqI8z2x7v9aFvZiVBjM=;
	h=From:To:Cc:Subject:Date:From;
	b=skgOde9MwXEwXvSkgYJcl06ZPobl0IJiGjX/8QiZT9x9C0FF0XBQG73qQwkVnh4X0
	 bGzdPPBSoNhfQe5WVKrUgle03vfspAv41/4quGciNVg8p2uNNIbHHrQSWSI92z8vTc
	 spfEghcvm6qDRgr/01DiDoTjMdEb6LKRFALRGam0=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4gjqv943mZz10yx;
	Sun, 21 Jun 2026 12:11:49 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4gjqv84jgfz10yq;
	Sun, 21 Jun 2026 12:11:48 +0000 (UTC)
From: Bradley Morgan <include@grrlz.net>
To: Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	Joern Engel <joern@logfs.org>,
	Pekka Enberg <penberg@kernel.org>,
	Christoph Lameter <cl@linux-foundation.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bradley Morgan <include@grrlz.net>
Subject: [PATCH] lib/string: fix memchr_inv() for large ranges
Date: Sun, 21 Jun 2026 12:11:33 +0000
Message-ID: <20260621121133.16460-1-include@grrlz.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

memchr_inv() takes a size_t length but counts 8 byte words in an
unsigned int. At 32GiB that count wraps, so the scan can quietly miss
most of the range.

Use size_t for the word count.

Fixes: 798248206b59 ("lib/string.c: introduce memchr_inv()")
Signed-off-by: Bradley Morgan <include@grrlz.net>
---
 lib/string.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/string.c b/lib/string.c
index 1f9297e9776a..8ea7d4b9f0c0 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -837,7 +837,8 @@ void *memchr_inv(const void *start, int c, size_t bytes)
 {
 	u8 value = c;
 	u64 value64;
-	unsigned int words, prefix;
+	size_t words;
+	unsigned int prefix;
 
 	if (bytes <= 16)
 		return check_bytes8(start, value, bytes);
-- 
2.53.0

