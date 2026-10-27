Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793125900;
	b=gcxvO+wFQnbekB76UITMUmmFgDLTAe+dfPo5/lOoJ4KLoh/LZ4b0jdL5XDjr7m745uu7
	 4EBI6H7h6tFqSZMrRlgX7Cp7iWJ6GbD+iM9+jPMiROC9IM/SwHuZyy4M4w0jJNBLgpA5A
	 FRDso3nJbBqJy84XhiEyLj7K2nAER+Wv2v7NNywymb7KJLp7RFieDtzyu1fBnohKnQaJr
	 7H5NGk962bSCR+I3HzfniI5RvRLy2a20Nal/92PmOPmdntS6wE2RTKEtsinPBk5YJfPqK
	 E7xh8deEt0hTZ0OX7zNDWYFw6DByyg8Eqgx5nxduQLTOI+Nldjt3u5monJITduIz5ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793125900;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Zy1XjAvFE8Nfo7sM1UI6Kgc6ORVuqVDmnIjZZndivXA=;
	b=L2+ZQvex4caFAd1BwUAmmrCbdvTH+gix56c+E2e3Zu5IlSRfD03177yL7jKBEBdjF0do
	 nOH6y7rKYMOn3YnJA9rW7mb2yZ1qsjy3vVkQZAs9imWXHbjU7h2cJqJGkcG9eARYMEKUI
	 zgb6epxJQTht67lwMXuflBJ1mc7TWTscmgezPkY2akCNLEhnhkKN0365e5MUclx4oX6wX
	 6xN5sFzk8c9Q3VDNjhN4lPfvvayXSABd/4Ys99B04yTpPKxspYr4QsbjzxWJ2xIpP4SEl
	 cTtJeaYzegMhp+uRrVlInDCL+py3IQ07qWOlDAMjTQc5NY8OJ40qZIQ8Gz9KyRUP+Fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jjxHiqsF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D55606A31A;
	Tue, 27 Oct 2026 18:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jjxHiqsF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 475FC1F01825;
	Tue, 27 Oct 2026 18:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793125899;
	bh=Zy1XjAvFE8Nfo7sM1UI6Kgc6ORVuqVDmnIjZZndivXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jjxHiqsFMUljw0mFy0rB3mF05wn357Z5Avshsq+h6/XJ+4wWpRHRWyb4blIhsmyOa
	 dEjfVWkOOtDn+MAlzmBhiqXt0FR7Tb86gkV3rz6HYv/N9xl5s7FL7x3pZ2gYnFFR6b
	 mQj/RcQBOlggEz0Zfy34bACS6vwVemN8bDvDSmV7pv987yMD47L4Oio9ssZsVtO/Tu
	 ErnOaGJU62MD/T7ZIaOUvVr8vlxFjJCDq5Mxh/bd2y2XzlTd7O1kvt+fme80GsO+ZD
	 o/Qh4uVMfZy6tTb1oGCG8dJewg/YoXn8q4Fg9UVrfKnSoq7V63IBZJFwMENsHqxfSv
	 pvp0q9nw2hWww==
Date: Tue, 27 Oct 2026 18:31:37 +0000
From: Harry Yoo <harry@kernel.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Chris Down <chris@chrisdown.name>, 
	Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, 
	David Rientjes <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Kees Cook <kees@kernel.org>, Marco Elver <elver@google.com>, 
	GONG Ruiqi <gongruiqi@huaweicloud.com>, Jan Kiszka <jan.kiszka@siemens.com>, 
	Kieran Bingham <kbingham@kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH 0/8] mm/slab: Support selecting slab hardening features
 at boot
Message-ID: <179312451613.474906.1475329637924619088@kernel.org>
References: <cover.1793086056.git.chris@chrisdown.name>
 <16121542-acd5-4727-b64c-f8d519145b63@kernel.org>
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
In-Reply-To: <16121542-acd5-4727-b64c-f8d519145b63@kernel.org>

On Tue, Oct 27, 2026 at 08:10:40AM +0100, Vlastimil Babka (SUSE) wrote:
> These two should be only a small cpu overhead, which is why distros
> generally enable them [1].

Yeah I'd expect the impact on them to be small enough.

> >   slab_buckets=
> >   kmalloc_partition=
> 
> These are more valid as there's a memory overhead tradeoff.

quickly measuring it on a VM with 64 CPUs and 64 GiB RAM:

w/ partitioned kmalloc: 94.0 MiB (235 kmalloc caches)
w/o partitioned kmalloc: 76.1 MiB (~17.9 MiB diff) (40 kmalloc caches) 

Mostly due to a large number number of under-utilized slabs after boot.
(per memalloc profiling)

slab_buckets had relately smaller impact, about ~1MiB after boot.

(Of course this is just after boot, and actual bloat depends on memory
 usage and fragmentation on production)

-- 
Cheers,
Harry / Hyeonggon
