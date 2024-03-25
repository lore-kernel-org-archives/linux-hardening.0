Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99B0199B4
	for <linux-hardening@vger.kernel.org>; Mon, 25 Mar 2024 19:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711395145; cv=none; b=ReaAvQoFUvUn3Y4zQsEgE63cNbKWpLNgwnH7APdCbNDhQFPy0YrMRXTsmDN8TpdWTWBpkjJfdpk8LNGNevv6mPymNkcEFidgjkMWyEm35cApFLwTFval+gQBDqCM7NtJVcIotg+T5BSIUd2/j927Yh1CqWZ1gjZtsQ6gIvk+oG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711395145; c=relaxed/simple;
	bh=wBbTvs8a684vKOnj8w74k+eidd++ilzlw0L2ptoiWDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bR17FZpR3BXMl37e7H6VoNy38Qls1JBgiI1sM4ADn61QSZi5UXjZ+p5K0mvyx34pZOYoSVsEpf7hF96u1QuTuWVhBliuKnYm8T6nhVVFShuwomvCW/Jve3/+iFtn2KYbHv1+nHskaLasTT7zgCyf/FsUNx5gUPdx8a11oXEFNqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Tt9y8gqe; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Tt9y8gqe"
Date: Mon, 25 Mar 2024 15:32:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711395138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1gryeiILn0m+T/+WOsFBV2kucx78V+7dn4UI+UGeudY=;
	b=Tt9y8gqecpCFTIL+y/osjlhWrpo1KQtb/1UXfmFeze654xW6zkDcEyie11UoFjNjp4BXp9
	oZP1t2r17ya36MzSoPE3/EfxxXiNsLPXf7EoIbhni7lnDr7tntgBdh7Yphl73XODtkfzFy
	eoEKO/4ji3L41u98P86ayEAcTjMOSPo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Kees Cook <keescook@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>, 
	Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, "GONG, Ruiqi" <gongruiqi@huaweicloud.com>, 
	Xiu Jianfeng <xiujianfeng@huawei.com>, Suren Baghdasaryan <surenb@google.com>, 
	Jann Horn <jannh@google.com>, Matteo Rizzo <matteorizzo@google.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	jvoisin <julien.voisin@dustri.org>
Subject: Re: [PATCH v2 0/9] slab: Introduce dedicated bucket allocator
Message-ID: <24vn56fs7oohqgw3rhssiwglmviruqnt44y6oeajzvskostcrr@7jzhmxjbhcha>
References: <20240305100933.it.923-kees@kernel.org>
 <5e1571de-2c5a-4be4-93f4-01582094ee96@suse.cz>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e1571de-2c5a-4be4-93f4-01582094ee96@suse.cz>
X-Migadu-Flow: FLOW_OUT

On Mon, Mar 25, 2024 at 10:03:23AM +0100, Vlastimil Babka wrote:
> On 3/5/24 11:10 AM, Kees Cook wrote:
> > Hi,
> > 
> > Repeating the commit logs for patch 4 here:
> > 
> >     Dedicated caches are available For fixed size allocations via
> >     kmem_cache_alloc(), but for dynamically sized allocations there is only
> >     the global kmalloc API's set of buckets available. This means it isn't
> >     possible to separate specific sets of dynamically sized allocations into
> >     a separate collection of caches.
> > 
> >     This leads to a use-after-free exploitation weakness in the Linux
> >     kernel since many heap memory spraying/grooming attacks depend on using
> >     userspace-controllable dynamically sized allocations to collide with
> >     fixed size allocations that end up in same cache.
> > 
> >     While CONFIG_RANDOM_KMALLOC_CACHES provides a probabilistic defense
> >     against these kinds of "type confusion" attacks, including for fixed
> >     same-size heap objects, we can create a complementary deterministic
> >     defense for dynamically sized allocations.
> > 
> >     In order to isolate user-controllable sized allocations from system
> >     allocations, introduce kmem_buckets_create(), which behaves like
> >     kmem_cache_create(). (The next patch will introduce kmem_buckets_alloc(),
> >     which behaves like kmem_cache_alloc().)
> > 
> >     Allows for confining allocations to a dedicated set of sized caches
> >     (which have the same layout as the kmalloc caches).
> > 
> >     This can also be used in the future once codetag allocation annotations
> >     exist to implement per-caller allocation cache isolation[0] even for
> >     dynamic allocations.
> > 
> >     Link: https://lore.kernel.org/lkml/202402211449.401382D2AF@keescook [0]
> > 
> > After the implemetation are 2 example patches of how this could be used
> > for some repeat "offenders" that get used in exploits. There are more to
> > be isolated beyond just these. Repeating the commit log for patch 8 here:
> > 
> >     The msg subsystem is a common target for exploiting[1][2][3][4][5][6]
> >     use-after-free type confusion flaws in the kernel for both read and
> >     write primitives. Avoid having a user-controlled size cache share the
> >     global kmalloc allocator by using a separate set of kmalloc buckets.
> > 
> >     Link: https://blog.hacktivesecurity.com/index.php/2022/06/13/linux-kernel-exploit-development-1day-case-study/ [1]
> >     Link: https://hardenedvault.net/blog/2022-11-13-msg_msg-recon-mitigation-ved/ [2]
> >     Link: https://www.willsroot.io/2021/08/corctf-2021-fire-of-salvation-writeup.html [3]
> >     Link: https://a13xp0p0v.github.io/2021/02/09/CVE-2021-26708.html [4]
> >     Link: https://google.github.io/security-research/pocs/linux/cve-2021-22555/writeup.html [5]
> >     Link: https://zplin.me/papers/ELOISE.pdf [6]
> 
> Hi Kees,
> 
> after reading [1] I think the points should be addressed, mainly about the
> feasibility of converting users manually. On a related technical note I
> worry what will become of /proc/slabinfo when we convert non-trivial amounts
> of users.

There shouldn't be any need to convert users to this interface - just
leverage the alloc_hooks() macro.
