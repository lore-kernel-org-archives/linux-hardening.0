Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14F4375F67
	for <linux-hardening@vger.kernel.org>; Fri,  8 May 2026 09:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778234234; cv=none; b=NeEL3/kEsfsCroziAbtlQRnwWc51VY3hrSgj5w8NYqBHaE4ibBA7tnUJMhzgvLUUhoYjtLcKDGALvRyln46JZ1kDyVcKzUblOFLeMjnLfMzUY0dDDy+h7p+4jNmOReT6weyhjZHdY74wwJRrrVaIGqlNCSffwdoBY7I4pka6rqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778234234; c=relaxed/simple;
	bh=uq6NS3wkYlm6qGia6wNpM+lK5EwUdE7ZVNCYhl3zVL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G4+xKH2HJpvklqxQAhTAxElokAdgEA2HeoTnPQYfqJgkpTZyQo20IZLh6acDaFEqRqcaKCU60FGleMUPLn81CQHbdBRWPnLMkmOXGPvlEfrSsgzywwfJBFXlVYspsruiZt8CNPcbADfmqnvlLykLuCMYk2Rhmj+SCIknXp/fBS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O7Ldkjyt; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O7Ldkjyt"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488ad135063so15851375e9.0
        for <linux-hardening@vger.kernel.org>; Fri, 08 May 2026 02:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778234231; x=1778839031; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KRgaW4hIJFOF/lN2ojaR0wBglA4GTBFExa+lpIIRN6g=;
        b=O7LdkjytGTItJmqe4ZWSlYf8u0zrsvLPQt2yIpSzNvZh0Ko31QgYhKx+rf8zlCm1Fu
         9GGO5f5cNmo4yILIlWpjVhadSGRU9O6HXc8Aeb7W31C7B6DhHg266EgXaOT23dCLwAm5
         VFP8SAX9KHXSDNR5vahrhi16fWjovo6G+OVoC40BWc6X3VQtNwvfch7xxsPhkWIwzCj6
         rdf41Cv16Vv5NhgB7V2NsXCvS5++IG3JhiUM8FrV6XWPztGWBirBdlcLGaWJh3rjbErT
         Qy1cDJARgzOd8U3fVUeVAQ9QaWISspGYMtAhdVdxbPYPG0GjrAruBpOLNhbFK/saPO2f
         jZ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778234231; x=1778839031;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KRgaW4hIJFOF/lN2ojaR0wBglA4GTBFExa+lpIIRN6g=;
        b=MUf/LRA/5m2oVgvqtamevb5wXQSVXt0WFJAam5Ho3Z2E5USoNzkXerK8Te5NYNRPqW
         xsLur5DjVQYqKGtNSeFpmujZTfhx7mGmknlrtcmWtwLgL3YbdkpVcLtyMNcpnCjElNz3
         0B//mX58v6eqt+Y5xD0IVnfX2gQPbEdTET0PCsaonYkF1cES7S0kKveMvr8Swi+PYdlI
         EZznu1tcQ/qCZr1smiZvaxU4H7fWP0UECVu0lgyviriJ61IdCoL1lPgYEcUu9I+4+33P
         GLKFG3ZRTFsqK45aH6U4HiO3gdBtoV0gd8IYMFPgyOK4m1HR3dksdHwFZIEB/upzVysn
         6wRw==
X-Forwarded-Encrypted: i=1; AFNElJ/GA+BEpIUhm3qw8dkzBsNSCJ7l+qJw6STUa9Rqq19y7Z2oylect0s5C/imV+MztBazHo6amcjNnIHVw/X2hmI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1YD4JILBIqj78fF+qmwj2QkZD1QPu1NgyYcqWk0BxnPD7lcot
	GxKAyuzYkbYUDzRENKQhRjET2dHGVCqLIblZhdXxPppHQhXHJvpaWaJGV8DWWUbhgHk=
X-Gm-Gg: AeBDievgljmETq0rC1wN8ZriGOFCM23OCvhZEw5jVKfO2jJ6Y4xecJw74uZMH+cqW/B
	oOxvGqbKnMmw3bcoQ26xy5TTuOlJmBJrXFDQiA5AhQ9w4NPAF+NzIS+nOYWEN8TdQI8uZGWDbUh
	grZMkuehGlYTpwZA0Efz+bHH5D8rCRjsO1eVQ/Rimh+f9LjUy4Wvag7fBFcK12xJl/+XJtc8+hE
	0TWaBIvlnAcP0tl2OWyFXoDkjnvkHlzo4lkVLCDRPxaViPiD5FGSVI1p4F0MKiZa2c+oBJTuYhS
	yki9NQEErr3YD+FVMbHdlTvjef9aYWpLjRODBbmKcgx1bfxWo5qvGyrj0bfw7+yR9BQfMkhphzI
	bCXZNCoB2ZhyAju4wFC9C1R37QgNUzToK3vJ6z5NRt2cmcjwPj3ZipMAerL6RYcujyuaUqP/mgi
	njBdiYpHUWMXqU+ucBv9hGPRWiL7rkYQDBl3JDf5zIk1ggDg==
X-Received: by 2002:a05:600c:4617:b0:48a:5970:1fe1 with SMTP id 5b1f17b1804b1-48e51e0bb17mr106102845e9.4.1778234231006;
        Fri, 08 May 2026 02:57:11 -0700 (PDT)
Received: from [192.168.0.167] ([109.76.20.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e68f5104esm32511305e9.12.2026.05.08.02.57.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2026 02:57:10 -0700 (PDT)
Message-ID: <3c46545a-64e3-49f9-a2db-7de154e92daa@linaro.org>
Date: Fri, 8 May 2026 10:57:08 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/15] media: qcom: camss: Add camss-isp-bufq helper
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Bryan O'Donoghue <bod@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 devicetree@vger.kernel.org, laurent.pinchart@ideasonboard.com,
 kieran.bingham@ideasonboard.com, johannes.goede@oss.qualcomm.com
References: <20260508-camss-isp-ope-v3-0-bb1055274603@oss.qualcomm.com>
 <20260508-camss-isp-ope-v3-4-bb1055274603@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20260508-camss-isp-ope-v3-4-bb1055274603@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07/05/2026 23:49, Loic Poulain wrote:
> Add a per-queue ready-buffer FIFO helper for CAMSS offline ISP drivers.
> camss_isp_bufq provides N spinlock-protected FIFO lists of ready vb2
> buffers, one per queue index. This can help multi-queues management
> and synchronization in ISP context.
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>   drivers/media/platform/qcom/camss/Kconfig          |  14 +++
>   drivers/media/platform/qcom/camss/Makefile         |   5 +
>   drivers/media/platform/qcom/camss/camss-isp-bufq.c | 101 +++++++++++++++++
>   drivers/media/platform/qcom/camss/camss-isp-bufq.h | 122 +++++++++++++++++++++
>   4 files changed, 242 insertions(+)
> 
> diff --git a/drivers/media/platform/qcom/camss/Kconfig b/drivers/media/platform/qcom/camss/Kconfig
> index 4eda48cb1adf049a7fb6cb59b9da3c0870fe57f4..d77482f3f5eadc65856806b9b237d65ea484f267 100644
> --- a/drivers/media/platform/qcom/camss/Kconfig
> +++ b/drivers/media/platform/qcom/camss/Kconfig
> @@ -7,3 +7,17 @@ config VIDEO_QCOM_CAMSS
>   	select VIDEO_V4L2_SUBDEV_API
>   	select VIDEOBUF2_DMA_SG
>   	select V4L2_FWNODE
> +
> +config VIDEO_QCOM_CAMSS_ISP

I think this config option should be dropped entirely.

> +	tristate "Qualcomm CAMSS ISP common helpers"
> +	depends on VIDEO_DEV
> +	depends on MEDIA_CONTROLLER
> +	select V4L2_ISP
> +	select VIDEOBUF2_CORE
> +	help
> +	  Common helper library for Qualcomm CAMSS offline ISP drivers.
> +	  Provides buffer queue management, job scheduling, MC pipeline
> +	  topology builder, and ISP parameter buffer parsing.
> +
> +	  This module is selected automatically by drivers that need it.
> +
> diff --git a/drivers/media/platform/qcom/camss/Makefile b/drivers/media/platform/qcom/camss/Makefile
> index 5e349b4915130c71dbff90e73102e46dfede1520..bfc05db0eada1d801839ceb8a3b157baae613053 100644
> --- a/drivers/media/platform/qcom/camss/Makefile
> +++ b/drivers/media/platform/qcom/camss/Makefile
> @@ -29,3 +29,8 @@ qcom-camss-objs += \
>   		camss-format.o \
>   
>   obj-$(CONFIG_VIDEO_QCOM_CAMSS) += qcom-camss.o
> +
> +qcom-camss-isp-objs := camss-isp-bufq.o
> +
> +obj-$(CONFIG_VIDEO_QCOM_CAMSS_ISP) += qcom-camss-isp.o
> +
> diff --git a/drivers/media/platform/qcom/camss/camss-isp-bufq.c b/drivers/media/platform/qcom/camss/camss-isp-bufq.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..b1dcf60afcc63d112eee7bd143f08a7b4aac9a18
> --- /dev/null
> +++ b/drivers/media/platform/qcom/camss/camss-isp-bufq.c
> @@ -0,0 +1,101 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * camss-isp-bufq.c
> + *
> + * CAMSS ISP per-queue ready-buffer FIFO.
> + *
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +
> +#include "camss-isp-bufq.h"
> +
> +struct camss_isp_bufq *camss_isp_bufq_init(unsigned int num_queues)
> +{
> +	struct camss_isp_bufq *bufq;
> +	unsigned int i;
> +
> +	bufq = kzalloc(struct_size(bufq, entries, num_queues), GFP_KERNEL);
> +	if (!bufq)
> +		return ERR_PTR(-ENOMEM);
> +
> +	bufq->num_queues = num_queues;
> +
> +	for (i = 0; i < num_queues; i++) {
> +		INIT_LIST_HEAD(&bufq->entries[i].rdy_queue);
> +		spin_lock_init(&bufq->entries[i].rdy_spinlock);
> +	}
> +
> +	return bufq;
> +}
> +EXPORT_SYMBOL_GPL(camss_isp_bufq_init);
> +
> +void camss_isp_bufq_release(struct camss_isp_bufq *bufq)
> +{
> +	kfree(bufq);
> +}
> +EXPORT_SYMBOL_GPL(camss_isp_bufq_release);
> +
> +void camss_isp_bufq_queue(struct camss_isp_bufq *bufq, unsigned int queue_idx,
> +			  struct vb2_v4l2_buffer *vbuf)
> +{
> +	struct camss_isp_buf *buf =
> +		container_of(vbuf, struct camss_isp_buf, vb);
> +	struct camss_isp_bufq_entry *entry = &bufq->entries[queue_idx];
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&entry->rdy_spinlock, flags);
> +	list_add_tail(&buf->list, &entry->rdy_queue);
> +	entry->num_rdy++;
> +	spin_unlock_irqrestore(&entry->rdy_spinlock, flags);
> +}
> +EXPORT_SYMBOL_GPL(camss_isp_bufq_queue);
> +
> +struct vb2_v4l2_buffer *camss_isp_bufq_next(struct camss_isp_bufq *bufq, unsigned int queue_idx)
> +{
> +	struct camss_isp_bufq_entry *entry = &bufq->entries[queue_idx];
> +	struct camss_isp_buf *buf;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&entry->rdy_spinlock, flags);
> +	buf = list_first_entry_or_null(&entry->rdy_queue,
> +				       struct camss_isp_buf, list);
> +	spin_unlock_irqrestore(&entry->rdy_spinlock, flags);
> +
> +	return buf ? &buf->vb : NULL;
> +}
> +EXPORT_SYMBOL_GPL(camss_isp_bufq_next);
> +
> +struct vb2_v4l2_buffer *camss_isp_bufq_remove(struct camss_isp_bufq *bufq, unsigned int queue_idx)
> +{
> +	struct camss_isp_bufq_entry *entry = &bufq->entries[queue_idx];
> +	struct camss_isp_buf *buf;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&entry->rdy_spinlock, flags);
> +	buf = list_first_entry_or_null(&entry->rdy_queue,
> +				       struct camss_isp_buf, list);
> +	if (buf) {
> +		list_del(&buf->list);
> +		entry->num_rdy--;
> +	}
> +	spin_unlock_irqrestore(&entry->rdy_spinlock, flags);
> +
> +	return buf ? &buf->vb : NULL;
> +}
> +EXPORT_SYMBOL_GPL(camss_isp_bufq_remove);
> +
> +void camss_isp_bufq_drain(struct camss_isp_bufq *bufq, unsigned int queue_idx,
> +			  enum vb2_buffer_state state)
> +{
> +	struct vb2_v4l2_buffer *vbuf;
> +
> +	while ((vbuf = camss_isp_bufq_remove(bufq, queue_idx)))
> +		camss_isp_buf_done(vbuf, state);
> +}
> +EXPORT_SYMBOL_GPL(camss_isp_bufq_drain);
> +
> +MODULE_DESCRIPTION("CAMSS ISP per-queue ready-buffer FIFO");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/media/platform/qcom/camss/camss-isp-bufq.h b/drivers/media/platform/qcom/camss/camss-isp-bufq.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..1a8bc7b112a1b039233cfc7be573f1f40fcda7c9
> --- /dev/null
> +++ b/drivers/media/platform/qcom/camss/camss-isp-bufq.h
> @@ -0,0 +1,122 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * camss-isp-bufq.h
> + *
> + * CAMSS ISP per-queue ready-buffer FIFO.
> + *
> + * Provides N spinlock-protected FIFO lists of ready vb2 buffers, one per
> + * queue index.  Drivers call these helpers from their vb2 ops and job
> + * completion paths.
> + *
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#ifndef CAMSS_ISP_BUFQ_H
> +#define CAMSS_ISP_BUFQ_H
> +
> +#include <linux/list.h>
> +#include <linux/spinlock.h>
> +#include <linux/types.h>
> +#include <media/videobuf2-v4l2.h>
> +
> +/**
> + * struct camss_isp_buf - vb2 buffer wrapper
> + *
> + * Use as vb2_queue.buf_struct_size so buffers can be placed on the
> + * ready lists managed by camss_isp_bufq.
> + *
> + * @vb:   The vb2 V4L2 buffer — must be first.
> + * @list: Entry in the per-queue ready list.
> + */
> +struct camss_isp_buf {
> +	struct vb2_v4l2_buffer	vb;	/* must be first */
> +	struct list_head	list;
> +};
> +
> +/**
> + * struct camss_isp_bufq_entry - per-queue ready-buffer state (opaque)
> + */
> +struct camss_isp_bufq_entry {
> +	struct list_head	rdy_queue;
> +	spinlock_t		rdy_spinlock;
> +	u32			num_rdy;
> +};
> +
> +/**
> + * struct camss_isp_bufq - multi-queue ready-buffer state
> + *
> + * Allocate with camss_isp_bufq_init(), free with camss_isp_bufq_release().
> + *
> + * @num_queues: Number of entries in @entries.
> + * @entries:    Per-queue state; flexible array.
> + */
> +struct camss_isp_bufq {
> +	unsigned int			num_queues;
> +	struct camss_isp_bufq_entry	entries[] __counted_by(num_queues);
> +};
> +
> +/**
> + * camss_isp_bufq_init() - allocate a multi-queue ready-buffer state
> + * @num_queues: number of per-queue FIFO lists to create
> + *
> + * Returns a pointer to the new bufq or ERR_PTR on allocation failure.
> + */
> +struct camss_isp_bufq *camss_isp_bufq_init(unsigned int num_queues);
> +
> +/**
> + * camss_isp_bufq_release() - free a bufq allocated with camss_isp_bufq_init()
> + * @bufq: bufq to free
> + */
> +void camss_isp_bufq_release(struct camss_isp_bufq *bufq);
> +
> +/**
> + * camss_isp_bufq_queue() - append a buffer to the ready list for @queue_idx
> + * @bufq:      target bufq
> + * @queue_idx: queue index (must be < bufq->num_queues)
> + * @vbuf:      buffer to enqueue; must be embedded in a &struct camss_isp_buf
> + */
> +void camss_isp_bufq_queue(struct camss_isp_bufq *bufq, unsigned int queue_idx,
> +			   struct vb2_v4l2_buffer *vbuf);
> +
> +/**
> + * camss_isp_bufq_next() - peek at the head of the ready list without removing
> + * @bufq:      target bufq
> + * @queue_idx: queue index
> + *
> + * Returns the head buffer or NULL if the list is empty.
> + */
> +struct vb2_v4l2_buffer *camss_isp_bufq_next(struct camss_isp_bufq *bufq,
> +					     unsigned int queue_idx);
> +
> +/**
> + * camss_isp_bufq_remove() - dequeue and return the head of the ready list
> + * @bufq:      target bufq
> + * @queue_idx: queue index
> + *
> + * Returns the dequeued buffer or NULL if the list is empty.
> + */
> +struct vb2_v4l2_buffer *camss_isp_bufq_remove(struct camss_isp_bufq *bufq,
> +					       unsigned int queue_idx);
> +
> +/**
> + * camss_isp_bufq_drain() - return all ready buffers with the given state
> + * @bufq:      target bufq
> + * @queue_idx: queue index
> + * @state:     vb2 state to pass to vb2_buffer_done() for each buffer
> + */
> +void camss_isp_bufq_drain(struct camss_isp_bufq *bufq, unsigned int queue_idx,
> +			   enum vb2_buffer_state state);
> +
> +static inline u32 camss_isp_bufq_num_ready(struct camss_isp_bufq *bufq,
> +					    unsigned int queue_idx)
> +{
> +	return bufq->entries[queue_idx].num_rdy;
> +}
> +
> +static inline void camss_isp_buf_done(struct vb2_v4l2_buffer *vbuf,
> +				       enum vb2_buffer_state state)
> +{
> +	vb2_buffer_done(&vbuf->vb2_buf, state);
> +}
> +
> +#endif /* CAMSS_ISP_BUFQ_H */
> 

I honsestly don't think patches 4,5 and 6 are necessary and TBH they 
look at least partially generated to me.

Several LLM patterns abound - em - dash and (parenthetical style) as an 
example.

I just wonder is all of this code really necessary ? You could do all of 
this locking in the OPE itself and save ~200 LOC.

I think in the previous cycle we discussed articulating some of these 
concepts in v4l2 itself - I think you could achieve what you want to do 
here with a struct list_head and a spinlock_t in the OPE driver context.

---
bod
