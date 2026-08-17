Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25746437845;
	Mon, 17 Aug 2026 16:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786982978; cv=none; b=HI44kYo59SBa5NJcgxhOTJipJgg7VKtJ9LkkWPAKHDldfwz0TAdCVZu0bz4rB9q53rOYysNZjxOfVK8CwPTbvOB13ChgJVaLjYM+R1kao5pIHKDGxpfp+OEuon1OASddoFl48a9tYwQa7LsyC+wdfFrRr8ij1NS8H5dBL1jtO7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786982978; c=relaxed/simple;
	bh=D9WRnoe4v155Yuh2kUpX0fyEN+hFQCP5ZrigCdKEEeo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=niCb19RS39hFssiEJ+QdgbyFRr+ea8kZZ8DnMUGSGtbK4gzdRac3KepG6TWFjaCOg6y4AY60W4ACrFaT084ERbnggSdWfwIZ84QTc6Uus/qzQH/j0oE31PB0ajHvhHyukHPl2MPgAGaKZBs7acKABz7xuclQ4wIDdoyvarK7dlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 9B97D2021FE;
	Mon, 17 Aug 2026 18:09:25 +0200 (CEST)
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1wvztt-001z5B-1l;
	Mon, 17 Aug 2026 18:09:25 +0200
Received: from [::1] (helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.98.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1wvztt-0000000GIh1-1rnO;
	Mon, 17 Aug 2026 18:09:25 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Mon, 17 Aug 2026 18:09:23 +0200
Subject: [PATCH] dmaengine: pxa: fix double counting of the hw descriptors
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-dmaengine-pxa-v1-1-850c215c1196@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIADIyg2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDC0Nz3ZTcxNS89My8VN2CikRdMxNDU6OkJGMTY0NjJaCegqLUtMwKsHn
 RsbW1ALVd3pRfAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786982965; l=2267;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=D9WRnoe4v155Yuh2kUpX0fyEN+hFQCP5ZrigCdKEEeo=;
 b=AJKvO/QZuJIonFzDi8gj1ix7neC3X40fbm6QZwMVke1PYjFEDVIN7VH8cxTIzDQ8lLPhuVxn6
 xuXZ3vIU6bLDjMf5VjMVix91xfM12GyXBu4X9HCQIoOflCqLeWdBSv3
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=

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
 drivers/dma/pxa_dma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
index fa2ee0b3e09f8..8252d27be8c3c 100644
--- a/drivers/dma/pxa_dma.c
+++ b/drivers/dma/pxa_dma.c
@@ -752,10 +752,11 @@ pxad_alloc_desc(struct pxad_chan *chan, unsigned int nb_hw_desc)
 			dev_err(&chan->vc.chan.dev->device,
 				"%s(): Couldn't allocate the %dth hw_desc from dma_pool %p\n",
 				__func__, i, sw_desc->desc_pool);
+			/* Only the descriptors below i have been allocated */
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

