Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFE834DCEB
	for <linux-hardening@vger.kernel.org>; Tue,  2 Jun 2026 20:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780431232; cv=none; b=t79uXFR4wTBBIqce7HZdw/iuQnXpfaEP+lR2AnYwJLrlmV1kjMLRtJTMyHVtJqL+uyvuW/0v9lTL8GnVeS2R282Ub4YPhV2ySufFtE6sUBmZlx+p+xIm6c5Chm8mAafqMlGsMXdQfO9eTLCIGpBYrva6/R+gUUCVE7k4TqNeyCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780431232; c=relaxed/simple;
	bh=nkKc9eAxXqQ+Dnqg7a5iNB9iiMTxfr611IbVN0vr3yE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dZpwqp2eHgNNEB/0etFtd9vzXZdcpbmXdj2eJ80rRbxlzrB8t4WscYZS82o/opCtAkrq6RGxpHSZlRvWm3m7oGzvZHMZ1jkWas7R/7p1YcUu4935Na9B4zqeLvNWrZE7rywgbNmLn3FkN15MiKBa8dwWcaSfHaDqX6eJIHPI570=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DujbOkL/; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DujbOkL/"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490acbb0f89so14101295e9.0
        for <linux-hardening@vger.kernel.org>; Tue, 02 Jun 2026 13:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780431229; x=1781036029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cg5WhaKDN5P0G6TtyP193M1YCM4tZRnE2W1nIni4O0k=;
        b=DujbOkL/dJwStcwCC8tOaqiZK4y/msKUOFAqeeNcYMQxI3k+kIuEy9uRDBR8wNfnco
         3E2CAOmOtd4qEaxxuJ0qxfVUeQrJgeNhI/NBsbmodpNBCx4WumdjHd9r1HPCdaMpp1i5
         YGJc7SuOaoeO0bYEIC3FaHjXQKfyE0hoqKccxdmeXMzk0UbGg9VMrRuCOJpcWSw/zygF
         nJEgCJ5z35+w8nSWFWDKZwA4up4lI0YTs66AvA8nCmlfKCxbgj7SwAj8hDLvnZPWSNJd
         O03RmIAJmjmcp2abnnBV62ag1ipI3pOEN2hoV88pfSTnG5fH0etO7aag9rE4mVM12wa8
         4iFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780431229; x=1781036029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cg5WhaKDN5P0G6TtyP193M1YCM4tZRnE2W1nIni4O0k=;
        b=j4xkRiFoMAkXhDG5OdDws27NPwNPZoD4gkU+2yI2/2kD8eIkeUlo4g+4shdqeXuHBX
         flhPdbi5nxS+9UWzX07TEe1wEUBIUP4FN/jD17KX3n+ZHqFuu6CFoljQzB5YgGUUdbnA
         J/vjkIZ5NkO2LkVkvlbN1d+Yxfz2GuaEHd/FAE4i/fxS06z0r2FSp1Z7729BcyMba37s
         epNUqeJy4iQjv9XH2PXLaUONndwXnvNzfKyUKKt7ZswygYC1a5F2Vot1os2Eg/TSgCXK
         hKVwIJ/QZBeYiNOi51A1qoVUoZelm6UH+VqgFyQ2a/tRNgkzBc7BKImbV53WV723tLAj
         6tFw==
X-Forwarded-Encrypted: i=1; AFNElJ8cKaBxs1cZH0TIZ/9xIHaORMgU2cZkhjtYb92ejsysmhEqckYCmEAWauJesGtQtGaLyc5LUr6ifVZEP+vZII8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE659tdU/JL1e805AyeVv63ijcI1VNG3Ww96vCgjvy6HgjkKRX
	UfDDXzD/KjGdVGeniRUciXfzVETDlrllWeb/x1GX580GIZY7M6HxOir5x4rP7tro+Yc=
X-Gm-Gg: Acq92OEWvXlsI9DrS/QRuHzGf4OLDWPyL3P86ipzzSWTvHNcnw7ojQCEQLVWwAfDh8d
	riddYrtnF5Q6Ksb48CLlsbDqtC9/FSHPWd7RKzPcSFrT327f0FgMmBqxQ9GuOjB0lTu7YXHlLC6
	w50U33HNuQP4dUde2m/kfgJu6oKV29k+SOvosyMBcRJcA2YJDZzRHh/oxqxK4J7utG9pz7Vea0s
	z0Sx5hdA0OZg4GWMDrCn19NPJrODbMypysoQu5d8g2CMCBH0Wj5mmMm87sXNAWwPrfv6AH1nWOn
	mCX3vbEmbnJyl0quBGzOlxuk48utTaFskjApiVuq0QK95ycoOFgJbSVIsRCgAQGfMAzcDTs0no6
	lE2V6bF1/P/8QZ4FxWXh236HY0UO1TR+uhmzSJStz2otjhFxzAqLqO0Kz++BJoaOi8r+MQQWorx
	UfLFHCXVoohxTHhTb0m7Yf4uujnL+qIOclXDXA/nCoPvW7Ol/OaK81UHnO3Um/aq/zua7YWPvbO
	OhEdlHtp7tUC/oSZhztujR54EFKe/T7ZyoXduPHRrWN8wZbJjQkn64ecZb1Wvpjn0k=
X-Received: by 2002:a05:600c:458b:b0:490:9804:afdc with SMTP id 5b1f17b1804b1-490b5fda3c3mr5787925e9.23.1780431228585;
        Tue, 02 Jun 2026 13:13:48 -0700 (PDT)
Received: from iku.example.org ([2a06:5906:61b:2d00:5ef:9913:4a77:3bcf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b613f167sm1017515e9.22.2026.06.02.13.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 13:13:48 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Ulf Hansson <ulfh@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3] mmc: mmc_test: Fix __counted_by handling after kzalloc_flex() conversion
Date: Tue,  2 Jun 2026 21:13:44 +0100
Message-ID: <20260602201344.1809801-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Fix logic issues introduced by the kzalloc_flex() conversion in
mmc_test_alloc_mem() due to interaction with the __counted_by
annotation on the flexible array.

Bounds-checking sanitizers rely on the counter field reflecting the
allocated array size before any array access occurs. However, use
mem->cnt both as the allocation size and as the runtime insertion
index, causing incorrect indexing and potentially invalid bounds
tracking.

Initialize mem->cnt to the maximum allocated number of segments
immediately after kzalloc_flex(), then use a separate local index
variable to track successfully allocated entries. Update mem->cnt to
the actual number of initialized elements before returning or entering
the cleanup path.

Also rewrite mmc_test_free_mem() to use a forward for-loop, improving
readability and ensuring only initialized entries are freed.

Fixes: c3126dccfd7b ("mmc: mmc_test: use kzalloc_flex")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2->v3:
- Switched back to v1 version of the patch.
- Addressed review comments from Geert.
- Add RB tag from Geert which was received on v1.

v1->v2:
- Started with cnt = 0 and incremented before assignment to ensure
  accurate tracking of initialized entries in mmc_test_alloc_mem().
- In mmc_test_free_mem(), replaced the while loop with a forward for-loop to
  safely iterate over initialized entries without risking underflow.
- Updated commit message to clarify the issue and the fix.

v2: https://lore.kernel.org/all/20260519133025.618255-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
v1: https://lore.kernel.org/all/20260513201315.3186621-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
---
 drivers/mmc/core/mmc_test.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
index ab38e4c45a8d..4dc16649e61d 100644
--- a/drivers/mmc/core/mmc_test.c
+++ b/drivers/mmc/core/mmc_test.c
@@ -318,9 +318,9 @@ static void mmc_test_free_mem(struct mmc_test_mem *mem)
 {
 	if (!mem)
 		return;
-	while (mem->cnt--)
-		__free_pages(mem->arr[mem->cnt].page,
-			     mem->arr[mem->cnt].order);
+	for (unsigned int i = 0; i < mem->cnt; i++)
+		__free_pages(mem->arr[i].page,
+			     mem->arr[i].order);
 	kfree(mem);
 }
 
@@ -341,6 +341,7 @@ static struct mmc_test_mem *mmc_test_alloc_mem(unsigned long min_sz,
 	unsigned long page_cnt = 0;
 	unsigned long limit = nr_free_buffer_pages() >> 4;
 	struct mmc_test_mem *mem;
+	unsigned int idx = 0;
 
 	if (max_page_cnt > limit)
 		max_page_cnt = limit;
@@ -375,23 +376,26 @@ static struct mmc_test_mem *mmc_test_alloc_mem(unsigned long min_sz,
 				goto out_free;
 			break;
 		}
-		mem->arr[mem->cnt].page = page;
-		mem->arr[mem->cnt].order = order;
-		mem->cnt += 1;
+		mem->arr[idx].page = page;
+		mem->arr[idx].order = order;
+		idx += 1;
 		if (max_page_cnt <= (1UL << order))
 			break;
 		max_page_cnt -= 1UL << order;
 		page_cnt += 1UL << order;
-		if (mem->cnt >= max_segs) {
+		if (idx >= mem->cnt) {
 			if (page_cnt < min_page_cnt)
 				goto out_free;
 			break;
 		}
 	}
 
+	mem->cnt = idx;
+
 	return mem;
 
 out_free:
+	mem->cnt = idx;
 	mmc_test_free_mem(mem);
 	return NULL;
 }
-- 
2.54.0

