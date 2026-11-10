Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794305315;
	b=spyowjcDlWZ8mT4BpA3/quaW6amQi9WoAVUVZNyDll2YZvXnnskEtMjFhC/OXCAoo/vw
	 ZzClH5Vyf23CVrdg+07k73SK9W+dUmByySwSRmKQv5VCb1K2e8mLCHsQLBp6v0VGXevK9
	 hNxD5kCuQ1Ku9OVR1dJ4qac/RpCTWvpaqC9aS34bTNgou+sCLR8PuJwTu7Ta6JjbdEogK
	 nEzIQbZF1VxM6VQZIab8R9X5uXr6IBIzfdRryTRNMdk5SxmAfSE10sKaNHO6/YNaYVWwX
	 3m/VM/ImEY2YF+xeTgeq4uo68snGTegjF17RqacVoC0iGAmHp7lUqpRDuy9N6qWnptg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794305315;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:From:
	 Subject:To:Cc:References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=2BPiniroA+BvlA0T6zRTYGNNKv2JYMJyth1xvzKik8I=;
	b=DUSwnB/k2hUNXyPVPQKIVUCSr7yBJPImhFhYkDoOl8cUx4O7lJXcRLj3BeV1iSYiQDHF
	 0oaNauz3jnU3izjiULE/BXsJhM7Q7rDzur9J3UAk7Ztjc105qgDjA+BzhV0oUshC+pc7o
	 GtA1ZozG41qxXbIAVSQX5wFB7JGtpMvuJkRQEKscL2rFx3N1huIhElfgnv7V9qzOw8TfP
	 aSLDRr4ey3Lm89+Qe3R2JWyBErxYU2fZD4notvimSDv3+CJGhiCIARdUUpthy6mXHYmsm
	 O5pXIsU871wfbYG6pU5DMtDeBypzDBN8hfxJgUcZJ0APrmWmDnM7kFEfjEAqlpUvmzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cXjWnmj+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81F06071086;
	Tue, 10 Nov 2026 10:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cXjWnmj+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3DBA1F008A5;
	Tue, 10 Nov 2026 10:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794305314;
	bh=2BPiniroA+BvlA0T6zRTYGNNKv2JYMJyth1xvzKik8I=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=cXjWnmj+kekitDP7b45fQR2Ua4XZtoo0hFqEANw6hpC21RCObLWiJcqQhDgbErkQg
	 JwJXE3s52MmDWqDpRw76Wx3CRLFxSCSNVst8c0T4PmGv5OYezIiGCcNcjwHpbE5f7L
	 HA+fdkN7plffb/BvhNyjN35xgUakIxlC10U2W6fQOllubK1N6SZQn4vzSbmn3yPvUa
	 pnVHR4NDBVUdC2TPvp6bkFHMA0cJoir7DZDZK8QIFkFRmue6xLj4tSjHkJ7JvyatkP
	 sJ+SLq0ywiDUI57NMLbhtqfIUikW6vnO2JZlWIVtpT1Kksn03IY9DYNhLrXiaoZKkQ
	 CZn8GvQLaE/8w==
Message-ID: <cd073632-0919-4015-8daf-39cfe24391e8@kernel.org>
Date: Tue, 10 Nov 2026 11:08:30 +0100
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
From: Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: Re: [PATCH] media: radio: Replace strlcat() with seq_buf in TEA
 drivers
To: Mariia Nikitash <nikitash.mariiaw@gmail.com>, hverkuil@kernel.org,
 mchehab@kernel.org
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, kees@kernel.org, justinstitt@google.com,
 morbo@google.com
References: <20261106074639.452630-1-nikitash.mariiaw@gmail.com>
Content-Language: en-US, nl
In-Reply-To: <20261106074639.452630-1-nikitash.mariiaw@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/11/2026 08:46, Mariia Nikitash wrote:
> In preparation for removing the deprecated strlcat() API[1],
> replace the strscpy() and strlcat() calls used to construct
> V4L2 card names in the TEA5777 and TEA575x radio drivers.
> 
> seq_buf tracks the current write position and remaining capacity
> across appends, avoiding repeated scans of the destination buffer.
> This preserves the resulting strings, including truncation behavior.
> 
> Link: https://github.com/KSPP/linux/issues/370 [1]
> Signed-off-by: Mariia Nikitash <nikitash.mariiaw@gmail.com>

Nacked-by: Hans Verkuil <hverkuil+cisco@kernel.org>

This is silly. Just use scnprintf().

Regards,

	Hans

> ---
>  drivers/media/radio/radio-tea5777.c | 10 ++++++++--
>  drivers/media/radio/tea575x.c       | 10 ++++++++--
>  2 files changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/radio/radio-tea5777.c b/drivers/media/radio/radio-tea5777.c
> index fb9de7bbcd19..2b1c7f6ddd60 100644
> --- a/drivers/media/radio/radio-tea5777.c
> +++ b/drivers/media/radio/radio-tea5777.c
> @@ -13,6 +13,7 @@
>  #include <linux/init.h>
>  #include <linux/module.h>
>  #include <linux/sched.h>
> +#include <linux/seq_buf.h>
>  #include <linux/slab.h>
>  #include <media/v4l2-device.h>
>  #include <media/v4l2-dev.h>
> @@ -255,10 +256,15 @@ static int vidioc_querycap(struct file *file, void  *priv,
>  					struct v4l2_capability *v)
>  {
>  	struct radio_tea5777 *tea = video_drvdata(file);
> +	struct seq_buf s;
>  
>  	strscpy(v->driver, tea->v4l2_dev->name, sizeof(v->driver));
> -	strscpy(v->card, tea->card, sizeof(v->card));
> -	strlcat(v->card, " TEA5777", sizeof(v->card));
> +
> +	seq_buf_init(&s, (char *)v->card, sizeof(v->card));
> +	seq_buf_puts(&s, (const char *)tea->card);
> +	seq_buf_puts(&s, " TEA5777");
> +	seq_buf_terminate(&s);
> +
>  	strscpy(v->bus_info, tea->bus_info, sizeof(v->bus_info));
>  	return 0;
>  }
> diff --git a/drivers/media/radio/tea575x.c b/drivers/media/radio/tea575x.c
> index c37315226c42..e49228eb7c46 100644
> --- a/drivers/media/radio/tea575x.c
> +++ b/drivers/media/radio/tea575x.c
> @@ -9,6 +9,7 @@
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/slab.h>
> +#include <linux/seq_buf.h>
>  #include <linux/sched.h>
>  #include <asm/io.h>
>  #include <media/v4l2-device.h>
> @@ -221,10 +222,15 @@ static int vidioc_querycap(struct file *file, void  *priv,
>  					struct v4l2_capability *v)
>  {
>  	struct snd_tea575x *tea = video_drvdata(file);
> +	struct seq_buf s;
>  
>  	strscpy(v->driver, tea->v4l2_dev->name, sizeof(v->driver));
> -	strscpy(v->card, tea->card, sizeof(v->card));
> -	strlcat(v->card, tea->tea5759 ? " TEA5759" : " TEA5757", sizeof(v->card));
> +
> +	seq_buf_init(&s, (char *)v->card, sizeof(v->card));
> +	seq_buf_puts(&s, (const char *)tea->card);
> +	seq_buf_puts(&s, tea->tea5759 ? " TEA5759" : " TEA5757");
> +	seq_buf_terminate(&s);
> +
>  	strscpy(v->bus_info, tea->bus_info, sizeof(v->bus_info));
>  	return 0;
>  }

