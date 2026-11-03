Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793672548;
	b=VXTOtkAM8u6H42zy+1l+yrElNJ/+Fh4QD0EORPwHKZ+vriO9X9uvmLWqdGgM9qp6tv9R
	 DgTMTW/EVEHqQf/uH8+NMqRJywKwueNGf413MFcLzhGCoAJW+bh8VoEhIXnKHxeU7RAwv
	 rv9FzC8McQH0o1MgAHFWIQ1pwWSjp0XtQEa4vGCNomqLXgwae/7rF+myLXavVNMffLucz
	 oCm0mWJbtFzGzLRU4KzgfJwzRId6VK6SFrDsvvYjauG9DDHe1+a1LSVY3IKFZH+TzrCbL
	 eDiu3Hqr3Bauv+CovX8MyQRfr44hGWu/F7QwCxLDGpFwlWoAe8dKy+lcDsDIh3NieIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793672548;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=w4L2/GTsnuum2BDutqRH8ITpZ6+alj477xTlolb3sbs=;
	b=nsTRuB8ZgEkk+9oUWNVlbN7GoTVnHr5UcIkQ8iokrUC9zmIIEaCzTWCCR/F/e5jwsWgm
	 +H2Ly8BQUh70vzUUR/6jZlmmupHK/hsCPAIELzb8FLd3u4ag2KP6QoTxiXwW2HYUbjvzv
	 0vycmGVXIAfzFKKuZHZ40gKMA+8uRYMwdw+jxPZ/Ej4OGMcUgV4gpgLs6WESc4SdbWem+
	 vmyKyoCGOLyb6CtAkm/aJ4PhcYN88EU5U3aa8fEk/6oBT6ZPgud08YjMGNHoHYjeR9Qzo
	 TbKV9jW78XJDM98IUWpvT/gsV6olO5CncbfjhJHgi3gB0LozCMlAn/d2TwdkXxiovQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yc9g42hN;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0D1606A327
	for <linux-hardening@vger.kernel.org>; Tue,  3 Nov 2026 02:22:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A0D1606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yc9g42hN
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3a4b3ac8fb7so2202590a91.0
        for <linux-hardening@vger.kernel.org>; Mon, 02 Nov 2026 18:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793672542; x=1794277342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w4L2/GTsnuum2BDutqRH8ITpZ6+alj477xTlolb3sbs=;
        b=yc9g42hN/OM9twgraaWW14GXfnAmxg7uaS28hyvmLpljSpIlnPiyjSvdQa1l2qOjcV
         iEiV2hdWP6SRQ4G1aWd2k6AA5IiIbGeo2odcz3vq68ANA1sBntxPPDTz4R+LGg8Xjc1Y
         GO1YuPmOezjGlDiHijYg2c2TulZzb7qzI8lTXy/+aBWqPGgevDZ8Q/kPT37xHYVxV9o+
         JrAMbhsSGpY85QCHQ+XJgtwDS+MDAPA+TNvs9/B6ISciZXsf0Xq6YLJsijJ6s0QwQs03
         YOACsJ97FLWRuABNvhwGQfZXPSKeO9NkZU9XxAopyZX43JS7rt3cjHHlv7yg82TSE12c
         lFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793672542; x=1794277342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w4L2/GTsnuum2BDutqRH8ITpZ6+alj477xTlolb3sbs=;
        b=BuETglYO/PY+dAQyTwdDIuhicHwM8bQyKw26UFs2zuy6UO6/zLxCJusMKUBq3c8rle
         pImLIrAzf0y2DxAgUFoL8dL17n+E3wO/Ce6HfK4Ibt3ltMRmks2wNuPDAdiWRJerYyKF
         OsNOZULzGmgb75fc+ZdZEy10L3ZfqbA19NR4zwf2tDN2YrNLcpc9zQuVP6F8IhvBHxRC
         klSnvYAxN6IJ6GrXPb74QS8XkNUPzFAcJgfm57EUrwc7mdNSLSW/Q4MXeaVOyBMbytf5
         WRWXxMdTIeu+5yy2ypv6RGjnSMUD0XQR/D/xXUKutT0BjoLh2rAt0pAI3PFIpztlzMde
         /X/g==
X-Forwarded-Encrypted: i=1; AKwUvBxGruZQ1AU8xYbAbsls5zJmuDfURNIbXsGR+3K4PK9DATTfdT0A39BYVfYK2/cUsR1XKceHa36vtr5JS2luyT0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ydoCs5rOWsjTA2zkKo5CmZnZ2b/UvUJuXmVQbbcPXpY295OoK
	+wH3CiYKjU/yvmquJ8ycCvM36sGEKs4EYUwGCtw9O6+RlYMh1SHrDr8j
X-Gm-Gg: AYBFou1NA9I/rXarg4m0E/PKnZAptG+PUeQHwpWwVuc2YNNZj5H0HgpwcGBnfXu6nzF
	0Je+6u7sL8ozQkjiAYarTaN0uUiipxJHdqjol5nsb+QVXYaXqVYQwIumRC2RJ60xoDa7FPbNAQT
	sPOdbSTfAf9kBuAvFnHg+c+DREnDD41NbwHXmVzbaHQHTZcWOi+SPJR/Ouph1kKCha+NoHZlF3+
	aD55xtTwACVuUQOi+T0fdI95WlG+GO+/xblQBmmMt/sumT3Tn79SDi1T6hWu+8XqwEMiLfyhBmG
	DdnFmIncvFvB8xZVYpQyGRT2zn7JWyRCJJ6kjK6+VNS5T/DBYZZcSU9BOmQxbymJrEv7dA86DPP
	Yhlct4iCupiMd7LPAheifdn6+nijb+vsQuvbxrTEtlbg2Wx/QT2iMpuOiLRTtT1zs5YPHk0Iq2s
	peNBqdyHoc80gYqJBJ1LBR2skX6c0isbimDepjf3NMYaVje5R/3GySidzUQkTiHPrbHC86ss3ct
	uFqSxYBQmpt8ecnnMB0aMENltLO8Jg3q4BDQjBOggGnuBRCPxEWVajD5ezhCY4jZaTSQTlUKE03
	JIqJQPh0GpHO+wIgLDB+jpiwCSFBoUdxwvxbe6n1tYtVxPTL6ww0S0vhDtuRft7ZZRaPI2UGOjt
	LRSiMz/uVIjiRc24=
X-Received: by 2002:a17:90b:4a83:b0:3ad:b86d:dbad with SMTP id 98e67ed59e1d1-3ae89747e27mr9119446a91.30.1793672541545;
        Mon, 02 Nov 2026 18:22:21 -0800 (PST)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c7dea24sm1570124a91.5.2026.11.02.18.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 18:22:21 -0800 (PST)
From: Shan-Chun Hung <shanchun1218@gmail.com>
To: ychuang3@nuvoton.com,
	schung@nuvoton.com,
	vkoul@kernel.org,
	Frank.Li@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	kees@kernel.org,
	gustavoars@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Cc: Shan-Chun Hung <shanchun1218@gmail.com>
Subject: [PATCH 2/2] dmaengine: ma35d1-pdma: Add MA35D1 PDMA driver
Date: Tue,  3 Nov 2026 10:22:02 +0800
Message-Id: <20261103022202.2139674-3-shanchun1218@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261103022202.2139674-1-shanchun1218@gmail.com>
References: <20261103022202.2139674-1-shanchun1218@gmail.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a driver for the PDMA controller found in the Nuvoton MA35D1 SoC.
It supports up to 10 channels with memory-to-memory, slave scatter-gather
and cyclic transfers, and a per-channel timeout for variable-length
peripheral RX.

Signed-off-by: Shan-Chun Hung <shanchun1218@gmail.com>
---
 drivers/dma/Kconfig             |  12 +
 drivers/dma/Makefile            |   1 +
 drivers/dma/ma35d1-pdma.c       | 780 ++++++++++++++++++++++++++++++++
 include/linux/dma/ma35d1-pdma.h |  24 +
 4 files changed, 817 insertions(+)
 create mode 100644 drivers/dma/ma35d1-pdma.c
 create mode 100644 include/linux/dma/ma35d1-pdma.h

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 01f96a8257e5..3d4d09e459f1 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -404,6 +404,18 @@ config LPC32XX_DMAMUX
 	  Support for PL080 multiplexed DMA request lines on
 	  LPC32XX platrofm.

+config MA35D1_PDMA
+	tristate "Nuvoton MA35D1 PDMA Engine"
+	depends on ARCH_MA35 || COMPILE_TEST
+	select DMA_ENGINE
+	select DMA_VIRTUAL_CHANNELS
+	help
+	  Support the Nuvoton MA35D1 PDMA engine. This engine is integrated
+	  into Nuvoton MA35D1 chips. This DMA controller can transfer data
+	  from memory to memory, memory to peripheral and peripheral to memory.
+	  If you have a board based on such a SoC and wish to use DMA, say Y
+	  or M here.
+
 config MCF_EDMA
 	tristate "Freescale eDMA engine support, ColdFire mcf5441x SoCs"
 	depends on M5441x || (COMPILE_TEST && FSL_EDMA=n)
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index f62d12b08e15..dd99f7d12d4d 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -52,6 +52,7 @@ obj-y += idxd/
 obj-$(CONFIG_K3_DMA) += k3dma.o
 obj-$(CONFIG_LPC18XX_DMAMUX) += lpc18xx-dmamux.o
 obj-$(CONFIG_LPC32XX_DMAMUX) += lpc32xx-dmamux.o
+obj-$(CONFIG_MA35D1_PDMA) += ma35d1-pdma.o
 obj-$(CONFIG_MILBEAUT_HDMAC) += milbeaut-hdmac.o
 obj-$(CONFIG_MILBEAUT_XDMAC) += milbeaut-xdmac.o
 obj-$(CONFIG_MMP_PDMA) += mmp_pdma.o
diff --git a/drivers/dma/ma35d1-pdma.c b/drivers/dma/ma35d1-pdma.c
new file mode 100644
index 000000000000..176bc56c8063
--- /dev/null
+++ b/drivers/dma/ma35d1-pdma.c
@@ -0,0 +1,780 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Nuvoton MA35D1 PDMA controller driver
+ *
+ * Copyright (C) 2026 Nuvoton Technology Corp.
+ *
+ * Author: Shan-Chun Hung <shanchun1218@gmail.com>
+ */
+
+#include <linux/align.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/clk.h>
+#include <linux/compiler_types.h>
+#include <linux/container_of.h>
+#include <linux/dev_printk.h>
+#include <linux/device.h>
+#include <linux/dma-direction.h>
+#include <linux/dma-mapping.h>
+#include <linux/dma/ma35d1-pdma.h>
+#include <linux/dmaengine.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/gfp_types.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/irqreturn.h>
+#include <linux/limits.h>
+#include <linux/list.h>
+#include <linux/math.h>
+#include <linux/minmax.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_dma.h>
+#include <linux/overflow.h>
+#include <linux/platform_device.h>
+#include <linux/scatterlist.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/spinlock_types.h>
+#include <linux/stddef.h>
+#include <linux/string.h>
+#include <linux/types.h>
+
+#include "dmaengine.h"
+#include "virt-dma.h"
+
+/* PDMA registers */
+#define PDMA_DSCT_CTL		0x000
+#define PDMA_DSCT_SA		0x004
+#define PDMA_DSCT_DA		0x008
+#define PDMA_DSCT_NEXT		0x00c
+#define PDMA_CHCTL		0x400
+#define PDMA_SWREQ		0x408
+#define PDMA_INTEN		0x418
+#define PDMA_INTSTS		0x41C
+#define PDMA_ABTSTS		0x420
+#define PDMA_TDSTS		0x424
+#define PDMA_TOUTEN		0x434
+#define PDMA_TOUTIEN		0x438
+#define PDMA_TOC		0x440
+#define PDMA_CHRST		0x460
+#define PDMA_TOUTPSC		0x470
+#define PDMA_REQSEL		0x480
+
+/* Bitfields in PDMA registers */
+#define PDMA_OP_BASIC		BIT(0)
+#define PDMA_OP_SCATTER		BIT(1)
+#define PDMA_OP_MSK		GENMASK(1, 0)
+#define PDMA_TXTYPE		BIT(2)
+#define PDMA_TBINTDIS		BIT(7)
+#define PDMA_SAFIX		GENMASK(9, 8)
+#define PDMA_DAFIX		GENMASK(11, 10)
+
+#define PDMA_MAX_CHANS		10
+#define PDMA_MAX_CHAN_BEATS	(U16_MAX + 1)
+
+#define PDMA_WIDTH(w)		FIELD_PREP(GENMASK(13, 12), (w) >> 1)
+#define PDMA_TXCNT(cnt)		FIELD_PREP(GENMASK(31, 16), (cnt) - 1)
+#define PDMA_GET_TXCNT(ctrl)	FIELD_GET(GENMASK(31, 16), readl(ctrl))
+#define PDMA_CH_OFFSET(ch)	((ch) * 0x10)
+
+#define PDMA_SLAVE_BUSWIDTHS	(BIT(DMA_SLAVE_BUSWIDTH_1_BYTE)  | \
+				 BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) | \
+				 BIT(DMA_SLAVE_BUSWIDTH_4_BYTES))
+
+struct ma35d1_sg {
+	u32 ctl;
+	u32 src;
+	u32 dst;
+	u32 next;
+};
+
+struct ma35d1_desc {
+	struct ma35d1_chan *ch;
+	bool cyclic;
+	/* bytes per beat */
+	u32 width;
+	struct virt_dma_desc vd;
+	dma_addr_t dma_addr;
+	size_t dma_len;
+	u32 sg_len;
+	struct ma35d1_sg sg[] __counted_by(sg_len);
+};
+
+struct ma35d1_chan {
+	struct device *dev;
+	struct ma35d1_pdmadev *pdmadev;
+	struct virt_dma_chan vc;
+	void __iomem *base;
+	int id;
+	struct ma35d1_desc *desc;
+	struct dma_slave_config cfg;
+	struct ma35d1_peripheral pcfg;
+	/* second #dma-cells argument from devicetree */
+	u32 request;
+	/* set when the current descriptor completed with an abort */
+	bool error;
+	/* bytes left after a timeout */
+	u32 remain;
+};
+
+struct ma35d1_pdmadev {
+	struct dma_device ddev;
+	/* protects read-modify-write of shared controller registers */
+	spinlock_t lock;
+	int nr_chans;
+	struct ma35d1_chan channels[] __counted_by(nr_chans);
+};
+
+static inline struct ma35d1_chan *to_ma35d1_pdma_chan(struct dma_chan *c)
+{
+	return container_of(c, struct ma35d1_chan, vc.chan);
+}
+
+static inline struct ma35d1_desc *to_ma35d1_pdma_desc(struct virt_dma_desc *vd)
+{
+	return container_of(vd, struct ma35d1_desc, vd);
+}
+
+static inline void ma35d1_pdma_reg_set(struct ma35d1_chan *ch, u32 offset, u32 mask)
+{
+	writel(readl(ch->base + offset) | mask, ch->base + offset);
+}
+
+static inline void ma35d1_pdma_reg_clear(struct ma35d1_chan *ch, u32 offset, u32 mask)
+{
+	writel(readl(ch->base + offset) & ~mask, ch->base + offset);
+}
+
+static void ma35d1_pdma_desc_free(struct virt_dma_desc *vd)
+{
+	struct ma35d1_desc *d = to_ma35d1_pdma_desc(vd);
+
+	dma_unmap_single(d->ch->dev, d->dma_addr, d->dma_len, DMA_TO_DEVICE);
+	kfree(d);
+}
+
+static int ma35d1_terminate_all(struct dma_chan *chan)
+{
+	LIST_HEAD(head);
+	struct ma35d1_chan *ch = to_ma35d1_pdma_chan(chan);
+	unsigned long flags, pdmadev_flags;
+
+	spin_lock_irqsave(&ch->vc.lock, flags);
+
+	spin_lock_irqsave(&ch->pdmadev->lock, pdmadev_flags);
+	ma35d1_pdma_reg_clear(ch, PDMA_CHCTL, BIT(ch->id));
+	spin_unlock_irqrestore(&ch->pdmadev->lock, pdmadev_flags);
+
+	if (ch->desc) {
+		vchan_terminate_vdesc(&ch->desc->vd);
+		ch->desc = NULL;
+	}
+
+	vchan_get_all_descriptors(&ch->vc, &head);
+	spin_unlock_irqrestore(&ch->vc.lock, flags);
+
+	vchan_dma_desc_free_list(&ch->vc, &head);
+
+	return 0;
+}
+
+static void ma35d1_synchronize(struct dma_chan *chan)
+{
+	struct ma35d1_chan *ch = to_ma35d1_pdma_chan(chan);
+
+	vchan_synchronize(&ch->vc);
+}
+
+static void ma35d1_pdma_timeout(struct ma35d1_chan *ch)
+{
+	struct ma35d1_peripheral *pcfg = ch->cfg.peripheral_config;
+	u32 offset, shift;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ch->pdmadev->lock, flags);
+	if (!pcfg || (pcfg->prescaler == 0 && pcfg->counter == 0)) {
+		ma35d1_pdma_reg_clear(ch, PDMA_TOUTIEN, BIT(ch->id));
+		ma35d1_pdma_reg_clear(ch, PDMA_TOUTEN, BIT(ch->id));
+		goto spin_unlock;
+	}
+
+	/*
+	 * Calculate the positions of the timeout prescaler's bit fields and registers,
+	 * then write them.
+	 */
+	offset = PDMA_TOUTPSC + 4 * (ch->id >> 3);
+	shift = (ch->id & GENMASK(2, 0)) * 4;
+	ma35d1_pdma_reg_clear(ch, offset, GENMASK(2, 0) << shift);
+	ma35d1_pdma_reg_set(ch, offset, pcfg->prescaler << shift);
+
+	/*
+	 * Calculate the positions of the timeout counter's bit fields and registers,
+	 * then write them.
+	 */
+	offset = PDMA_TOC + 4 * (ch->id >> 1);
+	shift = (ch->id & GENMASK(0, 0)) * 16;
+	ma35d1_pdma_reg_clear(ch, offset, GENMASK(15, 0) << shift);
+	ma35d1_pdma_reg_set(ch, offset, pcfg->counter << shift);
+
+	ma35d1_pdma_reg_set(ch, PDMA_TOUTEN, BIT(ch->id));
+	ma35d1_pdma_reg_set(ch, PDMA_TOUTIEN, BIT(ch->id));
+
+spin_unlock:
+	spin_unlock_irqrestore(&ch->pdmadev->lock, flags);
+}
+
+static void ma35d1_pdma_setup_channel(struct ma35d1_chan *ch)
+{
+	u32 offset, reg, shift;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ch->pdmadev->lock, flags);
+
+	if ((readl(ch->base + PDMA_CH_OFFSET(ch->id)) & GENMASK(1, 0)) != 0) {
+		reg = readl(ch->base + PDMA_CHCTL);
+		writel(0, ch->base + PDMA_CH_OFFSET(ch->id));
+		ma35d1_pdma_reg_set(ch, PDMA_CHRST, BIT(ch->id));
+		writel(reg | BIT(ch->id), ch->base + PDMA_CHCTL);
+	} else {
+		writel(0, ch->base + PDMA_CH_OFFSET(ch->id));
+		ma35d1_pdma_reg_set(ch, PDMA_CHCTL, BIT(ch->id));
+	}
+	ma35d1_pdma_reg_set(ch, PDMA_INTEN, BIT(ch->id));
+
+	offset = PDMA_REQSEL + (ch->id & ~GENMASK(1, 0));
+	shift = (ch->id & GENMASK(1, 0)) * 8;
+	ma35d1_pdma_reg_clear(ch, offset, GENMASK(7, 0) << shift);
+	ma35d1_pdma_reg_set(ch, offset, ch->request << shift);
+
+	spin_unlock_irqrestore(&ch->pdmadev->lock, flags);
+}
+
+static int ma35d1_slave_config(struct dma_chan *chan, struct dma_slave_config *cfg)
+{
+	struct ma35d1_chan *ch = to_ma35d1_pdma_chan(chan);
+	struct ma35d1_peripheral *pcfg = cfg->peripheral_config;
+
+	memcpy(&ch->cfg, cfg, sizeof(*cfg));
+	ch->cfg.peripheral_config = NULL;
+
+	if (pcfg) {
+		if (cfg->peripheral_size != sizeof(*pcfg)) {
+			dev_err(ch->dev, "Invalid peripheral size %zu, expected %zu\n",
+				cfg->peripheral_size, sizeof(*pcfg));
+			return -EINVAL;
+		}
+
+		if (pcfg->counter > GENMASK(15, 0) || pcfg->prescaler > GENMASK(2, 0)) {
+			dev_err(ch->dev, "Maximum prescaler or counter exceeded\n");
+			return -EINVAL;
+		}
+
+		memcpy(&ch->pcfg, pcfg, sizeof(ch->pcfg));
+		ch->cfg.peripheral_config = &ch->pcfg;
+	}
+
+	return 0;
+}
+
+static int ma35d1_slave_width(struct ma35d1_chan *ch, enum dma_transfer_direction dir)
+{
+	enum dma_slave_buswidth width;
+
+	if (dir == DMA_MEM_TO_DEV) {
+		width = ch->cfg.dst_addr_width;
+	} else if (dir == DMA_DEV_TO_MEM) {
+		width = ch->cfg.src_addr_width;
+	} else {
+		dev_err(ch->dev, "invalid DMA direction %d\n", dir);
+		return -EINVAL;
+	}
+
+	if (width != DMA_SLAVE_BUSWIDTH_1_BYTE && width != DMA_SLAVE_BUSWIDTH_2_BYTES &&
+	    width != DMA_SLAVE_BUSWIDTH_4_BYTES) {
+		dev_err(ch->dev, "invalid DMA width %d\n", width);
+		return -EINVAL;
+	}
+
+	return width;
+}
+
+static struct ma35d1_desc *ma35d1_desc_alloc(struct ma35d1_chan *ch, u32 sg_len)
+{
+	struct ma35d1_desc *d;
+
+	d = kzalloc(struct_size(d, sg, sg_len), GFP_ATOMIC);
+	if (!d)
+		return NULL;
+
+	d->sg_len = sg_len;
+	d->dma_len = sizeof(*d->sg) * sg_len;
+	d->dma_addr = dma_map_single(ch->dev, d->sg, d->dma_len, DMA_TO_DEVICE);
+	if (dma_mapping_error(ch->dev, d->dma_addr)) {
+		dev_err(ch->dev, "dma mapping error for channel\n");
+		kfree(d);
+		return NULL;
+	}
+
+	writel(d->dma_addr, ch->base + PDMA_CH_OFFSET(ch->id) + PDMA_DSCT_NEXT);
+
+	return d;
+}
+
+static struct dma_async_tx_descriptor *
+ma35d1_desc_submit(struct ma35d1_chan *ch, struct ma35d1_desc *d, bool cyclic,
+		   unsigned long tx_flags)
+{
+	dma_sync_single_for_device(ch->dev, d->dma_addr, d->dma_len, DMA_TO_DEVICE);
+	d->cyclic = cyclic;
+	d->ch = ch;
+	ch->error = false;
+
+	return vchan_tx_prep(&ch->vc, &d->vd, tx_flags);
+}
+
+static struct dma_async_tx_descriptor *
+ma35d1_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dst, dma_addr_t src,
+		       size_t len, unsigned long tx_flags)
+{
+	int i;
+	size_t tlen, max_chunk;
+	struct ma35d1_chan *ch = to_ma35d1_pdma_chan(chan);
+	struct ma35d1_desc *d;
+	u32 sg_len, width = 1;
+
+	if (ch->request != 0) {
+		dev_err(ch->dev, "%s: channel is bound to a peripheral request\n", __func__);
+		return NULL;
+	}
+
+	if (!len) {
+		dev_err(ch->dev, "invalid memcpy length\n");
+		return NULL;
+	}
+
+	if (IS_ALIGNED(src, 4) && IS_ALIGNED(dst, 4) && IS_ALIGNED(len, 4))
+		width = 4;
+
+	max_chunk = (size_t)PDMA_MAX_CHAN_BEATS * width;
+
+	sg_len = DIV_ROUND_UP_ULL(len, max_chunk);
+	d = ma35d1_desc_alloc(ch, sg_len);
+	if (!d)
+		return NULL;
+	d->width = width;
+
+	ma35d1_pdma_setup_channel(ch);
+
+	for (i = 0; i < sg_len; i++) {
+		tlen = min_t(size_t, len, max_chunk);
+		d->sg[i].src = src;
+		d->sg[i].dst = dst;
+		d->sg[i].ctl = PDMA_WIDTH(width) | PDMA_TXCNT(tlen / width) | PDMA_OP_SCATTER;
+		d->sg[i].next = d->dma_addr + PDMA_CH_OFFSET(i + 1);
+		src += tlen;
+		dst += tlen;
+		len -= tlen;
+	}
+	d->sg[sg_len - 1].ctl &= ~(PDMA_OP_MSK | PDMA_TBINTDIS);
+	d->sg[sg_len - 1].ctl |= PDMA_OP_BASIC;
+
+	return ma35d1_desc_submit(ch, d, false, tx_flags);
+}
+
+static struct dma_async_tx_descriptor *
+ma35d1_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
+		     u32 sg_len, enum dma_transfer_direction dir,
+		     unsigned long tx_flags, void *context)
+{
+	int i, width;
+	struct ma35d1_chan *ch = to_ma35d1_pdma_chan(chan);
+	struct ma35d1_desc *d;
+	struct scatterlist *sgent;
+
+	width = ma35d1_slave_width(ch, dir);
+	if (width < 0)
+		return NULL;
+
+	if (!sg_len) {
+		dev_err(ch->dev, "SG entry length is zero\n");
+		return NULL;
+	}
+
+	d = ma35d1_desc_alloc(ch, sg_len);
+	if (!d)
+		return NULL;
+	d->width = width;
+
+	ma35d1_pdma_setup_channel(ch);
+
+	for_each_sg(sgl, sgent, sg_len, i) {
+		if (dir == DMA_MEM_TO_DEV) {
+			d->sg[i].ctl = PDMA_WIDTH(width) | PDMA_DAFIX;
+			d->sg[i].src = sg_dma_address(sgent);
+			d->sg[i].dst = ch->cfg.dst_addr;
+		} else {
+			d->sg[i].ctl = PDMA_WIDTH(width) | PDMA_SAFIX;
+			d->sg[i].src = ch->cfg.src_addr;
+			d->sg[i].dst = sg_dma_address(sgent);
+		}
+		d->sg[i].ctl |= PDMA_TXCNT(sg_dma_len(sgent) / width) | PDMA_TBINTDIS |
+				PDMA_TXTYPE | PDMA_OP_SCATTER;
+		d->sg[i].next = d->dma_addr + PDMA_CH_OFFSET(i + 1);
+	}
+
+	d->sg[sg_len - 1].ctl &= ~(PDMA_OP_MSK | PDMA_TBINTDIS);
+	d->sg[sg_len - 1].ctl |= PDMA_OP_BASIC;
+
+	return ma35d1_desc_submit(ch, d, false, tx_flags);
+}
+
+static struct dma_async_tx_descriptor *
+ma35d1_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t dma_addr, size_t buf_len,
+		       size_t period_len, enum dma_transfer_direction dir,
+		       unsigned long flags)
+{
+	int i, sg_len, width;
+	size_t offset = 0;
+	struct ma35d1_chan *ch = to_ma35d1_pdma_chan(chan);
+	struct ma35d1_desc *d;
+
+	width = ma35d1_slave_width(ch, dir);
+	if (width < 0)
+		return NULL;
+
+	if (!buf_len || !period_len || period_len / width > PDMA_MAX_CHAN_BEATS) {
+		dev_err(ch->dev, "Invalid buffer/period length\n");
+		return NULL;
+	}
+
+	if (buf_len % period_len) {
+		dev_err(ch->dev, "Buffer length not multiple of period length\n");
+		return NULL;
+	}
+
+	if (period_len % width) {
+		dev_err(ch->dev, "Period length must be a multiple of DMA width\n");
+		return NULL;
+	}
+
+	sg_len = buf_len / period_len;
+	d = ma35d1_desc_alloc(ch, sg_len);
+	if (!d)
+		return NULL;
+	d->width = width;
+
+	ma35d1_pdma_setup_channel(ch);
+
+	/* Split the buffer into period size chunks. */
+	for (offset = 0, i = 0; offset < buf_len; offset += period_len, i++) {
+		if (dir == DMA_MEM_TO_DEV) {
+			d->sg[i].ctl = PDMA_WIDTH(width) | PDMA_TXCNT(period_len / width) |
+					PDMA_DAFIX;
+			d->sg[i].src = dma_addr + offset;
+			d->sg[i].dst = ch->cfg.dst_addr;
+		} else {
+			d->sg[i].ctl = PDMA_WIDTH(width) | PDMA_TXCNT(period_len / width) |
+					PDMA_SAFIX;
+			d->sg[i].src = ch->cfg.src_addr;
+			d->sg[i].dst = dma_addr + offset;
+		}
+		d->sg[i].ctl |= PDMA_TXTYPE | PDMA_OP_SCATTER;
+		d->sg[i].next = d->dma_addr + PDMA_CH_OFFSET(i + 1);
+	}
+	d->sg[sg_len - 1].next = d->dma_addr;
+
+	return ma35d1_desc_submit(ch, d, true, flags);
+}
+
+static struct dma_chan *ma35d1_of_xlate(struct of_phandle_args *dma_spec, struct of_dma *of)
+{
+	struct ma35d1_pdmadev *pdmadev = of->of_dma_data;
+	unsigned int chan_id, reqsel;
+
+	if (dma_spec->args_count != 2)
+		return NULL;
+
+	chan_id = dma_spec->args[0];
+	reqsel = dma_spec->args[1];
+	if (chan_id >= pdmadev->nr_chans || reqsel > GENMASK(7, 0))
+		return NULL;
+
+	pdmadev->channels[chan_id].request = reqsel;
+
+	return dma_get_slave_channel(&pdmadev->channels[chan_id].vc.chan);
+}
+
+static void ma35d1_free_chan_resources(struct dma_chan *chan)
+{
+	struct ma35d1_chan *ch = to_ma35d1_pdma_chan(chan);
+
+	vchan_free_chan_resources(&ch->vc);
+	ch->request = 0;
+}
+
+static void ma35d1_pdma_start(struct ma35d1_chan *ch)
+{
+	struct ma35d1_desc *d = ch->desc;
+
+	if (d->sg_len == 1 && !d->cyclic) {
+		/* Trigger basic mode. */
+		writel(d->sg[0].src, ch->base + PDMA_CH_OFFSET(ch->id) + PDMA_DSCT_SA);
+		writel(d->sg[0].dst, ch->base + PDMA_CH_OFFSET(ch->id) + PDMA_DSCT_DA);
+		writel(d->sg[0].ctl, ch->base + PDMA_CH_OFFSET(ch->id) + PDMA_DSCT_CTL);
+	} else {
+		/* Trigger scatter-gather mode. */
+		ma35d1_pdma_reg_clear(ch, PDMA_CH_OFFSET(ch->id) + PDMA_DSCT_CTL, PDMA_OP_MSK);
+		ma35d1_pdma_reg_set(ch, PDMA_CH_OFFSET(ch->id) + PDMA_DSCT_CTL, PDMA_OP_SCATTER);
+	}
+
+	/* Memory-to-memory has no peripheral request, so trigger it by software. */
+	if (ch->request == 0)
+		writel(BIT(ch->id), ch->base + PDMA_SWREQ);
+}
+
+static void ma35d1_pdma_start_desc(struct dma_chan *chan)
+{
+	struct ma35d1_chan *ch = to_ma35d1_pdma_chan(chan);
+	struct virt_dma_desc *vd;
+
+	vd = vchan_next_desc(&ch->vc);
+	if (!vd) {
+		ch->desc = NULL;
+		return;
+	}
+
+	list_del(&vd->node);
+	ch->desc = to_ma35d1_pdma_desc(vd);
+	ma35d1_pdma_timeout(ch);
+	ma35d1_pdma_start(ch);
+}
+
+static void ma35d1_issue_pending(struct dma_chan *chan)
+{
+	struct ma35d1_chan *ch = to_ma35d1_pdma_chan(chan);
+	unsigned long flags;
+
+	spin_lock_irqsave(&ch->vc.lock, flags);
+
+	if (vchan_issue_pending(&ch->vc) && !ch->desc)
+		ma35d1_pdma_start_desc(chan);
+
+	spin_unlock_irqrestore(&ch->vc.lock, flags);
+}
+
+static enum dma_status ma35d1_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
+					struct dma_tx_state *txstate)
+{
+	enum dma_status ret;
+	struct ma35d1_chan *ch = to_ma35d1_pdma_chan(chan);
+	unsigned long flags;
+
+	spin_lock_irqsave(&ch->vc.lock, flags);
+
+	ret = dma_cookie_status(chan, cookie, txstate);
+	if (ret == DMA_COMPLETE) {
+		if (ch->error)
+			ret = DMA_ERROR;
+		else
+			dma_set_residue(txstate, ch->remain);
+	}
+
+	spin_unlock_irqrestore(&ch->vc.lock, flags);
+
+	return ret;
+}
+
+static void ma35d1_pdma_complete(struct ma35d1_chan *ch)
+{
+	if (!ch->desc)
+		return;
+
+	vchan_cookie_complete(&ch->desc->vd);
+	ma35d1_pdma_start_desc(&ch->vc.chan);
+}
+
+static irqreturn_t ma35d1_pdma_interrupt(int irq, void *devid)
+{
+	int i;
+	struct ma35d1_pdmadev *pdmadev = devid;
+	struct ma35d1_chan *ch = &pdmadev->channels[pdmadev->nr_chans - 1];
+	unsigned int timeout_sts, done_sts, abort_sts;
+	unsigned long pending;
+
+	/*
+	 * Read the interrupt flags. Normally, only one is set per channel.
+	 * Check and clear each flag separately.
+	 */
+	done_sts = readl(ch->base + PDMA_TDSTS);
+	timeout_sts = readl(ch->base + PDMA_INTSTS);
+	abort_sts = readl(ch->base + PDMA_ABTSTS);
+
+	pending = (done_sts | abort_sts | (timeout_sts >> 8)) &
+		  GENMASK(pdmadev->nr_chans - 1, 0);
+
+	for_each_set_bit(i, &pending, pdmadev->nr_chans) {
+		unsigned long flags;
+
+		ch = &pdmadev->channels[i];
+
+		spin_lock_irqsave(&ch->vc.lock, flags);
+
+		if (done_sts & BIT(i)) {
+			writel(BIT(i), ch->base + PDMA_TDSTS);
+			if (ch->desc) {
+				ch->remain = 0;
+				if (ch->desc->cyclic)
+					vchan_cyclic_callback(&ch->desc->vd);
+				else
+					ma35d1_pdma_complete(ch);
+			}
+		}
+
+		if (timeout_sts & BIT(i + 8)) {
+			if (ch->desc)
+				ch->remain = PDMA_GET_TXCNT(ch->base + PDMA_CH_OFFSET(ch->id)) *
+					     ch->desc->width;
+			ma35d1_pdma_reg_clear(ch, PDMA_TOUTEN, BIT(i));
+			writel(BIT(i + 8), ch->base + PDMA_INTSTS);
+			ma35d1_pdma_complete(ch);
+		}
+
+		if (abort_sts & BIT(i)) {
+			writel(BIT(i), ch->base + PDMA_ABTSTS);
+			ch->error = true;
+			ma35d1_pdma_complete(ch);
+		}
+
+		spin_unlock_irqrestore(&ch->vc.lock, flags);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int ma35d1_pdma_probe(struct platform_device *pdev)
+{
+	int i, irq, nr_chans, ret;
+	struct clk *pdma_clk;
+	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->of_node;
+	struct ma35d1_chan *ch;
+	struct ma35d1_pdmadev *pdmadev;
+	void __iomem *reg_base;
+
+	pdma_clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(pdma_clk))
+		return dev_err_probe(dev, PTR_ERR(pdma_clk), "Failed to get clk\n");
+
+	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
+	if (ret)
+		return ret;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	ret = of_property_read_u32(node, "dma-channels", &nr_chans);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get dma-channels\n");
+
+	if (nr_chans > PDMA_MAX_CHANS) {
+		dev_warn(dev, "dma-channels %d exceeds max %d, clamping\n",
+			 nr_chans, PDMA_MAX_CHANS);
+		nr_chans = PDMA_MAX_CHANS;
+	}
+
+	pdmadev = devm_kzalloc(dev, struct_size(pdmadev, channels, nr_chans), GFP_KERNEL);
+	if (!pdmadev)
+		return -ENOMEM;
+
+	pdmadev->nr_chans = nr_chans;
+
+	reg_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(reg_base))
+		return dev_err_probe(dev, PTR_ERR(reg_base),
+				     "Failed to map pdma global registers\n");
+
+	dma_cap_zero(pdmadev->ddev.cap_mask);
+	dma_cap_set(DMA_SLAVE, pdmadev->ddev.cap_mask);
+	dma_cap_set(DMA_PRIVATE, pdmadev->ddev.cap_mask);
+	dma_cap_set(DMA_MEMCPY, pdmadev->ddev.cap_mask);
+	dma_cap_set(DMA_CYCLIC, pdmadev->ddev.cap_mask);
+
+	pdmadev->ddev.dev = dev;
+	pdmadev->ddev.src_addr_widths = PDMA_SLAVE_BUSWIDTHS;
+	pdmadev->ddev.dst_addr_widths = PDMA_SLAVE_BUSWIDTHS;
+	pdmadev->ddev.directions = BIT(DMA_MEM_TO_DEV) | BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_MEM);
+	pdmadev->ddev.device_prep_dma_memcpy = ma35d1_prep_dma_memcpy;
+	pdmadev->ddev.device_prep_slave_sg = ma35d1_prep_slave_sg;
+	pdmadev->ddev.device_prep_dma_cyclic = ma35d1_prep_dma_cyclic;
+	pdmadev->ddev.device_free_chan_resources = ma35d1_free_chan_resources;
+	pdmadev->ddev.device_issue_pending = ma35d1_issue_pending;
+	pdmadev->ddev.device_tx_status = ma35d1_tx_status;
+	pdmadev->ddev.device_config = ma35d1_slave_config;
+	pdmadev->ddev.device_terminate_all = ma35d1_terminate_all;
+	pdmadev->ddev.device_synchronize = ma35d1_synchronize;
+
+	spin_lock_init(&pdmadev->lock);
+	INIT_LIST_HEAD(&pdmadev->ddev.channels);
+	for (i = 0; i < nr_chans; i++) {
+		ch = &pdmadev->channels[i];
+		ch->dev = dev;
+		ch->pdmadev = pdmadev;
+		ch->id = i;
+		ch->base = reg_base;
+		ch->vc.desc_free = ma35d1_pdma_desc_free;
+		vchan_init(&ch->vc, &pdmadev->ddev);
+	}
+
+	ret = devm_request_irq(dev, irq, ma35d1_pdma_interrupt, 0, pdev->name, pdmadev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to request IRQ\n");
+
+	ret = dmaenginem_async_device_register(&pdmadev->ddev);
+	if (ret)
+		return ret;
+
+	ret = of_dma_controller_register(node, ma35d1_of_xlate, pdmadev);
+	if (ret)
+		return dev_err_probe(dev, ret, "of_dma_controller_register failed\n");
+
+	platform_set_drvdata(pdev, pdmadev);
+
+	return 0;
+}
+
+static void ma35d1_pdma_remove(struct platform_device *pdev)
+{
+	struct ma35d1_pdmadev *pdmadev = platform_get_drvdata(pdev);
+	int i;
+
+	of_dma_controller_free(pdev->dev.of_node);
+	writel(0, pdmadev->channels[0].base + PDMA_INTEN);
+
+	for (i = 0; i < pdmadev->nr_chans; i++)
+		tasklet_kill(&pdmadev->channels[i].vc.task);
+}
+
+static const struct of_device_id ma35d1_pdma_match[] = {
+	{ .compatible = "nuvoton,ma35d1-pdma" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, ma35d1_pdma_match);
+
+static struct platform_driver ma35d1_pdma_driver = {
+	.probe = ma35d1_pdma_probe,
+	.remove = ma35d1_pdma_remove,
+	.driver = {
+		.name = "ma35d1-pdma",
+		.of_match_table = ma35d1_pdma_match,
+	},
+};
+module_platform_driver(ma35d1_pdma_driver);
+
+MODULE_DESCRIPTION("PDMA controller driver for Nuvoton MA35D1");
+MODULE_AUTHOR("Shan-Chun Hung <shanchun1218@gmail.com>");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/dma/ma35d1-pdma.h b/include/linux/dma/ma35d1-pdma.h
new file mode 100644
index 000000000000..13f1410d74da
--- /dev/null
+++ b/include/linux/dma/ma35d1-pdma.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Header file for the MA35D1 PDMA Controller driver
+ *
+ * Copyright (C) 2026 Nuvoton Technology Corp.
+ */
+#ifndef _MA35D1_PDMA_H
+#define _MA35D1_PDMA_H
+
+/**
+ * struct ma35d1_peripheral - PDMA peripheral configuration
+ * @prescaler: timeout prescaler value
+ * @counter: timeout counter value
+ *
+ * Slave device drivers fill in this structure and pass it via
+ * dma_slave_config.peripheral_config/peripheral_size to configure
+ * the MA35D1 PDMA engine's per-channel timeout detection block.
+ */
+struct ma35d1_peripheral {
+	unsigned int prescaler;
+	unsigned int counter;
+};
+
+#endif /* _MA35D1_PDMA_H */
--
2.25.1

