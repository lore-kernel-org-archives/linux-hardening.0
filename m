Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D77348C66
	for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 13:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779197440; cv=none; b=d4NfNJotqchG43wSml+bM77yU1tQ0C2cr9f1oHugT2xgM3gM41pQNhh7yPU4SZY65WnJkvlz1b2JYp7YAqQ8q3ezYR3ExEy2VI38LYvKe5ts8TNbRKpPzEUBuHUGkgVlBf+oOrA67wIzpQZAsDg8y/8ssxx7KszN0zYqm9OdJFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779197440; c=relaxed/simple;
	bh=T7hmCnyhQzzscqgFF2ZS1aF6SwPsdArS5/C7Z+iJcVg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NHR1x5Jyi5LlEOoVJKQjXsA5nNppY91phFBTN8c13VViiDvIZKmoezAZXDMQEj09bVVAZiChcvy3JN/hxr7zsDQnNKEWwtFKuGOjnTo4FxHW4MC09cFppja4GWo2bKtVfUZJeiTU7hGNnuRW71rWqrhhpgzXQZuEDaNBs7EW4pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jM17acKl; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jM17acKl"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-44dd5cb0f81so3066251f8f.0
        for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 06:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779197437; x=1779802237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EKiZp6w902hBrKMv0fRjCuQOc40X5kR259+Yoc8tiYk=;
        b=jM17acKlcoLbkVA/VLY6b8YYxhnvT87fG9oGIh04hDKEmNDa7AzsGWsLXqH7szLrjF
         F7uwuteTOBFRdsygRakPiQ1SCJGSD8TsEjzYC78S52k6BgRWokP8lCim4ikvVoSukXF2
         0tjEn+PzK+phoHsS+7MOTLzhtz5rBc2oDmFeW0nByhtOwxhuE2Xmz0C0V0EB3gDdA/Hd
         Jp4FoWSufMwrfgFQoeyf/zsibPXvxDnAKYsW2+wuf0M1S4+m7DyYy79I9kBu2ChB/tIo
         FRZ/KIQDAlOp9HVRqc7qqlQFMWxvPaSltGgnTJOC55c4L25e5Cs4JJsCk4JptZcANVxJ
         ULKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779197437; x=1779802237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKiZp6w902hBrKMv0fRjCuQOc40X5kR259+Yoc8tiYk=;
        b=YhxuEiVPs8baRlNxzKvrXTbC8MMSkCDXNPU2DMDMm2AxNdN1149H4EEEzSOn9eBJux
         q/oJg+jsQTNqv5omLnEe2J/a2SatrHlGMWD69v9IInDwW7kTryuANhbFgEXNQm+tquGz
         EskEALuXxInoqWnOIiTTnDc6saidQWt3LB5D45eQYr2ncMc8EFC2ulN8gG3sQubLKizp
         +g3I9NT8hNlEWrNtTUPVcokFQVOvEidWfZPnUATIZvkDsFQcmVKe7MCJX3aIpchksyeo
         VtRmtBn4WuwkOerwyCcyF9YLk/qPHQtE6PcpFZD17huwi6JJXYDMcAe4KPzt2+wgPlEr
         +Vlw==
X-Forwarded-Encrypted: i=1; AFNElJ9IVY5tMHodfsrvmdGLSMa9Dfn4TfZ8ujUcnPQqBKWmIqaW1K3yTVFUMYp2zOPzVSFqx5ciZDWnUakQNhbwsrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzta6hEhvg+TNlbGHWi4YTCcgVcw9wyK9nd1XEN901ARQIz1cdn
	+N4iqKcItlQcf3HFjEZHyUCDRQXE3yNfTzN/zXLH/p+HYHDn1c1VT1/q
X-Gm-Gg: Acq92OEuP79yFVRXvn7Px7XLZMQSpGflsg5qpWQ3FjdC4CZD+wz90B+r/MOHv41z2kb
	CffB/S+0L3A1XVgLLux8z3SlcCxu0demWfn0P0zRaefA5/FdEk6n7nXDPzJc4hFQBRVsrMTVSmC
	LMjD+QbHC+aXFIuLCc/E6Ou08VlzyRLO4d1z2YYG0pINcVQPiADFioKAwKGAwCuguF5+H1Tcp0b
	hypwy2xi/NCBpdgW64yhNM+K7QDMgPJY4Ep2x5Yf/o/CSPuBzcw4mawJiRn0oAYiBMSyveHsVWY
	xmclLkRRsskouv0mx/Vzw1flIvYm07xR0BJsZgwRY4+kmUyh6k2/8c577cNrm7sIanZax8jKhH+
	qS9SuHvrFgPED7Nmw6aAck2sgMBCv2y6sTmS17/tTX5oOKWonRYbqlRzpZ79/DI/f3lGeUvSLVS
	4saxnln+blKFBY7KoGxgDcNKswCHtP2FOEW/JP+KvHQKbpiFd41204flVwJkASXGjWyRR3TP0Lp
	Z41l9SLwPbRKcu5zy+7HSTlKMs9WVNi0tErPg==
X-Received: by 2002:a05:600c:a406:b0:489:32b:ac0b with SMTP id 5b1f17b1804b1-48fe4fa1902mr235741575e9.6.1779197437094;
        Tue, 19 May 2026 06:30:37 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:3f5e:825d:a98f:fd29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48feaa2a878sm168177835e9.1.2026.05.19.06.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 06:30:36 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Ulf Hansson <ulfh@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2] mmc: mmc_test: Fix counter tracking in mmc_test_alloc_mem()
Date: Tue, 19 May 2026 14:30:25 +0100
Message-ID: <20260519133025.618255-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Fix an counter tracking in mmc_test_alloc_mem() that causes a kernel panic
during error unwinding.

The `struct mmc_test_mem` uses the `__counted_by(cnt)` annotation on its
flexible array member `arr`. While kzalloc_flex() initially sets the
counter field (`cnt`) to `max_segs`, the allocation loop needs to track
how many elements have actually been populated.

Previously, leaving `mem->cnt` at `max_segs` meant that if the loop failed
midway (e.g., "Failed to map sg list"), the error unwinding path in
mmc_test_free_mem() would attempt to clean up uninitialized trailing
array slots. This resulted in passing NULL pointers to __free_pages(),
triggering a kernel panic:

  [   66.172845] mmc0: Failed to map sg list
  [   66.176722] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
  ...
  [   66.432747] Call trace:
  [   66.435191]  ___free_pages+0x1c/0xc4 (P)
  [   66.439119]  __free_pages+0x14/0x20
  [   66.442608]  mmc_test_area_cleanup+0x58/0x84 [mmc_test]

Fix this by explicitly resetting `mem->cnt` to 0 immediately after
allocation. Then, move the existing `mem->cnt` increment so that it occurs
prior to populating each array slot, using `mem->cnt - 1` for the actual
assignment index. This guarantees that the counter accurately tracks
initialized entries for safe error cleanup, while dynamically expanding
the `__counted_by` validation boundary ahead of each flexible array write.

Additionally, rewrite the cleanup loop in mmc_test_free_mem() to use a
standard forward for-loop. This addresses the unsafe post-decrement logic
in the original `while (mem->cnt--)` loop which evaluated and decremented
the counter field before indexing the array, and avoids a potential integer
underflow/wrap-around of the counter field if the cleanup path is invoked
when `mem->cnt` is 0.

Fixes: c3126dccfd7b ("mmc: mmc_test: use kzalloc_flex")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2:
- Started with cnt = 0 and incremented before assignment to ensure
  accurate tracking of initialized entries in mmc_test_alloc_mem().
- In mmc_test_free_mem(), replaced the while loop with a forward for-loop to
  safely iterate over initialized entries without risking underflow.
- Updated commit message to clarify the issue and the fix.

v1: https://lore.kernel.org/all/20260513201315.3186621-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
---
 drivers/mmc/core/mmc_test.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
index ab38e4c45a8d..3c7e8a0704bb 100644
--- a/drivers/mmc/core/mmc_test.c
+++ b/drivers/mmc/core/mmc_test.c
@@ -318,9 +318,8 @@ static void mmc_test_free_mem(struct mmc_test_mem *mem)
 {
 	if (!mem)
 		return;
-	while (mem->cnt--)
-		__free_pages(mem->arr[mem->cnt].page,
-			     mem->arr[mem->cnt].order);
+	for (unsigned int i = 0; i < mem->cnt; i++)
+		__free_pages(mem->arr[i].page, mem->arr[i].order);
 	kfree(mem);
 }
 
@@ -356,6 +355,7 @@ static struct mmc_test_mem *mmc_test_alloc_mem(unsigned long min_sz,
 	mem = kzalloc_flex(*mem, arr, max_segs);
 	if (!mem)
 		return NULL;
+	mem->cnt = 0;
 
 	while (max_page_cnt) {
 		struct page *page;
@@ -375,9 +375,9 @@ static struct mmc_test_mem *mmc_test_alloc_mem(unsigned long min_sz,
 				goto out_free;
 			break;
 		}
-		mem->arr[mem->cnt].page = page;
-		mem->arr[mem->cnt].order = order;
 		mem->cnt += 1;
+		mem->arr[mem->cnt - 1].page = page;
+		mem->arr[mem->cnt - 1].order = order;
 		if (max_page_cnt <= (1UL << order))
 			break;
 		max_page_cnt -= 1UL << order;
-- 
2.54.0

