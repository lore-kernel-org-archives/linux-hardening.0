Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9034F231A30;
	Fri, 21 Mar 2025 20:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742589669; cv=none; b=YFfVPcHd4CWK2xbWqKlG4DQrXpyMFOhHpzkbwDQIGQVDdQkLQhYSJyOdXD0yfoevpjtSkdNhFSsL8FUlqF6PYc/g5tUezRLiBAUI+GfWRWudB0KExfhInlxSnBciQ2ObJNMLoSYlr8DiVgBkEgrRty42WG5YYJFRLtt52usNiE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742589669; c=relaxed/simple;
	bh=8jN+LgPc4pYO7xP8Ft4KTlabcnXZcFpxZy0ZLjzDlJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ou653dRGNRa1hO07wZ2Xm/a9B4FlOrW+oDh9va5B/oJjgGyVeCl85euMjjFzoxsxtSPb+Pg3sNsnGZO8tFQVqu/YT24RfKrse1mK4Hgj3VyvqtMNxoHKMgAPNjf9Ee5n3ii9exHU3lrvArvyyX4qSFIpF9ZntT6al6EUi9NIUlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WtJq8S47; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WtJq8S47"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF32AC4CEEE;
	Fri, 21 Mar 2025 20:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742589669;
	bh=8jN+LgPc4pYO7xP8Ft4KTlabcnXZcFpxZy0ZLjzDlJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WtJq8S47J/UuWqIAzy9TuEJGFQk4HJuLRbH8atr4DkckIW8aXz4mhZhyDvxpREsHs
	 pRz/myqOcZP8kBIQkxj93QtnE+NoL+cAe8pFBq7KoEgOYgT+S7+YVyC1kTj3K2YKxn
	 u6pcn5daWnjtIktg8f1Da/vbZCLSx2+f4TSuTkwxby6VkAodokz6T/fhVvsL6TTcVS
	 mb2Nxlku8Sm528ibouXmGEjQAMLBewdMwBIsPBZCtlgJirx5gvUM+2GbM62VL/ZHb0
	 8UXSomC4QEcbKaDad86AheREhHoY/DmO1oSa06aS177vok6kSNQbvGm0zpCEybBQGT
	 ls9yw8rB8S+vg==
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
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Marco Elver <elver@google.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 4/5] slab: Set freed variables to NULL by default
Date: Fri, 21 Mar 2025 13:41:00 -0700
Message-Id: <20250321204105.1898507-4-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250321202620.work.175-kees@kernel.org>
References: <20250321202620.work.175-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4269; i=kees@kernel.org; h=from:subject; bh=8jN+LgPc4pYO7xP8Ft4KTlabcnXZcFpxZy0ZLjzDlJ8=; b=owGbwMvMwCVmps19z/KJym7G02pJDOl3z92p+u+64HJA29I5My3e3+V+YpHjosRV7hSQWLmb7 2rYS9nOjlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgIm0zWX4Kymo1fzu4dItS5lN L54sOBR8f4ZR2IcXrw5xa11VYq+TyGFkuH5kVZ9nvsOsv+6xv36efM6lFZbqfmciZ4tSmPrNljf ubAA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

To defang a subset of "dangling pointer" use-after-free flaws[1], take the
address of any lvalues passed to kfree() and set them to NULL after
freeing.

To do this manually, kfree_and_null() (and the "sensitive" variant)
are introduced.

Link: https://github.com/KSPP/linux/issues/87 [1]
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
 include/linux/slab.h | 30 +++++++++++++++++++++++++++---
 mm/slab_common.c     |  8 ++++----
 mm/slub.c            |  6 +++---
 3 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 3e807ccc8583..2717ad238fa2 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -465,11 +465,35 @@ void * __must_check krealloc_noprof(const void *objp, size_t new_size,
 				    gfp_t flags) __realloc_size(2);
 #define krealloc(...)				alloc_hooks(krealloc_noprof(__VA_ARGS__))
 
-void kfree(const void *objp);
-void kfree_sensitive(const void *objp);
+void __kfree(const void *objp);
+void __kfree_sensitive(const void *objp);
 size_t __ksize(const void *objp);
 
-#define __kfree(x)	kfree(x)
+static inline void kfree_and_null(void **ptr)
+{
+	__kfree(*ptr);
+	*ptr = NULL;
+}
+static inline void kfree_sensitive_and_null(void **ptr)
+{
+	__kfree_sensitive(*ptr);
+	*ptr = NULL;
+}
+
+#define __force_lvalue_expr(x)	\
+	__builtin_choose_expr(__is_lvalue(x), x, (void *){ NULL })
+
+#define __free_and_null(__how, x)	\
+({					\
+	typeof(x) *__ptr = &(x);	\
+	__how ## _and_null((void **)__ptr);	\
+})
+#define __free_and_maybe_null(__how, x)	\
+	__builtin_choose_expr(__is_lvalue(x), \
+		__free_and_null(__how, __force_lvalue_expr(x)), \
+		__kfree(x))
+#define kfree(x)	   __free_and_maybe_null(kfree, x)
+#define kfree_sensitive(x) __free_and_maybe_null(kfree_sensitive, x)
 
 DEFINE_FREE(kfree, void *, if (!IS_ERR_OR_NULL(_T)) kfree(_T))
 DEFINE_FREE(kfree_sensitive, void *, if (_T) kfree_sensitive(_T))
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 4030907b6b7d..9a82952ec266 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1211,7 +1211,7 @@ module_init(slab_proc_init);
 #endif /* CONFIG_SLUB_DEBUG */
 
 /**
- * kfree_sensitive - Clear sensitive information in memory before freeing
+ * __kfree_sensitive - Clear sensitive information in memory before freeing
  * @p: object to free memory of
  *
  * The memory of the object @p points to is zeroed before freed.
@@ -1221,7 +1221,7 @@ module_init(slab_proc_init);
  * deal bigger than the requested buffer size passed to kmalloc(). So be
  * careful when using this function in performance sensitive code.
  */
-void kfree_sensitive(const void *p)
+void __kfree_sensitive(const void *p)
 {
 	size_t ks;
 	void *mem = (void *)p;
@@ -1231,9 +1231,9 @@ void kfree_sensitive(const void *p)
 		kasan_unpoison_range(mem, ks);
 		memzero_explicit(mem, ks);
 	}
-	kfree(mem);
+	__kfree(mem);
 }
-EXPORT_SYMBOL(kfree_sensitive);
+EXPORT_SYMBOL(__kfree_sensitive);
 
 size_t ksize(const void *objp)
 {
diff --git a/mm/slub.c b/mm/slub.c
index 1f50129dcfb3..38dd898667bf 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4729,12 +4729,12 @@ static void free_large_kmalloc(struct folio *folio, void *object)
 }
 
 /**
- * kfree - free previously allocated memory
+ * __kfree - free previously allocated memory
  * @object: pointer returned by kmalloc() or kmem_cache_alloc()
  *
  * If @object is NULL, no operation is performed.
  */
-void kfree(const void *object)
+void __kfree(const void *object)
 {
 	struct folio *folio;
 	struct slab *slab;
@@ -4756,7 +4756,7 @@ void kfree(const void *object)
 	s = slab->slab_cache;
 	slab_free(s, slab, x, _RET_IP_);
 }
-EXPORT_SYMBOL(kfree);
+EXPORT_SYMBOL(__kfree);
 
 static __always_inline __realloc_size(2) void *
 __do_krealloc(const void *p, size_t new_size, gfp_t flags)
-- 
2.34.1

