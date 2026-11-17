Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794899114;
	b=NzX/iEK2DSd1KC2KkIgndpDuKxzx4v8HUTIIUrX5vyf3+g1FaPq+C/MFEOAgSj0pWynG
	 taymKlLuUDUTGXsFoqb3SH6YkrJKHxhrIulGkOzz5pzVR2/ZAD8cXh4nR/kUnRSIomczR
	 fDxeoc31NFPRneUysem6im/6ylrJ/zPZkq6kiM9fEWF3P2eu7J1vzsYLPC2T9VT9KsQky
	 XfY7/qx/GsX9ETS1hQo77RHzgByoVTPUzCMHAn7S4TEd6AToOTLY/sXMfDuRoGlUlV8KF
	 PMYUmDu+xioq8rU5iNrHZ+eCvnRf/LiIS3jRQM06we10teNOZX1JyhniEp/0euhFrbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794899114;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=yREBUehJP9kZv0aqNbOFx6DIC/LJcLkZgW3MOZiPYBQ=;
	b=OmdRJNsj4hKnUNPBWdnvKJPFr0TH2jNdMzkCgpX6Warc4ffexA96i/LI883qVUpIG+yP
	 /2VLS4rpmPTnTL6MOe5yr3R3eQN2xKo3MfIP9RdCTmBFjNLTuCh3yj7j5EJjvJSAXl9sq
	 KKBk0VJLJOQ8885QH7VVLvQqKf6HLbYIGqC1Bi46QLJH9gNmw+yPcDsxQo2rj+5fD6T5u
	 LFaPPDZ6AxnboxIClTzKpApQoIj0miaH68fa6BCODC8b2RX5o5rwu3ckEINhYucKhk7TS
	 pFnoo7VkNBsD39ZZ6oxPy63mNJMFXKKCFto2YSK4Scz/dIj1ErOd85GqXNCVj1T9M1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0vMpXKDm;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F1D606A32A
	for <linux-hardening@vger.kernel.org>; Tue, 17 Nov 2026 07:05:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78F1D606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0vMpXKDm
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc4aa18f9afso1868482a12.3
        for <linux-hardening@vger.kernel.org>; Mon, 16 Nov 2026 23:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794899112; x=1795503912; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yREBUehJP9kZv0aqNbOFx6DIC/LJcLkZgW3MOZiPYBQ=;
        b=0vMpXKDmWrWSnUTCqI+tnT+VSVx6ybmG5WdvEc3g0F8DOg1ic4zSf1B0RNdyk2cgUB
         YQBSLGSD9eicsOHS98cRxUq4IgqgGejQES70AUqL1ctm/CvQWCUXGO+07aqasQooJMbA
         qaPqnoakiCcbxxqL41uGkxWjGy9OK0eSOUZZOkoB5nKCAmHXg/vy2Dd/Ul+8nWYwxB++
         Jfjj/recsG+lOJLJQT8lJbsmpMOOzkburXvwEbLMkUf/9LmLN16dX0xwtcgZUGZuPOLA
         LEIG82WLBb/vxKL0rw8V1qpTwF0mq4wf4US8TyTU2rCgEun1U+4Zb6yCY3LwYcid3hd+
         3mRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794899112; x=1795503912;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yREBUehJP9kZv0aqNbOFx6DIC/LJcLkZgW3MOZiPYBQ=;
        b=jwqRgJwCUxlRRa/LZV2CzOp/Kn1Gyq3goj2RVwgxdkTtduMZYu0NYVmwYGa5hFRAdc
         G8qT0Bpp2konUYlz6oxu3wQ5LKeagcwP5mQ3lEI+tnLlXwLBK6r59vcHM59LSy1YTP7R
         kvh3rydVL48UV10Bi7jcBWAjykoO5f2tiQikQ3Spt0qapFHnZar7PI8NTA8sGd3GNsSe
         2RTFujPYYVBw7Kf65ltYsDZ3F0v5I9lA3mmhhPOu84Wr/fsfUTCtcv++bzMsWoIt7Vsy
         3pRJ89IEftRAWZxOKMLU5b4uB+hA1nK/DSdFeZpA0qGs4LwLod75qpTcHOm+iFmpeD/C
         nnLQ==
X-Forwarded-Encrypted: i=1; AL+hErFFVA4YAiwOro0YRqgKquphWhk08aCrpHAIduO9YY0WZYHWiq+riymzIAQ/mQRmY1F0G/2XKB+CjB2WS97vJ2M=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Bem6CZHe4ez3NpJjboq4UYT/JnvO7qyVx1DdAhb/OtegCNz6m
	mz7MpwWEmdIXFfeDrz9ESfq0R+SbyjGbA2KVPCYeR8hqbD7idjv4ro9E
X-Gm-Gg: AYBFou22h7xEx0WKCXqp0B//+nqQ55x04z1e3hHIZAb4ROjFYmNlvmaAuDH0YIV9GLt
	jYrN5Cz761DymH8gGTi85No6HaT42qC0k2XfE9PNUyt7G593KEPlEsuCQA0Luf38y3ZY2oJKkoU
	CSdcOCqPBWS78tnUhxGq7OPr7eHMkzAYsu+OLc7ctaMkatNuW/Mf9s10NacZAUiK3XdK/MY941l
	J4gwL3edZDBXbIrqZHphKh/LkgYJqlUkMqzdixNz07HokGoxYFAYZtrD4DURLb6iVHN6nO9cT9Q
	Uct4AR94B3lBDdlN+G+k5juIoz8awsddPd9Gf5sy/BXoMlqQj7SodpubUZ1vTaJ0DJWyc/UAA4s
	yiIKD29GciDlVGbaAMyNM6O4I7rg49Nkt4nFbb6p2T2d7Nhu9boXk4zI7+9xowISB6LWSpaPz2F
	EazyYyKbxhby4sHMdxNItTGTb/lKLmf3rclYh1KVYEYAy1d6KXciFxFLp1YKN7QwRzWrOAiWt6J
	u8hZ9bnM/jRsR1xpwqzWd37DT66ZXUm+x7wMOTF9zlf+YmHVwreCwwAmNRP/iZPMHajMx+QWDoL
	haC8xm9HJDnZ0WHkrqAHCBxD0ZVdGy0at5BntralAob6N0nz6pIjL04HvSWn+K6+T+2v+KAGNC/
	d1YpE
X-Received: by 2002:a05:6a20:4304:b0:3fb:5869:81f1 with SMTP id adf61e73a8af0-3fb5878d154mr5449447637.26.1794899112171;
        Mon, 16 Nov 2026 23:05:12 -0800 (PST)
Received: from [172.19.1.51] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed12a902esm4641003b3a.16.2026.11.16.23.05.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 23:05:11 -0800 (PST)
Message-ID: <17673b43-7975-41ac-8c0d-8fa12befa7a6@gmail.com>
Date: Tue, 17 Nov 2026 15:04:52 +0800
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
Subject: Re: [PATCH v2 2/2] dmaengine: ma35d1-pdma: Add MA35D1 PDMA driver
To: Frank Li <Frank.li@oss.nxp.com>
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, vkoul@kernel.org,
 Frank.Li@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, kees@kernel.org, gustavoars@kernel.org,
 linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20261109052900.2960473-1-shanchun1218@gmail.com>
 <20261109052900.2960473-3-shanchun1218@gmail.com>
 <avtyLPRZB3uC5G_A@SMW015318>
Content-Language: en-US
From: Shan-Chun Hung <shanchun1218@gmail.com>
In-Reply-To: <avtyLPRZB3uC5G_A@SMW015318>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Frank,

Thanks for your review.

On 11/17/2026 5:14 AM, Frank Li wrote:
> On Mon, Nov 09, 2026 at 01:29:00PM +0800, Shan-Chun Hung wrote:
>> Add a driver for the PDMA controller found in the Nuvoton MA35D1 SoC.
>> It supports up to 10 channels with memory-to-memory, slave scatter-gather
>> and cyclic transfers.
>>
>> Signed-off-by: Shan-Chun Hung <shanchun1218@gmail.com>
>> ---
> ...
>> +
>> +static struct ma35d1_desc *ma35d1_desc_alloc(struct ma35d1_chan *ch, u32 sg_len)
>> +{
>> +	struct ma35d1_desc *d;
>> +
>> +	d = kzalloc(struct_size(d, sg, sg_len), GFP_ATOMIC);
>> +	if (!d)
>> +		return NULL;
> 
> Generally, we use dma_alloc_coherence() or dma pool for desc. There are
> extra complex if use kzalloc and dma_map_single(), which will cause second
> bounce buffer at swiotlb.
I will use dma_alloc_coherent() for the hardware descriptors.
> 
>> +
>> +	d->sg_len = sg_len;
>> +	d->dma_len = sizeof(*d->sg) * sg_len;
>> +	d->dma_addr = dma_map_single(ch->dev, d->sg, d->dma_len, DMA_TO_DEVICE);
>> +	if (dma_mapping_error(ch->dev, d->dma_addr)) {
>> +		dev_err(ch->dev, "dma mapping error for channel\n");
>> +		kfree(d);
>> +		return NULL;
>> +	}
>> +
>> +	return d;
>> +}
>> +
>> +static struct dma_async_tx_descriptor *
>> +ma35d1_desc_submit(struct ma35d1_chan *ch, struct ma35d1_desc *d, bool cyclic,
>> +		   unsigned long tx_flags)
>> +{
>> +	dma_sync_single_for_device(ch->dev, d->dma_addr, d->dma_len, DMA_TO_DEVICE);
>> +	d->cyclic = cyclic;
>> +	d->ch = ch;
>> +
>> +	return vchan_tx_prep(&ch->vc, &d->vd, tx_flags);
>> +}
>> +
>> +static struct dma_async_tx_descriptor *
>> +ma35d1_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dst, dma_addr_t src,
>> +		       size_t len, unsigned long tx_flags)
>> +{
>> +	int i;
>> +	size_t tlen, max_chunk;
>> +	struct ma35d1_chan *ch = to_ma35d1_pdma_chan(chan);
>> +	struct ma35d1_desc *d;
>> +	u32 sg_len, width = 1;
>> +
>> +	if (ch->request != 0) {
>> +		dev_err(ch->dev, "%s: channel is bound to a peripheral request\n", __func__);
>> +		return NULL;
>> +	}
>> +
>> +	if (!len) {
>> +		dev_err(ch->dev, "invalid memcpy length\n");
>> +		return NULL;
>> +	}
>> +
>> +	if (IS_ALIGNED(src, 4) && IS_ALIGNED(dst, 4) && IS_ALIGNED(len, 4))
>> +		width = 4;
> 
> where are field copy_align, you check it here.

The controller supports byte-wide transfers, so the minimum alignment
is one byte. I will set copy_align to DMAENGINE_ALIGN_1_BYTE explicitly.

The check selects a 4-byte transfer width when the source, destination,
and length are aligned; otherwise, the driver uses a 1-byte width.
> 
>> +
>> +	max_chunk = (size_t)PDMA_MAX_CHAN_BEATS * width;
>> +
>> +	sg_len = DIV_ROUND_UP_ULL(len, max_chunk);
>> +	d = ma35d1_desc_alloc(ch, sg_len);
>> +	if (!d)
>> +		return NULL;
>> +
>> +	for (i = 0; i < sg_len; i++) {
>> +		tlen = min_t(size_t, len, max_chunk);
>> +		d->sg[i].src = src;
>> +		d->sg[i].dst = dst;
>> +		d->sg[i].ctl = PDMA_WIDTH(width) | PDMA_TXCNT(tlen / width) | PDMA_TBINTDIS |
>> +				PDMA_OP_SCATTER;
>> +		d->sg[i].next = d->dma_addr + PDMA_CH_OFFSET(i + 1);
>> +		src += tlen;
>> +		dst += tlen;
>> +		len -= tlen;
>> +	}
>> +	d->sg[sg_len - 1].ctl &= ~(PDMA_OP_MSK | PDMA_TBINTDIS);
>> +	d->sg[sg_len - 1].ctl |= PDMA_OP_BASIC;
>> +
>> +	return ma35d1_desc_submit(ch, d, false, tx_flags);
> 
> Prep() don't submit request, dmaengine_submit() do it, move it submit()
> call back.
The prep function does not submit the descriptor.
ma35d1_desc_prep_done() (renamed from ma35d1_desc_submit()) prepares
the descriptor and calls vchan_tx_prep(), which sets tx_submit to
vchan_tx_submit. The actual submission happens when the client calls
dmaengine_submit().

I renamed the helper to avoid confusion; there is no functional change.
> 
>> +}
>> +
>> +static struct dma_async_tx_descriptor *
>> +ma35d1_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
>> +		     u32 sg_len, enum dma_transfer_direction dir,
>> +		     unsigned long tx_flags, void *context)
>> +{
>> +	int i, width;
>> +	struct ma35d1_chan *ch = to_ma35d1_pdma_chan(chan);
>> +	struct ma35d1_desc *d;
>> +	struct scatterlist *sgent;
>> +
>> +	width = ma35d1_slave_width(ch, dir);
>> +	if (width < 0)
>> +		return NULL;
>> +
>> +	if (!sg_len) {
>> +		dev_err(ch->dev, "SG entry length is zero\n");
>> +		return NULL;
>> +	}
>> +
>> +	for_each_sg(sgl, sgent, sg_len, i) {
>> +		unsigned int len = sg_dma_len(sgent);
>> +
>> +		if (!len || len % width || len / width > PDMA_MAX_CHAN_BEATS) {
>> +			dev_err(ch->dev, "invalid SG segment length %u\n", len);
>> +			return NULL;
>> +		}
>> +
>> +		if (!IS_ALIGNED(sg_dma_address(sgent), width)) {
>> +			dev_err(ch->dev, "SG address not aligned to DMA width\n");
>> +			return NULL;
>> +		}
>> +	}
>> +
>> +	d = ma35d1_desc_alloc(ch, sg_len);
>> +	if (!d)
>> +		return NULL;
>> +
>> +	for_each_sg(sgl, sgent, sg_len, i) {
>> +		if (dir == DMA_MEM_TO_DEV) {
>> +			d->sg[i].ctl = PDMA_WIDTH(width) | PDMA_DAFIX;
>> +			d->sg[i].src = sg_dma_address(sgent);
>> +			d->sg[i].dst = ch->cfg.dst_addr;
>> +		} else {
>> +			d->sg[i].ctl = PDMA_WIDTH(width) | PDMA_SAFIX;
>> +			d->sg[i].src = ch->cfg.src_addr;
>> +			d->sg[i].dst = sg_dma_address(sgent);
>> +		}
>> +		d->sg[i].ctl |= PDMA_TXCNT(sg_dma_len(sgent) / width) | PDMA_TBINTDIS |
>> +				PDMA_TXTYPE | PDMA_OP_SCATTER;
>> +		d->sg[i].next = d->dma_addr + PDMA_CH_OFFSET(i + 1);
>> +	}
>> +
>> +	d->sg[sg_len - 1].ctl &= ~(PDMA_OP_MSK | PDMA_TBINTDIS);
>> +	d->sg[sg_len - 1].ctl |= PDMA_OP_BASIC;
>> +
>> +	return ma35d1_desc_submit(ch, d, false, tx_flags);
>> +}
>> +
>> +static struct dma_async_tx_descriptor *
>> +ma35d1_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t dma_addr, size_t buf_len,
>> +		       size_t period_len, enum dma_transfer_direction dir,
>> +		       unsigned long flags)
>> +{
>> +	int i, sg_len, width;
>> +	size_t offset = 0;
>> +	struct ma35d1_chan *ch = to_ma35d1_pdma_chan(chan);
>> +	struct ma35d1_desc *d;
>> +
>> +	width = ma35d1_slave_width(ch, dir);
>> +	if (width < 0)
>> +		return NULL;
>> +
>> +	if (!buf_len || !period_len || period_len / width > PDMA_MAX_CHAN_BEATS) {
>> +		dev_err(ch->dev, "Invalid buffer/period length\n");
>> +		return NULL;
>> +	}
>> +
>> +	if (buf_len % period_len) {
>> +		dev_err(ch->dev, "Buffer length not multiple of period length\n");
>> +		return NULL;
>> +	}
>> +
>> +	if (period_len % width) {
>> +		dev_err(ch->dev, "Period length must be a multiple of DMA width\n");
>> +		return NULL;
>> +	}
>> +
>> +	if (!IS_ALIGNED(dma_addr, width)) {
>> +		dev_err(ch->dev, "Buffer address not aligned to DMA width\n");
>> +		return NULL;
>> +	}
>> +
>> +	sg_len = buf_len / period_len;
>> +	d = ma35d1_desc_alloc(ch, sg_len);
>> +	if (!d)
>> +		return NULL;
>> +
>> +	/* Split the buffer into period size chunks. */
>> +	for (offset = 0, i = 0; offset < buf_len; offset += period_len, i++) {
>> +		if (dir == DMA_MEM_TO_DEV) {
>> +			d->sg[i].ctl = PDMA_WIDTH(width) | PDMA_TXCNT(period_len / width) |
>> +					PDMA_DAFIX;
>> +			d->sg[i].src = dma_addr + offset;
>> +			d->sg[i].dst = ch->cfg.dst_addr;
>> +		} else {
>> +			d->sg[i].ctl = PDMA_WIDTH(width) | PDMA_TXCNT(period_len / width) |
>> +					PDMA_SAFIX;
>> +			d->sg[i].src = ch->cfg.src_addr;
>> +			d->sg[i].dst = dma_addr + offset;
>> +		}
>> +		d->sg[i].ctl |= PDMA_TXTYPE | PDMA_OP_SCATTER;
>> +		d->sg[i].next = d->dma_addr + PDMA_CH_OFFSET(i + 1);
>> +	}
>> +	d->sg[sg_len - 1].next = d->dma_addr;
>> +
>> +	return ma35d1_desc_submit(ch, d, true, flags);
>> +}
>> +
>> +static struct dma_chan *ma35d1_of_xlate(struct of_phandle_args *dma_spec, struct of_dma *of)
>> +{
>> +	struct ma35d1_pdmadev *pdmadev = of->of_dma_data;
>> +	struct dma_chan *chan;
>> +	unsigned int chan_id, reqsel;
>> +
>> +	if (dma_spec->args_count != 2)
>> +		return NULL;
>> +
>> +	chan_id = dma_spec->args[0];
>> +	reqsel = dma_spec->args[1];
>> +	if (chan_id >= PDMA_MAX_CHANS || reqsel > GENMASK(7, 0))
>> +		return NULL;
>> +
>> +	chan = dma_get_slave_channel(&pdmadev->channels[chan_id].vc.chan);
>> +	if (chan)
>> +		pdmadev->channels[chan_id].request = reqsel;
>> +
>> +	return chan;
>> +}
>> +
>> +static void ma35d1_free_chan_resources(struct dma_chan *chan)
>> +{
>> +	struct ma35d1_chan *ch = to_ma35d1_pdma_chan(chan);
>> +
>> +	ma35d1_terminate_all(chan);
>> +	vchan_free_chan_resources(&ch->vc);
>> +	ch->request = 0;
>> +	memset(&ch->cfg, 0, sizeof(ch->cfg));
>> +}
>> +
>> +static void ma35d1_pdma_start(struct ma35d1_chan *ch)
>> +{
>> +	struct ma35d1_desc *d = ch->desc;
>> +
>> +	if (d->sg_len == 1 && !d->cyclic) {
>> +		writel(d->sg[0].src, ch->base + PDMA_CH_OFFSET(ch->id) + PDMA_DSCT_SA);
>> +		writel(d->sg[0].dst, ch->base + PDMA_CH_OFFSET(ch->id) + PDMA_DSCT_DA);
>> +		writel(d->sg[0].ctl, ch->base + PDMA_CH_OFFSET(ch->id) + PDMA_DSCT_CTL);
>> +	} else {
>> +		writel(d->dma_addr, ch->base + PDMA_CH_OFFSET(ch->id) + PDMA_DSCT_NEXT);
>> +		ma35d1_pdma_reg_clear(ch, PDMA_CH_OFFSET(ch->id) + PDMA_DSCT_CTL, PDMA_OP_MSK);
>> +		ma35d1_pdma_reg_set(ch, PDMA_CH_OFFSET(ch->id) + PDMA_DSCT_CTL, PDMA_OP_SCATTER);
>> +	}
>> +
>> +	/* Memory-to-memory has no peripheral request, so trigger it by software. */
>> +	if (ch->request == 0)
>> +		writel(BIT(ch->id), ch->base + PDMA_SWREQ);
>> +}
>> +
>> +static void ma35d1_pdma_start_desc(struct dma_chan *chan)
>> +{
>> +	struct ma35d1_chan *ch = to_ma35d1_pdma_chan(chan);
>> +	struct virt_dma_desc *vd;
>> +
>> +	vd = vchan_next_desc(&ch->vc);
>> +	if (!vd) {
>> +		ch->desc = NULL;
>> +		return;
>> +	}
>> +
>> +	list_del(&vd->node);
>> +	ch->desc = to_ma35d1_pdma_desc(vd);
>> +	ma35d1_pdma_setup_channel(ch);
>> +	ma35d1_pdma_start(ch);
>> +}
>> +
>> +static void ma35d1_issue_pending(struct dma_chan *chan)
>> +{
>> +	struct ma35d1_chan *ch = to_ma35d1_pdma_chan(chan);
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&ch->vc.lock, flags);
>> +
>> +	if (vchan_issue_pending(&ch->vc) && !ch->desc)
>> +		ma35d1_pdma_start_desc(chan);
>> +
>> +	spin_unlock_irqrestore(&ch->vc.lock, flags);
>> +}
>> +
>> +static void ma35d1_pdma_complete(struct ma35d1_chan *ch)
>> +{
>> +	if (!ch->desc)
>> +		return;
>> +
>> +	vchan_cookie_complete(&ch->desc->vd);
>> +	ma35d1_pdma_start_desc(&ch->vc.chan);
>> +}
>> +
>> +static irqreturn_t ma35d1_pdma_interrupt(int irq, void *devid)
>> +{
>> +	int i;
>> +	bool handled = false;
>> +	struct ma35d1_pdmadev *pdmadev = devid;
>> +	struct ma35d1_chan *ch;
>> +
>> +	for (i = 0; i < PDMA_MAX_CHANS; i++) {
>> +		unsigned long flags;
>> +		bool done, abort;
>> +
>> +		ch = &pdmadev->channels[i];
>> +
>> +		spin_lock_irqsave(&ch->vc.lock, flags);
>> +
>> +		done = readl(ch->base + PDMA_TDSTS) & BIT(i);
>> +		abort = readl(ch->base + PDMA_ABTSTS) & BIT(i);
>> +
>> +		if (done || abort) {
>> +			handled = true;
>> +
>> +			/* Ack both flags first so a new descriptor is not completed twice. */
>> +			writel(BIT(i), ch->base + PDMA_TDSTS);
>> +			writel(BIT(i), ch->base + PDMA_ABTSTS);
> 
> 
> done = readl(ch->base + PDMA_TDSTS);
> abort = readl(ch->base + PDMA_ABTSTS);
> writel(done, ch->base + PDMA_TDSTS);
> writel(abort, ch->base + PDMA_ABTSTS);
> 
> for_each_bit(done | abort) {
> 	...
> }
I will update the interrupt handler accordingly.>
>> +
>> +			if (ch->desc) {
>> +				if (abort) {
>> +					ch->desc->vd.tx_result.result = DMA_TRANS_ABORTED;
>> +					ma35d1_pdma_complete(ch);
>> +				} else if (ch->desc->cyclic) {
>> +					vchan_cyclic_callback(&ch->desc->vd);
>> +				} else {
>> +					ma35d1_pdma_complete(ch);
>> +				}
>> +			}
>> +		}
>> +
>> +		spin_unlock_irqrestore(&ch->vc.lock, flags);
>> +	}
>> +
>> +	return handled ? IRQ_HANDLED : IRQ_NONE;
>> +}
>> +
>> +static int ma35d1_pdma_probe(struct platform_device *pdev)
>> +{
>> +	int i, ret;
>> +	struct clk *pdma_clk;
>> +	struct reset_control *rst;
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
>> +	rst = devm_reset_control_get_optional_exclusive_deasserted(dev, NULL);
>> +	if (IS_ERR(rst))
>> +		return dev_err_probe(dev, PTR_ERR(rst), "Failed to get reset\n");
>> +
>> +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
>> +	if (ret)
>> +		return ret;
>> +
>> +	pdmadev = devm_kzalloc(dev, sizeof(*pdmadev), GFP_KERNEL);
>> +	if (!pdmadev)
>> +		return -ENOMEM;
>> +
>> +	pdmadev->irq = platform_get_irq(pdev, 0);
>> +	if (pdmadev->irq < 0)
>> +		return pdmadev->irq;
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
>> +	pdmadev->ddev.device_tx_status = dma_cookie_status;
>> +	pdmadev->ddev.device_config = ma35d1_slave_config;
>> +	pdmadev->ddev.device_terminate_all = ma35d1_terminate_all;
>> +	pdmadev->ddev.device_synchronize = ma35d1_synchronize;
>> +
>> +	spin_lock_init(&pdmadev->lock);
>> +	INIT_LIST_HEAD(&pdmadev->ddev.channels);
>> +	for (i = 0; i < PDMA_MAX_CHANS; i++) {
>> +		ch = &pdmadev->channels[i];
>> +		ch->dev = dev;
>> +		ch->pdmadev = pdmadev;
>> +		ch->id = i;
>> +		ch->base = reg_base;
>> +		ch->vc.desc_free = ma35d1_pdma_desc_free;
>> +		vchan_init(&ch->vc, &pdmadev->ddev);
>> +	}
>> +
>> +	ret = devm_request_irq(dev, pdmadev->irq, ma35d1_pdma_interrupt, 0, pdev->name, pdmadev);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "Failed to request IRQ\n");
> 
> Move irq request after register device()
I will move the IRQ request after register device().
> 
>> +
>> +	platform_set_drvdata(pdev, pdmadev);
>> +
>> +	ret = dma_async_device_register(&pdmadev->ddev);
> 
> dmaenginem_async_device_register();
I will use dmaenginem_async_device_register().
> 
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = of_dma_controller_register(node, ma35d1_of_xlate, pdmadev);
> 
> devm_of_dma_controller_register();
I will use devm_of_dma_controller_register().
> 
> Frank
> 
>> +	if (ret) {
>> +		dma_async_device_unregister(&pdmadev->ddev);
>> +		for (i = 0; i < PDMA_MAX_CHANS; i++)
>> +			tasklet_kill(&pdmadev->channels[i].vc.task);
>> +		return dev_err_probe(dev, ret, "of_dma_controller_register failed\n");
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void ma35d1_pdma_remove(struct platform_device *pdev)
>> +{
>> +	struct ma35d1_pdmadev *pdmadev = platform_get_drvdata(pdev);
>> +	void __iomem *base = pdmadev->channels[0].base;
>> +	int i;
>> +
>> +	/* Stop new requests before the hardware is quiesced. */
>> +	of_dma_controller_free(pdev->dev.of_node);
>> +	dma_async_device_unregister(&pdmadev->ddev);
>> +
>> +	writel(0, base + PDMA_CHCTL);
>> +	writel(0, base + PDMA_INTEN);
>> +	synchronize_irq(pdmadev->irq);
>> +
>> +	for (i = 0; i < PDMA_MAX_CHANS; i++)
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
>> --
>> 2.25.1
>>

Best Regards,
Shan-Chun
