Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A2B367;
	Sat, 15 Mar 2025 03:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742008554; cv=none; b=rXvAkhx9diymv7z0a0PmjpQjmsJl/vBv/gwbvV41Ck+rGCTdi5YKOfcIDx5xZu0J4QcWGkn6w/eOvgduzHa8rB4aKfdbDXQ+4M66HzzuNdVj/tTmhPV9WNLqZy7rHM7eNJaNQTM7iTevkrlgGfkLJW7rAoILMWcOnpcckB2XvW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742008554; c=relaxed/simple;
	bh=zi7L+44xNw8FjsYE/pQgXf+lhNPzyajEGszBBKF88W0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KnW/iJzT+h9O7JGKd/rOM9hvXOe2EG6+ttjhj94/wf0EYVi+PLnT0lSOfAnCQuzB4IXiJmrzzRXj0N0bWukOPW1xDSLPVfDGpnxXSBwpnXjEYcUGHR9S1n/k3bAis6mOc4FTDCwvIZkjLWMGnrUusSso6V7UuWdBP0++D4tOaO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=agzIeCNX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="agzIeCNX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C0EDC4CEE3;
	Sat, 15 Mar 2025 03:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742008553;
	bh=zi7L+44xNw8FjsYE/pQgXf+lhNPzyajEGszBBKF88W0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=agzIeCNXq8duZcnIQDt+7ehzYrxeEh+8hpvtCiyCwY3f7Qu/27Odsrsfig5DMiAgb
	 asYW4DIQKKUuoaoFHmokbNrDOW/anEY3qOJzVzQytbHKPabDVfwUZyVQzMO6KJ/EVx
	 OEZvTpUsM47u9ziCCOAjNcn6uYTfoaEUDf8m6eH6pu8dqzzMqucUhVoNVP9fE23BwH
	 nSzpWBQWaP8xKJaum5W4VjDAhgaCbllFWy57aFcZGdaJp2mwg7GcztSvCpIrQJ7Ecn
	 E/uZT34gZ7ds0Eer/GUPyTC4mZa6R7nWZP+3ZuONmmyK2GaeC7/ch9OyPP+BrGTQ7q
	 k7KuNrGbgJvfA==
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
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-mm@kvack.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Yafang Shao <laoar.shao@gmail.com>,
	Tony Ambardar <tony.ambardar@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Alexander Potapenko <glider@google.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-doc@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v4 2/2] slab: Introduce kmalloc_obj() and family
Date: Fri, 14 Mar 2025 20:15:45 -0700
Message-Id: <20250315031550.473587-2-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250315025852.it.568-kees@kernel.org>
References: <20250315025852.it.568-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=16896; i=kees@kernel.org; h=from:subject; bh=zi7L+44xNw8FjsYE/pQgXf+lhNPzyajEGszBBKF88W0=; b=owGbwMvMwCVmps19z/KJym7G02pJDOlXPjzcc8/shdqNJlP90/13XDuWzZW9cXbOnLBnSccnW WV+SlR511HKwiDGxSArpsgSZOce5+Lxtj3cfa4izBxWJpAhDFycAjCRh2YM/4McHAPLJks5Pt5q zTrr2d2MT2+XFU1UCF7y2nTp7/b0GYwM/1OttgowfZszL+eg/4UXU+4pck7lObt9Q9prF8v1O4o rBZkA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Introduce type-aware kmalloc-family helpers to replace the common
idioms for single, array, and flexible object allocations:

	ptr = kmalloc(sizeof(*ptr), gfp);
	ptr = kmalloc(sizeof(struct some_obj_name), gfp);
	ptr = kzalloc(sizeof(*ptr), gfp);
	ptr = kmalloc_array(count, sizeof(*ptr), gfp);
	ptr = kcalloc(count, sizeof(*ptr), gfp);
	ptr = kmalloc(struct_size(ptr, flex_member, count), gfp);

These become, respectively:

	kmalloc_obj(ptr, gfp);
	kmalloc_obj(ptr, gfp);
	kzalloc_obj(ptr, gfp);
	kmalloc_objs(ptr, count, gfp);
	kzalloc_objs(ptr, count, gfp);
	kmalloc_flex(ptr, flex_member, count, gfp);

Beyond the other benefits outlined below, the primary ergonomic benefit
is the elimination of type redundancy (and the elimination of potential
type mismatches), as the existing kmalloc assignment code pattern must
always repeat the variable or the variable type on the right hand side.

These each return the assigned value of ptr (which may be NULL on
failure). For cases where the total size of the allocation is needed,
the kmalloc_obj_sz(), kmalloc_objs_sz(), and kmalloc_flex_sz() family
of macros can be used. For example:

	info->size = struct_size(ptr, flex_member, count);
	ptr = kmalloc(info->size, gfp);

becomes:

	kmalloc_flex_sz(ptr, flex_member, count, gfp, &info->size);

With the *_sz() helpers, it becomes possible to do bounds checking of
the final size to make sure no arithmetic overflow has happened that
exceeds the storage size of the target size variable. e.g. it was possible
before to end up wrapping an allocation size and not noticing, there by
allocating too small a size. (Most of Linux's exposure on that particular
problem is via newly written code as we already did bulk conversions[1],
but we continue to have a steady stream of patches catching additional
cases[2] that would just go away with this API.)

Internal introspection of the allocated type now becomes possible,
allowing for future alignment-aware choices to be made by the allocator
and future hardening work that can be type sensitive. For example,
adding __alignof(*ptr) as an argument to the internal allocators so that
appropriate/efficient alignment choices can be made, or being able to
correctly choose per-allocation offset randomization within a bucket
that does not break alignment requirements.

For the flexible array helpers, the internal use of __flex_counter()
allows for automatically setting the counter member of a struct's flexible
array member when it has been annotated with __counted_by(), avoiding
any missed early size initializations while __counted_by() annotations
are added to the kernel. Additionally, this also checks for "too large"
allocations based on the type size of the counter variable. For example:

	if (count > type_max(ptr->flex_count))
		fail...;
	info->size = struct_size(ptr, flex_member, count);
	ptr = kmalloc(info->size, gfp);
	ptr->flex_count = count;

becomes (n.b. unchanged from earlier example):

	kmalloc_flex_sz(ptr, flex_member, count, gfp, &info->size);
	ptr->flex_count = count;

Note that manual initialization of the flexible array counter is still
required (at some point) after allocation as not all compiler versions
support the __counted_by annotation yet. But doing it internally makes
sure they cannot be missed when __counted_by _is_ available, meaning
that the bounds checker will not trip due to the lack of "early enough"
initializations that used to work before enabling the stricter bounds
checking. For example:

	kmalloc_flex(ptr, flex_member, count);
	fill(ptr->flex, count);
	ptr->flex_count = count;

This works correctly before adding a __counted_by annotation (since
nothing is checking ptr->flex accesses against ptr->flex_count). After
adding the annotation, the bounds sanitizer would trip during fill()
because ptr->flex_count wasn't set yet. But with kmalloc_flex() setting
ptr->flex_count internally at allocation time, the existing code works
without needing to move the ptr->flex_count assignment before the call
to fill(). (This has been a stumbling block for __counted_by adoption.)

Replacing all existing simple code patterns found via Coccinelle[3]
shows what could be replaced immediately (also saving roughly 2200 lines):

 7568 files changed, 16342 insertions(+), 18580 deletions(-)

This would take us from 23927 k*alloc assignments to 8378:

$ git grep ' = kv\?[mzcv]alloc\(\|_array\)(' | wc -l
23927
$ git reset --hard HEAD^
HEAD is now at 8bccc91e6cdf treewide: kmalloc_obj conversion
$ git grep ' = kv\?[mzcv]alloc\(\|_array\)(' | wc -l
8378

This treewide change could be done at the end of the merge window just
before -rc1 is released (as is common for treewide changes). Handling
this API change in backports to -stable should be possible without much
hassle by backporting the __flex_counter() patch and this patch, while
taking conversions as-needed.

The impact on my bootable testing image size (with the treewide patch
applied) is tiny. With both GCC 13 (no __counted_by support) and GCC 15
(with __counted_by) the images are actually very slightly smaller:

$ size -G gcc-boot/vmlinux.gcc*
      text       data        bss      total filename
  29975593   21527689   16601200   68104482 gcc-boot/vmlinux.gcc13-before
  29969263   21528663   16601112   68099038 gcc-boot/vmlinux.gcc13-after
  30555626   21291299   17086620   68933545 gcc-boot/vmlinux.gcc15-before
  30550144   21292039   17086540   68928723 gcc-boot/vmlinux.gcc15-after

Link: https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b08fc5277aaa1d8ea15470d38bf36f19dfb0e125 [1]
Link: https://lore.kernel.org/all/?q=s%3Akcalloc+-s%3ARe%3A [2]
Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/kmalloc_objs.cocci [3]
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
Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: Bill Wendling <morbo@google.com>
Cc: Justin Stitt <justinstitt@google.com>
Cc: Jann Horn <jannh@google.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Marco Elver <elver@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>
Cc: linux-mm@kvack.org
---
 Documentation/process/deprecated.rst |  42 +++++++
 include/linux/slab.h                 | 170 +++++++++++++++++++++++++++
 2 files changed, 212 insertions(+)

diff --git a/Documentation/process/deprecated.rst b/Documentation/process/deprecated.rst
index 1f7f3e6c9cda..c5a4b245c895 100644
--- a/Documentation/process/deprecated.rst
+++ b/Documentation/process/deprecated.rst
@@ -372,3 +372,45 @@ The helper must be used::
 			DECLARE_FLEX_ARRAY(struct type2, two);
 		};
 	};
+
+Open-coded kmalloc assignments for struct objects
+-------------------------------------------------
+Performing open-coded kmalloc()-family allocation assignments prevents
+the kernel (and compiler) from being able to examine the type of the
+variable being assigned, which limits any related introspection that
+may help with alignment, wrap-around, or additional hardening. The
+kmalloc_obj()-family of macros provide this introspection, which can be
+used for the common code patterns for single, array, and flexible object
+allocations. For example, these open coded assignments::
+
+	ptr = kmalloc(sizeof(*ptr), gfp);
+	ptr = kmalloc(sizeof(struct the_type_of_ptr_obj), gfp);
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
+the kmalloc_obj_sz(), kmalloc_objs_sz(), and kmalloc_flex_sz() family of
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
diff --git a/include/linux/slab.h b/include/linux/slab.h
index 09eedaecf120..c51edc046835 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -12,6 +12,7 @@
 #ifndef _LINUX_SLAB_H
 #define	_LINUX_SLAB_H
 
+#include <linux/bug.h>
 #include <linux/cache.h>
 #include <linux/gfp.h>
 #include <linux/overflow.h>
@@ -906,6 +907,175 @@ static __always_inline __alloc_size(1) void *kmalloc_noprof(size_t size, gfp_t f
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
+	if (!WARN_ON_ONCE(__size_ptr && __obj_size > type_max(*__size_ptr))) \
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
+	const size_t __count = (COUNT);					\
+	size_t __obj_size = struct_size(P, FAM, __count);		\
+	/* "*SIZE = ...;" below is unbuildable when SIZE is "NULL" */	\
+	const typeof(_Generic(SIZE,					\
+			void *: (size_t *)NULL,				\
+			default: SIZE)) __size_ptr = (SIZE);		\
+	typeof(P) __obj_ptr = NULL;					\
+	if (!WARN_ON_ONCE(!can_set_flex_counter(__obj_ptr->FAM, __count)) && \
+	    !WARN_ON_ONCE(__size_ptr && __obj_size > type_max(*__size_ptr))) \
+		__obj_ptr = ALLOC(__obj_size, FLAGS);			\
+	if (__obj_ptr) {						\
+		set_flex_counter(__obj_ptr->FAM, __count);		\
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
+
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
+
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
+
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
+
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
+/* All kzalloc aliases for kmalloc_(obj|objs|fam)(|_sz). */
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
+/* All kvmalloc aliases for kmalloc_(obj|objs|fam)(|_sz). */
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
+/* All kvzalloc aliases for kmalloc_(obj|objs|fam)(|_sz). */
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

