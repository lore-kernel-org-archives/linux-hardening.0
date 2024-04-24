Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8B915747C
	for <linux-hardening@vger.kernel.org>; Wed, 24 Apr 2024 21:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713994872; cv=none; b=fBchdX6OCRDRPyLYnHO28eIZwyxgOtvXna7q2t1geh0QI0aQr0S/slmmlPZ1WBOzfJordihly3W5yZoNBRE2XxjsdNzDIm0fHjtCQs3YtGnGc5cM2hy4pXpzrLsSvDxCVB8TfrDimlTlsEOmiy+c+qC++XMEGgLXDQKFCknsrp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713994872; c=relaxed/simple;
	bh=b6S8APzjeiOvxh7QXxGMfpkIi0N6Ek4SYDm0EuC0dW4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LoQdX+7i40nY6ybSL7CY0Sglng3vLlElSCZlAt9vwxlmSE4scLo0FvQSfjzp2pIzuDZbT+2LvSq+i4DdzaGXP1PYX4QS2PLp2PspHXJiy9+lSiFWX8foeKeiKz8CnxNC4WivkIabbaJ+9ZLoQ2+pkWdiA6Uj2A1/RQekWHuloD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JgqgnVzm; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JgqgnVzm"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ed627829e6so440113b3a.1
        for <linux-hardening@vger.kernel.org>; Wed, 24 Apr 2024 14:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713994870; x=1714599670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AHwyZxYzmrEMajI8SxktaczkjAAhwGi1bdDM+8q+7+o=;
        b=JgqgnVzmqBgipNE5uNE92f4sup+VUAq4aLjvyP4VH/yESmTJDX7kKNHxUXhj54k4V9
         88ddErLaBIUwlU4V1rhOCeM5y+/vek1QJKyWk6+ESsxrzth/N0+WhZYKCauzTAsWecdv
         efNt7VLmh3zlH636uiJFar6VrKocjGyX/y9Jw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713994870; x=1714599670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AHwyZxYzmrEMajI8SxktaczkjAAhwGi1bdDM+8q+7+o=;
        b=YOPIGbJyiX7N83tSsFCdiM3xagJRDQiT5mPL6MrPaRoP7xpPUNgpYYEN0NKVoW+PR4
         +7NwGki883JfhLB4yqj36jyOFlM3stVjKoDYxcmrdIzWb5Jf+V4fPlJ2HbNo+eSYBN7k
         mluMP4sf3cPWe/IiTQRlbZdvKnKzB8f/QuYf9H7ogLGcBwLDBVGkgLrb3uMfxxHNUF1p
         Y0uFrKI4C0HZdbUrPdAPqQKGn2MbZgSXIsCbvVH9mtJQF8vnAtjPybvjWcR6GHbuwg7N
         b4/uvvM/8ZVZog6mSda9ReK4/j8GoHhUBzhCDyQczWe1+hZ6aIzOyUPAuNcQHsydWHHd
         xe2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXST2amqTz5ov1SlLJuq9+jvQKnW/AlKmTEb1pFa3+dZB+INoxMOWFbo5TqfqOX+MnwZZ7mh8V7pCUebiEPQOBR85n/ucSl7Q2fSyHNF99Z
X-Gm-Message-State: AOJu0YxRYz0Pc4k4Ngt/Kgduo7WgfqPW8+FLDUCG9Ic/SPE2nDtOR2uM
	Fihtg5bNPdrkQ839AGLwEqPtz9LbloOMM6HzBJ1ch4rIsYFJWWC9XP/lE3gc9Q==
X-Google-Smtp-Source: AGHT+IF+6ZBq5uRyKg/lyeaV7Zfjb1C4ubPI1uf/1ezK3wBx+DQpcIBEs1vcTlhgEw/fCjnkutcopg==
X-Received: by 2002:a05:6a00:3909:b0:6ea:c2c7:5d6a with SMTP id fh9-20020a056a00390900b006eac2c75d6amr4392756pfb.2.1713994870491;
        Wed, 24 Apr 2024 14:41:10 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d11-20020a056a0010cb00b006e685994cdesm11863906pfu.63.2024.04.24.14.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 14:41:09 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Jann Horn <jannh@google.com>,
	Matteo Rizzo <matteorizzo@google.com>,
	linux-mm@kvack.org,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Thomas Graf <tgraf@suug.ch>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	julien.voisin@dustri.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v3 6/6] mm/util: Use dedicated slab buckets for memdup_user()
Date: Wed, 24 Apr 2024 14:41:03 -0700
Message-Id: <20240424214104.3248214-6-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424213019.make.366-kees@kernel.org>
References: <20240424213019.make.366-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3141; i=keescook@chromium.org;
 h=from:subject; bh=b6S8APzjeiOvxh7QXxGMfpkIi0N6Ek4SYDm0EuC0dW4=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmKXxvnemB4TZWw6/SnmxaAlLoQIy43uGWllQev
 OnPiAH/9CKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZil8bwAKCRCJcvTf3G3A
 JgDRD/9furWdb2wMJZeJdepRap6uPYO2c5ds4IQAE7tziQMuuSmONplOC3rkp+YC2fB+nkaxPWE
 d5SxYD9e0M/84q90AW2Ti0nh0jvfTtNMZ0w2uIaVV00CyQNhiPlE3NnR373AMGa7YCotWcpcwyX
 NCGb/Um52ghKJrB7GUeqADeH51g6QIiaQ5A+61wh2r58IOUBXzWTViSlBUz7tDW/wxytYUO0xLx
 MBsozAddCGBLWZde0yKTX/DhJtVJLK9QN57x8/gGzPrEbm+SwyhxWIlVSOFZCXIb1GmE2dCKP04
 WKTMHUL9wBBDdVJHEAezmq1VUNjqrMAltoUhsU68zHrBMOZ0xALfArySjrQgYOZ/s/LhSN1eixy
 YB2HnwwW1Ob7iRyos9jHaqZuUfPhr5HkR1Xt7W48XR/orPhpxKNcC56bEVdjiNDqF2nH+7T6Dw1
 wdT983ZF/WKKXFcuG9HEuWc/berdLOmFwtWLZ2o9u/HgPXUPUYUZ3y6nO89h5f63BoqgV9Pezyf
 VBHjGDS635QY8qwXZDBkeh/KqpQ6PKclipOmkFCvAKAWYzxi7Cae9uKfTTfmYrBkCvyAQ6TmATh
 nsSnp2IGyAwwXBGuXHvO3DSd4XidX2nYJrNw/qYXoDpZvebUgj46ue7R7B/WpnH8rgDo7mlnUJJ T33evI365HcKYwg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Both memdup_user() and vmemdup_user() handle allocations that are
regularly used for exploiting use-after-free type confusion flaws in
the kernel (e.g. prctl() PR_SET_VMA_ANON_NAME[1] and setxattr[2][3][4]
respectively).

Since both are designed for contents coming from userspace, it allows
for userspace-controlled allocation sizes. Use a dedicated set of kmalloc
buckets so these allocations do not share caches with the global kmalloc
buckets.

After a fresh boot under Ubuntu 23.10, we can see the caches are already
in active use:

 # grep ^memdup /proc/slabinfo
 memdup_user-8k         4      4   8192    4    8 : ...
 memdup_user-4k         8      8   4096    8    8 : ...
 memdup_user-2k        16     16   2048   16    8 : ...
 memdup_user-1k         0      0   1024   16    4 : ...
 memdup_user-512        0      0    512   16    2 : ...
 memdup_user-256        0      0    256   16    1 : ...
 memdup_user-128        0      0    128   32    1 : ...
 memdup_user-64       256    256     64   64    1 : ...
 memdup_user-32       512    512     32  128    1 : ...
 memdup_user-16      1024   1024     16  256    1 : ...
 memdup_user-8       2048   2048      8  512    1 : ...
 memdup_user-192        0      0    192   21    1 : ...
 memdup_user-96       168    168     96   42    1 : ...

Link: https://starlabs.sg/blog/2023/07-prctl-anon_vma_name-an-amusing-heap-spray/ [1]
Link: https://duasynt.com/blog/linux-kernel-heap-spray [2]
Link: https://etenal.me/archives/1336 [3]
Link: https://github.com/a13xp0p0v/kernel-hack-drill/blob/master/drill_exploit_uaf.c [4]
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
Cc: Xiu Jianfeng <xiujianfeng@huawei.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Jann Horn <jannh@google.com>
Cc: Matteo Rizzo <matteorizzo@google.com>
Cc: linux-mm@kvack.org
---
 mm/util.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/mm/util.c b/mm/util.c
index bdec4954680a..c448f80ed441 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -198,6 +198,16 @@ char *kmemdup_nul(const char *s, size_t len, gfp_t gfp)
 }
 EXPORT_SYMBOL(kmemdup_nul);
 
+static kmem_buckets *user_buckets __ro_after_init;
+
+static int __init init_user_buckets(void)
+{
+	user_buckets = kmem_buckets_create("memdup_user", 0, 0, 0, INT_MAX, NULL);
+
+	return 0;
+}
+subsys_initcall(init_user_buckets);
+
 /**
  * memdup_user - duplicate memory region from user space
  *
@@ -211,7 +221,7 @@ void *memdup_user(const void __user *src, size_t len)
 {
 	void *p;
 
-	p = kmalloc_track_caller(len, GFP_USER | __GFP_NOWARN);
+	p = kmem_buckets_alloc_track_caller(user_buckets, len, GFP_USER | __GFP_NOWARN);
 	if (!p)
 		return ERR_PTR(-ENOMEM);
 
@@ -237,7 +247,7 @@ void *vmemdup_user(const void __user *src, size_t len)
 {
 	void *p;
 
-	p = kvmalloc(len, GFP_USER);
+	p = kmem_buckets_valloc(user_buckets, len, GFP_USER);
 	if (!p)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.34.1

