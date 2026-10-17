Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E4740A944
	for <linux-hardening@vger.kernel.org>; Sat, 17 Oct 2026 22:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792275082; cv=none; b=Bhr++9H+4MD0UMux1v4qbwSHnRHfs5gkNJjq+EiKY7reDLH5LonHTq2SlVf6ZkygnW5BME+q9iCB4HRYXIVSXosWzjXoY58DijwAdvbMirhLvzHyY9cUUjPlMWF52M1p8IdWU+85sLcIrbF3mfj+bKsRy4IwUZfIoMYZgE0W2fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792275082; c=relaxed/simple;
	bh=/Yrw2Pxsodgd+C7rMdJqMEaeHAtdLqPPZnmeOO2Plxs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kYfaFS+TmTbceJppT5C1vhzoJbRnL5VCn8qFyHZbMaYlORq6N09uuSsXYPhZjNL8fDY7CQvuYrG9ZE7M5BO1F6p7KpXSuRIDp8Gf5vsWdt+CeGNF2l8UINlblt5Zy7smQc29ut5KeGLRZIXrztdxnb4sumTenz9wx33LytU5PNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hhSOTpKo; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhSOTpKo"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso10927175e9.1
        for <linux-hardening@vger.kernel.org>; Sat, 17 Oct 2026 15:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792275080; x=1792879880; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O7eqTqZMZBSun91Qk6DX1ShYcBC+PEVqt3fz0F4KCmo=;
        b=hhSOTpKoLgi5E96f2PmfVbxhH5xdEjLl7PNhoHfHp8o2H8hQuKgMr8P3G4a9ozBG4R
         qWu98tmA7KrEf+qU+pxyfANAev4bUxCuA4wC/umPHLiaMLJAbEnw/VRMBDYR4Ryv607z
         EeifzfpYuZti1RluM9mNnFsqTx9Cxz7mElUnrqeUPvH33q55LQmQbfdi8BPZ4gSl9dAZ
         3AkGmMzFaqgIL5Kovxbppqh2g8vcxa4rOjHUrXmhHBX2u2wqNPZebIms9kIS9Yo4U6iI
         LUPYYaSHWX4/gFwGqtPFtQrQi0jO7Jy+0QQzRyzT9+H+jjy9TN/KfZRK9dPuF52OfjzL
         wiMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792275080; x=1792879880;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O7eqTqZMZBSun91Qk6DX1ShYcBC+PEVqt3fz0F4KCmo=;
        b=mPJ/u7HfHza1Tm8WgckXSTrGPfe+Boq0U6UEeAES1tPOhxfp2lSJbdTsDysKw6pso8
         gOOMPU3unuJfIPhSyxW3h6Aqec2ggQQXuV33oD07/dvkgoqnFZ5tMKN/43srDuQSAs3v
         rjWFmLHkMHnQAsiz+NS2I/w5veZuDksfptlmHbSdhzrHZ/HzMFf3A5QR5ms0qv2byb0M
         0UdViuR4ARvI0SnVmzXFJbiTyWT/QRCrZCAuhtr4pi9Nwk1PIsPA3jsclou+EVeCiewN
         LNUu7WPLRzEpq6hKpeMpqIg1AECZCC6XWM9UnSqgPHP7IoDdxh2qWMjjP6a/PoHV6vC1
         gTIg==
X-Forwarded-Encrypted: i=1; AKwUvBzDohGmkXKOxTZbdrP9LXYSjHk00p2B7e94125u09e/phcaNpLqwSlIU3hFDzPvhX9g+GIcVFflDdFUkECjnpE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKfPu9ZOSCom0G2/+BAE7didSv7YoVSDi8ECYW0BobHrf5l//22
	NJr1x4dJxunx4aECQQ+pMmL0qe+Ym/YsbBiiIG+gghzN/34LqFxW3//M
X-Gm-Gg: AYBFou2mUCFu8eHgRqpNOl8+nQyawYyE+j9orawuyxkFA5QZV3SeO3/K87eCDf90eBD
	uQMtTSXWUf9YZPUfgvOntc6bRVxu42h6bZTyNIFOvYjEt7+dtdYNj1lCwueGyDh2f6mLMuTRdYF
	fOBlpgSkG/7RVh847Xdude81IbVUXQGwsQ1DuKqFZLd8qaUfVKykBS9dPfqOWGMX9b1iXuQ3+vj
	I5p4awuxNv1p4NmFsP0s6HlshPkRLF70qjqivo2sIYW8hVwr1z9TR2l5gZkYzsTlFYrEODEMq/M
	SL7h5K+OEZH54nv1s+02HD02NBiH5ciVBi4gasn5ml3tK2sidcnH1LZtCtviO8Bd6yI76Xu6fEs
	XH4ReHeNGtntQQ50zMQcBz8QEAn6f9+/4OT0Vympgfb0bAYsRWxnHOCwj0O9Lvcc9nRMiZVe3zY
	IozYv1cUIR+4v9xOKkqF+gC1ZwCytg3nZ9G07o9OyYr4RF81ugDs/AGGI/x8G6nnZ6LVsPpJPTq
	8Kw40PH9tcRALDU8cty35QFV/Gj/M3Blk4=
X-Received: by 2002:a05:600c:820a:b0:4a0:eae0:769a with SMTP id 5b1f17b1804b1-4a1d7616cfemr66857645e9.28.1792275079547;
        Sat, 17 Oct 2026 15:11:19 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1dc8ee409sm104834715e9.13.2026.10.17.15.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 15:11:19 -0700 (PDT)
Date: Sat, 17 Oct 2026 23:11:18 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Shihuang Liu <shlomojune6@gmail.com>
Cc: linux-input@vger.kernel.org, linux-hardening@vger.kernel.org, Marcus
 Folkesson <marcus.folkesson@gmail.com>, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>, Ville Syrjala <syrjala@sci.fi>, Henk Vergonet
 <Henk.Vergonet@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] Input: tablet - replace strlcat() with strscpy()
Message-ID: <20261017231118.2b440e44@pumpkin>
In-Reply-To: <20261016170411.51025-5-shlomojune6@gmail.com>
References: <20261016170411.51025-1-shlomojune6@gmail.com>
	<20261016170411.51025-5-shlomojune6@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 17 Oct 2026 01:04:10 +0800
Shihuang Liu <shlomojune6@gmail.com> wrote:

> The acecad, aiptek, hanwang, kbtab and pegasus_notetaker drivers
> build the physical path by appending a constant "/input0" suffix
> with strlcat() after usb_make_path().
> 
> In preparation for removing the deprecated strlcat() API[1],
> replace it with strnlen() followed by strscpy() into the remainder
> of the buffer, as commit 34b228b739f5 ("HID: usbhid: replace
> strlcat with better alternatives") did for the usbhid drivers.
> 
> Link: https://github.com/KSPP/linux/issues/370 [1]
> Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
> ---
>  drivers/input/tablet/acecad.c            | 4 +++-
>  drivers/input/tablet/aiptek.c            | 7 +++++--
>  drivers/input/tablet/hanwang.c           | 4 +++-
>  drivers/input/tablet/kbtab.c             | 4 +++-
>  drivers/input/tablet/pegasus_notetaker.c | 4 +++-
>  5 files changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/input/tablet/acecad.c b/drivers/input/tablet/acecad.c
> index ba79dff21aac8..8fec79c46d4b0 100644
> --- a/drivers/input/tablet/acecad.c
> +++ b/drivers/input/tablet/acecad.c
> @@ -117,6 +117,7 @@ static int usb_acecad_probe(struct usb_interface *intf, const struct usb_device_
>  	struct input_dev *input_dev;
>  	int pipe, maxp;
>  	int err;
> +	size_t len;
>  
>  	if (interface->desc.bNumEndpoints != 1)
>  		return -ENODEV;
> @@ -161,7 +162,8 @@ static int usb_acecad_probe(struct usb_interface *intf, const struct usb_device_
>  	}
>  
>  	usb_make_path(dev, acecad->phys, sizeof(acecad->phys));
> -	strlcat(acecad->phys, "/input0", sizeof(acecad->phys));
> +	len = strnlen(acecad->phys, sizeof(acecad->phys));
> +	strscpy(acecad->phys + len, "/input0", sizeof(acecad->phys) - len);

There is no point replacing strcat() with strlen() + strcpy()
(any variants of the functions).

David

>  
>  	input_dev->name = acecad->name;
>  	input_dev->phys = acecad->phys;
> diff --git a/drivers/input/tablet/aiptek.c b/drivers/input/tablet/aiptek.c
> index 0c1acb9e6b437..e868d0bac771d 100644
> --- a/drivers/input/tablet/aiptek.c
> +++ b/drivers/input/tablet/aiptek.c
> @@ -1637,6 +1637,7 @@ aiptek_probe(struct usb_interface *intf, const struct usb_device_id *id)
>  		AIPTEK_PROGRAMMABLE_DELAY_300
>  	};
>  	int err = -ENOMEM;
> +	size_t len;
>  
>  	/* programmableDelay is where the command-line specified
>  	 * delay is kept. We make it the first element of speeds[],
> @@ -1707,8 +1708,10 @@ aiptek_probe(struct usb_interface *intf, const struct usb_device_id *id)
>  	 */
>  	usb_make_path(usbdev, aiptek->features.usbPath,
>  			sizeof(aiptek->features.usbPath));
> -	strlcat(aiptek->features.usbPath, "/input0",
> -		sizeof(aiptek->features.usbPath));
> +	len = strnlen(aiptek->features.usbPath,
> +		      sizeof(aiptek->features.usbPath));
> +	strscpy(aiptek->features.usbPath + len, "/input0",
> +		sizeof(aiptek->features.usbPath) - len);
>  
>  	/* Set up client data, pointers to open and close routines
>  	 * for the input device.
> diff --git a/drivers/input/tablet/hanwang.c b/drivers/input/tablet/hanwang.c
> index fd5a7e761dcc4..a75d10dd2fc7d 100644
> --- a/drivers/input/tablet/hanwang.c
> +++ b/drivers/input/tablet/hanwang.c
> @@ -318,6 +318,7 @@ static int hanwang_probe(struct usb_interface *intf, const struct usb_device_id
>  	struct input_dev *input_dev;
>  	int error;
>  	int i;
> +	size_t len;
>  
>  	if (intf->cur_altsetting->desc.bNumEndpoints < 1)
>  		return -ENODEV;
> @@ -351,7 +352,8 @@ static int hanwang_probe(struct usb_interface *intf, const struct usb_device_id
>  	hanwang->dev = input_dev;
>  
>  	usb_make_path(dev, hanwang->phys, sizeof(hanwang->phys));
> -	strlcat(hanwang->phys, "/input0", sizeof(hanwang->phys));
> +	len = strnlen(hanwang->phys, sizeof(hanwang->phys));
> +	strscpy(hanwang->phys + len, "/input0", sizeof(hanwang->phys) - len);
>  
>  	strscpy(hanwang->name, hanwang->features->name, sizeof(hanwang->name));
>  	input_dev->name = hanwang->name;
> diff --git a/drivers/input/tablet/kbtab.c b/drivers/input/tablet/kbtab.c
> index 6ce70c8e2d7cc..79a5e217654b6 100644
> --- a/drivers/input/tablet/kbtab.c
> +++ b/drivers/input/tablet/kbtab.c
> @@ -113,6 +113,7 @@ static int kbtab_probe(struct usb_interface *intf, const struct usb_device_id *i
>  	struct kbtab *kbtab;
>  	struct input_dev *input_dev;
>  	int error = -ENOMEM;
> +	size_t len;
>  
>  	if (intf->cur_altsetting->desc.bNumEndpoints < 1)
>  		return -ENODEV;
> @@ -138,7 +139,8 @@ static int kbtab_probe(struct usb_interface *intf, const struct usb_device_id *i
>  	kbtab->dev = input_dev;
>  
>  	usb_make_path(dev, kbtab->phys, sizeof(kbtab->phys));
> -	strlcat(kbtab->phys, "/input0", sizeof(kbtab->phys));
> +	len = strnlen(kbtab->phys, sizeof(kbtab->phys));
> +	strscpy(kbtab->phys + len, "/input0", sizeof(kbtab->phys) - len);
>  
>  	input_dev->name = "KB Gear Tablet";
>  	input_dev->phys = kbtab->phys;
> diff --git a/drivers/input/tablet/pegasus_notetaker.c b/drivers/input/tablet/pegasus_notetaker.c
> index 85390ae423076..679600bd214e4 100644
> --- a/drivers/input/tablet/pegasus_notetaker.c
> +++ b/drivers/input/tablet/pegasus_notetaker.c
> @@ -277,6 +277,7 @@ static int pegasus_probe(struct usb_interface *intf,
>  	struct input_dev *input_dev;
>  	int error;
>  	int pipe;
> +	size_t len;
>  
>  	/* We control interface 0 */
>  	if (intf->cur_altsetting->desc.bInterfaceNumber >= 1)
> @@ -355,7 +356,8 @@ static int pegasus_probe(struct usb_interface *intf,
>  			 le16_to_cpu(dev->descriptor.idProduct));
>  
>  	usb_make_path(dev, pegasus->phys, sizeof(pegasus->phys));
> -	strlcat(pegasus->phys, "/input0", sizeof(pegasus->phys));
> +	len = strnlen(pegasus->phys, sizeof(pegasus->phys));
> +	strscpy(pegasus->phys + len, "/input0", sizeof(pegasus->phys) - len);
>  
>  	INIT_WORK(&pegasus->init, pegasus_init);
>  

