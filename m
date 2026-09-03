Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E439B501F21
	for <linux-hardening@vger.kernel.org>; Thu,  3 Sep 2026 20:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788467862; cv=none; b=rYeZuWGJ4QmGP45SRGhcA5I1jRd4eE8KgE4f+4ExP3JYEupB9kVuDSPFkqiWADgSfgrI1s/oHx1Bh827eQ/dYWhSWAMl9DP+nw7eXhaje34MnzHcTVETOfnzVaWFdRAg5ERKwtv6bVjnNEFLwGxKX4po7MKoZMlhbOBIxPQ20Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788467862; c=relaxed/simple;
	bh=O/xPPZ+sVVTaOOmEwsa+8rqbwM5fmRoimhLyr+2P6bA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PcZSbudtAj8ywQsIm+1j33Fp6DWk/y8+UAcWZfwQ9Dt/2exUu2xuAe8SZfpIaXv7GzhJfRdYk/hGcBbdCSu8N2O3TtPj4BBC0/4SHQd5t4tdMniYHg5fLrUtoDnLRfgE0vyM21d9ysD4/h6lSNEkxGfyxHItDH0uoJctG1h2zs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sxBNSnbM; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sxBNSnbM"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4998b5a63e2so3419125e9.1
        for <linux-hardening@vger.kernel.org>; Thu, 03 Sep 2026 13:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788467853; x=1789072653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rgIj/N8oul9ZLAizfJH63NRBCwMtcxycrJMIa0TwyZo=;
        b=sxBNSnbM925Xmo5xFRsdYK75FG4jLnidv2k76p3ry07PWePFFgrckheA2t8q5A06xT
         9Dmv0a49W5WIJMfsgZt0kWw2/KNBYRU11sC6TsKn/8enZf/yVlbe1ocdNRZNINzzDAut
         YlTSVagBG+H88PVSxMp9BbLLvMkPGw+lojTgiAv9RQ6rr/alybLCjOF12Du3V0WJMeWU
         xDilYMbZgFjlv5NKAzIU/zSFQLbm9iF1zlSIqlMEsr0pPWdYRTGERvXhUCngxX0Hz/kb
         FZW2IOZsUnJ6DX/qPaAVczsxdm4t0hQYu/EBLd6+U0TX+ubjrzRje5jmztl1e9BXvlEU
         cGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788467853; x=1789072653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rgIj/N8oul9ZLAizfJH63NRBCwMtcxycrJMIa0TwyZo=;
        b=TrE70iwcEfOmvGZiMgvC1rmzNHrorDQ+2tzShmL+CjGy+bwYHIefiGJzh9usYY4fou
         EBoGe/F5ln9LUTe87qREghQiicJmkPvpQjXW14pgzi4ZZ+Gu9OehukRnRFOfDd19l1Jo
         yjduaI6OyRGhX0G5v5cu6KFM/m5PTqy0/VSzS8uFO3O2pEfX4WQwS4NQ+vUhsIMf+tp3
         m2D2xxxFHI2jlheQ5zSskSHELMRz9gbSkXG9nChnGBtAc6jwNZiQNHMFEYmrsArquR5z
         35077A/eFvkRtJ2wOfct19ptHalHXbLurYX8nZ0abnY3II86CiFxc93LbMApoE+XluDe
         Buug==
X-Forwarded-Encrypted: i=1; AKwUvBzkFIPoLVyd8oFB/Q4sjEAeRxRqkDMgz6c2isH2bduSyo4h0JVfmUoNmHzlGMiS9ACOSqAozMF5P3tFMLNAGgw=@vger.kernel.org
X-Gm-Message-State: AFuF++mX/c8wH8aFZPODcnMxL3Xa6oDmgvU8/c+FgdXRrH7Xn00TpSBA
	fgSTQjCmTU4uBtmLaHnqap5asAuNlemgsPgH2M+7Jssot0X9RSXIAjZ0
X-Gm-Gg: AYBFou0+i+PREoDLHL16e0MMHzwXpAJgky7PHRAbNF4mv+hognvq67QmE3WERTllmWW
	b/Tt8PoZ4Bo5JAIPjyTRb9G16qzBnDb4cjoIOFui1IHwNE4pfv5IbbR+MoOL8dcywr5HwrN0+7h
	nJq7gkUUfAe2G9ha1RlGwlk7odqRLLo/1B0H84Q0DY6qIASJ5ic0WmQLPDnSXb2N5zODvZWmQKP
	NZU/7YUz0O0Ft9owbVBvL7xbt36e5ttWZdtxrt4zTKkTD7XHlnqdKTFlCMXifdvKUrgxRmUHpXv
	Tjrz2Mlk/NjW08q63uQD0wbdOvQLyGwZOM61srI3ofhY8bfPuNvUL/Q48Ii63EUJY9uhoKuC+3Y
	Q74DRgEHULwIyLHSqYIvCNuMKJnC39TD+wP2rE9vncs9lKI5lg1geru8zE2AMXXCksAKboI6htv
	zGnJ77pqAUWSoDdHd72geaSByIu7OwsJRKkTJqfVNhKahaMC/STL7YAqhiahT6o1g++RRXgI4Hs
	sbcHHbH5BjeNypTVgeKGHzrJGQpBiL0e1PM45QN1sFrhGUxcGfsjgXfvhHSJHma66/0zhwVtLCr
	jDUVZd+VtwNHJOWE3D5wN9P+c9w/9lr539J8aCJGYE74IRiUxGd+XnydKyQjHmp4kp36KHrFTVp
	88nmH5WJbYdpvxJNk
X-Received: by 2002:a05:600c:1c23:b0:49c:eb16:9fd with SMTP id 5b1f17b1804b1-49cf820a8e3mr8535635e9.3.1788467852848;
        Thu, 03 Sep 2026 13:37:32 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-a979-9501-3df6-d7fa-8a5a-06c5.310.pool.telefonica.de. [2a02:3100:a979:9501:3df6:d7fa:8a5a:6c5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48588394fa1sm1005070f8f.8.2026.09.03.13.37.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Sep 2026 13:37:32 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Vlastimil Babka <vbabka@kernel.org>,
	Harry Yoo <harry@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Hao Li <hao.li@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-hardening@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v3 3/5] slab: handle ERR_PTR values in kfree and hardened usercopy
Date: Thu,  3 Sep 2026 22:37:18 +0200
Message-Id: <20260903203720.63689-4-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260903203720.63689-1-kmehltretter@gmail.com>
References: <20260903203720.63689-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Passing an ERR_PTR to kfree() currently reaches virt_to_page() and may
fault. Warn and return instead, leaving the bad caller visible without
using the pointer as allocator metadata.

Also reject ERR_PTR values in hardened usercopy. Keep both checks
separate from ZERO_OR_NULL_PTR(), whose exact matching is required by
krealloc().

Link: https://lore.kernel.org/r/CAG48ez05QVn6_gQ2TBrRa1a_DWQoaSSYubUsu5YMWxx-gqMijQ@mail.gmail.com
Link: https://lore.kernel.org/r/202608111716.0FA9DB17@keescook
Link: https://github.com/KSPP/linux/issues/93
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 mm/slub.c     | 3 +++
 mm/usercopy.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/mm/slub.c b/mm/slub.c
index f9b56cb439e7..027b44dd7f07 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -6780,6 +6780,9 @@ void kfree(const void *object)
 	if (unlikely(ZERO_OR_NULL_PTR(object)))
 		return;
 
+	if (WARN_ON(IS_ERR(object)))
+		return;
+
 	page = virt_to_page(object);
 	slab = page_slab(page);
 	if (!slab) {
diff --git a/mm/usercopy.c b/mm/usercopy.c
index 5de7a518b1b1..c8d8703544c6 100644
--- a/mm/usercopy.c
+++ b/mm/usercopy.c
@@ -157,6 +157,9 @@ static inline void check_bogus_address(const unsigned long ptr, unsigned long n,
 	/* Reject if NULL or ZERO-allocation. */
 	if (ZERO_OR_NULL_PTR(ptr))
 		usercopy_abort("null address", NULL, to_user, ptr, n);
+
+	if (IS_ERR_VALUE(ptr))
+		usercopy_abort("ERR_PTR", NULL, to_user, ptr, n);
 }
 
 static inline void check_heap_object(const void *ptr, unsigned long n,
-- 
2.53.0

