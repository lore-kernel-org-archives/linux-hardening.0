Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793420967;
	b=UUEIid91KmIqZfUXLAtVHdfElw6Ru076cIgw+odBqAQPiUR4o2PoHRvf2TeEyQeGF64H
	 MhVD5qIWRO7Cos+lTOHEuPh0Hgd62c1Tbj2MMt9FArNK8qhoZD06Pd2uGJ2n/BInByUXL
	 mXevbpwAJi7a55E/8xtWO4nkN02HigYM6wOjIvvcz8fCBK7MP2YUKlsOuw94o0r3x3Ol2
	 sspvjrJEfaYtrHcCMGp4thd8qx/2KzTGZ6UlA3sW0fxmdtcs4wSvqyYGBmTkHdsabOdwA
	 GLeWorGT40PWoKUzZX4sQydneyAHK69h7IE8/nyEJ7SE5kL7a01ceD7IF5SWJ+vWX2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793420967;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=F+AT69Pw/D+atv5Rt7qE2T+LpdzYoQhnYrr78IvOD04=;
	b=c4R2wiFdxVjy++Bu5ypySKbzaN6e7eno9kRA/G2z0IstLiEFT/0VDwOsWZ0E7VB306oA
	 hJDNOyr6rC3Ee6TPgFNbMOgPE7y66MOlygsFZM8Ysoqdgo7l32+Q2uRrhFwOitUycJ6J8
	 K6++Tn1HjhUrodCM65f1iG0UpujJpJQ58rL2ClGuE7rFIAj9JTsswd7bXoyot59sndtg+
	 KhX8u1PsX8m0gWlgUh4Z61gyEJjVtBtSiDYN+vEz6+N1G0c3yQJqJLbRg7/snbTQ4RaTK
	 wHd5c3hdTsgLJb6f6qZ5wVXx2+fIvoqcsAc6kk/5Ba3ZG4ItgSSf4I71QeN7xJh9aPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GIbmAu2e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E05606A31A;
	Sat, 31 Oct 2026 04:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GIbmAu2e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 095F61F000C1;
	Sat, 31 Oct 2026 04:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793420967;
	bh=F+AT69Pw/D+atv5Rt7qE2T+LpdzYoQhnYrr78IvOD04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GIbmAu2exceR1uIZTs7rl2hC9kygOoZXYd8Y3qH3jGjd4i5fI3QDnM2lcqs9KMCUN
	 YtMrTP4XFTnOfdTfApE23z7YrJKGmPa/0L2iqHqPAga76lEMtHAWbXHPlsThGMi2Nu
	 QKjGT3muQdoirvHhGTIzTZayNmDTMt1ZJMEqTw79Z4/mG/whx3uGZuYeWv6Sr+wmrw
	 ASU/rpCy65bePqmVh9v6vYlRIoaADrtJLpevDq3BNlJD/3OO4/A88oBPdYLH7h2gHY
	 dn64zja+WxpOFshJ/S9FsE258ABtIForRe37CdrQFzdtZCuaBOtbsgJNjR2s6kk5az
	 4UDq9XtL57X4Q==
Date: Fri, 30 Oct 2026 21:29:26 -0700
From: Kees Cook <kees@kernel.org>
To: Chris Down <chris@chrisdown.name>
Cc: Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Marco Elver <elver@google.com>,
	GONG Ruiqi <gongruiqi@huaweicloud.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 6/6] slub_kunit: Add a test for the kmalloc_partition
 boot parameter
Message-ID: <202610302128.1009F254@keescook>
References: <cover.1793253633.git.chris@chrisdown.name>
 <66f981ce04dfb01d02d1683bb18ba6db1c4eabd1.1793253633.git.chris@chrisdown.name>
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
In-Reply-To: <66f981ce04dfb01d02d1683bb18ba6db1c4eabd1.1793253633.git.chris@chrisdown.name>

On Thu, Oct 29, 2026 at 02:09:21PM +0800, Chris Down wrote:
> Check that the kmalloc partitions are separate caches by default, and
> alias the normal kmalloc caches when they're turned off with
> kmalloc_partition=0.
> 
> Signed-off-by: Chris Down <chris@chrisdown.name>
> ---
>  lib/tests/slub_kunit.c | 46 ++++++++++++++++++++++++++++++++++++++++++
>  mm/slab.h              |  4 ++++
>  mm/slab_common.c       |  3 ++-
>  3 files changed, 52 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/tests/slub_kunit.c b/lib/tests/slub_kunit.c
> index 670645875b27..e3035864577d 100644
> --- a/lib/tests/slub_kunit.c
> +++ b/lib/tests/slub_kunit.c
> @@ -333,6 +333,49 @@ static void test_slab_buckets(struct kunit *test)
>  }
>  #endif
>  
> +#ifdef CONFIG_KMALLOC_PARTITION_CACHES

Same feedback as the other test: let's get rid of all this ifdef-ery :)

-- 
Kees Cook
