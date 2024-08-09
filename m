Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0098F42A80;
	Fri,  9 Aug 2024 07:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723188790; cv=none; b=EnTZJ/FSPXrbl6wnegowtYiJe/sRhac5ayCKNo3SuQEzVwqpfRc4VnAyg4/isTqBnl67xVUhAb0tpQUnjq2EcI3/pVdl5NDjuiUakHQxBpDoHm1Dfalc1Jj75wcuEfSMmyfUkpBXS/lBKF7HKnuy0nYQUcPmXoTYmMj9d0wrFZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723188790; c=relaxed/simple;
	bh=fH+32u2hbe+aYvteHR+ZPHJXyfY1tBWhDA7Vvn2Or58=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e+gQmH+GTW/5BSS/Kml+P8c1gpwqkeGj6XTOJew18wkxRZN6di3Q2GvvLgAarX0OqSmBZ+2m9F0ZB60FreAjN2gjOzACXGLFv/tCNc+ZON0ks2D0XuwUCrCkzk4UxqmjsfoKvNjfBmiJLNMW3pNRiL0q2ksWDKPGzf+qgs78MMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1GOg7df; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1GOg7df"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F687C32782;
	Fri,  9 Aug 2024 07:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723188789;
	bh=fH+32u2hbe+aYvteHR+ZPHJXyfY1tBWhDA7Vvn2Or58=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U1GOg7dfFb6vCTpdmAesrPycht4b3E2BP61/NHu5KkhADUw+F/qMwpsb+4EE0wwPr
	 L9nvFDqSei8WJyngCv1Q76XygeWaSsjBlLrD6F/LC8/k4VknfL0og/dzm76kmgZgtR
	 95TPrS8GpHcyJsvMNXhSCnbwb/zN8o2cGRSd7yux2dwYNZdWYITUiYaoPN0QRrAz4J
	 xWzfOO8GT/bjnPzIqghQGJWNHo7TvFmqxfVY9RsL2FSgfXLSt5noN6OfXW0U8mVhWW
	 LIZVWRO8MeNF1Hpm2FoGdrC++nOc8Th3OtGsIxGUZ8FgbOdZ6MVMjlaGpBWyS3Y5Uq
	 lUO1diWANHxyg==
From: Kees Cook <kees@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Kees Cook <kees@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	linux-mm@kvack.org,
	Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	"GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
	Jann Horn <jannh@google.com>,
	Matteo Rizzo <matteorizzo@google.com>,
	jvoisin <julien.voisin@dustri.org>,
	Xiu Jianfeng <xiujianfeng@huawei.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 1/5] slab: Introduce kmem_buckets_destroy()
Date: Fri,  9 Aug 2024 00:33:02 -0700
Message-Id: <20240809073309.2134488-1-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809072532.work.266-kees@kernel.org>
References: <20240809072532.work.266-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2139; i=kees@kernel.org; h=from:subject; bh=fH+32u2hbe+aYvteHR+ZPHJXyfY1tBWhDA7Vvn2Or58=; b=owGbwMvMwCVmps19z/KJym7G02pJDGlbjxkoHv8l8yD/Mrump/fE6Mr5/aFh0Z63wl+F6swJe 9mx9VNSRykLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwER0XzEyzOnisNb8799w6KzH TqX4LWYLH5sfsG/JsPy17/be9sMdXxgZDioISWWoefx3MnrGUf7s0jzWyOPSmyWaxZQnrvt/sGs bNwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Modular use of kmem_buckets_create() means that kmem_buckets will need
to be removed as well. Introduce kmem_buckets_destroy(), matching
kmem_cache_destroy().

Signed-off-by: Kees Cook <kees@kernel.org>
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
 include/linux/slab.h |  1 +
 mm/slab_common.c     | 17 ++++++++++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index eb2bf4629157..86cb61a0102c 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -552,6 +552,7 @@ void kmem_cache_free(struct kmem_cache *s, void *objp);
 kmem_buckets *kmem_buckets_create(const char *name, slab_flags_t flags,
 				  unsigned int useroffset, unsigned int usersize,
 				  void (*ctor)(void *));
+void kmem_buckets_destroy(kmem_buckets *b);
 
 /*
  * Bulk allocation and freeing operations. These are accelerated in an
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 40b582a014b8..fc698cba0ebe 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -392,6 +392,19 @@ kmem_cache_create(const char *name, unsigned int size, unsigned int align,
 }
 EXPORT_SYMBOL(kmem_cache_create);
 
+void kmem_buckets_destroy(kmem_buckets *b)
+{
+	int idx;
+
+	if (!b)
+		return;
+
+	for (idx = 0; idx < ARRAY_SIZE(kmalloc_caches[KMALLOC_NORMAL]); idx++)
+		kmem_cache_destroy((*b)[idx]);
+	kfree(b);
+}
+EXPORT_SYMBOL(kmem_buckets_destroy);
+
 static struct kmem_cache *kmem_buckets_cache __ro_after_init;
 
 /**
@@ -476,9 +489,7 @@ kmem_buckets *kmem_buckets_create(const char *name, slab_flags_t flags,
 	return b;
 
 fail:
-	for (idx = 0; idx < ARRAY_SIZE(kmalloc_caches[KMALLOC_NORMAL]); idx++)
-		kmem_cache_destroy((*b)[idx]);
-	kfree(b);
+	kmem_buckets_destroy(b);
 
 	return NULL;
 }
-- 
2.34.1

