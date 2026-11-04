Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801196;
	b=FRtN8qIQY9MgXp+ng3oCGjzQft5CE8qiLOmdSg3z+M8JXx482b8lC9qmGjsKor1IeQvN
	 3dpD02ZNJJxt/5iUsRqhc5azetCYs8iyJcEWSMpXJAVZhTeXdG/SRQ8ziREiH/nlCbim3
	 fsHiejn6vdj0XVa84gvdslyMzI14XxmH6SP+o2umysqHIob8AucRCayUZv5HCyqu1EcOq
	 wC6gCVD9YGA6nlK21s6lcBryZM+e6oWBNLa0BfwQcfSukUx3PtZjFbov5uKZK+42ChJSv
	 tOqr3xYKSlFZCpg8PYdQPXZENfbVLV1T0fnPj4ByjNavZFdFh89n8inNGE5uyfqq9Ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801196;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=aXWAiVoz/GShbNgnrlETN1gpMxMxX7DmXCvxpsTV6/E=;
	b=bVQl6nN1aqJpXTKFkiHbqK5BsNQS/0m+t4dxPBzTFUQIz64hjbeb7ZRAw8zssafIF81U
	 1A4ulSQ6V8Xrq5+c1tWq+qbGiqEc/KyJbiZ+7hrPixdYv5o0Ibmrm6xxAEVa/YDSGHuEf
	 FOWE0vdqWLBNd2nq5CbqObyWBPjD/Li7uZjqzSZkiO4bwuoVk/pu22NApmYMxpyE9zAmA
	 uQRe1icaKpH7U0zmLbAW2DSRa2AI5PUl1rWwtobWf+6sOptS7y6iTTXhaPuh1JxILVPWd
	 tn0ytqs/DDwkrZ5BE/ya5p+XYnY1j2VmWIfVWQt3Ikk5MU420Dk8/SHIVgtIaN7LdkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bDAinQV7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1B9606A31B;
	Wed,  4 Nov 2026 14:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bDAinQV7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3943A1F00919;
	Wed,  4 Nov 2026 14:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793801195;
	bh=aXWAiVoz/GShbNgnrlETN1gpMxMxX7DmXCvxpsTV6/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bDAinQV78kjJGiRao2RlWwJ7qdRGHIzm8KQao4PrDV/PUop6ZnJhhSCnZ7zWFaZXj
	 izuvBAY15eKrmx8/0Dg52D3yuOCzfzA47CKA0osbIpS7Jnpu0T+kekKoIm4z1KoT98
	 8XO41cC7jSYiuEYnKQIKDFs0Y6lx3rxnA3lATzL37Lo5t+seairFqy4rw99vURD6SV
	 Nl24+LErs1Xhnr1zFtPP/QIW9neMElBYB0zIMokMaU/BGgXzYIvIubR/ok/X1uiimI
	 Ie7Qffgec1FYRixwAld/q/0zdZy/911jv68Utp9WjeVJBZs4m6krRAQTTp2XnX9EKE
	 8TnxLsUXIxwIg==
Date: Wed, 4 Nov 2026 15:06:31 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Shan-Chun Hung <shanchun1218@gmail.com>
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, vkoul@kernel.org, 
	Frank.Li@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	kees@kernel.org, gustavoars@kernel.org, linux-arm-kernel@lists.infradead.org, 
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/2] dmaengine: ma35d1-pdma: Add MA35D1 PDMA driver
Message-ID: <20261104-airborne-vivid-caterpillar-991425@quoll>
References: <20261103022202.2139674-1-shanchun1218@gmail.com>
 <20261103022202.2139674-3-shanchun1218@gmail.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261103022202.2139674-3-shanchun1218@gmail.com>

On Tue, Nov 03, 2026 at 10:22:02AM +0800, Shan-Chun Hung wrote:
> +#include <linux/align.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/compiler_types.h>
> +#include <linux/container_of.h>
> +#include <linux/dev_printk.h>
> +#include <linux/device.h>
> +#include <linux/dma-direction.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dma/ma35d1-pdma.h>
> +#include <linux/dmaengine.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/gfp_types.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/irqreturn.h>
> +#include <linux/limits.h>
> +#include <linux/list.h>
> +#include <linux/math.h>
> +#include <linux/minmax.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_dma.h>
> +#include <linux/overflow.h>
> +#include <linux/platform_device.h>
> +#include <linux/scatterlist.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/spinlock_types.h>
> +#include <linux/stddef.h>
> +#include <linux/string.h>
> +#include <linux/types.h>

Do you use all these defines?

I don't see usage of header with bindings, though.

> +
> +#include "dmaengine.h"
> +#include "virt-dma.h"
> +

...

> +static int ma35d1_pdma_probe(struct platform_device *pdev)
> +{
> +	int i, irq, nr_chans, ret;
> +	struct clk *pdma_clk;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *node = dev->of_node;
> +	struct ma35d1_chan *ch;
> +	struct ma35d1_pdmadev *pdmadev;
> +	void __iomem *reg_base;
> +
> +	pdma_clk = devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(pdma_clk))
> +		return dev_err_probe(dev, PTR_ERR(pdma_clk), "Failed to get clk\n");
> +
> +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> +	if (ret)
> +		return ret;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
> +	ret = of_property_read_u32(node, "dma-channels", &nr_chans);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get dma-channels\n");
> +
> +	if (nr_chans > PDMA_MAX_CHANS) {
> +		dev_warn(dev, "dma-channels %d exceeds max %d, clamping\n",
> +			 nr_chans, PDMA_MAX_CHANS);
> +		nr_chans = PDMA_MAX_CHANS;
> +	}
> +
> +	pdmadev = devm_kzalloc(dev, struct_size(pdmadev, channels, nr_chans), GFP_KERNEL);
> +	if (!pdmadev)
> +		return -ENOMEM;
> +
> +	pdmadev->nr_chans = nr_chans;
> +
> +	reg_base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(reg_base))
> +		return dev_err_probe(dev, PTR_ERR(reg_base),
> +				     "Failed to map pdma global registers\n");
> +
> +	dma_cap_zero(pdmadev->ddev.cap_mask);
> +	dma_cap_set(DMA_SLAVE, pdmadev->ddev.cap_mask);
> +	dma_cap_set(DMA_PRIVATE, pdmadev->ddev.cap_mask);
> +	dma_cap_set(DMA_MEMCPY, pdmadev->ddev.cap_mask);
> +	dma_cap_set(DMA_CYCLIC, pdmadev->ddev.cap_mask);
> +
> +	pdmadev->ddev.dev = dev;
> +	pdmadev->ddev.src_addr_widths = PDMA_SLAVE_BUSWIDTHS;
> +	pdmadev->ddev.dst_addr_widths = PDMA_SLAVE_BUSWIDTHS;
> +	pdmadev->ddev.directions = BIT(DMA_MEM_TO_DEV) | BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_MEM);
> +	pdmadev->ddev.device_prep_dma_memcpy = ma35d1_prep_dma_memcpy;
> +	pdmadev->ddev.device_prep_slave_sg = ma35d1_prep_slave_sg;
> +	pdmadev->ddev.device_prep_dma_cyclic = ma35d1_prep_dma_cyclic;
> +	pdmadev->ddev.device_free_chan_resources = ma35d1_free_chan_resources;
> +	pdmadev->ddev.device_issue_pending = ma35d1_issue_pending;
> +	pdmadev->ddev.device_tx_status = ma35d1_tx_status;
> +	pdmadev->ddev.device_config = ma35d1_slave_config;
> +	pdmadev->ddev.device_terminate_all = ma35d1_terminate_all;
> +	pdmadev->ddev.device_synchronize = ma35d1_synchronize;
> +
> +	spin_lock_init(&pdmadev->lock);
> +	INIT_LIST_HEAD(&pdmadev->ddev.channels);
> +	for (i = 0; i < nr_chans; i++) {
> +		ch = &pdmadev->channels[i];
> +		ch->dev = dev;
> +		ch->pdmadev = pdmadev;
> +		ch->id = i;
> +		ch->base = reg_base;
> +		ch->vc.desc_free = ma35d1_pdma_desc_free;
> +		vchan_init(&ch->vc, &pdmadev->ddev);
> +	}
> +
> +	ret = devm_request_irq(dev, irq, ma35d1_pdma_interrupt, 0, pdev->name, pdmadev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to request IRQ\n");
> +
> +	ret = dmaenginem_async_device_register(&pdmadev->ddev);
> +	if (ret)
> +		return ret;
> +
> +	ret = of_dma_controller_register(node, ma35d1_of_xlate, pdmadev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "of_dma_controller_register failed\n");
> +
> +	platform_set_drvdata(pdev, pdmadev);
> +
> +	return 0;
> +}
> +
> +static void ma35d1_pdma_remove(struct platform_device *pdev)
> +{
> +	struct ma35d1_pdmadev *pdmadev = platform_get_drvdata(pdev);
> +	int i;
> +
> +	of_dma_controller_free(pdev->dev.of_node);
> +	writel(0, pdmadev->channels[0].base + PDMA_INTEN);
> +
> +	for (i = 0; i < pdmadev->nr_chans; i++)
> +		tasklet_kill(&pdmadev->channels[i].vc.task);
> +}
> +
> +static const struct of_device_id ma35d1_pdma_match[] = {
> +	{ .compatible = "nuvoton,ma35d1-pdma" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, ma35d1_pdma_match);
> +
> +static struct platform_driver ma35d1_pdma_driver = {
> +	.probe = ma35d1_pdma_probe,
> +	.remove = ma35d1_pdma_remove,
> +	.driver = {
> +		.name = "ma35d1-pdma",
> +		.of_match_table = ma35d1_pdma_match,
> +	},
> +};
> +module_platform_driver(ma35d1_pdma_driver);
> +
> +MODULE_DESCRIPTION("PDMA controller driver for Nuvoton MA35D1");
> +MODULE_AUTHOR("Shan-Chun Hung <shanchun1218@gmail.com>");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/dma/ma35d1-pdma.h b/include/linux/dma/ma35d1-pdma.h
> new file mode 100644
> index 000000000000..13f1410d74da
> --- /dev/null
> +++ b/include/linux/dma/ma35d1-pdma.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Header file for the MA35D1 PDMA Controller driver
> + *
> + * Copyright (C) 2026 Nuvoton Technology Corp.
> + */
> +#ifndef _MA35D1_PDMA_H
> +#define _MA35D1_PDMA_H
> +
> +/**
> + * struct ma35d1_peripheral - PDMA peripheral configuration
> + * @prescaler: timeout prescaler value
> + * @counter: timeout counter value
> + *
> + * Slave device drivers fill in this structure and pass it via
> + * dma_slave_config.peripheral_config/peripheral_size to configure
> + * the MA35D1 PDMA engine's per-channel timeout detection block.

Hm? Confusing, how is it supposed to be used? Do you just reimplement
board files?

> + */
> +struct ma35d1_peripheral {
> +	unsigned int prescaler;
> +	unsigned int counter;
> +};
> +
> +#endif /* _MA35D1_PDMA_H */
> --
> 2.25.1
> 
