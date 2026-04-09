Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3982033260D
	for <linux-hardening@vger.kernel.org>; Thu,  9 Apr 2026 20:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775765989; cv=pass; b=oKE8xn/0r+cntQvm2NjVg4BJ0BZZj9ELCOi2kYfeXXi55SOGm3XOPKUn9+aFjvLyErx4lBLqDNm1SW9dSDWgJlJuXTCV50wnJKM/FIKGfc/u8tgOjYHQRJ8e1N7NDy655Km65ZdcJsVc9UzMOcnM4uzB3FVB8JIUd53w7Nf6yKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775765989; c=relaxed/simple;
	bh=RDN1p6W4IQhH95WIO0SfwAGjMDMJiLF3yAuqpAlJwVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zil9AXoW8ZXziuQQ8rUjYHTwdO3aN8e9VXBi8FhPnyOwVNcHj80tIHCQkMhlqiMfqdFJFWElTle/aQKC0cw/6KQojRzGYN7zIOAtUPGUQDJ2l7Hjv5q+fd/N7dVVRoXZgMqDrQL8FcWsYXPMpFW2eGsQnpI73ADdzgxCxdbZ88c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SbYoHP38; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SbYoHP38"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1273349c56bso1791978c88.0
        for <linux-hardening@vger.kernel.org>; Thu, 09 Apr 2026 13:19:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775765986; cv=none;
        d=google.com; s=arc-20240605;
        b=fdtpdfWxw7dKYifva307Nl/NUZwUafTpx4c5j3b75EB/+5lRm+Ob6eNBI648DwJGWV
         oRdgukyRRQnGQyrZNjKJeazqzi/Tmq5GfCDMkfnQauzLuqs6hh7cZuNbcrh9/kSHGqeZ
         ZPl/MkF2Hb2MFwBiRZurg6Ne37Aiqf+zcUgmuLkO31dKPkffuhrvp55JfATeEUM0GPgf
         XsWw4ZlzvtWbTM8g9TgWBft352vZm81GUhk5szK9X/BirM3kn/YRb+OqOOjNs6FfMiIG
         MOuhC+2vpiH9fyHDxvFlqTSu4zvRB88Bjr6pLRnvxCp5BOQumID2xqM8nChN6VHpInMd
         JtYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=G8yxp814R8LsOCbjv5Tx3ImzbZaJM5uPFtadcPgr4Gc=;
        fh=gJpwgmYKpc+66EYhLTmGB2C3So1rR6i3+LGTHAbnbQA=;
        b=BJmPBHhDd0a67Oc40TAvJpSjh9DM4i5l4KkG6wtuIMJU71luDfzCtyFQcM8YdfgIOw
         A9VDtXklTbfUU/RVfPpLNIasPUm9c5kMGIRzCNM6A1Xp1VB9OnfoHJLuOqtZxNvzMjch
         3MTA8WwjcLbqYceYt1EZZYS9Ct74QPHHcO2vdhkUHMNLyT/Td8xF7OAXB6Xfcxfjspxn
         uON6e/4Q212hMzwE7mg39z7t88nO89E4xFgFNN7lr17fpOd1u2ouSYoG3vzE/FgDGU2A
         /cB0r8Q7FxjSpjztLvmcDY+BFRvHYnSZkvjg9wHR3Hy/E38wx7X0lxfMyK8v/c3KDsJ7
         kakQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775765986; x=1776370786; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G8yxp814R8LsOCbjv5Tx3ImzbZaJM5uPFtadcPgr4Gc=;
        b=SbYoHP38SaD2Pnl2GmuwycnO74rqVSMo+9Fh6GLNiGwlB145JtUVbPEmGqfD3DTi/w
         ZCmtV4u/I0PtEHZweUJOY0cUCfJRhBNmY/RN0sOonv7Zd6z9dlvc4AU2dbh7eEcD4P0d
         LmlIydZG0NOP6rUhk5uLYNwMuVbHkiZWltU1r/vSkSbSPfSg2y3X/eTFl1SpOj4eB8C7
         qkmF8Dles7T7oNhQZF4r6ZaRCsCvb4RGasHQtqlBZPyF//Zj3euBL2HYKaNSs2/nAgRJ
         PNgOS5svOBzdfSWPDk44inOG0XJUB9HRVTL9yJOVf+vf4oqhQBpDzL2EIPlEm47DQHh7
         0Yaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775765986; x=1776370786;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G8yxp814R8LsOCbjv5Tx3ImzbZaJM5uPFtadcPgr4Gc=;
        b=O9QIIPCsOloM6nixO5UU72XSHlCwSqaWO2v54jPSoG3A+3My5ZvbelznGZuJ6Iu+fC
         d65KoncThA6FwuV0FIPLMCIyscFr8Knu6vxIWhGftr8VbMYMQ3JiHFcx+ZehdpaligY6
         0MhnDEoGTcL8FGNuOjBmFaEo7NNW06hglDTtjG5jFUtaZDjg1wyGuvxQBznGtBuNP0BY
         gKWUO8LcsGakXh7avL1hgRY7CVeDT+RdXEcD9A8wxu6ox/aGwhg7ctfeWiBSUuhWuPIh
         6N+1QXTI+YWRV4Rj7rn6+3YeGqWA6YdCwo/D1SzW0UWgDLrAq+X89CsphjYe0tNwNWki
         LWkg==
X-Forwarded-Encrypted: i=1; AJvYcCW6Vd9npixMz1X5ANdrTQKVnTJ8iI+2cDHjwJCmo7zKhmdG74Uca152RuXpxFa6tE9W3sSold7TSf4aj7/9d/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWmqAil/XTLt02GTiwyRRxhBnbe5VCbo+HFJlLFa2v0lS/bNz7
	kvrOItAPxZnOXHUFNmCrG6j2BWSaILHSP93cKsyuLaf2Pd9EU2xBDFzQdNwMl6NqX3Mq+NOtGAz
	VzCOZPlumjBmUx/+4QhZALZgRDElTODZ6a1dpHgFl
X-Gm-Gg: AeBDieuDHs5IUuZE4q6X3VwJgIUzfu+tnFh64NGd8hJiku7YlGPDjy8RxowyMzxtf2/
	vHRzNOvIc7yNqmMc638HJz3LVxzOcPWsVF0Au7Xq5cUutw83ITc9MNy6MGbVrrm9jk2NpO0OXWQ
	Fe+hKle+c9mwCQRj+B/tWI6Llo8RulfJi4FZd46UIyo4LYfcoy4qXGRS1185y0e4Cm9ix7v0hS/
	4POVh+LnJHCY0LvhGDBfiQM+UfPs/EN48HLIpohdfnfjHgd9aLfm0pVhP2YRzdFyNU4ickBDBW3
	NmawLdP09Qtnad9T1wuvDWf04Q598NzaoYs8H2OLVFLz9chx
X-Received: by 2002:a05:7022:ff43:b0:128:d1c9:3633 with SMTP id
 a92af1059eb24-12c34ea93bamr326968c88.13.1775765985689; Thu, 09 Apr 2026
 13:19:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331111240.153913-1-elver@google.com> <ac9d5O5XehnXRc5A@hyeyoo>
 <d0fe363c-2e8f-44a4-9b64-3fa3ba9a5773@kernel.org> <adM2XVZf1DekahlY@hyeyoo>
 <CANpmjNMeaWWuDMAj_n38U9XRqgZQz30ca82Vy10Bg=NoDfZ5ng@mail.gmail.com> <adT-gkVmVDDXR1h_@hyeyoo>
In-Reply-To: <adT-gkVmVDDXR1h_@hyeyoo>
From: Marco Elver <elver@google.com>
Date: Thu, 9 Apr 2026 22:19:09 +0200
X-Gm-Features: AQROBzARAi5e7VBJC9ZT2jVCPDAMFQKWBBwNXJCnP3Ii1ddqjsxmVTwsC-HQUUI
Message-ID: <CANpmjNO1aNm3mKphDGWasK_NUfVY8q4K9GCjyREZFqrOu9WLcw@mail.gmail.com>
Subject: Re: [PATCH v1] slab: support for compiler-assisted type-based slab
 cache partitioning
To: "Harry Yoo (Oracle)" <harry@kernel.org>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Dennis Zhou <dennis@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, Hao Li <hao.li@linux.dev>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, kasan-dev@googlegroups.com, 
	llvm@lists.linux.dev, Andrey Konovalov <andreyknvl@gmail.com>, 
	Florent Revest <revest@google.com>, GONG Ruiqi <gongruiqi@huaweicloud.com>, 
	Jann Horn <jannh@google.com>, KP Singh <kpsingh@kernel.org>, 
	Matteo Rizzo <matteorizzo@google.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Apr 2026 at 14:54, 'Harry Yoo (Oracle)' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> On Tue, Apr 07, 2026 at 01:17:14PM +0200, Marco Elver wrote:
> > On Mon, 6 Apr 2026 at 06:28, 'Harry Yoo (Oracle)' via kasan-dev
> > <kasan-dev@googlegroups.com> wrote:
> > > On Fri, Apr 03, 2026 at 08:29:22PM +0200, Vlastimil Babka (SUSE) wrote:
> > > > On 4/3/26 08:27, Harry Yoo (Oracle) wrote:
> > > > >> diff --git a/include/linux/slab.h b/include/linux/slab.h
> > > > >> index 15a60b501b95..c0bf00ee6025 100644
> > > > >> --- a/include/linux/slab.h
> > > > >> +++ b/include/linux/slab.h
> > > > >> @@ -864,10 +877,10 @@ unsigned int kmem_cache_sheaf_size(struct slab_sheaf *sheaf);
> > > > >>   * with the exception of kunit tests
> > > > >>   */
> > > > >>
> > > > >> -void *__kmalloc_noprof(size_t size, gfp_t flags)
> > > > >> +void *__kmalloc_noprof(size_t size, gfp_t flags, kmalloc_token_t token)
> > > > >>                            __assume_kmalloc_alignment __alloc_size(1);
> > > > >>
> > > > >> -void *__kmalloc_node_noprof(DECL_BUCKET_PARAMS(size, b), gfp_t flags, int node)
> > > > >> +void *__kmalloc_node_noprof(DECL_BUCKET_PARAMS(size, b), gfp_t flags, int node, kmalloc_token_t token)
> > > > >>                            __assume_kmalloc_alignment __alloc_size(1);
> > > > >
> > > > > So the @token parameter is unused when CONFIG_PARTITION_KMALLOC_CACHES is
> > > > > disabled but still increases the kernel size by a few kilobytes...
> > > > > but yeah I'm not sure if we can get avoid it without hurting readability.
> > > > >
> > > > > Just saying. (does anybody care?)
> > > >
> > > > Well we did care enough with CONFIG_SLAB_BUCKETS to hide the unused param
> > > > using DECL_BUCKET_PARAMS(),
> > >
> > > Hmm yeah.
> > >
> > > I wasn't sure if we could do this without hurting readability,
> > > but perhaps we could...
> > >
> > > > so maybe extend that idea?
> > > > I think it's not just kernel size, but increased register pressure etc.
> >
> > I'll take a closer look at generated code.
>
> > In some cases the compiler ought to omit zero-sized arguments,
>
> Oh, didn't know that was a thing.

So I checked with Clang and GCC. Looks like Clang does omit the
zero-sized struct argument, i.e. generated code is identical to
before. Whereas GCC wastes a few bytes of stack space at callsites.

Which is sad, because that means we need the macro workaround.

Do you want to be credited with Co-authored-by - in which case I need
your Signed-off-by.

> Not sure if it's safe to do that for exported functions though (since
> modules can be built w/ a different compiler).

Kernel modules built with a different config (implicit if different
compiler) are not supported, and never have been. If it works, it's
just luck (I know people do this, but it's just a disaster waiting to
happen).

Thanks,
-- Marco
