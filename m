Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3146F7D3ED
	for <linux-hardening@vger.kernel.org>; Tue, 30 Jan 2024 21:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706651835; cv=none; b=aIMhuROIllagHSpforuiFCKzxiBmwv61hpfZmmGE2DTRwXlsMXQofdnotdN06mYZM47EtldkHU3f+e5dPngyM2JdkiGjBeb71HxVnHtd9cL9RbLGEKZEMKPB/aWOTS3/VVfFptOLmEmqRfOFAVvkN4gp6EHcSWz5xjQRI5WoEfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706651835; c=relaxed/simple;
	bh=SJeL4VmwMt85IREwh/WCKzPi0aDbNEOX0Q8fiUCOSXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ufwwEf2NHB+D/XZvANtHmLi12VLuFsT/NxOb67a7I/KHsY71yqGJBXnxk2nZU1gFsiFRbe6yy/5gsbbVr6ONU3vmOMJVZ2H6pYbGMhhotbFliCC6E2OElZX0jgr8QVZljx31ymPXQoHUimUsuglGY+pjAri0TQWOT11HiTb2T9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dJRC3kZl; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dJRC3kZl"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-214d1139620so1299885fac.3
        for <linux-hardening@vger.kernel.org>; Tue, 30 Jan 2024 13:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706651833; x=1707256633; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jcDCGmwUxE4c0aGDkwHcRSvrmg1sdA6mlv/IQQCx6ZY=;
        b=dJRC3kZlZ0QuqNNAc+ZOtnJYEiQcV0bxkhdvcA2hWDjYHt2FCc287ErU93O3VtEkYp
         d3gdWLI7e5JMP3qED1klAe0VC5QS7FfOFuO1HGfPIwRBflGr9/wOZacdnUHUgCB19Hdx
         a0FzUQXv8qhIB9Xs+4FgD2GA3CzZhl+OxxJhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706651833; x=1707256633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jcDCGmwUxE4c0aGDkwHcRSvrmg1sdA6mlv/IQQCx6ZY=;
        b=SXBDwDlyV+62G/yQhC9eJZtN34yvVyhLHmpotBmNN1ybCKqGH9ciU1yw89Spuzb1Dk
         uQPTlb6X58ytT7smEhX7Em5HRosGGORYZ8I61aq+Bgd333pZtklfqub83BgVAYHHmEYu
         b167MQ85deAmoMM0HsmRqhnqO+BhbJl1gnsEiTZ+O8ChhTgKaq/G3tkqNJYNrAw6eHyj
         GSM/Kpu+zX21whRmY5tXIr6ayWwm4a1GPIYq873zp1I1ABCZgPEa+Fjdx1lD63ZS44ZS
         qRVC/K6OtyWf4lZgKMmJsuWRXdT1wN9hxxiaPhx/ScMJxysjFVinxLu3Z3kk1/l4bRGn
         6sqA==
X-Gm-Message-State: AOJu0YyVDTA81ifusozcyv+0TXNm3MY+qFWst07JeQtsQX3Fi1nY7dhO
	68r5QHqn2s4VC0tJozCJ+sYzbKyNsqttDNWH6Feep5XpHyUS0ykn+wnicqF9+6kPcU19DOtiDas
	=
X-Google-Smtp-Source: AGHT+IG7VNSkRKTfrFQKKzj3pYu2rCl/Sscr49lUqKuRxSTqkD3njddB8NnGkSXYSNCwoZUjctqxDg==
X-Received: by 2002:a05:6870:5707:b0:218:7079:6177 with SMTP id k7-20020a056870570700b0021870796177mr5357267oap.43.1706651833264;
        Tue, 30 Jan 2024 13:57:13 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 17-20020a630011000000b005c621e0de25sm2271749pga.71.2024.01.30.13.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 13:57:12 -0800 (PST)
Date: Tue, 30 Jan 2024 13:57:12 -0800
From: Kees Cook <keescook@chromium.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Lorenzo Stoakes <lstoakes@gmail.com>, linux-hardening@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 33/82] mm/vmalloc: Refactor intentional wrap-around
 calculation
Message-ID: <202401301356.4F87B727@keescook>
References: <20240122235208.work.748-kees@kernel.org>
 <20240123002814.1396804-33-keescook@chromium.org>
 <24526e13-2df6-47ea-865f-b5a5594bc024@lucifer.local>
 <ZblT2OjkPcZQEw7A@pc636>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZblT2OjkPcZQEw7A@pc636>

On Tue, Jan 30, 2024 at 08:54:00PM +0100, Uladzislau Rezki wrote:
> On Tue, Jan 30, 2024 at 06:55:57PM +0000, Lorenzo Stoakes wrote:
> > On Mon, Jan 22, 2024 at 04:27:08PM -0800, Kees Cook wrote:
> > > In an effort to separate intentional arithmetic wrap-around from
> > > unexpected wrap-around, we need to refactor places that depend on this
> > > kind of math. One of the most common code patterns of this is:
> > >
> > > 	VAR + value < VAR
> > >
> > > Notably, this is considered "undefined behavior" for signed and pointer
> > > types, which the kernel works around by using the -fno-strict-overflow
> > > option in the build[1] (which used to just be -fwrapv). Regardless, we
> > > want to get the kernel source to the position where we can meaningfully
> > > instrument arithmetic wrap-around conditions and catch them when they
> > > are unexpected, regardless of whether they are signed[2], unsigned[3],
> > > or pointer[4] types.
> > >
> > > Refactor open-coded unsigned wrap-around addition test to use
> > > check_add_overflow(), retaining the result for later usage (which removes
> > > the redundant open-coded addition). This paves the way to enabling the
> > > unsigned wrap-around sanitizer[2] in the future.
> > >
> > > Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
> > > Link: https://github.com/KSPP/linux/issues/26 [2]
> > > Link: https://github.com/KSPP/linux/issues/27 [3]
> > > Link: https://github.com/KSPP/linux/issues/344 [4]
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: Uladzislau Rezki <urezki@gmail.com>
> > > Cc: Christoph Hellwig <hch@infradead.org>
> > > Cc: Lorenzo Stoakes <lstoakes@gmail.com>
> > > Cc: linux-mm@kvack.org
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > ---
> > >  mm/vmalloc.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > index d12a17fc0c17..7932ac99e9d3 100644
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > > @@ -1223,6 +1223,7 @@ is_within_this_va(struct vmap_area *va, unsigned long size,
> > >  	unsigned long align, unsigned long vstart)
> > >  {
> > >  	unsigned long nva_start_addr;
> > > +	unsigned long sum;
> > >
> > >  	if (va->va_start > vstart)
> > >  		nva_start_addr = ALIGN(va->va_start, align);
> > > @@ -1230,11 +1231,11 @@ is_within_this_va(struct vmap_area *va, unsigned long size,
> > >  		nva_start_addr = ALIGN(vstart, align);
> > >
> > >  	/* Can be overflowed due to big size or alignment. */
> > > -	if (nva_start_addr + size < nva_start_addr ||
> > > +	if (check_add_overflow(nva_start_addr, size, &sum) ||
> > >  			nva_start_addr < vstart)
> > >  		return false;
> > >
> > > -	return (nva_start_addr + size <= va->va_end);
> > > +	return (sum <= va->va_end);
> > >  }
> > >
> > >  /*
> > > --
> > > 2.34.1
> > >
> > 
> > Looks good to me,
> > 
> > Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
> >
> Same here. One small nit though. The "sum" variable is not something
> that it suits for. IMO, we should use a better name and replace it:
> 
> "nva_offset"?

Sure, I can use that. Other folks in other patches have suggested "end",
so maybe nva_end or nva_end_addr ?

-Kees

-- 
Kees Cook
