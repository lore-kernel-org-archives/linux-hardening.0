Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793851919;
	b=Letouq6tTYYZPtmkMdrQs8QqPa4eRoZjagEID9KvmKYDb+ivvMsh7GEafA017Uuss4Vm
	 skLLaDO0K+XW+PxQTTfwmmfR2Bdiw9ezVoQU2b3EkCNYku0w9fKYCRkPLZv4SAgy5Stz9
	 KkQgCDj/1DxR7aENeMWm9VihQV18lWVLKoPZjB9KTpWftTGIku3beucBko84V7bXtBWsF
	 Xr/0AC1fxTJGCzFWYhTeJgZ42g9R9q+OjAdZAtQm3ZXEonvdvJotFX6+D7/Sxl0eOXZ2H
	 4FS1muXWgD96HmoQfUc1QDnaT2XBKusuxBssIbcU8qOxyYlAmSTWoQyVLg/mahFJ6og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793851919;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=9R8sjon0OoLhcKLtvCx4GBuhrJBqClfpAAsAKQfgIQk=;
	b=LqxD+xV6J6tmI+Hw6hHQjw0UwVwzYKcL3pBnT+Apf/Dz+M+V186K5NJflEbB1iVUccfW
	 +klj3TxX6UQbVQ+3ZLBXA+7Pl4Es9VE4Qq1PzGt0YT3vtQvg25Kex1U/3aUdV+yo11gIe
	 ARG5Zs3OIzsEX8RM3hnaxJ+5gzxgmydYbF5YIBInaKdPhzYaA02IWeii+IwnceRKnTRK0
	 VHKlsVXpkk31qJcX+KIR+mb/n2Tc2m9+h/AWz8Tts67HF1nAfbDyQZMFdMTb+LI0sU7/O
	 6nnojpPhxeCqaNAigHPKOzlBEYhJmwgYu3QoQ/s3mwsMhfJC2pLB0iO3siMEYarMOdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zZljd6UB;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757A2606A32F
	for <linux-hardening@vger.kernel.org>; Thu,  5 Nov 2026 04:11:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 757A2606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zZljd6UB
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ae1da332bcso759589a91.2
        for <linux-hardening@vger.kernel.org>; Wed, 04 Nov 2026 20:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793851919; x=1794456719; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9R8sjon0OoLhcKLtvCx4GBuhrJBqClfpAAsAKQfgIQk=;
        b=zZljd6UBufh4vD0ULN76wTjQM9CsCwNN57X+eTtmXuFwt64K6XFvEfqukaAdtyfb1P
         V/Dg3zKw/NLw069mAPuouhlewFf7l+4RRRoL8uAksV8GwKymaDbc8oNjYOpstFmn/sSu
         ISebpV1+27FP2pZBNUKeFpjYhavkBWNCmiwKk3DpLORjNxcGc+fHFXAtJ0yZqIvqPC3J
         qR93Mfz+d2Xg1daGf/nNSOAKRwm4riYwC/BKUTiZ2awuRoGwXTTsJ5MLsZVzgCVKQxtm
         ycoV4eXsm6NjyjONdYdiatqv7lg+GO/odyQWgIAjw1kT3QXRHO37F50+/uvQFzikqSKL
         2vbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793851919; x=1794456719;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9R8sjon0OoLhcKLtvCx4GBuhrJBqClfpAAsAKQfgIQk=;
        b=yx5P9xfRDGsLLq2owRdXrwj7jL7GZDw7WARK2Pv4+jA8lbNcYHsygI8csUTsCF9HPI
         3L9baSKQC+r5ya4B/tC7eXLWtP7uc7pEYSoJxhV9ILuH806ME0bzY9hfXDZxFPVpYvos
         ALNhBOc2spuIH9Q+eJwVb8vJEyvrO+pTARHhCve+mfTZKVFJwzii9HNxEKjlC7EVwgRE
         GWFq2ShzDIt4LHoh3YgEWTzepGdzLY5q5fvaMiMc6fyZNy5bO/t91eTn6FEEw8BMio/9
         ORIEtmzKRQGDMtsFq09tc0nehnSJc/oVl9ZLjOOVN8t1XP5BW6PuMtRxp4obZv71rVeH
         X0tQ==
X-Forwarded-Encrypted: i=1; AKwUvByLr7Lax0U6+genkNcPylicP9JCqjP3juOVngiEeE8b+5Ap7GE3/g8v6JMREYj0f1EXZQf0WcsK99mmzh4ZI2c=@vger.kernel.org
X-Gm-Message-State: APuU4Z8DBoAfGT0UpCZbTNtHP8Mehqr82zIb5JcJfvCRFGydIYaSXsJj
	LeSE6xplBAdeFcnlOGXc0PrLI9TbhBMiZVowf1xDxgLfJiLJLfwT3Dro
X-Gm-Gg: AYBFou0KMzkOcGSCWu1ivXO6+a83ZU0zof6QH63KmYV6D/H6lxNnvseIp2j7sO0xLSc
	WJzCBVh/mdzDI7uQX++q7v2bL77AKICZDDsIAWA1VHrTmTfmznAfoEHsoMdSXdC6EXtnEV7XKQx
	jVrvEPmrBoMvpJ/Y66ZaswqSz5Dx+H2WC0n+92HCXvCc/++TSChA2rThuhLtGFxHdcTZ+bMw0sF
	kn3sr57Ssd5CYXUVdtXzyUWhTA1oiO5Kfi5hFBo4A5Fm4MeNo2V1oMyzfOLt8ArbFtJmtdNkXpf
	Iq88EAc3M8ER7J2MiN97XhGO49EuW+mr9xcmAIm/vC8QADexW3sySeARyYAh+V2w72NxfYp2x3F
	PovqS3ClFaxAWPAMAnmdpZGqCvMkHCaCmSbXsw0dJE8e82dao2BRS3dMYPenXGhTuUGwz36ekLb
	vusKsjVd26mluD2A4cGx8ePnqpW5wBco4WEyiV+iI3EyxGZCQKIJ5HeZhA3BPvE6LLeEeZi+HGp
	1MBww0ABKFvm8k/Mrfo8wYXaD2zkfFnECV4i1w0lVZXtgMGeS3gdp3LoD1lf0Rye7pI7GeX4Unr
	ZS3DSWikh2GocirTXL1Lcw8mmEohOD3YVirh1LHxMQKzBBLHMf3ulBSgGfL4QELwsHij9XYjSzI
	Ez08=
X-Received: by 2002:a17:90b:1c88:b0:3a8:495b:d64b with SMTP id 98e67ed59e1d1-3ae8957cff0mr15276654a91.4.1793851918778;
        Wed, 04 Nov 2026 20:11:58 -0800 (PST)
Received: from [172.19.1.51] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b3280378sm1540693a91.12.2026.11.04.20.11.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 20:11:58 -0800 (PST)
Message-ID: <de0bcd11-edfe-471b-a22d-f1e748a7fda6@gmail.com>
Date: Thu, 5 Nov 2026 12:11:45 +0800
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dmaengine: ma35d1-pdma: Add MA35D1 PDMA driver
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, vkoul@kernel.org,
 Frank.Li@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, kees@kernel.org, gustavoars@kernel.org,
 linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20261103022202.2139674-1-shanchun1218@gmail.com>
 <20261103022202.2139674-3-shanchun1218@gmail.com>
 <20261104-airborne-vivid-caterpillar-991425@quoll>
Content-Language: en-US
From: Shan-Chun Hung <shanchun1218@gmail.com>
In-Reply-To: <20261104-airborne-vivid-caterpillar-991425@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Krzysztof,

Thanks for your review.

On 11/4/2026 10:06 PM, Krzysztof Kozlowski wrote:
> On Tue, Nov 03, 2026 at 10:22:02AM +0800, Shan-Chun Hung wrote:
>> +#include <linux/align.h>
>> +#include <linux/bitfield.h>
>> +#include <linux/bits.h>
>> +#include <linux/clk.h>
>> +#include <linux/compiler_types.h>
>> +#include <linux/container_of.h>
>> +#include <linux/dev_printk.h>
>> +#include <linux/device.h>
>> +#include <linux/dma-direction.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/dma/ma35d1-pdma.h>
>> +#include <linux/dmaengine.h>
>> +#include <linux/err.h>
>> +#include <linux/errno.h>
>> +#include <linux/gfp_types.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/irqreturn.h>
>> +#include <linux/limits.h>
>> +#include <linux/list.h>
>> +#include <linux/math.h>
>> +#include <linux/minmax.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_dma.h>
>> +#include <linux/overflow.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/scatterlist.h>
>> +#include <linux/slab.h>
>> +#include <linux/spinlock.h>
>> +#include <linux/spinlock_types.h>
>> +#include <linux/stddef.h>
>> +#include <linux/string.h>
>> +#include <linux/types.h>
> 
> Do you use all these defines?
> 
> I don't see usage of header with bindings, though.
> 
>> +
>> +#include "dmaengine.h"
>> +#include "virt-dma.h"
>> +
> 
> ...
> 
>> +static int ma35d1_pdma_probe(struct platform_device *pdev)
>> +{
>> +	int i, irq, nr_chans, ret;
>> +	struct clk *pdma_clk;
>> +	struct device *dev = &pdev->dev;
>> +	struct device_node *node = dev->of_node;
>> +	struct ma35d1_chan *ch;
>> +	struct ma35d1_pdmadev *pdmadev;
>> +	void __iomem *reg_base;
>> +
>> +	pdma_clk = devm_clk_get_enabled(dev, NULL);
>> +	if (IS_ERR(pdma_clk))
>> +		return dev_err_probe(dev, PTR_ERR(pdma_clk), "Failed to get clk\n");
>> +
>> +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
>> +	if (ret)
>> +		return ret;
>> +
>> +	irq = platform_get_irq(pdev, 0);
>> +	if (irq < 0)
>> +		return irq;
>> +
>> +	ret = of_property_read_u32(node, "dma-channels", &nr_chans);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "Failed to get dma-channels\n");
>> +
>> +	if (nr_chans > PDMA_MAX_CHANS) {
>> +		dev_warn(dev, "dma-channels %d exceeds max %d, clamping\n",
>> +			 nr_chans, PDMA_MAX_CHANS);
>> +		nr_chans = PDMA_MAX_CHANS;
>> +	}
>> +
>> +	pdmadev = devm_kzalloc(dev, struct_size(pdmadev, channels, nr_chans), GFP_KERNEL);
>> +	if (!pdmadev)
>> +		return -ENOMEM;
>> +
>> +	pdmadev->nr_chans = nr_chans;
>> +
>> +	reg_base = devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(reg_base))
>> +		return dev_err_probe(dev, PTR_ERR(reg_base),
>> +				     "Failed to map pdma global registers\n");
>> +
>> +	dma_cap_zero(pdmadev->ddev.cap_mask);
>> +	dma_cap_set(DMA_SLAVE, pdmadev->ddev.cap_mask);
>> +	dma_cap_set(DMA_PRIVATE, pdmadev->ddev.cap_mask);
>> +	dma_cap_set(DMA_MEMCPY, pdmadev->ddev.cap_mask);
>> +	dma_cap_set(DMA_CYCLIC, pdmadev->ddev.cap_mask);
>> +
>> +	pdmadev->ddev.dev = dev;
>> +	pdmadev->ddev.src_addr_widths = PDMA_SLAVE_BUSWIDTHS;
>> +	pdmadev->ddev.dst_addr_widths = PDMA_SLAVE_BUSWIDTHS;
>> +	pdmadev->ddev.directions = BIT(DMA_MEM_TO_DEV) | BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_MEM);
>> +	pdmadev->ddev.device_prep_dma_memcpy = ma35d1_prep_dma_memcpy;
>> +	pdmadev->ddev.device_prep_slave_sg = ma35d1_prep_slave_sg;
>> +	pdmadev->ddev.device_prep_dma_cyclic = ma35d1_prep_dma_cyclic;
>> +	pdmadev->ddev.device_free_chan_resources = ma35d1_free_chan_resources;
>> +	pdmadev->ddev.device_issue_pending = ma35d1_issue_pending;
>> +	pdmadev->ddev.device_tx_status = ma35d1_tx_status;
>> +	pdmadev->ddev.device_config = ma35d1_slave_config;
>> +	pdmadev->ddev.device_terminate_all = ma35d1_terminate_all;
>> +	pdmadev->ddev.device_synchronize = ma35d1_synchronize;
>> +
>> +	spin_lock_init(&pdmadev->lock);
>> +	INIT_LIST_HEAD(&pdmadev->ddev.channels);
>> +	for (i = 0; i < nr_chans; i++) {
>> +		ch = &pdmadev->channels[i];
>> +		ch->dev = dev;
>> +		ch->pdmadev = pdmadev;
>> +		ch->id = i;
>> +		ch->base = reg_base;
>> +		ch->vc.desc_free = ma35d1_pdma_desc_free;
>> +		vchan_init(&ch->vc, &pdmadev->ddev);
>> +	}
>> +
>> +	ret = devm_request_irq(dev, irq, ma35d1_pdma_interrupt, 0, pdev->name, pdmadev);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "Failed to request IRQ\n");
>> +
>> +	ret = dmaenginem_async_device_register(&pdmadev->ddev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = of_dma_controller_register(node, ma35d1_of_xlate, pdmadev);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "of_dma_controller_register failed\n");
>> +
>> +	platform_set_drvdata(pdev, pdmadev);
>> +
>> +	return 0;
>> +}
>> +
>> +static void ma35d1_pdma_remove(struct platform_device *pdev)
>> +{
>> +	struct ma35d1_pdmadev *pdmadev = platform_get_drvdata(pdev);
>> +	int i;
>> +
>> +	of_dma_controller_free(pdev->dev.of_node);
>> +	writel(0, pdmadev->channels[0].base + PDMA_INTEN);
>> +
>> +	for (i = 0; i < pdmadev->nr_chans; i++)
>> +		tasklet_kill(&pdmadev->channels[i].vc.task);
>> +}
>> +
>> +static const struct of_device_id ma35d1_pdma_match[] = {
>> +	{ .compatible = "nuvoton,ma35d1-pdma" },
>> +	{ /* sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(of, ma35d1_pdma_match);
>> +
>> +static struct platform_driver ma35d1_pdma_driver = {
>> +	.probe = ma35d1_pdma_probe,
>> +	.remove = ma35d1_pdma_remove,
>> +	.driver = {
>> +		.name = "ma35d1-pdma",
>> +		.of_match_table = ma35d1_pdma_match,
>> +	},
>> +};
>> +module_platform_driver(ma35d1_pdma_driver);
>> +
>> +MODULE_DESCRIPTION("PDMA controller driver for Nuvoton MA35D1");
>> +MODULE_AUTHOR("Shan-Chun Hung <shanchun1218@gmail.com>");
>> +MODULE_LICENSE("GPL");
>> diff --git a/include/linux/dma/ma35d1-pdma.h b/include/linux/dma/ma35d1-pdma.h
>> new file mode 100644
>> index 000000000000..13f1410d74da
>> --- /dev/null
>> +++ b/include/linux/dma/ma35d1-pdma.h
>> @@ -0,0 +1,24 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +/*
>> + * Header file for the MA35D1 PDMA Controller driver
>> + *
>> + * Copyright (C) 2026 Nuvoton Technology Corp.
>> + */
>> +#ifndef _MA35D1_PDMA_H
>> +#define _MA35D1_PDMA_H
>> +
>> +/**
>> + * struct ma35d1_peripheral - PDMA peripheral configuration
>> + * @prescaler: timeout prescaler value
>> + * @counter: timeout counter value
>> + *
>> + * Slave device drivers fill in this structure and pass it via
>> + * dma_slave_config.peripheral_config/peripheral_size to configure
>> + * the MA35D1 PDMA engine's per-channel timeout detection block.
> 
> Hm? Confusing, how is it supposed to be used? Do you just reimplement
> board files?

Sorry, the comment did not clearly explain the intended usage.

For UART RX DMA, the UART driver calculates the PDMA timeout prescaler 
and counter values based on the current baud rate, then passes them 
through dma_slave_config.peripheral_config to configure the channel's 
timeout detection. These are runtime settings.

However, I understand that passing raw prescaler and counter values 
couples the UART driver to the MA35D1 PDMA register layout. I will 
consider having the UART driver specify the required timeout duration 
and letting the PDMA driver convert it into the hardware settings.

In the next revision, I will remove this timeout configuration interface 
and revisit it together with the UART DMA support patches, so the 
intended usage and client implementation can be reviewed together.
> 
>> + */
>> +struct ma35d1_peripheral {
>> +	unsigned int prescaler;
>> +	unsigned int counter;
>> +};
>> +
>> +#endif /* _MA35D1_PDMA_H */
>> --
>> 2.25.1
>>

Best Regards,
Shan-Chun
