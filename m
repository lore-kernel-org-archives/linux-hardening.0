Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343AD55E58
	for <linux-hardening@vger.kernel.org>; Tue,  5 Mar 2024 10:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709633435; cv=none; b=fLfHZ4Exny+5bU24+K2IISeIZcZ/oCd++dPK3ny9AEVvNmW0cm5UeLJffBd4YP9xA2sp0+WoFAbJ9qs8NcL21uqb+3HlRiw3yc+7YxIaIWDm8cIg/pun290iLoPXgG0A2gKrgdwvPT7FR5bN/NtRi6RAQoTsopqUr0nWMrFL6PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709633435; c=relaxed/simple;
	bh=5+bllf7wQXoQ1iiymcQxAaVJUnLpEaTtP4WhLyfCGPk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nwsrmnYxY3nFiKg8PDd5Zp9tChHkG/0un93f6ICyil8i3+yCccl5fmNN9dUxh6DTV63wAoTfYmn7CSyquIB4sayZ0pcdAxCurNRPTlccM8dBdqBRhpkfialnBCFLmIDz9O9sgev4qOoDdcHNQsU01fG61cJ1BYTALTL2nTHNBIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Jq5k6fQ7; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Jq5k6fQ7"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e5e4b1d1f1so1959461b3a.1
        for <linux-hardening@vger.kernel.org>; Tue, 05 Mar 2024 02:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709633432; x=1710238232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W6tSmWQUz9mHEs7KKdtWRSqXpZBjknnUveJhwT+v2FU=;
        b=Jq5k6fQ703V9hULNmaMj51rmkGH4CZW4hnaqyjwDdexzJc3KRKc3FZohTAuw3xhVzh
         NAVVN1Lmmtv2M2c2IIeawk+kfjYC5A3Ez3gi9VSBRvidR0CoSLFmZ1WywTNWOPe67oA+
         pbNEBGHPBJYMKL7jN67cKd9iWt4tbRxpFRel8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709633432; x=1710238232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W6tSmWQUz9mHEs7KKdtWRSqXpZBjknnUveJhwT+v2FU=;
        b=Q1yIzru8EGoA32dArSGSjpwgLT7rl2K/YKfrq/S9gRvCVFYY8nPGPDpkHBx02cMVE4
         /fpG3pFB0NPxU9ctkPbPJLiBhd7ZOmrzSpV8AKr9yKo+TN/JNZzW0IVXcwwVNJh0SPs1
         m7a2YZ6vqrLrBz2/YPK1zl34g6P55pIg2EVXXyXtk/zMUgYXAGTzS9AMsm5rdqzgabSx
         nwUTF5boG8x+NcY9YX26hGnBtQLHe1OgG+WbbY8BEm6VClMK79O3OpnqWswl/Am3b3OF
         9bY4jhneJM6GwzM6HUB6/sylxSSDZCNoPg9CIfqhMtwFAgONa3gnNph4Nty9LxfIX66V
         6xcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMxXX2bcrGxcr56u8pOnpbUVu+9mvJvoYR6tOxX5+r5PUHLD8sxJoCvz6Jlv/rjFrERTJrCHTuVF2W/cZ2OAgLhkq3kuEnx9Y/hsBsSFj/
X-Gm-Message-State: AOJu0YxNgNBDjT7kGz31r2ykowizMbDykhCa+Q+Djl3Aw8uIvFP/j4D/
	fp2CKL6xZUe1wpXRrL8fOetpAA7fEcYDihc7WwD62EZ0szq411SfqrqdWp3TTQ==
X-Google-Smtp-Source: AGHT+IGioGxnLf58krzooyXRSux/Zxx7hWwNEvHeCXchceFMByRkqxZ+PaMIxnsL+kY8mFgOqRxI3w==
X-Received: by 2002:a05:6a20:729a:b0:1a1:3b27:4f3f with SMTP id o26-20020a056a20729a00b001a13b274f3fmr1585251pzk.2.1709633432471;
        Tue, 05 Mar 2024 02:10:32 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m7-20020a62f207000000b006e580678dfbsm8485054pfh.193.2024.03.05.02.10.28
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
Subject: [PATCH v2 6/9] slub: Introduce kmem_buckets_alloc_track_caller()
Date: Tue,  5 Mar 2024 02:10:22 -0800
Message-Id: <20240305101026.694758-6-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240305100933.it.923-kees@kernel.org>
References: <20240305100933.it.923-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2914; i=keescook@chromium.org;
 h=from:subject; bh=5+bllf7wQXoQ1iiymcQxAaVJUnLpEaTtP4WhLyfCGPk=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl5u+Q9Fez113NbGGVqjvVTslyLAH8TI+6Wb4a3
 UHTy9ESMGeJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZebvkAAKCRCJcvTf3G3A
 Jum0D/9tfCyWy09BzH1L9P4M66z0u2ctSfRJPeQ1x4bgaEnW38mkbjG41ME6e+R5Zj0gpmBgZ+L
 BVNaHnefEXko8smuTRzZ4FGGksACNwKf0+N86253pNgtssxWUfgfa3aQ1EA8XEBCMceHWGnr84H
 h34x9bAbwoUCp96M4lvRDs8cKxVlleF0jjCvDpvMT3T1ZAyvoPvNHYpvj6mth+oFIZTSkt3Wz+X
 919IaLbl/IDuiJVd9rtpALExUWOh+KXL6FuuwYZHWN+SaSa712xlgG/5pLuJ+2l8Ub1IJiEQVWp
 r/4azSgELrhUJFvtIbkEWWKreqYhRzNs/rKZUmxW7K1gGKiGdDk4ZDqhqhclVbw3MMBNLZbLerx
 rSCyI/khhcdBGZYwjg6IFEY/vpFVkrL44xPf13VdK07PEsrsff7tXBBEX59HFI2KvQG5OsvWVhP
 aHHbbGxMkh8n+z9aHH4WpY49kUBjUPRrASB5fIz5FsMzXVgyemQHiUSYTVdkJ3aT34AdKNF6pks
 Immb98LUo/rCvKgXzxq/u49qS0zQkVpV4BWtD/SwK4MuhHIOU8Rm9ytXz8ZSxeZ0v1pYc89qObI
 o3aW/HpIQI7IY2DuYh0+o+TW5k0hDDZa00o0vGiCTiQIKa61gmW3pYCwmM5FPO2U0gagUkJ30W6 V9QFinQCp7WdukA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

For better capturing the caller details for allocation wrappers,
introduce kmem_buckets_alloc_track_caller() by plumbing the
buckets into the existing *_track_caller() interfaces.

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
 include/linux/slab.h | 11 +++++++----
 mm/slub.c            |  4 ++--
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 08d248f9a1ba..7d84f875dcf4 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -606,6 +606,9 @@ void *kmem_buckets_alloc(kmem_buckets *b, size_t size, gfp_t flags)
 	return __kmalloc_node(b, size, flags, NUMA_NO_NODE);
 }
 
+#define kmem_buckets_alloc_track_caller(b, size, flags)	\
+	__kmalloc_node_track_caller(b, size, flags, NUMA_NO_NODE, _RET_IP_)
+
 static __always_inline __alloc_size(1) void *kmalloc_node(size_t size, gfp_t flags, int node)
 {
 	if (__builtin_constant_p(size) && size) {
@@ -670,10 +673,10 @@ static inline __alloc_size(1, 2) void *kcalloc(size_t n, size_t size, gfp_t flag
 	return kmalloc_array(n, size, flags | __GFP_ZERO);
 }
 
-void *__kmalloc_node_track_caller(size_t size, gfp_t flags, int node,
-				  unsigned long caller) __alloc_size(1);
+void *__kmalloc_node_track_caller(kmem_buckets *b, size_t size, gfp_t flags, int node,
+				  unsigned long caller) __alloc_size(2);
 #define kmalloc_node_track_caller(size, flags, node) \
-	__kmalloc_node_track_caller(size, flags, node, \
+	__kmalloc_node_track_caller(NULL, size, flags, node, \
 				    _RET_IP_)
 
 /*
@@ -685,7 +688,7 @@ void *__kmalloc_node_track_caller(size_t size, gfp_t flags, int node,
  * request comes from.
  */
 #define kmalloc_track_caller(size, flags) \
-	__kmalloc_node_track_caller(size, flags, \
+	__kmalloc_node_track_caller(NULL, size, flags, \
 				    NUMA_NO_NODE, _RET_IP_)
 
 static inline __alloc_size(1, 2) void *kmalloc_array_node(size_t n, size_t size, gfp_t flags,
diff --git a/mm/slub.c b/mm/slub.c
index 71220b4b1f79..ae54ec452a11 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3995,10 +3995,10 @@ void *__kmalloc(size_t size, gfp_t flags)
 }
 EXPORT_SYMBOL(__kmalloc);
 
-void *__kmalloc_node_track_caller(size_t size, gfp_t flags,
+void *__kmalloc_node_track_caller(kmem_buckets *b, size_t size, gfp_t flags,
 				  int node, unsigned long caller)
 {
-	return __do_kmalloc_node(NULL, size, flags, node, caller);
+	return __do_kmalloc_node(b, size, flags, node, caller);
 }
 EXPORT_SYMBOL(__kmalloc_node_track_caller);
 
-- 
2.34.1

