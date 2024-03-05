Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E604355E48
	for <linux-hardening@vger.kernel.org>; Tue,  5 Mar 2024 10:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709633434; cv=none; b=h62daBlxg2LqYVLA5V1FVXvTtXjv/kFDkCnTdCFBmSnZcjbygiZKUo89bU1b/obO+NitJy0CjdJZiQ+CKuy+iuhm2ZXN2kOCyqtlKpoOCe8JMi9mZOarSfApCrf1SdUUkd39n91IlCqNoREYJFKUtCN/l37WBAT+JQAmzbagIu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709633434; c=relaxed/simple;
	bh=qg6+zLyXOvclDNk40orVz0UwK8KHs3WN88KHdjuAoYc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wz9nOdbyeo5EwPSWpJMnlGrcI/vBFghDXZVXNqjsFzn/C76lP821r+bl5Ygj82xr739LVx5NRrWWdnNqjFJRRmnlGcTJITuO2vtZiG8fcD3AizZ5f1tL610BHAGaLCtigWq2s5sjQq/lYmHM6HIct4b2wLeFjjJdGh3d4HOm5S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BItY9Tly; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BItY9Tly"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5c229dabbb6so374481a12.0
        for <linux-hardening@vger.kernel.org>; Tue, 05 Mar 2024 02:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709633432; x=1710238232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YqypDeuefMJmnQ8sf5GSNnN+8VJFJPXjvaUOYfHLyEk=;
        b=BItY9TlyKABqFNiQZW+MiXx1NsFwp6PhFbDLdxVqGRrElTOyZtWfsiUE5wy3FGayxs
         EJiPId9v7hN5/s+aSRYFjGLJ/82HpupxL08simauFrLKoxGjllpyjXtx/GIIrl+W8WQ3
         pDr+e49VwbW2A2mIpOfan8YkdOmwhXU8h6wjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709633432; x=1710238232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YqypDeuefMJmnQ8sf5GSNnN+8VJFJPXjvaUOYfHLyEk=;
        b=s1SBKx3hxvLYyiBQDAEsL3JYDGygVZZSXKgZgPH+1/nwcXuOoIVjAFOyUMKgb1avsX
         /T9FDs1GWZqjNJE/3otvM9wb32dUUPZhhQjtJ12hd/FifXRFUsHaXGTQsgOOYRXbbu/N
         rr4L2zIIZiyk1bZFCIwkfWcgxFTJk/Zerq4wMfNAGsyzzFh89FzWl4x/81hNmqffF+Ry
         wrjy8nDeyD7s+F6pea++qi1GIkdILfkE461ly+65i8e9JE0GrtXM1GhP51Ztlfxr1Gix
         H3jNmJV4gN84ehJ3paJdLRE7XpAgCmU3+ucAYuzI8rH3t8eFJLNnYJ4YDeGI1WQpPsrl
         w7ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQkj78bHsNol3drNFkkQmlNQ+5nNBMOOUr0B4UI11N2M/+NDTONiKEILMz4U+SYe/kBMmr8uiNZOQ4Mr9yMioSngoV/5btKFQ9HHGS8ug2
X-Gm-Message-State: AOJu0Yxdz2JHTwqRP8sNVFSx9RoLB2KfsKJf0fBJpBT2dJMB3jU0WINv
	J5wD4BrGuPjigG4pCTHDYdkihl/2uDpX8FuDSypCzX8MzOq9zCkFnYY5g9lYBA==
X-Google-Smtp-Source: AGHT+IGeJZyVJ09gI9gdMeeZa2TNl9QqRwg39EBpS2gnYKvxtqTdu16IIH+Z1sVU6rZsLUOu3KxERg==
X-Received: by 2002:a17:90a:2c8:b0:299:ecd0:483b with SMTP id d8-20020a17090a02c800b00299ecd0483bmr8668816pjd.10.1709633432154;
        Tue, 05 Mar 2024 02:10:32 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h8-20020a17090a3d0800b00299be0e00c1sm12409317pjc.33.2024.03.05.02.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 02:10:30 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Kees Cook <keescook@chromium.org>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	linux-mm@kvack.org,
	"GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Jann Horn <jannh@google.com>,
	Matteo Rizzo <matteorizzo@google.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2 5/9] slab: Introduce kmem_buckets_alloc()
Date: Tue,  5 Mar 2024 02:10:21 -0800
Message-Id: <20240305101026.694758-5-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240305100933.it.923-kees@kernel.org>
References: <20240305100933.it.923-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1274; i=keescook@chromium.org;
 h=from:subject; bh=qg6+zLyXOvclDNk40orVz0UwK8KHs3WN88KHdjuAoYc=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl5u+QePW1cikxrAkyTkNPDsM7P6WLLogreKw78
 DkUscrwcj2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZebvkAAKCRCJcvTf3G3A
 JkIeD/9SGhc8L8n+b0l4YrTF1D9VoErEfn1Ca1UNFW/W0gggb8pmBG/YuAzR/noRa8vP/Obacdv
 xX/kz3RVVUNa5CYWF20lMDU/Lp8oLF05rVXs0+FZ7Y+Hj4NcwGb4ZDEcTwKpevYm7+jo9WEDQ5d
 zMSamVXJp/wkyr1XfGZ7cxjHlDRKSjdplhbJgG0UpihMCnecqlqWCXwJbsKgeaEq4Sl26MCcrlM
 K0ULjcAvpm6F3d4s636IjEqcvuIG1obEke1QFfbVJC5/dJduyyEKm1Lgraw5dGP56FR+aC56qjS
 65EMTIxf1kNAW+Fy8bPuL7WDntcwNqNENqpozW05vn4+JPT/wOhqoVmXjQZ3DQfbw1ikOaWsuGR
 +wrVI1e9aMbAxyN+NV6Dk09hIjGge2x1xZ4ikVrEqfYiJl/PlZG1rZ3YtAjKzVhhHSlziq1EXO7
 eLtSu666WzevVuCoqb7mheOeAM4BFhlrgwfm+ZnWU0YM/Ycmrv70Q8134urLdvFSqmvc8qAL1CF
 xi+VJmmdh42aZ/SeMDt4C3lJogV3xKZGfmixjPA3HWDF8q7OPo6tVZ0GK5r+TW9BmbGeL5G/Mz5
 ehqYwoqpMNk2S8s4t7WPvdOakD8dz8vt+onslIuOlwmQgDswizHCZFv3m2uwtvVSPNlj7ZIDrUi W3INC3N8UCVkL0g==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

To perform allocations with the buckets allocated with
kmem_buckets_create(), introduce kmem_buckets_alloc() which behaves
like kmem_cache_alloc().

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: linux-mm@kvack.org
---
 include/linux/slab.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 058d0e3cd181..08d248f9a1ba 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -600,6 +600,12 @@ static __always_inline __alloc_size(1) void *kmalloc(size_t size, gfp_t flags)
 	return __kmalloc(size, flags);
 }
 
+static __always_inline __alloc_size(2)
+void *kmem_buckets_alloc(kmem_buckets *b, size_t size, gfp_t flags)
+{
+	return __kmalloc_node(b, size, flags, NUMA_NO_NODE);
+}
+
 static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t flags, int node)
 {
 	if (__builtin_constant_p(size) && size) {
-- 
2.34.1

