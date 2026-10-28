Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793201046;
	b=zFITYYjSGyyWwIVziIf4TnSxC4KwCpYnLGrgMkdn+Hittf5LrKIZKazc1Q142/QGTZM2
	 gMbVSU6i91rljUYf3Sz3jsJ9tjhhUQpO8juKvDU91lqPkTE1EUG9yWQlkObOHzGWb7cHK
	 RufsrKnDDbZBzZlgZ6stKB9RnwE7XsUYQSYIqpR+zfdK+eZE1k84f72QzTZnSkIEBY1+a
	 vAgwmcYPtJ1hwNikrDhFMY8zAMhVuCXnftqntLuf2QQkUkc0aYjWm0UrFfjmxuITcurm2
	 duLPYGPlg1IcF1USCBXj8nUULBVxatu+zSG6mb0ew5fiyDA3DXgbEAYt7eDZqc+S1iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793201046;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=2lKISFaBYtFQkl6whcZ+TLSbktmxJHBA6VayRzr31Z4=;
	b=VByhDCOuo7KkgFYPeeYqQwZuaGjm4/LCk57bK70VwHiCTIX5OezB+ZfgI/TZltdo5UC+
	 2dzx4FJ6rPA/K1Q4UYRnd0SIrnpGb0eqdtpSfRg6ksaAPyavLLM/jtxf84kXchKCAqC1u
	 W1lb7LsOmrPR6iiz5VPMKNlLP1oh8Yz2tJ+QZOSKW6qXElTr8/uatd0bjMLfxumqde+cl
	 9FRP7jLksw9a8OvviOnNi8DVQ+yuZ7EhQE7OjQ52VCrxjC/NIayh4I2IICgAydO7HjLTX
	 g2lsc5sBYpHCdNBTP8/Cply6aE+GfDhpohiJcs7Rxfa6hn+GsrIpHLXlPNafy+dfuHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=QzsOFHTn;
	arc=none smtp.remote-ip=209.85.161.54
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2DC606C00D
	for <linux-hardening@vger.kernel.org>; Wed, 28 Oct 2026 15:24:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C2DC606C00D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=QzsOFHTn
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6de1fd5f572so554545eaf.3
        for <linux-hardening@vger.kernel.org>; Wed, 28 Oct 2026 08:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1793201040; x=1793805840; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=2lKISFaBYtFQkl6whcZ+TLSbktmxJHBA6VayRzr31Z4=;
        b=QzsOFHTn+8+YYCPTJGlmJAzYJSwbb+puZMPW8ZPyRBshyLngAY+e6dPhx864T41TeV
         VRoSqpZvHxzPFF3fa4fGRSkeTPwimQr4nEfmZvP+5fZNAO4/mcunv/VJZJ3ivpfeQnby
         lKmOSVPl/Oez5xPk8aefWZsD/XQxg3z33pUYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793201040; x=1793805840;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2lKISFaBYtFQkl6whcZ+TLSbktmxJHBA6VayRzr31Z4=;
        b=qkmX5OxM5nfKwMw6D0AbSUuRID9YLkrmgmsHlwQT8QdmaxRXZwP6CD0XD+vRNn1ted
         R/fHafvTZJEGGeBlv60EJ0VxWCXJ0b/45HI+MDdb6PnInP8Z8Q4ocDmAtc90FbvU0ei4
         NOsBqHDP7tP9+rk+I/u+2rjJKZWxahMSr1IF+XXz9VnkHSLr1OOoAJVSiDIjd46QyYQy
         SGQvGaBEXraSz2CSNjLwYZIR+Cai4p1HeIsJpmsZZ+I47caYEOOgW/fSj5Vm9ANHO/Gr
         38UQGAGUmro82vsPbvq4x5ibg8xAH/5OfhwILcfa/aufkt0qMSEjZByv6U5KRK2p9X7p
         rjhw==
X-Forwarded-Encrypted: i=1; AKwUvBwDfSutwWoYOeNwtMCN2PQcqeIr6ezYXH+DSc7w/EPlPhY/LHcPe94N5W4y2MZhIqIchspJazTTdfXDGVc2ZQQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLqui4TEW/ZvfA//fk/A2YcJ4haJx6Qh8moKhTuKs3rI9ngFhg1
	/hpQZmEhyG8hE3VJTy232PFoX1YrmsT19xsAuRU4QBYTNb/BL57OU/V5JS9O/r8Wh7U=
X-Gm-Gg: AYBFou0j0zS8tGbIAvBJC4XKhpiX+ltCS3knRGz2h775N4V4Ueb569zhto+p2WZPAFF
	FmdN9u6kAwOX71Z59O/GpNw4ob/ugneJpR6yzVmkstERXpTsK01JQ4Xa5WKsY1crGF1N1x1Oc0D
	9g0K/AsL3k7KogVBGcJFBoMVWIESfMv/G+Of5aL+WFH+tqlw/EHZURBJgL2PGgBLGEIr/IYPJ34
	fqymVGY7W73xHmfGFFVjMU7d/IVPrevp0oEyt4OOn+lXyygYxGPKI4UMShQObbEt25Wg5RyE0lu
	+PtoIYMaWzz8oK8J8E7XakQnFnrG1Ri5YCfBquN4nLaUaOOcIkYHQv9J558TMaqYExk50e3AIOb
	xBaaUPdd+ac+3qvgzGMVaIK7SLUDn9kch7bAOPsKMx+t499ljFo5xx+Cv9cjSCvfTBk17a60qa3
	LPR5HzdD86MO1xFMtsBKD+DxZ/XixIB4ZjGSMmlBVs1sUT54D5avIuHP+QH3WEF2nWafoXUdBOO
	Wj3vBSxuhkO+avYvZRmrAvbUbrNrire5R6VURF09nINRPL5RXU1VKFxkqzrhgaPoEgQnPvp2stT
	wQDLQRPAH/J1HQngD0gJB4eP+FkofIfDh4I7attqiNvLWmGJUaMov0W/QzD+fYu/W9x+iWntJ1k
	7nTXkG76ht2+eaA4Nvb/wHXK87vFOCq0ou6xZyeKdX+0QQH99iuwKvcZkj7GtHicfDxIJwo4iRD
	wzDWIUHgayEngVsZXJuiY=
X-Received: by 2002:a05:6820:8597:10b0:70b:8379:c170 with SMTP id 006d021491bc7-713ee85c744mr964651eaf.27.1793201040161;
        Wed, 28 Oct 2026 08:24:00 -0700 (PDT)
Received: from localhost ([116.86.153.182])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-7142c736d4dsm1749066eaf.8.2026.10.28.08.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 08:23:59 -0700 (PDT)
Date: Wed, 28 Oct 2026 23:23:55 +0800
From: Chris Down <chris@chrisdown.name>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Harry Yoo <harry@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Kees Cook <kees@kernel.org>, Marco Elver <elver@google.com>,
	GONG Ruiqi <gongruiqi@huaweicloud.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 0/8] mm/slab: Support selecting slab hardening features
 at boot
Message-ID: <auITixAJMfLtfa7i@chrisdown.name>
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
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <16121542-acd5-4727-b64c-f8d519145b63@kernel.org>
User-Agent: Mutt/2.3.3 (9073d26d) (2026-06-12)

Hi Vlastimil,

Vlastimil Babka (SUSE) writes:
>These two should be only a small cpu overhead, which is why distros
>generally enable them [1]. Also the code basically only runs in slowpaths
>because percpu caching doesn't use freelists. It's possible the static key
>conversion doesn't help anything. You could try to measure the impact, I'd
>be surprised perhaps :)

Well I measured it, and you're right :-)

I built kernels from d15d7703166d ("mm/slub: initialize the free pointer of the 
bootstrap kmem_cache_node") toggling SLAB_FREELIST_HARDENED and 
SLAB_FREELIST_RANDOM, with SLAB_BUCKETS, KMALLOC_PARTITION_CACHES and 
SHUFFLE_PAGE_ALLOCATOR pinned off on an AMD Genoa.

With both on vs both off, sched messaging, perf bench syscall fork, a 
tinyconfig kernel build and netperf over lo all moved by less than 0.8%, which 
is within the noise here. So the slowpaths do pay, as you'd expect. Here's the 
change in ns/object vs both off, over 64, 256 and 1024 byte objects:

                       hard           rand          both
   batch alloc      +5.5..+7.8%    +7.6..+12.5%   +13..+15%
   bulk alloc       -2.0..+3.9%    +28..+32%      +33..+38%
   batch/bulk free  +0.5..+4.6%    -1.7..+0.6%    +0.8..+4.5%

These are from a small module which just does ktime_get_ns() on one pinned CPU.  
batch allocates 4096 objects with kmalloc() and then frees them 1000 times.  
bulk does the same with kmem_cache_alloc_bulk() and kmem_cache_free_bulk() on a 
private cache, so it keeps creating new slabs, which is where the random seq 
gets applied.

So for us the right answer is to likely just turn these two on rather than make 
them switchable, too.

>Maybe we should just make them default=y.

Agreed. In v2 I'll replace the boot parameters for these two with patches which 
make them default y, and keep slab_buckets= and kmalloc_partition=.

Thank you for spotting this!
