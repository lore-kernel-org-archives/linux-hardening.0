Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794168484;
	b=XmpdHHnA/DKTsrdcnDB/hocN6Al/B+ZXCX/8lNeRAB2x+mt9JCFJdgmMampfv1juVtVY
	 T+mWVo/soazLlmf2WLhB3x1T7PPRHXp7a8Ibbr0u0n5URSWUxtZudm2WBxZCKmsF7O02T
	 rkyZLZvpQYiCqDgbEFUEReqqPFHFGfhV5MUWmkkDXSWkE6+Q15Px4Ectwiyb1esWCuAVL
	 5XqzT0YuuF5R/Bafxqz3D0lPwsqHgqlkmREulvcbev/QZwWU8jIP+2dCNvmG8DT+1xtxZ
	 ax5MaTM4D8HzwKm3u5yKjPmgvk2A71/7FPbFv1wcKsSV5TYNLOJl/ggMh4f+tygMfSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794168484;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=AKFhX2kTzcPr0xphsyszWaihfxahRuh70nv/fwZfZKU=;
	b=J6cFZfRo58IDtS6eP1JOLZ9eF4MXbVplVl1ebQ0ND7ZoaQ1YK5JbsOYcHw6haS37f+Tm
	 0aRI1yGyUeXTgs5xOjGLmn/5/KokpfGtHdT1UttCPZvODq3QaDXXACZZAP2NOQkaqQs1E
	 Nau4+odJp4iXwWUoLPwdM+UizbyONutjE7ivSIrPR9au1pi7ocbNj4cS4Y+BQyPHeAPqG
	 Vib/1f/YKX1SZ1wh+3/lLR7KPkK2ZvTFIQdRWKYuWso8cbSLuHtHb53l9m4eXNZMfQ/mA
	 rHYvAfIVU9/MISdLcxLH0yEI80ctnjXsqSoO8nEnxrrpK0+b0gAU5iKWJ3FB6NDKH/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wBRcKNqS;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70767606A339
	for <linux-hardening@vger.kernel.org>; Sun,  8 Nov 2026 20:08:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70767606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wBRcKNqS
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a2167bd087so1954975e9.3
        for <linux-hardening@vger.kernel.org>; Sun, 08 Nov 2026 12:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794168482; x=1794773282; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AKFhX2kTzcPr0xphsyszWaihfxahRuh70nv/fwZfZKU=;
        b=wBRcKNqSAz36TTDwUf5ZOcSL8WudVNLCqD5t/lH5GhVDm7QF/V0exVUJWErSCrGj1H
         n0jS4cebVkJfkAGphSRhqB/HxUANeaTIdWx5U2qA561nZzkVLx7TKz87KhbFWubHF8S0
         N+ovVfagIlEM3o8xlH6/uvaSCHBQeHbEYYbKl27dtqeBvxauUuOAVZiJ5UEejGJoaMeG
         zxXKPRx3KTdKCB2ArgW8xu+Pqh0SLBHhpvCk4VtkmSP+UWANVq264VihJNHRp8jdW+kY
         5VhmcTiONg4v2h3Pb2l7pTMnwIPxmD0pXTUyt55F1/qQ0uoetVTnnrnNrJ7xdtMjYwOe
         dXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794168482; x=1794773282;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AKFhX2kTzcPr0xphsyszWaihfxahRuh70nv/fwZfZKU=;
        b=lGQb1Lc1bNqWG4XQOC5qtqMcp31eqTgW52r6iWdi7+0rXdO34NmP/l5BmQv2CkQd/h
         YtBSXqPIfisRteUqPZ9xOAWP5nQxIDzkNuZMD7zXaEhgAfdRhFKBezJaxDErwgiLkTwO
         kza6u33j9Iz1f37bodOOJGyIDGkENe0cAsd/GgygIZtMS7/hN2mriRJy4lRevTack0jN
         KcQvJs6ono1yu2SCB7j5yqBfQGOFXAqq/RfGzlYXiQYu7KGUl9g5Jklvj2WRj3MelQ0V
         N4mCUvXeLuQw3D/62u/m9+omUXGPTwc/oP5rMyAlPNeB78Y7N85Ab1GCXjZ+ERXuQ2+B
         5l4w==
X-Forwarded-Encrypted: i=1; AL+hErEpGd6IOxrN/tWTVq7qkd2svxvamYOW9dGkx5qp+D/EZSwhvVgzT3X6XQzXNGSWPNdFreAdMlGbxEADT7kggeA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8kcLp6FNjqFKeuHLaJLSRRa6yYwUYq+m4Tkn+6oHnfKmALfxgQ
	dO6/C14QBXhXVEbnBmUzkNMuLebbSUIvwVoYUBfh1QE4MiTrgSfm9BHB
X-Gm-Gg: AYBFou03pQ60P0SMIao0Zpq3WkVLIl+tXOkjbL1kiXQ3xzinQ3VoBhNzTaxTjQbOgR7
	oNRGgZ/84JQmt5QFqS12ZKFyHhBfbd8V+SUKc8aCgvR/nB/nL6CKALTU8pdpdEFww26CPo8l8GH
	nd5B5fG4GB820UvIQMvIga7NvOvYIoBpZzI2mKN95U+j9MmMk8ma82j+kEzj49RQTe/gcFDmg4D
	j9qZrDGrjvFLk0tiZYAAO1U8tDCfjG+EZOxgjcw9IVO3NrXcewOzLOyNVWadoMlOia4+lUrsBje
	NiOUQZeBWDijfBra5ErSvkZbiO3a+IPm4Go4TdtW3WdAYOzQb8lIQG7gpW9ert2fghpxhsiQRbW
	Svjf7g+luOHa23y0jTJwkkOP1ElIsnK+1HzopsCK4O/XLpbFr+oW/LnryXT67iDSjS31sahezP8
	1S1pnBwul4y1AV7UBIPDFPOa55FUYUEJkZfneD1eSoCc2ES/eeWvn5Svs5HYvDzLEY1bEO6ioo2
	y51tOTRfnTtkDhXOx1RGfi+HtFN8K/5OnvLsOVasDzLL8T08q3buz+UwBWkemSDDDSbBwvZKqXK
	Rdw1wUzp/U1/8sb4h5a07athHr/5Ikp9OvdAdQxiOGoV7AbJ4nlQrbRZZhkTZU0w
X-Received: by 2002:a05:600c:8b6f:b0:4a5:1cf1:b7bd with SMTP id 5b1f17b1804b1-4b9633cddd6mr40682765e9.16.1794168481504;
        Sun, 08 Nov 2026 12:08:01 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b90ee249d3sm87320515e9.7.2026.11.08.12.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 12:08:01 -0800 (PST)
Date: Sun, 8 Nov 2026 20:08:00 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Mariia Nikitash <nikitash.mariiaw@gmail.com>
Cc: nicolas.dufresne@collabora.com, benjamin.gaignard@collabora.com,
 p.zabel@pengutronix.de, mchehab@kernel.org, linux-media@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, kees@kernel.org, justinstitt@google.com,
 morbo@google.com
Subject: Re: [PATCH] media: verisilicon: Replace strlcat() with seq_buf
Message-ID: <20261108200800.2b3b15cf@pumpkin>
In-Reply-To: <20261105084518.386234-1-nikitash.mariiaw@gmail.com>
References: <20261105084518.386234-1-nikitash.mariiaw@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  5 Nov 2026 00:45:18 -0800
Mariia Nikitash <nikitash.mariiaw@gmail.com> wrote:

> In preparation for removing the deprecated strlcat() API[1], replace
> the strscpy() and strlcat() calls with seq_buf operations when
> constructing Hantro video device names.
> 
> This preserves the resulting strings, including truncation
> when the compatible string and suffix exceed the destination
> buffer's capacity.

This is just stupid...

David

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

