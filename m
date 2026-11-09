Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794202155;
	b=fCeEkqdrQQ06SVS6das61WoWDJqZ4Jkg5DIJekPFJxjPW4E4cX+HXkifRAHYoiHNqaDt
	 akDZhstdiAHOSyhlzk5N0x2fC7gkq/A2KI+69cPWkyrrZ3SnoPPc5/pr1qbmvBuW62lGf
	 WWLzjdaiwyeL4L4CzIhGuKr5InpgSqEaOVEeTXCTqXy6D19bqw1SRvjiNhRJqhEaq38A3
	 TkylK60SPiI3UnB65rzPGqCbFOZFtB0jzSeVAUClL4sKjiMJGqBQyXHxUo6L8Rg32qPiB
	 J6eSGe67rHHgHUXaHBzN0vJ2uf8je6yJVQKEUGIs4Vs2hzu3qjsVPxi2/eV1iJmXGBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794202155;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=o/Zu8d9pjMW/MzpeHmGEy9jntTL7TUHvfpSM9hyMkeI=;
	b=k/a7vlKWSHNo53YioKqj4BSWaPOcri0IsLyvWNBg1ZJrcisaz33tY5p0DcjVBGoa5Ore
	 kKxe3gDwZRL6yfwsOVpjoBxsd7VUYa7KFLA01nhA8/kaAmM3++egxAWoE8JTKHThtU7SP
	 byZ4iE6msi6WApgzWHPsmCjPrQ3I7otSA3hEnLnDe3fpDhb22oeohNcrEKKEeS6ZTNwQg
	 pLSFGZ89OCq0hfO5+5ES5wJH8Ip56PW5/nDQAIsRi8B2hdD4wPHUxXw/mgtXU++Qa5bDx
	 EAfpeArFJX+GfRO/1PZUr03TsmQ5TrtKxi+8OO5tOp5C6BSkM0gl8jPV8jSuMzEDAbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0ELv7xnh;
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619D6606D83B
	for <linux-hardening@vger.kernel.org>; Mon,  9 Nov 2026 05:29:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 619D6606D83B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0ELv7xnh
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8a06e79e152so191935b3a.0
        for <linux-hardening@vger.kernel.org>; Sun, 08 Nov 2026 21:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794202154; x=1794806954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o/Zu8d9pjMW/MzpeHmGEy9jntTL7TUHvfpSM9hyMkeI=;
        b=0ELv7xnhBjXLA7OQwudqcIzL/o1BjIovz0HBs+rIVtTTrk9MWz9mJShZ0d3rMK9bcN
         EjVOg30yJMCFkuL6XAHSSUSMy88CJJaBPhKtWH5k03L9sqYr/OKoMEs10ebHw4TrOIXY
         0VWAuGoIJgJczRyPFvHAWB9c6z8bG2ntDUy4p5bJZFt67BmwqLAd/0Lx4rTndWyF9CEC
         EI+RGVHIWNArETna4OR9SPDnyHAaheLtD+D15FiMIAel0wQcBW9YVgjTse5xKw5Cci1x
         lXpAS4lGYPFyLvXNhKQv4IjCD6/xWG+ndzbZhf7BhBhhvv6LrjaY1cw91noXEeAw7BgB
         FIzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794202154; x=1794806954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=o/Zu8d9pjMW/MzpeHmGEy9jntTL7TUHvfpSM9hyMkeI=;
        b=JuXL82+HHZQgye04kw/EfLnkJVLO5R/fp2P18+i924c/fkWnky1dqaHR9Prg/ce/ws
         acDr1D2jkMOOouqbqsoKIFNf4OD8edI4/KSIrUFko8l6eWxWeLCt7d9ftxGNVZTlrY83
         xji48cctXm+tayct05hqlEaUkUqZ0b6r2BYWKkTqNmqMu4a9dzNValjjllipAtcLq3I3
         H7jkE5cFXcvH8pXtCVRQ5EO1wqUmTtNX+vnbnQtwNFpQR+ROx2n35zQaAdvqegYZ0moj
         Md7vbLGJ9xoAupoPZ5kYoTWw8PZxN4OVlXda1qTwWHIr6LDcTQS5Sg9CbVGwdpFTXM+6
         We+Q==
X-Forwarded-Encrypted: i=1; AL+hErFBRFsyuHqBxwSm2zAz4JaJMByTBGSKO7Kk83lEMs1msq9VrPdYA2SZUCy7d3UPPE//ekwC2PRk92BTg9UkKTI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8qKujxDk9K0/39UVcSTd1jC1oGoY8PAFOXM1/DW2URMdTSHkzu
	+E3uJbmq2CJp+3EG/gAArjP2rQ0OUzQ1yEgdt72QLsidNRffIN4WN3+x
X-Gm-Gg: AYBFou0NNlQU9j8/yzswy8KYz9IqVrUxEc3W8YZa7C0Z/qUu/Eype3g2DH8/D7jrBKi
	5qaaNGE+wUQ4ttP6Z5GV5VdkmxObxYQQtDPiKG/SmCLQSg3JNH9u5caWcb9lGbVWS7zEY2qLmmt
	60Gsp6A+N4KpJC+/Q4bN4fvc+fFXbwgk4Q/UCcddSpgotJt47NInol6ztyY/Ujl1RlpEpQ0XTvp
	gZV67TAsuXAyz7VgAluGTZR7ycUbt7RwkDIFUgQoiMdSaI5Z0/hMmbTAEQg76qrY8H338aD+63T
	WT0ALO620nSjsnIHeaZ6NrL468EmlBkRwbZwcrDQjB6H4cB2tIlHL4YqCd2IO6f7AAECnrw4ywl
	1zvOOxzlzmC0vZK1m4LrFEkPnFdQyG8RFEkOC9WoEKpvSNHM+iDHfbdffHOo7M4NbvoFtVDznob
	9GxkyYcq1kd/urau2WwYPMnIujYNmccnIATZXywnBQnC6GxYzZjAII/XV1ZeRI2QPJFQMUCt+Ii
	VtxIy97TfqEPpk0Ku43qTwBsr6Y2Ry+J2YFVfuiX8LlH/hvB4+cHjEghIKSPP+Cf+VhkJhd87OS
	YtgL0AXk6czD6AB19Z8jeq1gUtNjOxjoV+vK2QGnF9MO7bLfwpo65h/JxqDrldzIs9I2PqSJ6Vu
	Syd9ytPvvwiLWGu+exEgs0ikLFXAHhKAN+hYL
X-Received: by 2002:a05:6a20:160e:b0:3de:53c1:b627 with SMTP id adf61e73a8af0-3eed3325837mr3088295637.43.1794202153524;
        Sun, 08 Nov 2026 21:29:13 -0800 (PST)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb9681385fsm1180899a12.6.2026.11.08.21.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 21:29:13 -0800 (PST)
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
Subject: [PATCH v2 2/2] dmaengine: ma35d1-pdma: Add MA35D1 PDMA driver
Date: Mon,  9 Nov 2026 13:29:00 +0800
Message-Id: <20261109052900.2960473-3-shanchun1218@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261109052900.2960473-1-shanchun1218@gmail.com>
References: <20261109052900.2960473-1-shanchun1218@gmail.com>
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
and cyclic transfers.

Signed-off-by: Shan-Chun Hung <shanchun1218@gmail.com>
---
 drivers/dma/Kconfig       |  12 +
 drivers/dma/Makefile      |   1 +
 drivers/dma/ma35d1-pdma.c | 672 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 685 insertions(+)
 create mode 100644 drivers/dma/ma35d1-pdma.c

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
index 000000000000..fef78e6d10d7
--- /dev/null
+++ b/drivers/dma/ma35d1-pdma.c
@@ -0,0 +1,672 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Nuvoton MA35D1 PDMA controller driver
+ *
+ * Copyright (C) 2026 Nuvoton Technology Corp.
+ *
+ * Author: Shan-Chun Hung <shanchun1218@gmail.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_dma.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
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
+#define PDMA_ABTSTS		0x420
+#define PDMA_TDSTS		0x424
+#define PDMA_CHRST		0x460
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
+	/* second #dma-cells argument from devicetree */
+	u32 request;
+};
+
+struct ma35d1_pdmadev {
+	struct dma_device ddev;
+	/* protects read-modify-write of shared controller registers */
+	spinlock_t lock;
+	int irq;
+	struct ma35d1_chan channels[PDMA_MAX_CHANS];
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
+	writel(BIT(ch->id), ch->base + PDMA_TDSTS);
+	writel(BIT(ch->id), ch->base + PDMA_ABTSTS);
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
+
+	memcpy(&ch->cfg, cfg, sizeof(*cfg));
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
+
+	for (i = 0; i < sg_len; i++) {
+		tlen = min_t(size_t, len, max_chunk);
+		d->sg[i].src = src;
+		d->sg[i].dst = dst;
+		d->sg[i].ctl = PDMA_WIDTH(width) | PDMA_TXCNT(tlen / width) | PDMA_TBINTDIS |
+				PDMA_OP_SCATTER;
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
+	for_each_sg(sgl, sgent, sg_len, i) {
+		unsigned int len = sg_dma_len(sgent);
+
+		if (!len || len % width || len / width > PDMA_MAX_CHAN_BEATS) {
+			dev_err(ch->dev, "invalid SG segment length %u\n", len);
+			return NULL;
+		}
+
+		if (!IS_ALIGNED(sg_dma_address(sgent), width)) {
+			dev_err(ch->dev, "SG address not aligned to DMA width\n");
+			return NULL;
+		}
+	}
+
+	d = ma35d1_desc_alloc(ch, sg_len);
+	if (!d)
+		return NULL;
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
+	if (!IS_ALIGNED(dma_addr, width)) {
+		dev_err(ch->dev, "Buffer address not aligned to DMA width\n");
+		return NULL;
+	}
+
+	sg_len = buf_len / period_len;
+	d = ma35d1_desc_alloc(ch, sg_len);
+	if (!d)
+		return NULL;
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
+	struct dma_chan *chan;
+	unsigned int chan_id, reqsel;
+
+	if (dma_spec->args_count != 2)
+		return NULL;
+
+	chan_id = dma_spec->args[0];
+	reqsel = dma_spec->args[1];
+	if (chan_id >= PDMA_MAX_CHANS || reqsel > GENMASK(7, 0))
+		return NULL;
+
+	chan = dma_get_slave_channel(&pdmadev->channels[chan_id].vc.chan);
+	if (chan)
+		pdmadev->channels[chan_id].request = reqsel;
+
+	return chan;
+}
+
+static void ma35d1_free_chan_resources(struct dma_chan *chan)
+{
+	struct ma35d1_chan *ch = to_ma35d1_pdma_chan(chan);
+
+	ma35d1_terminate_all(chan);
+	vchan_free_chan_resources(&ch->vc);
+	ch->request = 0;
+	memset(&ch->cfg, 0, sizeof(ch->cfg));
+}
+
+static void ma35d1_pdma_start(struct ma35d1_chan *ch)
+{
+	struct ma35d1_desc *d = ch->desc;
+
+	if (d->sg_len == 1 && !d->cyclic) {
+		writel(d->sg[0].src, ch->base + PDMA_CH_OFFSET(ch->id) + PDMA_DSCT_SA);
+		writel(d->sg[0].dst, ch->base + PDMA_CH_OFFSET(ch->id) + PDMA_DSCT_DA);
+		writel(d->sg[0].ctl, ch->base + PDMA_CH_OFFSET(ch->id) + PDMA_DSCT_CTL);
+	} else {
+		writel(d->dma_addr, ch->base + PDMA_CH_OFFSET(ch->id) + PDMA_DSCT_NEXT);
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
+	ma35d1_pdma_setup_channel(ch);
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
+	bool handled = false;
+	struct ma35d1_pdmadev *pdmadev = devid;
+	struct ma35d1_chan *ch;
+
+	for (i = 0; i < PDMA_MAX_CHANS; i++) {
+		unsigned long flags;
+		bool done, abort;
+
+		ch = &pdmadev->channels[i];
+
+		spin_lock_irqsave(&ch->vc.lock, flags);
+
+		done = readl(ch->base + PDMA_TDSTS) & BIT(i);
+		abort = readl(ch->base + PDMA_ABTSTS) & BIT(i);
+
+		if (done || abort) {
+			handled = true;
+
+			/* Ack both flags first so a new descriptor is not completed twice. */
+			writel(BIT(i), ch->base + PDMA_TDSTS);
+			writel(BIT(i), ch->base + PDMA_ABTSTS);
+
+			if (ch->desc) {
+				if (abort) {
+					ch->desc->vd.tx_result.result = DMA_TRANS_ABORTED;
+					ma35d1_pdma_complete(ch);
+				} else if (ch->desc->cyclic) {
+					vchan_cyclic_callback(&ch->desc->vd);
+				} else {
+					ma35d1_pdma_complete(ch);
+				}
+			}
+		}
+
+		spin_unlock_irqrestore(&ch->vc.lock, flags);
+	}
+
+	return handled ? IRQ_HANDLED : IRQ_NONE;
+}
+
+static int ma35d1_pdma_probe(struct platform_device *pdev)
+{
+	int i, ret;
+	struct clk *pdma_clk;
+	struct reset_control *rst;
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
+	rst = devm_reset_control_get_optional_exclusive_deasserted(dev, NULL);
+	if (IS_ERR(rst))
+		return dev_err_probe(dev, PTR_ERR(rst), "Failed to get reset\n");
+
+	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
+	if (ret)
+		return ret;
+
+	pdmadev = devm_kzalloc(dev, sizeof(*pdmadev), GFP_KERNEL);
+	if (!pdmadev)
+		return -ENOMEM;
+
+	pdmadev->irq = platform_get_irq(pdev, 0);
+	if (pdmadev->irq < 0)
+		return pdmadev->irq;
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
+	pdmadev->ddev.device_tx_status = dma_cookie_status;
+	pdmadev->ddev.device_config = ma35d1_slave_config;
+	pdmadev->ddev.device_terminate_all = ma35d1_terminate_all;
+	pdmadev->ddev.device_synchronize = ma35d1_synchronize;
+
+	spin_lock_init(&pdmadev->lock);
+	INIT_LIST_HEAD(&pdmadev->ddev.channels);
+	for (i = 0; i < PDMA_MAX_CHANS; i++) {
+		ch = &pdmadev->channels[i];
+		ch->dev = dev;
+		ch->pdmadev = pdmadev;
+		ch->id = i;
+		ch->base = reg_base;
+		ch->vc.desc_free = ma35d1_pdma_desc_free;
+		vchan_init(&ch->vc, &pdmadev->ddev);
+	}
+
+	ret = devm_request_irq(dev, pdmadev->irq, ma35d1_pdma_interrupt, 0, pdev->name, pdmadev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to request IRQ\n");
+
+	platform_set_drvdata(pdev, pdmadev);
+
+	ret = dma_async_device_register(&pdmadev->ddev);
+	if (ret)
+		return ret;
+
+	ret = of_dma_controller_register(node, ma35d1_of_xlate, pdmadev);
+	if (ret) {
+		dma_async_device_unregister(&pdmadev->ddev);
+		for (i = 0; i < PDMA_MAX_CHANS; i++)
+			tasklet_kill(&pdmadev->channels[i].vc.task);
+		return dev_err_probe(dev, ret, "of_dma_controller_register failed\n");
+	}
+
+	return 0;
+}
+
+static void ma35d1_pdma_remove(struct platform_device *pdev)
+{
+	struct ma35d1_pdmadev *pdmadev = platform_get_drvdata(pdev);
+	void __iomem *base = pdmadev->channels[0].base;
+	int i;
+
+	/* Stop new requests before the hardware is quiesced. */
+	of_dma_controller_free(pdev->dev.of_node);
+	dma_async_device_unregister(&pdmadev->ddev);
+
+	writel(0, base + PDMA_CHCTL);
+	writel(0, base + PDMA_INTEN);
+	synchronize_irq(pdmadev->irq);
+
+	for (i = 0; i < PDMA_MAX_CHANS; i++)
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
-- 
2.25.1

