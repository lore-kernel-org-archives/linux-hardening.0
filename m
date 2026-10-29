Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793254082;
	b=unGEN9+G3uQLij0fR90Dnf5ExKti7upL7mkVwnaq5wzxsgSp8IBY8UJHMC31zEsly+JJ
	 mf16cxvlw9en1WUiExWxkVMYq8u8s+qXPOQFSVKjm5RHymjirKL8vBljokd9IP54e0njv
	 YPeUqgE8ieFFjsdtEkNxkeDRrl1YNV0LSohlTUoOd9mtkiZjXmDjdsAZJPWGcPmjHQ1Gv
	 XgmzligcjOfkN56kjSScQH6E6Qh0L/05MVhjlEjjy/s/bQEsZAL7FDeA8szNiOY8DVvlH
	 aqUwb379t+r0Fbw4EbORijZuX57X+9Sn1w4xznRMy1xGpd9YydvIfu+mpM699Qy0D+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793254082;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=KIyRNW6At3oCihbJNccAaO3bWJ8LNw9lR1egadV9gDM=;
	b=g7w38ukTxL8lhORQdL51cyJAm2klH/AzztlnsplEK3yePWI/31VC+ss/UUol8e5fZYPG
	 TtTqAePdO0oVfL8O02KjqV8WMZdzB3RRgf4VP07uhzkE//r7MhkB5raAuptfKxbOGzcOD
	 q0P9M2C4tINiTQ0zi8H3rYCyK2XFSiIsGoTBhK/WGQYcgU4ME+yOHY15V1bUAeD18Ae1E
	 /ihh329kVvs8lfl9LFo8GGH633j8ObJoxBW5uRQ5m2KUx0tlW0TnNY+VaSsthY0rqrnsw
	 5wdD2Vc5oUq+aYM2Z5+3Hlfp7pZPop0AeoapEEfI5aKGmNvPeTRH9yAeVWppzrzFDYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b="I/xnC8+n";
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1879606A31A
	for <linux-hardening@vger.kernel.org>; Thu, 29 Oct 2026 06:08:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1879606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=I/xnC8+n
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8a058f74a54so854795b3a.1
        for <linux-hardening@vger.kernel.org>; Wed, 28 Oct 2026 23:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1793254081; x=1793858881; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=KIyRNW6At3oCihbJNccAaO3bWJ8LNw9lR1egadV9gDM=;
        b=I/xnC8+nPsymSUHPSCVMndHbMjYrHGaw/y9W97v/V/2TNEsAbBBtCC0eACd7C6iOiB
         ASuuEHniK+dy6GiylaKYvhwWBE9+sneWyYMdevPhbS4Ji19fDeXXk1rT00IZNjslxLMk
         Ei6Ot5AsDmBrSOlXrS725Y2BufoI2xfgpZUi4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793254081; x=1793858881;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KIyRNW6At3oCihbJNccAaO3bWJ8LNw9lR1egadV9gDM=;
        b=qTs9RsK8RQVi9N5OZd3DC5rd9wqE25YcIcwndQsbiuQufiwP+8PpPRubyQ3JCZqwYE
         AHL8MPMf+zM3S9dm9M6QKiNdq6VjbdFcpwS7RBxo9DgP4xGDhFsSmmzD77pWuUk5RcjJ
         bbrrgR4hlYFrwme0GNYBhwM83Gog85I65EX1a7WuIE99fOExlogDAVd9NGzAdhvmm8cK
         Yz8RprmEg87HgNF+lju+xtYuoBh4tLfEYYR8jdPNpRIrdpwE+pYE8qNeHylpmIZJfnBA
         YrNqCN4OURhhRRcaFd+azYg/2Ig2mXfzT2dDn98rGcoAlX+2opZMJcu4kukw28pXe6zv
         PAGQ==
X-Forwarded-Encrypted: i=1; AKwUvBxzDirs4+l4psUGVgdaCls/6AAWCQ5j07as4jwp4tIW0gRn8AZDfprp6hWH/0colDWKtgOaOeg7OPZoIkpqFfM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIyBYDN8yy1Byu/BoHgx4u8QQN0ByZERW7KAYkF30JHuISBUduM
	QOx5B/tRRrlrZZ9Hcty8U8E++5B/BLNevFr4jzwj0GPYNsso9+bP694P+1sVoDpAE/E=
X-Gm-Gg: AYBFou0OLEeSuO0WfrC8cvSqlVOSmL6J4lP0gG4p0pisXVSgvE9uJ4t5Wo79WDp72Eu
	66RcnaD2+gPVQQkpVBroSRxN1HFmAYXxf51XR0dm/IKvLkBXdK3zZk2DSqvnuEkcMfRbB87fLXU
	iJMdEQ7DXhg/Zp934vlD38y5XYOdNwJBVcYHTnbDQsKVC3Q/LQE8SIB5YmmtuDZhn/KuUhXWvVd
	aFtWPhOKAK2uc4ShKbCFEXX5m6dnV6H9r02hzj/Rf82wNMBxbhKmycP666+riswQJyMqUAn6LuK
	6GQsR0FZ0DJSQyj/pfL8atoqD7FURuXi2p5dmwFtTafpzY/K4RoZEs+zkFLrD3FYwraFVNGCOF8
	TaNQxZkCkAe+2APLfJbiqwGYTdn5KgVdGSp+BdOl540pbmRJzcAWLVDzL17xs9TI+O6ltZaNz0W
	S2mGdZCiol0fkHPmO9pZB2t7KzzoSY+mCzbxlSCjRQACgpX/YB7Mkj4ijGoyBjh5f73OE42ZhN0
	rUDO4WzKZCVO32nPeDbLvmLZBcclWKCMo3eX5Mmc9iSN2YMHOc0tnGFmE2Mb232La2GOgxdB3os
	7XHYpmZ/yAe49URin2v5xh+xCqK6jI/E1eNk470R+mswRr2mr2tgxAmQ/8ZKu5VS01cN2A9hNya
	HmPrkFCdAvNm61m75IkQefYj8B2cRoB/3I6cA8GysEYxTPd4IdlgSMZxqvOq7UvIkzLJJYscJ
X-Received: by 2002:a05:6a00:a0f:b0:886:5f48:3fca with SMTP id d2e1a72fcca58-8a6e7dc9293mr3736944b3a.37.1793254081351;
        Wed, 28 Oct 2026 23:08:01 -0700 (PDT)
Received: from localhost ([116.86.153.182])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a6a3d5bd6asm1861640b3a.4.2026.10.28.23.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 23:08:00 -0700 (PDT)
Date: Thu, 29 Oct 2026 14:07:55 +0800
From: Chris Down <chris@chrisdown.name>
To: Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Kees Cook <kees@kernel.org>, Marco Elver <elver@google.com>,
	GONG Ruiqi <gongruiqi@huaweicloud.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: [PATCH v2 2/6] mm/slab: Enable SLAB_FREELIST_RANDOM by default
Message-ID: <6bdc161bd869ead04b3b9a651ef6a83882ecbea3.1793253633.git.chris@chrisdown.name>
References: <cover.1793253633.git.chris@chrisdown.name>
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
In-Reply-To: <cover.1793253633.git.chris@chrisdown.name>
User-Agent: Mutt/2.3.3 (9073d26d) (2026-06-12)

SLAB_FREELIST_RANDOM randomises the order in which the objects in a new
slab are handed out. Like SLAB_FREELIST_HARDENED, most distros already
enable it, and its cost is only paid when a new slab is set up.

With it on, the same system level benchmarks didn't change measurably.
Allocating from new slabs does get slower, by up to about 30% per object
in a microbenchmark which does little else.

So let's enable it by default too. SHUFFLE_PAGE_ALLOCATOR defaults to
SLAB_FREELIST_RANDOM && ACPI_NUMA, so it's now built in by default on
those systems, but page shuffling itself stays off unless it's enabled
with page_alloc.shuffle.

Suggested-by: Vlastimil Babka <vbabka@kernel.org>
Signed-off-by: Chris Down <chris@chrisdown.name>
---
 mm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/Kconfig b/mm/Kconfig
index 17d017e8fbef..92ff97ff24fb 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -200,6 +200,7 @@ config SLAB_MERGE_DEFAULT
 config SLAB_FREELIST_RANDOM
 	bool "Randomize slab freelist"
 	depends on !SLUB_TINY
+	default y
 	help
 	  Randomizes the freelist order used on creating new pages. This
 	  security feature reduces the predictability of the kernel slab
-- 
2.54.0

