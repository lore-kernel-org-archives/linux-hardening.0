Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A4A27B50C
	for <linux-hardening@vger.kernel.org>; Mon, 18 Aug 2025 23:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755560707; cv=none; b=u/+47QRksF6y1Hm5WmlFHBTX8pGak/mxE3nqqF86BVNLqP6jbBW/z5PVDKDazl5jL7yXNklcwBxVRScs79AoPcCyAzxhQoEB16SRs6mlXkBnTAMuRFFe74UnrQID5AGvHzcte6KYvf0UQk6262ygVvYRgrl5ofFu6h5qrHX/uxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755560707; c=relaxed/simple;
	bh=20GbQYSlKyvlXvDnnjkkcG80NKWGMOYxQbD0qXNg3pE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VGJLCLj1ijdooFS69Zxv3g6rU80F4XqnIAsEfnU3CyxtmqVyuZbV0nTTJNnpzX8ov1Ql1WKb3v0QfKt1n6Vu9+SjGHl3il2/aJBuGGip+H42JEatMbvssfGgSlpn7PiMMwwz/AGUq92UapXJnhRtswRijNxEMW6miaJboqY0ZOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lHaXPjCm; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lHaXPjCm"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3e570042988so51129315ab.2
        for <linux-hardening@vger.kernel.org>; Mon, 18 Aug 2025 16:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755560705; x=1756165505; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tr/+srRnInstoyTTTLvFCgnYoosQgmYpeHv/fgPsY8Q=;
        b=lHaXPjCmWqCSTJlzeQINh6keuNXZoDwfyrV4BmVDS2OgG4FoqW5wRPsaEVUVEh/0dA
         U0DPFCZ77P6Y2cwZvz+bwFYMvApZpqmLYVhUdilEG0B/uCDJFvlXzGP8mKqO0oTf9Iwj
         ygWP+fnrs+xNkB1+lJScsKHracnMmctTB7/srQTD3Hm71P8v/SdCOaQ4PKJ7jlJ1AdUv
         1qhLt6RPk2yAaRHTy2d6buZ4EUW1vuPTGRDXUaxRTJ5qUdgTsj5m+kqhOqn/ZfXPnrNh
         qFT8S1aWmBAOWmpnVxzjGYnl6U7i/SYC1VjTPH+kzlfW+R5m7ho3SPJf6U8I7hfUk980
         EHQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755560705; x=1756165505;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tr/+srRnInstoyTTTLvFCgnYoosQgmYpeHv/fgPsY8Q=;
        b=mqnot2e6XrlBDC4IZvUB8WAnobzfkzjK1IU+zKwgJptR35TQq0BIx5zfaAZR/PYSFN
         zVygucfee7AMiZkBBaBZOGpOszNp3JFwBj+xqpFjtv4i0RbxXgu2uJ3PxnXnIUk/n2N5
         FvQ/70QPWHajiLoBJ97VyCtIBwSG6WXe++nRaYt1TExpNoUE6kX2t+aKy6JnNOTcYIzs
         N6YfQdtBwbGZi1PYAdFmBmTcdVGh6ZXykvTZxYHFDZQw9vvsVK20Zsj+mRxHcXX3z9Cu
         Z+1o8Fo0arCIqeXrHOc1SW30DzAnKef7GdNp7gIGx57g9f17+bNFmVZi6fruFm/+18G5
         gwhw==
X-Forwarded-Encrypted: i=1; AJvYcCVDZwwD6sWxGgtruqZRJQUwdsgm4OGIvXmE7xid/jsnhKBeQEkquykdNA0KjQHrS8dL7OMX/JUWFdwKaoEszeM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCI+B5Y+Rp/+pBVUytIbUwmcuk4QP7LohTLPKeIk5dKi2LrKzP
	B4ZVegBPwbUHzmQQLeC2l/erqw7tTn3+O7XOudZUaMUdRVPelDmqqDDCP10bBs1x5g==
X-Gm-Gg: ASbGncvv6yQqy96CdZ+b/3gDFH2RZvGfE9Bdjip6Vr3am0nLxanJkdsuVIkDuW+gKlc
	kEpivLNNP5r4SBfGgork6ZJrhg15X53FiB2HM/tIeZfkL/s25ld4mqZSus9oW4skeF/mF1hXPMc
	TMEErjWs8X1zvcblnE3atEPivjWai4PRIV/1Q4UqJUn5xm0g0LiYX1SGc7FlaerovQKJlUYTaRF
	P8pKC8xNGZWsOYr0Eq30YIWlAUgGg7s4i86zwQzLNRlNl6enKgcQjAlDDXmc3Z57d/OFntgw+FC
	EnQqdU5/r/MRWKsiwXiGebBssXiSmYorzpP7fDIS7ffP156Ll6iFdGJwIguJAxmYmdnQ+m6r7Ch
	iH47wmcQBY0OZC8ecEifrHv+8B2dhz6evAg6r3AQSNl34BWHEDV4gBBKlAgB3cNA=
X-Google-Smtp-Source: AGHT+IFgrO8Ncrqq+4A/cmmyJGbffL5WUyP9hfiMe85kNg5r66Z0zlRCako1lOTHiPISU60//YjCvw==
X-Received: by 2002:a05:6e02:2782:b0:3e5:4da2:93ad with SMTP id e9e14a558f8ab-3e676639feemr10482265ab.11.1755560704218;
        Mon, 18 Aug 2025 16:45:04 -0700 (PDT)
Received: from google.com (2.82.29.34.bc.googleusercontent.com. [34.29.82.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e57e58c57dsm38431015ab.4.2025.08.18.16.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 16:45:03 -0700 (PDT)
Date: Mon, 18 Aug 2025 16:45:01 -0700
From: Justin Stitt <justinstitt@google.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-hardening@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] MIPS: sni: Replace deprecated strcpy() in
 sni_console_setup()
Message-ID: <2xo5aonnmv5wfyomeh3ju6x4m2x3akr2kcjwx3c25fxwgdgczm@v6m5gtp3apsf>
References: <20250817183728.612012-1-thorsten.blum@linux.dev>
 <20250817183728.612012-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250817183728.612012-3-thorsten.blum@linux.dev>

Hi,

On Sun, Aug 17, 2025 at 08:37:13PM +0200, Thorsten Blum wrote:
> strcpy() is deprecated; use strscpy() instead.
> 
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  arch/mips/sni/setup.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/mips/sni/setup.c b/arch/mips/sni/setup.c
> index 03cb69937258..fc7da12284f5 100644
> --- a/arch/mips/sni/setup.c
> +++ b/arch/mips/sni/setup.c
> @@ -13,6 +13,7 @@
>  #include <linux/export.h>
>  #include <linux/console.h>
>  #include <linux/screen_info.h>
> +#include <linux/string.h>

This include isn't strictly necessary but I suppose it makes the
dependency explicit.

Reviewed-by: Justin Stitt <justinstitt@google.com>

>  
>  #ifdef CONFIG_FW_ARC
>  #include <asm/fw/arc/types.h>
> @@ -80,7 +81,7 @@ static void __init sni_console_setup(void)
>  			break;
>  		}
>  		if (baud)
> -			strcpy(options, baud);
> +			strscpy(options, baud);
>  		if (strncmp(cdev, "tty552", 6) == 0)
>  			add_preferred_console("ttyS", port,
>  					      baud ? options : NULL);
> -- 
> 2.50.1
> 
>

Thanks
Justin
