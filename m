Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794439649;
	b=ZrRfPCpYShvh0I1mu5yeSZl6QMP80cUvrVb8Qib/ZfB0PewRK31/oAPjA65fJtum+dLF
	 JI51e2L6g5b/qxbBvKToN1akmWtQ/i2Ecmqjes59nB3fS2Mz4ON4LcfpooI8ssIxZ9zmQ
	 UyG+DDFkqiM0U2HVl3x3nCumugydM4yEdOAR3xOH/4YQ5fF/8JNQUduMavxcRckjBmL7f
	 raLlUphD/r0GGrrR/YCTVm1qmV4xWuKJl1XasxLsWO4WObiQSXNOUyjc3vCRvQlgCaw4x
	 1gLO1dIiTgapgGNWHVLtLY5VZtM3rP2a62U0+18izYZ9o+0Zo1hLwmuKnbkxeYaP5Sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794439649;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=l3ncA7LGC0e8S60f6Aii7X3fJT4GkRwmt3Q/dedOq/0=;
	b=HtYRuUywFHdd/yeukywwTX2DN5rw03ujd+9YItnVUImAULs2tQnZHD0ExxnOMom2i2PJ
	 zp0nCT+TEaU58Ki86RQqk/wyeFT/pwwLGzTYZfMjIjVdFglUHV5G1/CjqDO36hz9JIsd/
	 NMcDgynfChWesgy4xUw4ARCcrgJ9zJlr3GM3bn1aXJ0sAd1XjFeSalt4/rKg+xGI28t0w
	 ZhjDdPDv0ik82hNqsr9cYOiESqO/90caXR66ixRJpMjmP4xLbZ8ctdHCaYflNjLuJevPY
	 026qz4n46rD8uwxvPvSsUXtnTuT6aNArXMAaDdKkJWiXTCFuA6dYiyiL1BmA5Rsx8sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=m3oPiefK;
	arc=none smtp.remote-ip=209.85.210.71
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717C3606A334
	for <linux-hardening@vger.kernel.org>; Wed, 11 Nov 2026 23:27:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 717C3606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=m3oPiefK
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-85f39501878so4749269a34.1
        for <linux-hardening@vger.kernel.org>; Wed, 11 Nov 2026 15:27:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794439647; x=1795044447; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l3ncA7LGC0e8S60f6Aii7X3fJT4GkRwmt3Q/dedOq/0=;
        b=m3oPiefKK1pKNC1ByZp+CXLtguk52lx3tFmKkDLzRxnW2ziQO1e7nwERWF0O++DoaM
         DBil3J92yz5eO8nWIXRIFFQs2SnwU27FC0s0xcywJek3tgeb92DrIYoLHbKkp9/sLqo7
         W92iZI+qpSCm3StXd5Foqhvo6NMJ//IsqYGlPyGXzBa9EIaLtbCadT6935bd9YxWR4X7
         YzQxVqH3jCrkZjGe/cm0dpVdShRlJc2McL67UEAYvFd51oJ1Z5PIbINQciNLla9oAebb
         yh3jgtSDjBYWuDG1/dP0T9eCHun8+1or8gEJHXVs9vC5iqafDiryJd8GmIszleNBR7Qt
         2LgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794439647; x=1795044447;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l3ncA7LGC0e8S60f6Aii7X3fJT4GkRwmt3Q/dedOq/0=;
        b=wfTCpzJ72cmqx14KacZaxXbYWDUhJ5FoshKZ0ZbuLLQAnmzeoqjuW76Nr9HAZvBRaX
         Ur/2WJfcIuR/xCKfqRxhNoXTlZwA3QQV1yGAegL2eDQfihum/GWTu8DThXEJJ37gGo6g
         p9QlAA2HIhOT8b6RcV2NWx/a0hEQ9o/c7O419zY/x5Nx35t9OUFcXfsBkeqzbxwQYbvQ
         7WbLx2LEtp86kQNQ1/Mj2y26fe9EU5WMrFmzV0re3M1tL9r31/0E3Cc6OBqrifI9PMwe
         kmibufUZVKTshxI9pQFQXwx+rZuUxADeKywoqPD7Rm4yDA4a0EFOoqzyNy70sWb7Fuei
         pIDQ==
X-Forwarded-Encrypted: i=1; AL+hErFR1AB/UeEznuugNL36GLM4GfRuSc+Jq2nvOQP03eHP7S4975QKbVEd0/a/R8maufure0DxEPHBqsoL1yvZDOQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/e2FwqlfNd+hs/tISv8oZHw6aTxC1544upScRQUz7XHjhZe+F3
	ZdhVXu209IkGnaQ44Y2bhJjw1aldOQxhSikuRltuBof8PtRzTrCA9Id3fUzf3gPkWGnuuw+YMzp
	qC0cMjW8peZ7TDmTkNFndLL46ww==
X-Received: from ioz8.prod.google.com ([2002:a05:6602:20c8:b0:9c7:7bc8:8c7b])
 (user=justinstitt job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:2388:b0:517:dd67:aeb7 with SMTP id 5614622812f47-56b97e2b6cbmr3870593b6e.56.1794439646997;
 Wed, 11 Nov 2026 15:27:26 -0800 (PST)
Date: Wed, 11 Nov 2026 15:27:25 -0800
In-Reply-To: <20261105084518.386234-1-nikitash.mariiaw@gmail.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261105084518.386234-1-nikitash.mariiaw@gmail.com>
Message-ID: <avT5yrP3PYemJNCI@google.com>
Subject: Re: [PATCH] media: verisilicon: Replace strlcat() with seq_buf
From: Justin Stitt <justinstitt@google.com>
To: Mariia Nikitash <nikitash.mariiaw@gmail.com>
Cc: nicolas.dufresne@collabora.com, benjamin.gaignard@collabora.com, 
	p.zabel@pengutronix.de, mchehab@kernel.org, linux-media@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, kees@kernel.org, morbo@google.com
Content-Type: text/plain; charset="us-ascii"

Hi,

On Thu, Nov 05, 2026 at 12:45:18AM -0800, Mariia Nikitash wrote:
> In preparation for removing the deprecated strlcat() API[1], replace
> the strscpy() and strlcat() calls with seq_buf operations when
> constructing Hantro video device names.
> 
> This preserves the resulting strings, including truncation
> when the compatible string and suffix exceed the destination
> buffer's capacity.
> 
> Link: https://github.com/KSPP/linux/issues/370 [1]
> Signed-off-by: Mariia Nikitash <nikitash.mariiaw@gmail.com>
> ---
>  drivers/media/platform/verisilicon/hantro_drv.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
> index 26e5d5547466..2bfcd45cc55e 100644
> --- a/drivers/media/platform/verisilicon/hantro_drv.c
> +++ b/drivers/media/platform/verisilicon/hantro_drv.c
> @@ -17,6 +17,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/pm.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/seq_buf.h>
>  #include <linux/slab.h>
>  #include <linux/videodev2.h>
>  #include <linux/workqueue.h>
> @@ -883,6 +884,7 @@ static int hantro_add_func(struct hantro_dev *vpu, unsigned int funcid)
>  	const struct of_device_id *match;
>  	struct hantro_func *func;
>  	struct video_device *vfd;
> +	struct seq_buf s;
>  	int ret;
>  
>  	match = of_match_node(of_hantro_match, vpu->dev->of_node);
> @@ -902,9 +904,12 @@ static int hantro_add_func(struct hantro_dev *vpu, unsigned int funcid)
>  	vfd->vfl_dir = VFL_DIR_M2M;
>  	vfd->device_caps = V4L2_CAP_STREAMING | V4L2_CAP_VIDEO_M2M_MPLANE;
>  	vfd->ioctl_ops = &hantro_ioctl_ops;
> -	strscpy(vfd->name, match->compatible, sizeof(vfd->name));
> -	strlcat(vfd->name, funcid == MEDIA_ENT_F_PROC_VIDEO_ENCODER ?
> -		"-enc" : "-dec", sizeof(vfd->name));
> +
> +	seq_buf_init(&s, vfd->name, sizeof(vfd->name));
> +	seq_buf_puts(&s, match->compatible);
> +	seq_buf_puts(&s, funcid == MEDIA_ENT_F_PROC_VIDEO_ENCODER ?
> +			"-enc" : "-dec");
> +	seq_buf_terminate(&s);
>  
>  	if (funcid == MEDIA_ENT_F_PROC_VIDEO_ENCODER) {
>  		vpu->encoder = func;
> -- 
> 2.43.0
> 

Reviewed-by: Justin Stitt <justinstitt@google.com>

Justin
