Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793088646;
	b=GL2z80ELG+Qq9pxtzF0VMQ6yxHEL/L2Nu6tiG7Y48yjPXg87j1OoWoSGuwImVGgC92y3
	 AM1IfU5X9CDdN+T1MkQkNvi4e60USixg5KS3bosnPMB9HxV+30DpjksWq0vpYPcNdiONe
	 tL6JQLtNn6sGeWbbkMRYsU7PLKV7rt0MMwo8kw/kw2p5EpUzQFVLonIiXNXN9ypO1gEG+
	 m8IT6EtWjdjhoRLBHdi9ocdsWioT/u81L30PJ3vCuQBS7TexllOz8jPnr0FViNYGe653d
	 lsKdZEDY+hxlt0TM5S5+1YssqI18Wk+ADwJ4YXZjN764ogbwAgCSqPIjxvCZ6quLKKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793088646;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=dDmwmjf1rca7vDceLffwmnsnZHqgu7Yv+wtoDgqD3S0=;
	b=joJweOuxn/WKUDzLIoaaK70w2Ou/mdkLJ5zfPSTJe0+CRWvvzJlkny4YVGb1JZBFz3Wi
	 qIw1imvoa5/Q8TU1h0P0wDTnHJgFfGJGql8EUg1/tfbFHFcH3qpQy/AecSvhaDlGkb9Bd
	 S5uABDTPDb1WyCWDftuWgkzKhVFUUOpBm7iOZBuxOk5e6wFwtLDTyA1bBZE7MlDv7+T2j
	 4ZYv58GsEeNNH1O3g0ZXwxNDT4UZksB+dhgBx/zm2jF8SsJLGCYluZZN7oFjIyOzK+hE5
	 eVrQHD8Z56NztBVLKr+eSGCWZ1v5ah9yZo4PUTS/sxAxS4bqsC1dqCam7lO4wjD4SWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OuicXfmk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80071606A31F;
	Tue, 27 Oct 2026 08:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OuicXfmk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B40B41F01828;
	Tue, 27 Oct 2026 08:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793088646;
	bh=dDmwmjf1rca7vDceLffwmnsnZHqgu7Yv+wtoDgqD3S0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=OuicXfmkCul7MY0Y5pAoKRjE+HsPz/d6Z5LAZ89V6dhsXZuh0FzVVNsxN7gs2PTli
	 jDlNrVoA78k6uChpYYfdukgoWkhsHGLaW0vhy0jgREaMpxP2TtUShAxOKPl3dv09lk
	 qbbFAs1VA9dN7jtTCl9gKRYPdnFlggSd4augInStF/GhJymAwBnL5iS3vr4bPvps7b
	 lznY+CO12tXwJSxLi/rRnjkt9IQ8Hs9cVByOM/tSGc5ThASptgvVlxYLFV6A5E1RPI
	 3fjEE+YfMqB906EBk2d1Z0Ruoz6NZuW6IGGpcf15uzuUT6qSUfUwAUjt89VfmHRBCt
	 cdkqL6kErpc5g==
Message-ID: <16121542-acd5-4727-b64c-f8d519145b63@kernel.org>
Date: Tue, 27 Oct 2026 09:10:40 +0100
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] mm/slab: Support selecting slab hardening features at
 boot
To: Chris Down <chris@chrisdown.name>, Harry Yoo <harry@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
 David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Kees Cook <kees@kernel.org>,
 Marco Elver <elver@google.com>, GONG Ruiqi <gongruiqi@huaweicloud.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Kieran Bingham <kbingham@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
 linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <cover.1793086056.git.chris@chrisdown.name>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Content-Language: en-US
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <cover.1793086056.git.chris@chrisdown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/27/26 08:35, Chris Down wrote:
> Slab hardening settings are currently all build time choices. This means
> that, unfortunately, hosts with different requirements end up needing
> separate kernel images. Let's allow those hosts to use one image and
> select each policy at boot instead.
> 
> This series adds four new boot parameters that default to their values
> from CONFIG_*:
> 
>   slab_freelist_hardened=
>   slab_freelist_random=

These two should be only a small cpu overhead, which is why distros
generally enable them [1]. Also the code basically only runs in slowpaths
because percpu caching doesn't use freelists. It's possible the static key
conversion doesn't help anything. You could try to measure the impact, I'd
be surprised perhaps :)

Maybe we should just make them default=y.

>   slab_buckets=
>   kmalloc_partition=

These are more valid as there's a memory overhead tradeoff.

[1]
https://oracle.github.io/kconfigs/?config=UTS_RELEASE&config=SLAB_FREELIST_RANDOM&config=SLAB_FREELIST_HARDENED

> These mostly act at cache initialisation time. For free list hardening we
> use a static key settled before the first free pointer is written.
> 
> Chris Down (8):
>   mm/slub: Support disabling freelist hardening at boot
>   slub_kunit: Add a test for slab_freelist_hardened=
>   mm/slub: Support disabling freelist randomisation at boot
>   slub_kunit: Add a test for slab_freelist_random=
>   mm/slab: Support disabling SLAB_BUCKETS at boot
>   slub_kunit: Add a test for the slab_buckets boot parameter
>   mm/slab: Support disabling KMALLOC_PARTITION_CACHES at boot
>   slub_kunit: Add a test for the kmalloc_partition boot parameter
> 
>  .../admin-guide/kernel-parameters.txt         |  29 +++
>  lib/tests/slub_kunit.c                        | 186 ++++++++++++++++++
>  mm/Kconfig                                    |  15 ++
>  mm/slab.h                                     |  24 +++
>  mm/slab_common.c                              |  48 ++++-
>  mm/slub.c                                     |  68 ++++++-
>  scripts/gdb/linux/slab.py                     |   8 +-
>  7 files changed, 361 insertions(+), 17 deletions(-)
> 
> 
> base-commit: d15d7703166daf7bd62c844a3cb1b3a6279adb4c

