Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794171756;
	b=S0AAVZ9zBHPyDDZHzFg3J/BZy5XViBDTkuuNf369HITOQlv250jpJ4xcFpTVddtvJS8N
	 kU0dgMtWaIKWaZYEoe0yu/Y94WTHu3HPt+QfpUL/ESs5Zjvwrwo36yF8G/0Vu/5OjpHDS
	 9AxqEh28vmNco41zoKpgRgGrImqQpcOEosWIBer/yAaVBFFw7fLGWoZG6lda+HN5PXD3h
	 psOc/NkI1pp2cuv4lBfTHkAETufxC1EcXat6vAu6AV09/uyPQgLtMthr34T6oCRKsOBLr
	 L4hPu/mhcN2M9cH+2zZFVdJxtG3ENojiZa0eqIhsZxnWDtjLyMScrofcA73RO/S12zQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794171756;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=cMm3PWlZKSVzTBduDywaKmxs6tEZa4+wbXkdqUMN/Rw=;
	b=wpkG4pd2O/WtxEo/MmtR8uQhm53YOoeq4m5vkqFK7tpffXiQLMXH+aoi84Rf1e04fhmu
	 qFb9aLXbk/zNnTe6JxzIKzgGZ8lN8H7tyy6idvYnktI7pEMO7MWLB6mc7R4ps1NYPmifS
	 idK9MpC682edGVDeGo2fqfdEJltSbelfwsUDjXGVHjRqQBHkIGu9VXPqJTkWptwJQTDD2
	 9M2Al+BH0l02j1mtJ0/rcuizQng0Zt6Wi228gCx1fh8eaBmIvE8Pur+G1Gb0vCFULMeRq
	 OL2YUG9zA80sPEuj4Gk0T3cvyOl9E89/rwqToMX05EgnnVykqQcplwbkkZBh6Jf1BFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ef66MZbs;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CA7606A321
	for <linux-hardening@vger.kernel.org>; Sun,  8 Nov 2026 21:02:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81CA7606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ef66MZbs
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a2069b9710so1982295e9.2
        for <linux-hardening@vger.kernel.org>; Sun, 08 Nov 2026 13:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794171754; x=1794776554; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cMm3PWlZKSVzTBduDywaKmxs6tEZa4+wbXkdqUMN/Rw=;
        b=ef66MZbs7/9pQUnApmXYY+6HgFy7hXZ3fMbRal1xwVliJp8N2CZPYRn8DmmPTTXF0H
         IwQxUrmtz79jzNHH/Vwpw0dUvTlg5+LyAea6RTZP5rNYZw1H7lJL0LHeab9PN8P5csNO
         Jd8q7ULRZPEoWUtrjDx4YBfh/SzLACJQYUZltewehSpFhOQjUW67VicHRSa0MkT4fr93
         CgzC1XtxB6f7TYQZ6flxH1+U0KFvd3B9GKp/BsDdeznc9td9/HF5CtfocRaJiPCEbh86
         Xzz1SaJ7SbqW6nlXbLaMlzua9+bUwtpAdyX9TYAIUtByIh8yYF1MdYYM8eW7IAlTy/wQ
         /YLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794171754; x=1794776554;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cMm3PWlZKSVzTBduDywaKmxs6tEZa4+wbXkdqUMN/Rw=;
        b=ycDSo0xDRBlxUKOTLuq8S653jSUqCSX8wyaPCAkFLAnTphmAUs9kcAOVrUELDza59O
         k6ZpksF2rKgZ6nSJICylzSMibQcStQii0/CkP69NUDZoz5ISaGIikN4UPBlsKF9bNZp0
         w31A+ZCwQWmoa51Ebh2qfO+iESGakihrZL9sBeDMZ0Ex+3+4ta/lL4DxQ7aJvg78cQ9K
         Yzi9oNwgu5xYz76rfSxOh0Ga2ZWwevel+5ftJdL6TCV4fS2+UKVQ5lJ3ZXGnKT7zueK+
         5YmumyxAlp7VJUG6ODRP5fKVn7+c7nYXHjMfx69dsiEDDXD7MbkFgDVQValfL613hf2W
         nBJg==
X-Forwarded-Encrypted: i=1; AL+hErHh1TdZzjsfry+Yg5VNJ/k4T5rZ4kxhsuXb2EIm2nJFyO4mAy/IdhpE8sEjGuQ0LNaqbNledm10gjyFk0SqKqw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8mcOqYLJ9Sj/+9DCGxsnFFORgepy586yZ78byM4xDqLZL07o7N
	ASGA8eZWKq1FjHACdTx0R43uV4gkbKug2IKfSR6JlV2xq9SCzdN6VToXKTK86pHB
X-Gm-Gg: AYBFou21RKwRhq9GQi1t/BQRV7UNK96Xu5+NR7hX7PgYc9kbN7PtrCaf8PRugjhVcXN
	FFDItFoCUBi32HvnoL1bfmBLgfyREU+aV4K7pG1GtrM4nRE+s6ZK+fpbnfkwlFd6d+3rV4e09p9
	W1lgRe7nUs821PLlNyeB83OryIBSE9ed7566qiCzuaPNcUAM1vHYr9apXppESnqsHy/A4jmnKgT
	VtJVHG6Dcs7b8JwabhWW+NRFJYYnOGnHdLQFsmae2rDNCODUIN/ihX/zJGU/cOJ5Ns85FPQBvbN
	GBr68AtS9q1dV4VpSHDFdaP2z6x4Rnlon3i00fRHzYxdKugby/+nN2tuwMv+jZhLnENo3vku++C
	M97c+iiOrx7+OutVQ29AkBOEcqWPeiIbyOy5mSsfCLD0ZocmiVm4g1K927QigTF+kPMUxKUFV+8
	Mw7B7AOlEK0ttXfKE48mdxzsCuCkY9JF16HaUp9qJoG+9tSkjaQQwieR8JodgVwA/uK1/x16wDZ
	CgMIdV9Ish1qvM+WN6NuDUQLvNVUpdH4PbTzFEe8lBTwb+ohz7E3R+HHaxw5WSj7V02jz1Pkhi0
	50PoGmZqjSUS9yHmAv5RfxgrDKX8jutK56qN7njha2XQ/7EHbJDDuVNn3XN5pqGb
X-Received: by 2002:a05:600c:46d2:b0:4a1:fba8:b13d with SMTP id 5b1f17b1804b1-4b963c6ca8fmr41994175e9.9.1794171753830;
        Sun, 08 Nov 2026 13:02:33 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b90f1117fasm99840785e9.13.2026.11.08.13.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 13:02:33 -0800 (PST)
Date: Sun, 8 Nov 2026 21:02:32 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Mariia Nikitash <nikitash.mariiaw@gmail.com>
Cc: hverkuil@kernel.org, mchehab@kernel.org, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 kees@kernel.org, justinstitt@google.com, morbo@google.com
Subject: Re: [PATCH] media: radio: Replace strlcat() with seq_buf in TEA
 drivers
Message-ID: <20261108210232.13800dd3@pumpkin>
In-Reply-To: <20261106074639.452630-1-nikitash.mariiaw@gmail.com>
References: <20261106074639.452630-1-nikitash.mariiaw@gmail.com>
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

On Thu,  5 Nov 2026 23:46:39 -0800
Mariia Nikitash <nikitash.mariiaw@gmail.com> wrote:

> In preparation for removing the deprecated strlcat() API[1],
> replace the strscpy() and strlcat() calls used to construct
> V4L2 card names in the TEA5777 and TEA575x radio drivers.
> 
> seq_buf tracks the current write position and remaining capacity
> across appends, avoiding repeated scans of the destination buffer.
> This preserves the resulting strings, including truncation behavior.

seq_buf is just OTT.
Using to replace a single strcat() is just silly.
There is no point doing these patches until there is a sensible alternative.

> 
> Link: https://github.com/KSPP/linux/issues/370 [1]
> Signed-off-by: Mariia Nikitash <nikitash.mariiaw@gmail.com>
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

What is wrong with (and almost OTT):
#define TEA5777 " TEA5777"
	BUILD_BUG_ON(sizeof(TEA5777) <= sizeof(v->card))

	len = strscpy(v->card, tea->card, sizeof(v->card) - sizeof(TEA5777) + 1);
	if (len < 0)
		goto fail;
	memcpy(v->card + len, TEA5777, sizeof(TEA5777);

What might be useful is a helper that would let you write:
	len = strscpy(v->card, tea->card);
	len = strscpy_at(v->card, len, " TEA5777" [, implied_length]);
	if (len < 0)
		goto fail;

David

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

