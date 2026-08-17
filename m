Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60393B47C3;
	Mon, 17 Aug 2026 20:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786999494; cv=none; b=grhPG2h3o85TbClDkoAVo5CcZsSnKwT6v21KunBqFPmPDfy714pAnjlK6fXCrqKN3iuc5lxkSn9MsROZrfx25d6VEehj6YdgPnWQatnZsBim3QBPSWmH/p+c7vs9igL7BhkvoCDVTlg5Js9/Mq4VgUj5JkGya/o9i8/FE0popbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786999494; c=relaxed/simple;
	bh=OymTM1oQLQsal+qNBkUI4yVe4s/AFlcuq3qvVCmg53k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IxItN12TjbC1k1vIsrXcH4fhFlw0gBgbEozhs9q5QiBitt/urYEnJpsjTHT1t7+i5V6OoSFONPNRaJRlbEV6Lqf73cnosm6wWPDerpMKNegmBTqz7Rd5rsgYNNyvIqP4fbZgbOzuBkPk08hssyQdWhHOJtRZpbYPb4+VFVF60zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 79B9A201514;
	Mon, 17 Aug 2026 22:44:44 +0200 (CEST)
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1ww4CK-0020mx-1F;
	Mon, 17 Aug 2026 22:44:44 +0200
Received: from [::1] (helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.98.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1ww4CK-0000000GTDG-1EOv;
	Mon, 17 Aug 2026 22:44:44 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Mon, 17 Aug 2026 22:44:33 +0200
Subject: [PATCH v2] dmaengine: pxa: fix double counting of the hw
 descriptors
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-dmaengine-pxa-v2-1-f42ab0569a48@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIALByg2oC/3WMQQ6CMBBFr0JmbQ1TaEVX3sOwKGWEWViaFhsM6
 d2t7F2+//PeDpECU4RbtUOgxJEXV0CeKrCzcRMJHguDrKWuO7yI8WXITexI+M0I3aKSw9C0DTZ
 QHB/oydvRe/SFZ47rEj5HPuFv/VdKKFB0qrYSlUW86rsv73sNi+PtPBL0OecvN9yV2q8AAAA=
X-Change-ID: 20260817-dmaengine-pxa-64152bb34313
To: Daniel Mack <daniel@zonque.org>, 
 Haojian Zhuang <haojian.zhuang@gmail.com>, 
 Robert Jarzmik <robert.jarzmik@free.fr>, Vinod Koul <vkoul@kernel.org>, 
 Frank Li <Frank.Li@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
 Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786999484; l=2837;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=OymTM1oQLQsal+qNBkUI4yVe4s/AFlcuq3qvVCmg53k=;
 b=NnDXohUgWy3bkWKUxwEGJxUFYxlIDRPwojdF/IDz3k+6+8+ZOQbHy9h118+bsylfC30yq+iaf
 uDRZOzKQuFtDBTY2c6iKNlh92MGbWvmsDZGfulFL3ovC3epd9WV6D0E
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=

pxad_alloc_desc() was converted from

        kzalloc(struct_size(sw_desc, hw_desc, nb_hw_desc), GFP_NOWAIT)

to kzalloc_flex(), which sets the __counted_by() counter sw_desc->nb_desc
itself - but only where the compiler has __builtin_counted_by_ref(), so
from gcc 15.1 or clang 22.1 on. The loop below it still increments
nb_desc, which makes it come out doubled there and correct elsewhere.

nb_desc is what pxad_free_desc() iterates over and what
set_updater_desc() indexes from, so set it explicitly and drop the
increment. The error path has to lower it to the number of descriptors
allocated so far, otherwise pxad_free_desc() would free entries that were
never allocated.

Fixes: 69050f8d6d075 ("treewide: Replace kmalloc with kmalloc_obj for non-scalar types")
Assisted-by: Claude:claude-opus-5
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
pxad_alloc_desc() was converted from

        kzalloc(struct_size(sw_desc, hw_desc, nb_hw_desc), GFP_NOWAIT)

to kzalloc_flex(). hw_desc[] is annotated with __counted_by(nb_desc), so
__alloc_flex() now initializes sw_desc->nb_desc to nb_hw_desc itself.
The loop below it still increments nb_desc for every descriptor it
allocates though, so nb_desc ends up being twice the number of
descriptors that are actually there.

Drop the now redundant increment. The error path has to set nb_desc to
the number of descriptors allocated so far, otherwise pxad_free_desc()
would free entries that were never allocated.
---
Changes in v2:
- assign sw_desc->nb_desc manually as it is only automatically assigned
  for compilers supporting __builtin_counted_by_ref()
- Link to v1: https://lore.kernel.org/r/20260817-dmaengine-pxa-v1-1-850c215c1196@pengutronix.de
---
 drivers/dma/pxa_dma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
index fa2ee0b3e09f8..fc43124fefa89 100644
--- a/drivers/dma/pxa_dma.c
+++ b/drivers/dma/pxa_dma.c
@@ -744,6 +744,7 @@ pxad_alloc_desc(struct pxad_chan *chan, unsigned int nb_hw_desc)
 	sw_desc = kzalloc_flex(*sw_desc, hw_desc, nb_hw_desc, GFP_NOWAIT);
 	if (!sw_desc)
 		return NULL;
+	sw_desc->nb_desc = nb_hw_desc;
 	sw_desc->desc_pool = chan->desc_pool;
 
 	for (i = 0; i < nb_hw_desc; i++) {
@@ -752,10 +753,10 @@ pxad_alloc_desc(struct pxad_chan *chan, unsigned int nb_hw_desc)
 			dev_err(&chan->vc.chan.dev->device,
 				"%s(): Couldn't allocate the %dth hw_desc from dma_pool %p\n",
 				__func__, i, sw_desc->desc_pool);
+			sw_desc->nb_desc = i;
 			goto err;
 		}
 
-		sw_desc->nb_desc++;
 		sw_desc->hw_desc[i] = desc;
 
 		if (i == 0)

---
base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
change-id: 20260817-dmaengine-pxa-64152bb34313

Best regards,
-- 
Sascha Hauer <s.hauer@pengutronix.de>

