Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70AF5490A
	for <linux-hardening@vger.kernel.org>; Tue,  5 Mar 2024 10:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709633430; cv=none; b=QQUcmqwPd4jxTNfoT39jq4F7DE6FegguMWefDVAIrqueRFTuECj2EUFyT2mbmxmnIHtapvxiITrXh3euwZzFNIiUevGDOEMc8XTjKP0nsIJlQpzRWkpbJp9oVJIXWgut1UmOHsg6WQNV2HSGHp/IljxLWG9ZQ6mxRzTClrnSAkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709633430; c=relaxed/simple;
	bh=Wyo8wzm4MTDz4JStiYyO080jO0R+E8V6S6bv9ZTR4iA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=geCDlgPACiAHPxeHdBAgCbqRX6CGHA3URgC4UZ/nxjuSWDI4k2NM/1YnQ36S2X7HIv8+2cA3NV2NwlzE02OMsVkE9/bDB293Xnglm+96NuNLgMetdLuNFoRrq9C5lHmbsfyj/IyrluZZOEhged9o4jpF44POgJ925p6uNJOayGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VnyWQvGo; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VnyWQvGo"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3c19aaedfdaso3388578b6e.2
        for <linux-hardening@vger.kernel.org>; Tue, 05 Mar 2024 02:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709633428; x=1710238228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8rMBFW0tg47V1vhR+hT7ZAeuwLlaibSycxaH+YicYQ=;
        b=VnyWQvGoaTrXEWac3DWanC0wt1NS9T9vvxs3BxvbDsM5KF/8Nfn8o/Pz4snNDmj72v
         eby0QoOYbUA1lQlEnKfMK97JUMbps0xP5dJmqaBY/2xaND9S+Z1wBBqRFkZqlI6eWpmp
         jPmLVRClTxt2ovLmsrd1pTzTPL0ayxxcTBz3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709633428; x=1710238228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D8rMBFW0tg47V1vhR+hT7ZAeuwLlaibSycxaH+YicYQ=;
        b=u+PKIYzbFuP5NTp0SBX/DheptdXE/ET9Zv7C3IYhgMoJyvzgt0ln/2mt3T0Qb6r/9V
         GDRP/JugXLnya0vXoHznAYJzdAtuG+x+Ew98goQdNwyR2I31Cl1S05guC15CtX9KdmV0
         4YhMYKNmJwzBFovnTzLTQ4RVJY7nViYg322eHdIeKPrrEXv5WupruFX+NJknn4KA2kY7
         RAWINgQoNsMLdeeWb7zy5dwjegnaUotTAWH8nw1LenB233X1mI/WFbwj3MOHIk4o7sWA
         hnrS8J4MkDp9gbf2VERALIt7r9XQZ1WZjNKrYxaKr/5AOWAvUpkkVDNhZnv8BVeM74P/
         56Fw==
X-Forwarded-Encrypted: i=1; AJvYcCV4CqkD6juS/d86or54vuwZO+XbjGMWNK2a7oEHqlkjo0YCSrw08LQwL8hx7HHdCNm/bWRyhZIQ0KbD2RTgXqRNUGk/+slcV57vEIxXSzfZ
X-Gm-Message-State: AOJu0Yzb5vplXKx/CIdbajmWBH/earwN8SwiDjfah1QGreAUEbwnK5k4
	ckFQ3z19aLj/IzPHIXb4/9KGcjPYEyevsxalvmeHuTqr8WWRwHZ1x0cwCJVBGg==
X-Google-Smtp-Source: AGHT+IGYfAbScDqt9gSvtMMgpvMOmJMAT2r+uZEpZv8yZZyNk7NeKQx1h1ByxW1TZ8pqZAe02uLOcw==
X-Received: by 2002:a05:6808:607:b0:3c1:559b:4290 with SMTP id y7-20020a056808060700b003c1559b4290mr1272920oih.42.1709633427854;
        Tue, 05 Mar 2024 02:10:27 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y185-20020a638ac2000000b005df41b00ee9sm8692546pgd.68.2024.03.05.02.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 02:10:27 -0800 (PST)
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
Subject: [PATCH v2 1/9] slab: Introduce kmem_buckets typedef
Date: Tue,  5 Mar 2024 02:10:17 -0800
Message-Id: <20240305101026.694758-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240305100933.it.923-kees@kernel.org>
References: <20240305100933.it.923-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1794; i=keescook@chromium.org;
 h=from:subject; bh=Wyo8wzm4MTDz4JStiYyO080jO0R+E8V6S6bv9ZTR4iA=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl5u+QdzwZRrBHJ6q6tZF3ljbnIROOFCv0Jfi5y
 dLhu0dVnMWJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZebvkAAKCRCJcvTf3G3A
 JhRGEACXqOYvigduxdiLg5s3NKoZ5sAGZvlIOApR3AAy5NlVdVm3El7+ClqD7kAsaRASlCZzfCE
 SnrdJUJTmH8pIf9m0+2frgqPwuRmMlb09607iDkUQPLPN1YxJMR27tBwJWq9BgA3ubUWo+QsdgT
 YXE7VP7nPQdqREOzraeyi2MHH+U3DNUaP61lbMW6KxmdVKDTNvRohGXZ4t+fDkAx3qPc5WUijJu
 +T0ZdLwbHIqRgXmTleQTynxNAt+ias93uGlGLgEDjoQZXs3asvnUvukRlD4dRoL8Jw9iQijFq1Q
 Dt4OD7yUPU+PD4XJr3GZIJhcJtIYM4IVHGlAVfYnKDclM8zlcITotaYHXQpXMql4PslEEE4eao3
 2lj3oguta9XJ6ZA8lMy1oJUDczWNwOLRtiE4ocEojO7GA2/sMkSDKFBWiQoXoqqozQ72/GOfjya
 z0P7wyB5UCUQt13UQzDHMpYOQ/D5+iqge17qSf3KrlYD3bDZTO0UxJ6zzyDqVGApKdVJXmzv1nS
 5BCsV9JIyHRHMs1bxaWyexVgrO27nMe+VW7LxuZWBm53lHjxxXQXT0bPu26dEUkeQrRMBN6BrfR
 Hi8QkUDZmoqSL/wiOIGv/c+qZfMpokFWp+beQoz6lhK2cuoYx+8nFdtG2JAcDlfnXKJ5RU+DLD4 BUBdZTAp9dA4F9w==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Encapsulate the concept of a single set of kmem_caches that are used
for the kmalloc size buckets. Redefine kmalloc_caches as an array
of these buckets (for the different global cache buckets).

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
 include/linux/slab.h | 5 +++--
 mm/slab_common.c     | 3 +--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index b5f5ee8308d0..55059faf166c 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -375,8 +375,9 @@ enum kmalloc_cache_type {
 	NR_KMALLOC_TYPES
 };
 
-extern struct kmem_cache *
-kmalloc_caches[NR_KMALLOC_TYPES][KMALLOC_SHIFT_HIGH + 1];
+typedef struct kmem_cache * kmem_buckets[KMALLOC_SHIFT_HIGH + 1];
+
+extern kmem_buckets kmalloc_caches[NR_KMALLOC_TYPES];
 
 /*
  * Define gfp bits that should not be set for KMALLOC_NORMAL.
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 238293b1dbe1..8787cf17d6e4 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -649,8 +649,7 @@ static struct kmem_cache *__init create_kmalloc_cache(const char *name,
 	return s;
 }
 
-struct kmem_cache *
-kmalloc_caches[NR_KMALLOC_TYPES][KMALLOC_SHIFT_HIGH + 1] __ro_after_init =
+kmem_buckets kmalloc_caches[NR_KMALLOC_TYPES] __ro_after_init =
 { /* initialization for https://bugs.llvm.org/show_bug.cgi?id=42570 */ };
 EXPORT_SYMBOL(kmalloc_caches);
 
-- 
2.34.1

