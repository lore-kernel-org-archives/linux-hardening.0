Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48D92BE053
	for <linux-hardening@vger.kernel.org>; Thu,  5 Feb 2026 08:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770281643; cv=none; b=iLwv02Gx1wGC75Hb8duFzEJMl1ief8d2Y1ayqcw/MLd9K2aG94hLhC/0TxmLpwf2XImMqV+t4+2ioAClAyK/IbJudeUquuAXR9pbX1G1uQOjREBQOCXETXzw/TsGZHYUsGrJcrRKJsvDvg6JaLh3y+qjoJVLZYDsn0RFyPh4AOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770281643; c=relaxed/simple;
	bh=8Ud5KZqbUXkKx9YEHMMR1n4ewjTIPhDWsP0iGDJn2h0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LHAtlVdu8WM5mqxQSWHlMBf8u37XLG4ESOwfV8PIBTf/bUEsgTmvN2U2zSs0vYJgwwZgLZBKKba6yks9ccKwDmPHcyjWcx+hKDBs3xWNZVxPyBJd1ZI1jsU3nw9B9oXE36DxUlANGMGP5O8xjxvfesxzMx/32B70h5DuCDZhTEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SLHPrE0v; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SLHPrE0v"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43626796202so79940f8f.3
        for <linux-hardening@vger.kernel.org>; Thu, 05 Feb 2026 00:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770281641; x=1770886441; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WU7C8rJBZ4r5s92pw84UJSyynxDDIXXSUn6SFXmn01U=;
        b=SLHPrE0v9hoFddecXZuUfFwkCrSk+ryl046M7oEspcwVqlaAud984kz5SqEOHc0zyg
         fUc0oQAMa5PXWFQMGjFWsygJtx0L8+5nIqFIs2YXdc0bcql6STl6Cw6AYVUZnDFgjHWy
         efyEph50Z9N0r45A6XAn2fCSsP61sebzAjFVnt73hYl/W6wHkeG4Ok3ZkoxkC+BNIjFr
         FIxy8oBf6Sd+jrNsGHHU0ufqiZ4KnjdB95a5kU+l19938vRhvSZOOa6sUY9MnCv6PxVR
         kuoPsBoHyivlk+96UB85qeeD8XSyqGvKQfcogMsEGs6+IIxAgvOsdqx3sIoa4gY7f45S
         8Ckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770281641; x=1770886441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WU7C8rJBZ4r5s92pw84UJSyynxDDIXXSUn6SFXmn01U=;
        b=T8fVaIb15KRM6uTnj2mES+CPdfWBOx0TGwdWQQzIM4Z1A83P9/g7FYa6fdenGnFsTT
         SWM/EfApSu+VSnOnAp882dtEv9qEvy2GgEBwg6Q4fCf4RQa5ht8VG4EyZ/GR02QNmiiZ
         hF9MBu7R0RXpyU1dtavmp75nfuHEjJS9k0zRJr1Yj8tuLOjaLu7ENiuMwcpOyNV+kKQv
         WeMzqvLv4MCG0y31ya+nUPkhFTs9NmNPjsKHyj38lSsyfMOqOTG3LI2xyipknoT0C3nB
         7FcpNgdmHdC/F9nZB0mkVdrFjWCMaTQSycJCArRsyeu8xmPPDRVNisAVErsiEuP/VV4N
         KY9A==
X-Forwarded-Encrypted: i=1; AJvYcCWnDjdBQcs89B+jhrSzdTCuByBT/4lZ0Nkv0OTxZPYAY1jW1jGq8dDB4OP/JloiNBJXyCVQ8Qz8VhH4kS6RqqY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk/ZscxIZAheS/dq8wp2PDA0X9pqpV9mHxwcG9Gfv5A4pp1GBh
	F2+Xkg1Hs5jfrmZVfGPEdGalJlivHLeuOtIv8GlDZEnKNyjNaPtwl8Y8ik0auydnLZI=
X-Gm-Gg: AZuq6aIMBTA0O2z9/UdH7Epo4Fhq8sZwTdeiROSvCGij3RDWvbsvLA8kqYNcqfrzOcd
	ICKEWplcC0vmXUsv68gmCUmxStcJfZYHBRhoEd/1RK/Za90QAMTuMvhtYVH3GgVWimEytweHlKa
	8bl9JmoLNCe1WN2elBznyJ1lN5PIhOU6oiVEuXy5fPrxpAd3+IsHUE7B8YEmNnztbt9NPA1uxLm
	VbnvjhBL7CA/1trdBI7eyMK9E+UBrHlmeqgcBBA8PJvEPqc/LwOsMQV826wSFCvD6u0wWT+19hw
	tTL53WPsY4EF28wEBz1DSsYGIiXv6SayLRwKBkgxdmB9QpUo1XXMxuvf2E29VE485cihIGWxmUe
	p3HHotmKD9Bz019fd47omPZ4ibQqx98dHY9ZYj/sYALLrqjsN1LHvkdVQeWvCO8n0qPVFNDMwac
	n3+jrh5UXTnnmuji3hnn7lY3Cz
X-Received: by 2002:a05:6000:2011:b0:435:9950:ee1 with SMTP id ffacd0b85a97d-43617e37d52mr8503856f8f.3.1770281641118;
        Thu, 05 Feb 2026 00:54:01 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4361805f25dsm13272553f8f.29.2026.02.05.00.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 00:54:00 -0800 (PST)
Date: Thu, 5 Feb 2026 09:53:57 +0100
From: Petr Mladek <pmladek@suse.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andy Shevchenko <andy@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] vsnprintf: drop __printf() attributes on binary printing
 functions
Message-ID: <aYRapf5K8wFGEO8v@pathway.suse.cz>
References: <20260204132643.1302967-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204132643.1302967-1-arnd@kernel.org>

On Wed 2026-02-04 14:26:23, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The printf() format attributes are applied inconsistently for the binary
> printf helpers, which causes warnings for the bpf_trace code using
> them from functions that pass down format strings:
> 
>     kernel/trace/bpf_trace.c: In function '____bpf_trace_printk':
>     kernel/trace/bpf_trace.c:377:9: error: function '____bpf_trace_printk' might be a candidate for 'gnu_printf' format attribute [-Werror=suggest-attribute=format]
>       377 |         ret = bstr_printf(data.buf, MAX_BPRINTF_BUF, fmt, data.bin_args);
>           |         ^~~
> 
> This can be addressed either by annotating all five callers in bpf code,
> or by removing the annotations on the callees that were added by Andy
> Shevchenko last year.
> 
> As Alexei Starovoitov points out, there are no callers in C code that
> would benefit from the __printf attributes, the only users are in BPF
> code or in the do_trace_printk() helper that already checks the arguments.
> 
> Drop all three of these annotations, reverting the earlierl commits that
> added these, in order to get a clean build with -Wsuggest-attribute=format.
> 
> Fixes: 6b2c1e30ad68 ("seq_file: Mark binary printing functions with __printf() attribute")
> Fixes: 7bf819aa992f ("vsnprintf: Mark binary printing functions with __printf() attribute")

From the commit message, it is not obvious why reverting these commits
won't bring back the warnings in the modified functions.

My understanding is that the warnings won't get back thanks to
the commit bd67c1c3c353b6560 ("vsnprintf: Silence false positive
GCC warning for va_format()") as explained by the original cover
letter, see
https://lore.kernel.org/all/20250321144822.324050-1-andriy.shevchenko@linux.intel.com/#t

It would be worth to mentionin this in the commit message.

> Link: https://lore.kernel.org/all/CAADnVQK3eZp3yp35OUx8j1UBsQFhgsn5-4VReqAJ=68PaaKYmg@mail.gmail.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202512061640.9hKTnB8p-lkp@intel.com/
> Reported-by: kernel test robot <lkp@intel.com>
> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Acked-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> For reference, three additional patches are required before we can drop
> the Makefile.warn line that currently hides these warnings:
> 
> https://lore.kernel.org/lkml/20260203162546.2254900-1-arnd@kernel.org/
> https://lore.kernel.org/lkml/20260203163440.2674340-1-arnd@kernel.org/
> https://lore.kernel.org/lkml/20260203164545.3174910-1-arnd@kernel.org/
> 
> Tested using randconfig builds on arm/arm64/x86
> ---
>  include/linux/seq_file.h | 1 -
>  include/linux/string.h   | 4 ++--
>  2 files changed, 2 insertions(+), 3 deletions(-)

Otherwise, the change looks good to me. Feel free to use,
ideally with the updated commit message:

Acked-by: Petr Mladek <pmladek@suse.com>

I wonder who should take this patch. Should it go via
printk/bpf/tracing or another tree?
Does anyone has any preference, please?

Best Regards,
Petr
