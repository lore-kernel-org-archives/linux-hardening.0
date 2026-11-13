Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794595739;
	b=oQIsjIDRNjrKRvwjFzqrOHnkqc0MImt4oOYUYfR83wyuDmxdUOwML4qVnop6Cwl9xwJz
	 KXCFvMrVRKNO11j53sbfEFczwXyXDrIZwt8F20+NtLaIqRl99evVzTsGrkVg8gHg39d8h
	 dRmdArgJOx6dHDeZurtE0ZJcseEeTIFjXjwdtRtGlLgslJ8qV/ojLprJu0+r1tXOf7k3X
	 TQ6TYhn1/mLG2LyaBCqffuaHHgny0txmPoUAFoOh8ZwrXNjUaSoRdyAV9TRLMBDM1nw+F
	 UfLHBAN5Uze1KJ2dxcJK0Tl2pTJWtL525zCGz7SM/pBj8iw/3mmFLTwgFcry0XDBDQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794595739;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=4QthcyiX160Q2O1QLVhpEtRESs44jcv/A+FxN1Locc4=;
	b=5RoJX7+01uJHnxXlByUJ/BxK3IysaGZHGtJybtPgFF/xGi1NGmExfrNQ7WJNnArkzLuk
	 2LlwIeINezcYnbN3DxWCTWIXp56T9pN9Hy6WqM5v4dzjO8msJl6Jxa4prYKDTfbHrkr0u
	 kj8ssNJV3XeDthsF6Aj0dscYPr9k9YCHAqQbUC5CYjiAfOeU1qNuQ/Gd51K07osSBfp0F
	 sF6p2zgv9tEtXR5FfAfdVGqE5sY8zPHBEs/mgGcLtuP0hqyRWQ2jEJswP+Kz2sAb3R4Zz
	 AA/hcgT3y/B72WckZ7nFhyu4J07P5Y4WUdMielrfosxyw2lyBbYDuwfQdAma4fyf/Gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KM9Zundo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A9A606A644;
	Fri, 13 Nov 2026 18:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KM9Zundo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D3141F000C5;
	Fri, 13 Nov 2026 18:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794595738;
	bh=4QthcyiX160Q2O1QLVhpEtRESs44jcv/A+FxN1Locc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KM9ZundoTl/C+YRnnU78L9MVp1BzRd8EE2j13ChbAlxTVzDcNGS4mO3I5tLHPBi2u
	 BYEGgyNd8OumZ4JIQj27B01nx05UhAX7LynlAFmE2SKHQL/ggv/SodmJ6ne+VMwZPy
	 wPorpOp5FN0796vB5MiXuYp/z26K3ioFHVvuaaM89V8tl+xC9m8RxH9ARgR7AYnCiK
	 yYr4cY5ALq5WS4jStkYUz3ibMHWClD2mK1+TVzMD8WX73BIIIkzOMbzhmrBPlgTgKz
	 9RFVK+2fNI+3NMD0KQEbXC4lnIyDhdmggZD4Xnk0Cii4vm/uPUCsEr5yGeOYIyqnZF
	 +7+OMMzS3HLJQ==
Date: Fri, 13 Nov 2026 18:48:56 +0000
From: Harry Yoo <harry@kernel.org>
To: Marco Elver <elver@google.com>
Cc: Chris Down <chris@chrisdown.name>, Vlastimil Babka <vbabka@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Kees Cook <kees@kernel.org>, GONG Ruiqi <gongruiqi@huaweicloud.com>, 
	Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v3 0/6] mm/slab: Support selecting slab hardening
 features at boot
Message-ID: <avdbfEfQHpF9Ez-e@thinkstation>
References: <cover.1794506262.git.chris@chrisdown.name>
 <CANpmjNP0cWB_670hYj7p+Dd=do1qEu4XHeW+c7sTv-MXi0UBTg@mail.gmail.com>
 <avdQEBP70kK8W7d0@thinkstation>
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
In-Reply-To: <avdQEBP70kK8W7d0@thinkstation>

On Fri, Nov 13, 2026 at 06:36:49PM +0000, Harry Yoo wrote:
> On Fri, Nov 13, 2026 at 11:56:20AM +0100, Marco Elver wrote:
> > On Fri, 13 Nov 2026 at 09:51, Chris Down <chris@chrisdown.name> wrote:
> > >
> > > Slab hardening settings are currently all build time choices. This means
> > > that, unfortunately, hosts with different requirements end up needing
> > > separate kernel images. At Meta, for example, some hosts are built with
> > > these options and the rest of the fleet isn't, and that's one of the
> > > things that keeps those kernels apart.
> > >
> > > This series does two things:
> > >
> > > - SLAB_FREELIST_HARDENED and SLAB_FREELIST_RANDOM are cheap enough with
> > >   sheaves that it makes more sense to just enable them by default than
> > >   to make them switchable. With both on, system level benchmarks didn't
> > >   change measurably, only slowpath heavy microbenchmarks did [1].
> > >
> > > - SLAB_BUCKETS and KMALLOC_PARTITION_CACHES cost memory (Harry measured
> > >   about 1 MiB and 18 MiB respectively after boot on a 64 CPU VM [2]), so
> > >   they get slab_buckets= and kmalloc_partition= boot parameters, which
> > >   default to on when the option is built in.
> > >
> > > Whether those two should be folded into a single slab_hardening= is
> > > still open [3].
> > 
> > A coarse slab_hardening= option can easily be replaced by
> > documentation. While less knobs is better, an intransparent coarse
> > variant of slab_hardening= just makes the admin wonder "what does that
> > actually to, and do I want it?". They still have to go and look up
> > what it actually does, and at that point it doesn't add much value
> > (alternative suggestion below).
> > 
> > > > > light: "I'm willying to sacrifice _some_ memory and CPU for security"
> > > > > full: "I'm willying to sacrifice more overhead for security
> > 
> > Who will decide what is light and full? I think there just won't be
> > any consensus reached.
> 
> You're probably right.
> 
> > One thing that users may want is an "all off" option, similar to
> > mitigations=off, should they wish to get max performance back with a
> > single option. So you could consider slab_hardening=off.
> 
> slab_hardening=off sounds good to me.
> 
> However this assumes "all on" is the right thing to do by default,
> but not enabling slab hardening is not as nearly critical as not
> enabling mitigations to CPU vulnerabilities, no?
> 
> I'd rather mirror hardened_usercopy= instead of mitigations=off.
> 
> slab_hardening=on (turn on all slab hardening features)
> slab_hardening=off (turn off all slab hardening features)
> (Otherwise it is determined by CONFIG_*.)

Should have been CONFIG_*_DEFAULT_ON.

> > But at that point it may be more consistent to drop slab_buckets= and
> > kmalloc_partition= in favor of arguments to slab_hardening=, such as
> > slab_hardening=nobuckets,partition. This would mirror mitigations=,
> > and should cater to the usecase of slab_hardening=off to get max
> > performance with a single option.
> 
> I hope we don't reach this point, but more fine-grained control should
> be achivable if it is indeed required.
> 
> > But I would not add options such as 'light', 'full'.
> 
> Fair enough.
> 
> > Thanks,
> > -- Marco
> 
> -- 
> Cheers,
> Harry / Hyeonggon

-- 
Cheers,
Harry / Hyeonggon
