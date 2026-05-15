Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A8748AE3E
	for <linux-hardening@vger.kernel.org>; Fri, 15 May 2026 15:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778857766; cv=none; b=VvWn1+b5zfFHGCJshfJKpbgGyFVq3CBsRaAo5ZIZivmpRMt63fUaWqLdNim4n8Au2FVlT5C13VxhXrSf/iaq568S0P6LGFG0lJTWVyR1kVbtEG6C7HFRu2j7hmUHpJseWuSH2HgM5hSMexeH2YGZ9aIpQlbYjf4BB9tlK8qbnrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778857766; c=relaxed/simple;
	bh=CsGkRRMWVPsm0bpA/qBbuJrDLzaJTsgMzkh70YVJz2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PHARVkfntL6ViYjQSLfdZuGDjZoJMmqCLFPdU/SJYBjUhYbuX7U0Qa4Nsxzqr6fLiwds8AGwKHdMif5ttXVTB6RCbYB5xKBjVWIT5vVMTiipfk6hlKUI2M9egf8uymRE9FCOl5exIFBNhS4zf8lWluO7G86HuWBzIC/BdSOjFKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 15 May 2026 17:09:02 +0200
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] string: use min in sized_strscpy
Message-ID: <agc3DrODtyc2rF27@linux.dev>
References: <20260514165601.527883-3-thorsten.blum@linux.dev>
 <CAHp75VfQNkqEYsO4Uup0c-uiYuVyAWit=tmCz2BsYLp-sjXsZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VfQNkqEYsO4Uup0c-uiYuVyAWit=tmCz2BsYLp-sjXsZw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, May 15, 2026 at 09:45:08AM +0300, Andy Shevchenko wrote:
> On Thu, May 14, 2026 at 7:56 PM Thorsten Blum <thorsten.blum@linux.dev> wrote:
> >
> > Use min() and drop the limit variable to simplify sized_strscpy().
> 
> ...
> 
> > -       if ((long)src & (sizeof(long) - 1)) {
> > -               size_t limit = PAGE_SIZE - ((long)src & (PAGE_SIZE - 1));
> > -               if (limit < max)
> > -                       max = limit;
> > -       }
> > +       if ((long)src & (sizeof(long) - 1))
> > +               max = min(PAGE_SIZE - ((long)src & (PAGE_SIZE - 1)), max);
> 
> Side note: Isn't simply
>                max = min(PAGE_SIZE - offset_in_page(src), max);
> 
> ? (One will need to include linux/mm.h for this, though.)

I thought about it, but wasn't sure if pulling in all of linux/mm.h into
lib/string.c is worth it.

> Moreover there are plenty of duplications to count the size in the
> first page and even the similar min() as in
>   fs/iomap/buffered-io.c:869
>   arch/s390/kvm/gaccess.c:976
> and many more...
> 
> Perhaps a new macro with a good (famous last words!) naming?

How about adding

#define offset_in_page(p)	((unsigned long)(p) & ~PAGE_MASK)
#define bytes_to_page_end(p)	(PAGE_SIZE - offset_in_page(p))

to a new header, e.g. include/linux/page_helpers.h? There are about 50+
direct replacements and possibly more.
