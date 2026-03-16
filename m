Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348D4326945;
	Mon, 16 Mar 2026 16:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773679791; cv=pass; b=et7AoxyngERYBQsamvfxX75dUQC30/KF0j4HGV4/leoRsJFePNel67v/aLwEQa+IXDmKU+JMT5XhnjrndLaSMo42xDzMvn0uT6uHy18fuAy3Q61DkrbFVH7XhRI5/213qs/N0JCKels5aVGW5iOsmo4ZEGDjJ0dsselw+uNVeDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773679791; c=relaxed/simple;
	bh=4nDd2XUDji88Qsx+jqA0UuDtRuvt+Rg804sd1VBAvdw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sO+McVxhtZxJBNQ6dU/yL06nVvX77MEpThNdhmBNPtcLYO1kQHfVOO/1Btsknx7Klp99yDHkSOBUAf2p9iyobwTudIe2Qe35RWZzfhIf0wTrpetJcbK/j82MGa1ijv3E90qtShZpgriiNLUABMbP8gBwl9yBG3NkMHvBcT9pwrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=fevyFk1r; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="fevyFk1r"
ARC-Seal: i=1; a=rsa-sha256; t=1773679782; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=iGdp/Wk2pMA4q+Xl6wDe1ed3rgCFnglj/LUVMDdL2Y01XuB69iyN+35bX4EU/w6GPXhyFFJq1RZkbXhVf+tsE6VmDi6IxXVYffhXnyojJMD9NeWrlUUqv834+vhTOZTrdNoq1Jfgt7SscLVFxbVpFsXXTkciwmkkZ0vkKDjmBmo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773679782; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=dbF0BMNYrgA4K2nnTRhQtQjhdtbHznQXYukBY4YlD3Q=; 
	b=f08vVnbXZjfLTXOeuuCq+D4iq8NBIVQV3ymTAtAoZmw+9J/mGHhss1oQwNPGI09JARI/mtf0LebHFWMgEBy6/gyHdT9EdByOnTVq68+kLOesFnhP/95whjQg7CkbB5F5DXMnoTXOGo8anJhOGV/uW4aRscOrdluSYg4ERaWpfqA=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773679782;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=dbF0BMNYrgA4K2nnTRhQtQjhdtbHznQXYukBY4YlD3Q=;
	b=fevyFk1rWRmHna21mNzS8PFmaJiW7Yel31xdbtYFaLFKyGdktn4jgiSoeNtfqiEp
	Y1So/Xvip/4Gbe9/GAvz7g4sCsXdvWewEkS/kkBfNVPBEu0dFR3Dv9I8vWsfTWJP/FF
	t9mTyxO8l0ukoBsPQXLCIyHmFLRef0dbO0myKEtk=
Received: by mx.zoho.eu with SMTPS id 1773679780333981.4358712199604;
	Mon, 16 Mar 2026 17:49:40 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: kees@kernel.org,
	akpm@linux-foundation.org
Cc: andy@kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH] lib/string: rewrite strlcat() to use sized_strscpy()
Date: Mon, 16 Mar 2026 16:49:39 +0000
Message-Id: <20260316164939.89349-1-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Replace the hand-rolled copy logic and BUG_ON() in strlcat() with a
call to sized_strscpy(). This removes the kernel panic on caller
misuse (dsize >= count) and instead returns a truncation indicator
consistent with BSD strlcat semantics.

strlcat() is deprecated and callers should be converted to strscpy()
or similar bounded interfaces.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/string.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/lib/string.c b/lib/string.c
index b632c71df1a5..414016f8a6a6 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -253,18 +253,13 @@ size_t strlcat(char *dest, const char *src, size_t count)
 {
 	size_t dsize = strlen(dest);
 	size_t len = strlen(src);
-	size_t res = dsize + len;
 
-	/* This would be a bug */
-	BUG_ON(dsize >= count);
+	if (dsize >= count)
+		return count + len;
 
-	dest += dsize;
-	count -= dsize;
-	if (len >= count)
-		len = count-1;
-	__builtin_memcpy(dest, src, len);
-	dest[len] = 0;
-	return res;
+	sized_strscpy(dest + dsize, src, count - dsize);
+
+	return dsize + len;
 }
 EXPORT_SYMBOL(strlcat);
 #endif
-- 
2.34.1

