Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792652944;
	b=tbzkBRlxW3lanWb1NfK7gIKuR4SH6gSUS3enAE9SM+BjNwL/08c34cgW0dpKN/krlhIa
	 kT/1eo8BSH47QC2GHscQ50+iKo5+K88GVBy7bZC93F0qyUTp2reG02Dfd7tVBYoRLx2PF
	 8GMHwfaBe0V6NxeNJT57GARYWG/v7Mo6fwlxM0WF2lO8HuOuQbtaEuK/LA86VOEmyl21w
	 BX6asqaGBCGi1k+tvI87ucYxG6dNDkG62FgPyRptHpQfq5d6e0fr3Ttw+wbLP5ulAt8Wi
	 O/POnmjgoHoYK2/kNlHZfdMlnSz0kEwhcIr/BCJG1ZIKEs4VfiaZA6ZsvM+pAtgITdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792652944;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:Mail-Followup-To:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=XssGaeVl2OdevVN/fICXdcbv8t7nXjI9BLYiHfZ6gHw=;
	b=pqUIGsfot6b/HwNQtGVzGOS5dBSP7f+SsAhi/a28uAAI/rsYAD5GhDkFmXDPzsEr2DHs
	 fkMcuxXosOS6b+ZYlRK3R9Gv7D+jBZ/sWfacx8Y4CLv0/7viL5skGcj5//hG2b5KXDzCk
	 XeTgAQURPfyGBvYOIdGhfDG28TRcYTBGNah20MLZthJJUrgNXvnTPb3tZpfpCyYWT5FOq
	 P52iRv1NK6DU6jewKKueG+wuKlhn68PEE3mHFNN01YfHt3VA04xJh5F3bjeyBJq+fatkz
	 SXY/BpsMHQzO9hYB6VtXx9hJTUt9DQJt98nVP/xcLIy08OVEwnNPJl7vcISId+jMOSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ft7k+83o;
	arc=none smtp.remote-ip=74.125.227.138
Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34947606A31F
	for <linux-hardening@vger.kernel.org>; Thu, 22 Oct 2026 07:09:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34947606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ft7k+83o
Received: by mail-pj2-f10.google.com with SMTP id 98e67ed59e1d1-3abe4fb64d2so729216a91.1
        for <linux-hardening@vger.kernel.org>; Thu, 22 Oct 2026 00:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792652943; x=1793257743; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XssGaeVl2OdevVN/fICXdcbv8t7nXjI9BLYiHfZ6gHw=;
        b=Ft7k+83oYx8wwz21l0KLd/G/7TbRV/NMT2VZ2SfEwZA3WPyM+tGFEfDhqfRJFYX0zv
         M92D4zjGi/jH9I/GtwqRaQoEcF/P6xbeSxppXF/PDNvo3N0zC7BKMsrwr9Ram+frL+S0
         us4LfN9ML4N+GJRqsKljAVaajmbB30EfOvxkESt2vrGTgM1TuOBKg5TCWBsj3ZjegHh8
         wW76N2u2U2YpkqnWtexonzeiqF3gsTN7PyYZEfEqbGoUbPi78iii3EhWmpARwNxjaQS8
         DP7moImk6x6BQMgU376o4Rn6QYUhxohfuZnf3t2jXEQEX4O5MYm5UjpOPcPXT8vFPgXG
         7UAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792652943; x=1793257743;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XssGaeVl2OdevVN/fICXdcbv8t7nXjI9BLYiHfZ6gHw=;
        b=hDcMpTJj0HX9K9aIQWtFkKgkuSWS5QKnk2njo/1dAA6/axTO+f2oYP6NdRGpxaai2W
         z9f0MPCsBsYAE1vft5gKndHIjniPxQLNLdSRXE7eEjr+/k0s45Ey8h3yLKO6+YcLlwFN
         MpeZfRL27ods7bBlg8Dmf5GR5IcEXd52xkGw8+pQQ6GZEmIzFGXoOk6OaKe97T8zq/M8
         l/LTMUQYtg0xTXN60JrPo9d267tPL/7m7ReoXCZ5J2Fc+L90rQ5mom9gl7gv36ODHkha
         u+uBYdQfOy9njVDoRaGpe8p2cbbisLeaof6u3n0r9FPcxEDbOqT3DI/UQtNt6vCQqwwe
         anoA==
X-Forwarded-Encrypted: i=1; AKwUvBw7ZvnuRx9TAuw1mFXkpvGhf43u722uSvmKC5im2ULX/vdpQ/TaLffCvzQYl42emAA5UeXQPNuG7UA4Msm6F9k=@vger.kernel.org
X-Gm-Message-State: AFq9FYLcis/l4Q/ipDaki+t5qv7Fz9RDGnHPV5xN6ML6NLB5l+Ro5jyd
	yS2OnaCHwMe14Qmy4G1n5Hsrn2BNxRT46op4BPuASXSf7dURmOz8t5MnCzfJyxKn2mS7Cg==
X-Gm-Gg: AYBFou2QUwZtNvWZkQ8gdbV44zUdnV9wwNbROcKlGOMcjB5wjyXJJFwiund6Ut1m6/d
	e750AQ3TrcrHDBD6HwtZbPswKP6YKRGg3Q+2bjlxTxy/aUidIENTw+nBM0WJtIfhOiJ7d+G88YD
	2rr9OF/MxuE/eNSwtVC0+IDYxeHF88U0g11lsTT42kiqUPUkV2AVZLkrf1QeK9Ru+TsEcxZ+DwA
	KU6DtlJOHbQ1zYi6vSdQCwxfvAP8UPL1X1tAbK3Ee8UTqWRlPlFNTXvfH5ebfnzI+tq5aLxQTqS
	RPMLGipgPGVt2q11ElPIeShhhJocxlMEm1uJAYhrZZCd5n1rTbCeR6eNaMoyDqs9jjJcAB5pDVS
	qU/Cv38MuMcyM/7B+sxlQ/yHjii5uV9MjUmPOCbzr7NWO0tLu5oY9zj21wcnOO0PD3Vcptg9p6U
	PN9Fp1JaIrEdJDgT7jyv2Yx3KKarxyl/4M+cn0QPMYbptt5l3KSmLwngRKZwJW70WJKS9wsCAE6
	zjIqtqefV3ZVxFkyK6MP/KARjfCiErctjkhlW9ChhCVa4UDSUuWv8WYupr8KuG1bzOKlSStCt8p
	1fagHEI=
X-Received: by 2002:a17:90b:37cf:b0:3ab:c674:d83c with SMTP id 98e67ed59e1d1-3ad86ed34a8mr3884621a91.27.1792652942680;
        Thu, 22 Oct 2026 00:09:02 -0700 (PDT)
Received: from J4f-Laptop.localdomain ([183.36.237.113])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada4887669sm2913545a91.2.2026.10.22.00.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 00:09:02 -0700 (PDT)
Date: Thu, 22 Oct 2026 15:08:58 +0800
From: Shihuang Liu <shlomojune6@gmail.com>
To: Alejandro Colomar <alx+linux-hardening@kernel.org>
Cc: linux-input@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Marcus Folkesson <marcus.folkesson@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Ville Syrjala <syrjala@sci.fi>, Henk Vergonet <Henk.Vergonet@gmail.com>, 
	Henrik Rydberg <rydberg@bitmath.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] USB: add usb_make_subpath() for formatted device
 subpaths
Message-ID: <tlemhufl7x3zatbf7ygcfnshinyz4bunroyhegmyxutgooqbcc@wtpqkldesosb>
Mail-Followup-To: Alejandro Colomar <alx+linux-hardening@kernel.org>, 
	linux-input@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Marcus Folkesson <marcus.folkesson@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Ville Syrjala <syrjala@sci.fi>, Henk Vergonet <Henk.Vergonet@gmail.com>, 
	Henrik Rydberg <rydberg@bitmath.org>, linux-kernel@vger.kernel.org
References: <20261021123146.17202-1-shlomojune6@gmail.com>
 <20261021123146.17202-2-shlomojune6@gmail.com>
 <ati7RlrVvmzMjzNr@debian>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ati7RlrVvmzMjzNr@debian>

On Wed, Oct 21, 2026 at 03:17:56PM +0200, Alejandro Colomar wrote:
> Hi Shihuang,
> 
> > Date: 2026-10-21 20:31:41+0800
> > From: Shihuang Liu <shlomojune6@gmail.com>
> >
> > USB drivers often build device paths by calling usb_make_path() :and
> > then appending a subpath. Several callers use the deprecated strlcat()
> > API for this.
> > 
> > In preparation for removing the deprecated strlcat() API[1], add
> > usb_make_subpath() to format the USB device path.
> > 
> > Link: https://github.com/KSPP/linux/issues/370 [1]
> > Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
> > ---
> >  include/linux/usb.h | 29 +++++++++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> > 
> > diff --git a/include/linux/usb.h b/include/linux/usb.h
> > index 1da4ad1610bca..c90ccea0cdbf6 100644
> > --- a/include/linux/usb.h
> > +++ b/include/linux/usb.h
> > @@ -14,6 +14,7 @@
> >  #include <linux/errno.h>        /* for -ENODEV */
> >  #include <linux/delay.h>	/* for mdelay() */
> >  #include <linux/interrupt.h>	/* for in_interrupt() */
> > +#include <linux/stdarg.h>	/* for va_list */
> >  #include <linux/list.h>		/* for struct list_head */
> >  #include <linux/kref.h>		/* for struct kref */
> >  #include <linux/device.h>	/* for struct device */
> > @@ -987,6 +988,34 @@ static inline int usb_make_path(struct usb_device *dev, char *buf, size_t size)
> >  	return (actual >= (int)size) ? -1 : actual;
> >  }
> >  
> > +/**
> > + * usb_make_subpath - returns a stable device path and formatted subpath
> > + * @dev: the device whose path is being constructed
> > + * @buf: where to put the string
> > + * @size: how big is "buf"?
> > + * @fmt: format string for the subpath, without the leading slash
> > + * @...: arguments for @fmt
> > + *
> > + * Return: Length of the string (> 0) or negative if size was too small.
> > + */
> > +static inline __printf(4, 5)
> > +int usb_make_subpath(struct usb_device *dev, char *buf, size_t size,
> > +		     const char *fmt, ...)
> > +{
> > +	struct va_format vaf;
> > +	va_list args;
> > +	int actual;
> > +
> > +	va_start(args, fmt);
> > +	vaf.fmt = fmt;
> > +	vaf.va = &args;
> > +	actual = snprintf(buf, size, "usb-%s-%s/%pV", dev->bus->bus_name,
> > +			  dev->devpath, &vaf);
> > +	va_end(args);
> > +
> > +	return (actual >= (int)size) ? -1 : actual;
> 
> Why are you open-coding usb_make_path() here instead of calling it?
> 
> 
> Have a lovely day!
> Alex
> 
Hi, Alex

With open-coding, a single snprintf() is enough, so we don't need to
call usb_make_path() and then another function to append the suffix.

Thanks,
Shihuang
> > +}
> > +
> >  /*-------------------------------------------------------------------------*/
> >  
> >  #define USB_DEVICE_ID_MATCH_DEVICE \
> > -- 
> > 2.43.0
> > 
> > 
> 
> -- 
> <https://www.alejandro-colomar.es>
