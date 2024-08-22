Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF799168C20;
	Thu, 22 Aug 2024 23:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724368413; cv=none; b=kAvIbyPeT9n3cnveBbjDTeCHL85UNkUMgtOI53IsC1BbKMmfKrNPWtUDcZhETILTxY+BMmy+qtaF3kUkLtxW9bk24S3BD5s7BDGUp4C2DNtn+Zm2Kc2MCEofPl4db9hReNOt/xVSE5178DfEZSw/FIL7VBw92ttjB6qqFq/kf4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724368413; c=relaxed/simple;
	bh=TAMX8QsL8uiGQwqtkfnQTvM5gnjyCIZExznlqwceoRA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jp99a2SmCyW3vAG4Pdj7mfBnRKq3PGkawJ0K12sP1PQlsQkIvFPulVDHoLtLygkHcFIWXyyPIvegv7bVVoAFgilLr8RxP7Qbepo3NB/3V7OOylcsXIeDIjLrsF7X8gRfJQzjLA3amzF8Ch02F2Yh8QRReOJeITKA8hCnrMzToKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JzP/gGLA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JzP/gGLA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42494C32782;
	Thu, 22 Aug 2024 23:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724368411;
	bh=TAMX8QsL8uiGQwqtkfnQTvM5gnjyCIZExznlqwceoRA=;
	h=From:To:Cc:Subject:Date:From;
	b=JzP/gGLA5YDMA58IOT1SDJU7jwf+zCJch5lIg3m/Y6e/QZCtCadWqXiEHyuiEGHss
	 9peWmFvp6HX4cn/p+o/7diyBnu9YPKQeoVOXvgfe4ypJg3aWcX9qS548jtLImkXIoO
	 jNdixRTkAebLsqTkNgTJ1TtohV8SStjiN34FprDMpSJN6K7bcKfTYwVjcsoDBQw2t7
	 gBjKaJ8nNj7dyfi1VXtDr14cikLb4zC1MkWeheg+L3HtMSRQVbqVwMEPEOLncPwvvA
	 YMLw8vcBmmFiIEuorlevB2MSOFktNZB5FNnNyAFFG1EgHR8Xy2VGrc7n0mjzYqfruz
	 Zqz7WqTyWk9RQ==
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
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Jann Horn <jannh@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Marco Elver <elver@google.com>,
	linux-mm@kvack.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: [PATCH v3] slab: Introduce kmalloc_obj() and family
Date: Thu, 22 Aug 2024 16:13:28 -0700
Message-Id: <20240822231324.make.666-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=15177; i=kees@kernel.org; h=from:subject:message-id; bh=TAMX8QsL8uiGQwqtkfnQTvM5gnjyCIZExznlqwceoRA=; b=owGbwMvMwCVmps19z/KJym7G02pJDGnHj0nsn5XNE7b7V3nIbX6X/Wq6xzdU1T6f2qJg8TP42 zOOsLeXO0pZGMS4GGTFFFmC7NzjXDzetoe7z1WEmcPKBDKEgYtTACai9p6R4Zep6y75CbrmKyb5 ryhjf6isubfGf/li7vMfPp6+vjbrqTojw/Lyi/97123mmqLlmH/L82A9M+uiSIU7C0M5zew7TCU f8QEA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Introduce type-aware kmalloc-family helpers to replace the common
idioms for single, array, and flexible object allocations:

	ptr = kmalloc(sizeof(*ptr), gfp);
	ptr = kzalloc(sizeof(*ptr), gfp);
	ptr = kmalloc_array(count, sizeof(*ptr), gfp);
	ptr = kcalloc(count, sizeof(*ptr), gfp);
	ptr = kmalloc(struct_size(ptr, flex_member, count), gfp);

These become, respectively:

	kmalloc_obj(ptr, gfp);
	kzalloc_obj(ptr, gfp);
	kmalloc_objs(ptr, count, gfp);
	kzalloc_objs(ptr, count, gfp);
	kmalloc_flex(ptr, flex_member, count, gfp);

These each return the assigned value of ptr (which may be NULL on
failure). For cases where the total size of the allocation is needed,
the kmalloc_obj_sz(), kmalloc_objs_sz(), and kmalloc_flex_sz() family
of macros can be used. For example:

	info->size = struct_size(ptr, flex_member, count);
	ptr = kmalloc(info->size, gfp);

becomes:

	kmalloc_flex_sz(ptr, flex_member, count, gfp, &info->size);

Internal introspection of allocated type now becomes possible, allowing
for future alignment-aware choices and hardening work. For example,
adding __alignof(*ptr) as an argument to the internal allocators so that
appropriate/efficient alignment choices can be made, or being able to
correctly choose per-allocation offset randomization within a bucket
that does not break alignment requirements.

Introduces __flex_count() for when __builtin_get_counted_by() is added
by GCC[1] and Clang[2]. The internal use of __flex_count() allows for
automatically setting the counter member of a struct's flexible array
member when it has been annotated with __counted_by(), avoiding any
missed early size initializations while __counted_by() annotations are
added to the kernel. Additionally, this also checks for "too large"
allocations based on the type size of the counter variable. For example:

	if (count > type_max(ptr->flex_count))
		fail...;
	info->size = struct_size(ptr, flex_member, count);
	ptr = kmalloc(info->size, gfp);
	ptr->flex_count = count;

becomes (i.e. unchanged from earlier example):

	kmalloc_flex_sz(ptr, flex_member, count, gfp, &info->size);

Replacing all existing simple code patterns found via Coccinelle[3]
shows what could be replaced immediately (saving roughly 1,500 lines):

 7040 files changed, 14128 insertions(+), 15557 deletions(-)

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=116016 [1]
Link: https://github.com/llvm/llvm-project/issues/99774 [2]
Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/kmalloc_obj-assign-size.cocci [3]
Signed-off-by: Kees Cook <kees@kernel.org>
---
Initial testing looks good. Before I write all the self-tests, I just
wanted to validate that the new API is reasonable (i.e. it is no longer
using optional argument counts for choosing the internal API).

 v3:
  - Add .rst documentation
  - Add kern-doc
  - Return ptr instead of size by default
  - Add *_sz() variants that provide allocation size output
  - Implement __flex_counter() logic
 v2: https://lore.kernel.org/linux-hardening/20240807235433.work.317-kees@kernel.org/
 v1: https://lore.kernel.org/linux-hardening/20240719192744.work.264-kees@kernel.org/
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: Bill Wendling <morbo@google.com>
Cc: Justin Stitt <justinstitt@google.com>
Cc: Jann Horn <jannh@google.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Marco Elver <elver@google.com>
Cc: linux-mm@kvack.org
---
 Documentation/process/deprecated.rst |  41 +++++++
 include/linux/compiler_types.h       |  22 ++++
 include/linux/slab.h                 | 174 +++++++++++++++++++++++++++
 3 files changed, 237 insertions(+)

diff --git a/Documentation/process/deprecated.rst b/Documentation/process/deprecated.rst
index 1f7f3e6c9cda..b22ec088a044 100644
--- a/Documentation/process/deprecated.rst
+++ b/Documentation/process/deprecated.rst
@@ -372,3 +372,44 @@ The helper must be used::
 			DECLARE_FLEX_ARRAY(struct type2, two);
 		};
 	};
+
+Open-coded kmalloc assignments
+------------------------------
+Performing open-coded kmalloc()-family allocation assignments prevents
+the kernel (and compiler) from being able to examine the type of the
+variable being assigned, which limits any related introspection that
+may help with alignment, wrap-around, or additional hardening. The
+kmalloc_obj()-family of macros provide this introspection, which can be
+used for the common code patterns for single, array, and flexible object
+allocations. For example, these open coded assignments::
+
+	ptr = kmalloc(sizeof(*ptr), gfp);
+	ptr = kzalloc(sizeof(*ptr), gfp);
+	ptr = kmalloc_array(count, sizeof(*ptr), gfp);
+	ptr = kcalloc(count, sizeof(*ptr), gfp);
+	ptr = kmalloc(struct_size(ptr, flex_member, count), gfp);
+
+become, respectively::
+
+	kmalloc_obj(ptr, gfp);
+	kzalloc_obj(ptr, gfp);
+	kmalloc_objs(ptr, count, gfp);
+	kzalloc_objs(ptr, count, gfp);
+	kmalloc_flex(ptr, flex_member, count, gfp);
+
+For the cases where the total size of the allocation is also needed,
+the kmalloc_obj_size(), kmalloc_objs_sz(), and kmalloc_flex_sz() family of
+macros can be used. For example, converting these assignments::
+
+	total_size = struct_size(ptr, flex_member, count);
+	ptr = kmalloc(total_size, gfp);
+
+becomes::
+
+	kmalloc_flex_sz(ptr, flex_member, count, gfp, &total_size);
+
+If `ptr->flex_member` is annotated with __counted_by(), the allocation
+will automatically fail if `count` is larger than the maximum
+representable value that can be stored in the counter member associated
+with `flex_member`. Similarly, the allocation will fail if the total
+size of the allocation exceeds the maximum value `*total_size` can hold.
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index f14c275950b5..b99deae45210 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -421,6 +421,28 @@ struct ftrace_likely_data {
 #define __member_size(p)	__builtin_object_size(p, 1)
 #endif
 
+#if __has_builtin(__builtin_get_counted_by)
+/**
+ * __flex_counter - Get pointer to counter member for the given
+ *		    flexible array, if it was annotated with __counted_by()
+ * @flex: Pointer to flexible array member of an addressable struct instance
+ *
+ * For example, with:
+ *
+ *	struct foo {
+ *		int counter;
+ *		short array[] __counted_by(counter);
+ *	} *p;
+ *
+ * __flex_counter(p->array) will resolve to &p->counter.
+ *
+ * If p->array is unannotated, this returns (void *)NULL.
+ */
+#define __flex_counter(flex)	__builtin_get_counted_by(flex)
+#else
+#define __flex_counter(flex)	((void *)NULL)
+#endif
+
 /*
  * Some versions of gcc do not mark 'asm goto' volatile:
  *
diff --git a/include/linux/slab.h b/include/linux/slab.h
index eb2bf4629157..c37606b9e248 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -686,6 +686,180 @@ static __always_inline __alloc_size(1) void *kmalloc_noprof(size_t size, gfp_t f
 }
 #define kmalloc(...)				alloc_hooks(kmalloc_noprof(__VA_ARGS__))
 
+#define __alloc_objs(ALLOC, P, COUNT, FLAGS, SIZE)		\
+({								\
+	size_t __obj_size = size_mul(sizeof(*P), COUNT);	\
+	const typeof(_Generic(SIZE,				\
+			void *: (size_t *)NULL,			\
+			default: SIZE)) __size_ptr = (SIZE);	\
+	typeof(P) __obj_ptr = NULL;				\
+	/* Does the total size fit in the *SIZE variable? */	\
+	if (!__size_ptr || __obj_size <= type_max(*__size_ptr))	\
+		__obj_ptr = ALLOC(__obj_size, FLAGS);		\
+	if (!__obj_ptr)						\
+		__obj_size = 0;					\
+	if (__size_ptr)						\
+		*__size_ptr = __obj_size;			\
+	(P) = __obj_ptr;					\
+})
+
+#define __alloc_flex(ALLOC, P, FAM, COUNT, FLAGS, SIZE)			\
+({									\
+	size_t __count = (COUNT);					\
+	size_t __obj_size = struct_size(P, FAM, __count);		\
+	const typeof(_Generic(SIZE,					\
+			void *: (size_t *)NULL,				\
+			default: SIZE)) __size_ptr = (SIZE);		\
+	typeof(P) __obj_ptr = NULL;					\
+	/* Just query the counter type for type_max checking. */	\
+	typeof(_Generic(__flex_counter(__obj_ptr->FAM),			\
+			void *: (size_t *)NULL,				\
+			default: __flex_counter(__obj_ptr->FAM)))	\
+		__counter_type_ptr = NULL;				\
+	/* Does the count fit in the __counted_by counter member? */	\
+	if ((__count <= type_max(*__counter_type_ptr)) &&		\
+	    /* Does the total size fit in the *SIZE variable? */	\
+	    (!__size_ptr || __obj_size <= type_max(*__size_ptr)))	\
+		__obj_ptr = ALLOC(__obj_size, FLAGS);			\
+	if (__obj_ptr) {						\
+		/* __obj_ptr now allocated so get real counter ptr. */	\
+		typeof(_Generic(__flex_counter(__obj_ptr->FAM),		\
+				void *: (size_t *)NULL,			\
+				default: __flex_counter(__obj_ptr->FAM))) \
+			__counter_ptr = __flex_counter(__obj_ptr->FAM);	\
+		if (__counter_ptr)					\
+			*__counter_ptr = __count;			\
+	} else {							\
+		__obj_size = 0;						\
+	}								\
+	if (__size_ptr)							\
+		*__size_ptr = __obj_size;				\
+	(P) = __obj_ptr;						\
+})
+
+/**
+ * kmalloc_obj - Allocate a single instance of the given structure
+ * @P: Pointer to hold allocation of the structure
+ * @FLAGS: GFP flags for the allocation
+ *
+ * Returns the newly allocated value of @P on success, NULL on failure.
+ * @P is assigned the result, either way.
+ */
+#define kmalloc_obj(P, FLAGS)				\
+	__alloc_objs(kmalloc, P, 1, FLAGS, NULL)
+/**
+ * kmalloc_obj_sz - Allocate a single instance of the given structure and
+ *		 store total size
+ * @P: Pointer to hold allocation of the structure
+ * @FLAGS: GFP flags for the allocation
+ * @SIZE: Pointer to variable to hold the total allocation size
+ *
+ * Returns the newly allocated value of @P on success, NULL on failure.
+ * @P is assigned the result, either way. If @SIZE is non-NULL, the
+ * allocation will immediately fail if the total allocation size is larger
+ * than what the type of *@SIZE can represent.
+ */
+#define kmalloc_obj_sz(P, FLAGS, SIZE)			\
+	__alloc_objs(kmalloc, P, 1, FLAGS, SIZE)
+/**
+ * kmalloc_objs - Allocate an array of the given structure
+ * @P: Pointer to hold allocation of the structure array
+ * @COUNT: How many elements in the array
+ * @FLAGS: GFP flags for the allocation
+ *
+ * Returns the newly allocated value of @P on success, NULL on failure.
+ * @P is assigned the result, either way.
+ */
+#define kmalloc_objs(P, COUNT, FLAGS)			\
+	__alloc_objs(kmalloc, P, COUNT, FLAGS, NULL)
+/**
+ * kmalloc_objs_sz - Allocate an array of the given structure and store
+ *		     total size
+ * @P: Pointer to hold allocation of the structure array
+ * @COUNT: How many elements in the array
+ * @FLAGS: GFP flags for the allocation
+ * @SIZE: Pointer to variable to hold the total allocation size
+ *
+ * Returns the newly allocated value of @P on success, NULL on failure.
+ * @P is assigned the result, either way. If @SIZE is non-NULL, the
+ * allocation will immediately fail if the total allocation size is larger
+ * than what the type of *@SIZE can represent.
+ */
+#define kmalloc_objs_sz(P, COUNT, FLAGS, SIZE)		\
+	__alloc_objs(kmalloc, P, COUNT, FLAGS, SIZE)
+/**
+ * kmalloc_flex - Allocate a single instance of the given flexible structure
+ * @P: Pointer to hold allocation of the structure
+ * @FAM: The name of the flexible array member of the structure
+ * @COUNT: How many flexible array member elements are desired
+ * @FLAGS: GFP flags for the allocation
+ *
+ * Returns the newly allocated value of @P on success, NULL on failure.
+ * @P is assigned the result, either way. If @FAM has been annotated with
+ * __counted_by(), the allocation will immediately fail if @COUNT is larger
+ * than what the type of the struct's counter variable can represent.
+ */
+#define kmalloc_flex(P, FAM, COUNT, FLAGS)		\
+	__alloc_flex(kmalloc, P, FAM, COUNT, FLAGS, NULL)
+
+/**
+ * kmalloc_flex_sz - Allocate a single instance of the given flexible
+ *		     structure and store total size
+ * @P: Pointer to hold allocation of the structure
+ * @FAM: The name of the flexible array member of the structure
+ * @COUNT: How many flexible array member elements are desired
+ * @FLAGS: GFP flags for the allocation
+ * @SIZE: Pointer to variable to hold the total allocation size
+ *
+ * Returns the newly allocated value of @P on success, NULL on failure.
+ * @P is assigned the result, either way. If @FAM has been annotated with
+ * __counted_by(), the allocation will immediately fail if @COUNT is larger
+ * than what the type of the struct's counter variable can represent. If
+ * @SIZE is non-NULL, the allocation will immediately fail if the total
+ * allocation size is larger than what the type of *@SIZE can represent.
+ */
+#define kmalloc_flex_sz(P, FAM, COUNT, FLAGS, SIZE)	\
+	__alloc_flex(kmalloc, P, FAM, COUNT, FLAGS, SIZE)
+
+#define kzalloc_obj(P, FLAGS)				\
+	__alloc_objs(kzalloc, P, 1, FLAGS, NULL)
+#define kzalloc_obj_sz(P, FLAGS, SIZE)			\
+	__alloc_objs(kzalloc, P, 1, FLAGS, SIZE)
+#define kzalloc_objs(P, COUNT, FLAGS)			\
+	__alloc_objs(kzalloc, P, COUNT, FLAGS, NULL)
+#define kzalloc_objs_sz(P, COUNT, FLAGS, SIZE)		\
+	__alloc_objs(kzalloc, P, COUNT, FLAGS, SIZE)
+#define kzalloc_flex(P, FAM, COUNT, FLAGS)		\
+	__alloc_flex(kzalloc, P, FAM, COUNT, FLAGS, NULL)
+#define kzalloc_flex_sz(P, FAM, COUNT, FLAGS, SIZE)	\
+	__alloc_flex(kzalloc, P, FAM, COUNT, FLAGS, SIZE)
+
+#define kvmalloc_obj(P, FLAGS)				\
+	__alloc_objs(kvmalloc, P, 1, FLAGS, NULL)
+#define kvmalloc_obj_sz(P, FLAGS, SIZE)			\
+	__alloc_objs(kvmalloc, P, 1, FLAGS, SIZE)
+#define kvmalloc_objs(P, COUNT, FLAGS)			\
+	__alloc_objs(kvmalloc, P, COUNT, FLAGS, NULL)
+#define kvmalloc_objs_sz(P, COUNT, FLAGS, SIZE)		\
+	__alloc_objs(kvmalloc, P, COUNT, FLAGS, SIZE)
+#define kvmalloc_flex(P, FAM, COUNT, FLAGS)		\
+	__alloc_flex(kvmalloc, P, FAM, COUNT, FLAGS, NULL)
+#define kvmalloc_flex_sz(P, FAM, COUNT, FLAGS, SIZE)	\
+	__alloc_flex(kvmalloc, P, FAM, COUNT, FLAGS, SIZE)
+
+#define kvzalloc_obj(P, FLAGS)				\
+	__alloc_objs(kvzalloc, P, 1, FLAGS, NULL)
+#define kvzalloc_obj_sz(P, FLAGS, SIZE)			\
+	__alloc_objs(kvzalloc, P, 1, FLAGS, SIZE)
+#define kvzalloc_objs(P, COUNT, FLAGS)			\
+	__alloc_objs(kvzalloc, P, COUNT, FLAGS, NULL)
+#define kvzalloc_objs_sz(P, COUNT, FLAGS, SIZE)		\
+	__alloc_objs(kvzalloc, P, COUNT, FLAGS, SIZE)
+#define kvzalloc_flex(P, FAM, COUNT, FLAGS)		\
+	__alloc_flex(kvzalloc, P, FAM, COUNT, FLAGS, NULL)
+#define kvzalloc_flex_sz(P, FAM, COUNT, FLAGS, SIZE)	\
+	__alloc_flex(kvzalloc, P, FAM, COUNT, FLAGS, SIZE)
+
 #define kmem_buckets_alloc(_b, _size, _flags)	\
 	alloc_hooks(__kmalloc_node_noprof(PASS_BUCKET_PARAMS(_size, _b), _flags, NUMA_NO_NODE))
 
-- 
2.34.1

