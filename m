Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8C23E277B
	for <linux-hardening@vger.kernel.org>; Thu, 21 May 2026 12:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779367629; cv=pass; b=NwChN3Fc5S4cUBH4NoXEZKJ+t3sUXKqLltr74P4Ly/7KtTLlGTXkWrQaWKG0vQfiLgtamxz2B+/DBKCB1NaRH/NAAaHttjLd2LSWaNgXFc70SoQu7FR3cVKHzChrFBlGM/L+pZ2Yfcpn4VduBbBeDdaVxFhsTAxYun26X7T+ddc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779367629; c=relaxed/simple;
	bh=dkW6i0lPC1xs4pyupGvRdPXCA8v/Dbo9IGMvyg0RV0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JZ2MyK7T1Gs0Y1NZvgnUqahTL6MQvMH9HU18d6/dtZb+zg5cbgeSI3ikbWPXxSyPvVytdEjCyP6gEhvjfDJ2aWNDDDDnJPlCp4aHBw/gRqLQXUsQUS1yao3CVPZ2IlWmi8Yzs4JOOW3v0ogvVnyhMs1duPIm5fNcpCso2pMqM9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pqO1wQTA; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pqO1wQTA"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-132d1b2519eso13418485c88.0
        for <linux-hardening@vger.kernel.org>; Thu, 21 May 2026 05:47:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779367626; cv=none;
        d=google.com; s=arc-20240605;
        b=MvsvFvZFdfnkawO3NbUGh0vA1LbzWmOBhDQDIohSXF8+R2kV4BGbakSikPo+qM3Qf6
         MkT8vb3JcPVGh374J9+2DONYPmLXwI92EItixuldZwdrjSgAptl/NxsC7+LNWCimY9AD
         ShFay/zyiTGkycyRtAEw7usdmui4vGK7wW2N1Sq2fOmf+2aKwsnyxTCZv2p2YSo01Bux
         FF+4MfmiiDug9EBrVjv5fD6a4lllTDN+dJkWREiw2efpn5mi1fJy82hOvGZv6SoC2G5T
         elz8o1HMxswGdyR0MD5Z+tfgje70e9kxMWEDu0LdeDQDrf6AM3KT4qrKXdcHHBhffW3h
         6btA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bfHkA0nrfTMBedFezUAOt262MiL/f21Ttj4Z491TkXA=;
        fh=ckSD9V0qjouUtpesJ+2qdrg2kxcayongW/3RGeESLBY=;
        b=ATWZ0HloJXllnjbAl9+gUr7tzfd5wH94D7IttmV2rwyB5+3IVscKXqYU4K5Byaohlh
         uKbpLnOIEGgO/KTJawXKfGGQn2nsdl2kxZ+rPsFoG3jE5YZ07Nl9EdozoCOuH9GIdJex
         kr3wTsju01wm4htLfOWp6mjWPu9NTEKdTT3OESocyuzr1HqPabMDjtcDqi6kC9MAseK5
         8P0bBM6pSKSEaFUpvld3S8RPfMAv7owPeDyFGN402Em6qrY8bnL7yzmnZNXwPZBVbI5g
         guvkHK9nJlduQ3RsBDjbB3R0CHwSnZeyfUlxcocWAClZmENhcx+ZiI+xBsxh5dOyHxV2
         Ed6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779367626; x=1779972426; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bfHkA0nrfTMBedFezUAOt262MiL/f21Ttj4Z491TkXA=;
        b=pqO1wQTAhhMdjPEbskBLH8lhyTpJu1f+9nec/y1YDxrnufRzWE94nwCuuwokT4Tbhk
         9v1iL22b59XytWXtFQOmqeTs7ontyrEfJAKBQG9zOYuE+mss4rim3AMlBN3zk0iMA+Lc
         ZMDZQtykH88nRPsjfmqt2RnaQyIQoApUNe8ezITZt+Pp+NlnvqIJTqB19bviVu5gZxei
         Z04OssLatmcoF0GRdHwZPtIGDDY4doZXDRDEUzDxX+mWdfe21FGsMkb/Mi/eT3tL1gfl
         zyGp7NlKaySca/NY7JZ6M26CZhLPv16D9deZZGYc1Wu3mcgGkGQ2Va+gfeUA9CYOiBpk
         ykCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779367626; x=1779972426;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bfHkA0nrfTMBedFezUAOt262MiL/f21Ttj4Z491TkXA=;
        b=P0WcZCB5CcLq9NLIEmE8uhdPnnaPeEFguC1ocCI6YmPUVf2jWXitxaQg8j4IXGeXaH
         uJB1CdzNo+7v/bx1aLcmKWcgCJUKhygy+1R9wc43Q3TD4EaN3C20qxTxrD8wwJT01ys9
         2db56/5wlJOSr+KqvQjHmQZ2h/TTQPMRSUUjjSkT0HWDNWPE8bdewC4YW+G25O7r6l1/
         dHNQETAG7PdTyigr9AGA8qQStv+6quF29POQrOWdMECu2TTNkV9Zwdd1Lill24ethSyj
         CKBnqjaMGBGH/jDrIZWs/ZrodHd0gycqtGheNBROxDA3BsaX4az8D56Bz9ThvSFzSTPn
         /mwQ==
X-Forwarded-Encrypted: i=1; AFNElJ/J8kyCXjIZu50khjcZj+IexxCWo0dCwdMl26FgfjeBk529ufzJ0pCBYRoO3Nc09id6j4t8z8Q4am//EJyN4vw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrGVI9qICMx9/QSt0f9UHcrihHYB2HLpuChevNsGNsW4XMtoHK
	toKj+WdU91BFngX3LF7+1KZfX409Ybt5zCWaxwwEoCVnWtOtCqNF+TaIGvJasUMW3MNFY2k8+26
	XbWynf+v26P1tlh06wdIZKovz+7jObUglrZjIpxUw
X-Gm-Gg: Acq92OGllqZq3Ce2ffhxabOTRjX+Dxcc+zHBIxSpmb0c/GXpmV+zW/kQRmzKoGqjaDn
	9/HGzgwoltYejWwZLDLbRbSQXUF/f+qo46HF+FDZumvdB/LQGQ1B8rQEVdAFZFD8e1Hc1Z7ag3r
	hahktLJS62lxqfSVJxIJw/F5rSZ/q7iqZJzbpCGbGk4RYbsYBRL0jMDcvu70XaNqaLXnOE/ER/u
	Xj7EGjxCqjRyt/2dZNaZonjGtIQ7YZ1hXRXm0yc/PsOvdx8S7o0nofvrNTeBrBc+pxQbd8NswJm
	rukReHTf98wvvTlEL5UfnzEFi0rBLl0kEa6Nbtxv5h3Spocf
X-Received: by 2002:a05:701b:271a:b0:133:54fb:f563 with SMTP id
 a92af1059eb24-13632d47501mr902318c88.23.1779367625531; Thu, 21 May 2026
 05:47:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521124026.work.036-kees@kernel.org>
In-Reply-To: <20260521124026.work.036-kees@kernel.org>
From: Marco Elver <elver@google.com>
Date: Thu, 21 May 2026 14:46:28 +0200
X-Gm-Features: AVHnY4L3IHnERTLKoV3YcNfiEp2Dd5pISRDPTRx2YrQ-J231SBVM-n7vqCXkjZ8
Message-ID: <CANpmjNNPXZmabX+A=38JhTb6_rPWTvE9RfJGs3KiA3X6dthbzA@mail.gmail.com>
Subject: Re: [PATCH] mm/util: Use kmalloc buckets for kmemdup_nul()
To: Kees Cook <kees@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 May 2026 at 14:40, Kees Cook <kees@kernel.org> wrote:
>
> The use of the kmemdup_nul()-family of allocations are explicitly for
> allocating NUL terminated strings, so these would be best separated from
> typed allocations, as they are their own set of arbitrarily sized
> allocations. They are not as risky as userspace controlled allocations,
> but these would be good to separate as well.
>
>   # grep memdup_nul /proc/slabinfo | cut -c-25
>   memdup_nul-8k          0
>   memdup_nul-4k          0
>   memdup_nul-2k          0
>   memdup_nul-1k          0
>   memdup_nul-512        28
>   memdup_nul-256         0
>   memdup_nul-192        60
>   memdup_nul-128        60
>   memdup_nul-96         60
>   memdup_nul-64        180
>   memdup_nul-32        960
>   memdup_nul-16       1860
>   memdup_nul-8        1980
>
> Suggested-by: Harry Yoo <harry@kernel.org>
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Vlastimil Babka <vbabka@kernel.org>
> Cc: Marco Elver <elver@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@kernel.org>
> Cc: Lorenzo Stoakes <ljs@kernel.org>
> Cc: "Liam R. Howlett" <liam@infradead.org>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: <linux-mm@kvack.org>

Acked-by: Marco Elver <elver@google.com>

> ---
>  mm/util.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/mm/util.c b/mm/util.c
> index 3cc949a0b7ed..419269bb53da 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -34,6 +34,9 @@
>  #include "internal.h"
>  #include "swap.h"
>
> +static kmem_buckets *user_buckets __ro_after_init;
> +static kmem_buckets *nul_buckets __ro_after_init;
> +
>  /**
>   * kfree_const - conditionally free memory
>   * @x: pointer to the memory
> @@ -61,7 +64,7 @@ static __always_inline char *__kmemdup_nul(const char *s, size_t len, gfp_t gfp)
>         char *buf;
>
>         /* '+1' for the NUL terminator */
> -       buf = kmalloc_track_caller(len + 1, gfp);
> +       buf = kmem_buckets_alloc_track_caller(nul_buckets, len + 1, gfp);
>         if (!buf)
>                 return NULL;
>
> @@ -195,15 +198,14 @@ char *kmemdup_nul(const char *s, size_t len, gfp_t gfp)
>  }
>  EXPORT_SYMBOL(kmemdup_nul);
>
> -static kmem_buckets *user_buckets __ro_after_init;
> -
> -static int __init init_user_buckets(void)
> +static int __init init_buckets(void)
>  {
>         user_buckets = kmem_buckets_create("memdup_user", 0, 0, INT_MAX, NULL);
> +       nul_buckets = kmem_buckets_create("memdup_nul", 0, 0, INT_MAX, NULL);
>
>         return 0;
>  }
> -subsys_initcall(init_user_buckets);
> +subsys_initcall(init_buckets);
>
>  /**
>   * memdup_user - duplicate memory region from user space
> --
> 2.34.1
>
