Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4B43A8736;
	Tue,  6 Oct 2026 09:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791278437; cv=none; b=o/VOxD2I5r4aIOiTjXsiefO19ko0VFCkKqvgIxPhfFE8ijGPc1tF7ZHDdTxdw7hFUCVDyQ3QcYLFCm9risssEcLnEQUpiJ/vrUC7XSQo5OdPgsdFogM5N5wwaoc9Rlht8BUWN9GNGfxvHMP4OTfGD/iUG9FnPzg2U8IgcYpXjuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791278437; c=relaxed/simple;
	bh=Qc4gibobM/KiTch6bZpTHBpEl8CwkLveGZU5LrXrSHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=muhZ4NU3z8chhpiXhwAbRc8AGkDU0s28yHbonmg9V1iP2i22cEIShPjIpCyzfgZdXmPqV6i9RyNvvXWo6u/Odys2OWcOWZcmTpA5ZIoEpwx4tzdqY9xTR5LQt+GCG8ggkHLn5GK1vo6CYtLuILvbheQtr4Bbu5OcHKlk7MZD5K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMdhQHzq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMdhQHzq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F44F1F00899;
	Tue,  6 Oct 2026 09:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791278436;
	bh=bQARg85OdF5eGN4sTix/VU3mJvlcuBipIV6C7S90Sf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bMdhQHzqdI4P9vGs4735+trKLMRhRI0V8H/o4q2jl8pdDlT8ie3YnFFrbvS+qLxX4
	 7vswKvj3s8lcAAJQIwedRBsfOuh6GN1nsv9a20stUq1gzoHVsTdbHTve3yxHOwPsIT
	 Tcz4TbaVpHfcHz00go1EFZ2tI4aFzv1JnlxbraZHbaLbWcoI8Ke7IsK7quVG05safR
	 yUZyX2tVW/3vIBS0wv499KIMmXqdIzTP6hwRE3q9/hAW2OQJqM8stMh6IoW/YKst7y
	 W9ixi3JR+sNrq2ff1ZKSO8tLGGEo6alocFRCg0nN7y54RCIOKi/Aauoh56zsFgPBsm
	 MApiu+vzmRMIA==
From: Kees Cook <kees@kernel.org>
To: Vlastimil Babka <vbabka@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Harry Yoo <harry@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hao Li <hao.li@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	linux-mm@kvack.org,
	Pedro Falcato <pfalcato@suse.de>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v6 3/8] mm/slab: Drop the ctor and flags arguments from kmem_buckets_create()
Date: Tue,  6 Oct 2026 02:20:29 -0700
Message-ID: <20261006092035.166776-3-kees@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006092030.got.500-kees@kernel.org>
References: <20261006092030.got.500-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4654; i=kees@kernel.org; h=from:subject; bh=Qc4gibobM/KiTch6bZpTHBpEl8CwkLveGZU5LrXrSHk=; b=owGbwMvMwCVmps19z/KJym7G02pJDFlH9iYsELHlDNGfpXea+WDn85cTcg/fn6H0RD/utP0s4 cm/hF/97ShlYRDjYpAVU2QJsnOPc/F42x7uPlcRZg4rE8gQBi5OAZhIYQ3D//yKmZceL9px6567 3zZVx2uRdr9Vlsb2qvZ+Uoh6c0w4s5qR4fSunydahBQTmgIyfXt12pVa+4NS9DvapY66r7SU+aL OAAA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

A bucket set passes its constructor and slab flags to its own caches,
but its allocations do not always come from them. With
CONFIG_SLAB_BUCKETS=n, kmem_buckets_create() returns ZERO_SIZE_PTR, and
when creating the set fails it returns NULL. Either way
kmem_buckets_alloc() is served by the general kmalloc caches, which have
neither, so a caller cannot depend on them. msg_msg depended on
SLAB_ACCOUNT, which it no longer passes since accounting through
GFP_KERNEL_ACCOUNT instead.

No caller passes a constructor or flags; drop both arguments. The set's
caches keep SLAB_NO_MERGE, which kmem_buckets_create() always added.

Assisted-by: LLM
Signed-off-by: Kees Cook <kees@kernel.org>
---
 include/linux/slab.h |  5 ++---
 ipc/msgutil.c        |  5 ++---
 mm/slab_common.c     | 14 ++++----------
 mm/util.c            |  2 +-
 4 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index cda126def67a..31f97e2579a7 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -890,9 +890,8 @@ void *kmem_cache_alloc_lru_noprof(struct kmem_cache *s, struct list_lru *lru,
 bool kmem_cache_charge(void *objp, gfp_t gfpflags);
 void kmem_cache_free(struct kmem_cache *s, void *objp);
 
-kmem_buckets *kmem_buckets_create(const char *name, slab_flags_t flags,
-				  unsigned int useroffset, unsigned int usersize,
-				  void (*ctor)(void *));
+kmem_buckets *kmem_buckets_create(const char *name, unsigned int useroffset,
+				  unsigned int usersize);
 
 /*
  * Bulk allocation and freeing operations. These are accelerated in an
diff --git a/ipc/msgutil.c b/ipc/msgutil.c
index 1ba8e59cb255..10ce3087b089 100644
--- a/ipc/msgutil.c
+++ b/ipc/msgutil.c
@@ -43,9 +43,8 @@ static kmem_buckets *msg_buckets __ro_after_init;
 
 static int __init init_msg_buckets(void)
 {
-	msg_buckets = kmem_buckets_create("msg_msg", 0,
-					  sizeof(struct msg_msg),
-					  DATALEN_MSG, NULL);
+	msg_buckets = kmem_buckets_create("msg_msg", sizeof(struct msg_msg),
+					  DATALEN_MSG);
 
 	return 0;
 }
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 270408ce5a9d..f8bb70d76eb4 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -415,12 +415,10 @@ static struct kmem_cache *kmem_buckets_cache __ro_after_init;
  *			 allocations via kmem_buckets_alloc()
  * @name: A prefix string which is used in /proc/slabinfo to identify this
  *	  cache. The individual caches with have their sizes as the suffix.
- * @flags: SLAB flags (see kmem_cache_create() for details).
  * @useroffset: Starting offset within an allocation that may be copied
  *		to/from userspace.
  * @usersize: How many bytes, starting at @useroffset, may be copied
  *		to/from userspace.
- * @ctor: A constructor for the objects, run when new allocations are made.
  *
  * Context: Cannot be called within an interrupt, but can be interrupted.
  *
@@ -429,10 +427,8 @@ static struct kmem_cache *kmem_buckets_cache __ro_after_init;
  * subsequent calls to kmem_buckets_alloc() will fall back to kmalloc().
  * (i.e. callers only need to check for NULL on failure.)
  */
-kmem_buckets *kmem_buckets_create(const char *name, slab_flags_t flags,
-				  unsigned int useroffset,
-				  unsigned int usersize,
-				  void (*ctor)(void *))
+kmem_buckets *kmem_buckets_create(const char *name, unsigned int useroffset,
+				  unsigned int usersize)
 {
 	unsigned long mask = 0;
 	unsigned int idx;
@@ -455,8 +451,6 @@ kmem_buckets *kmem_buckets_create(const char *name, slab_flags_t flags,
 	if (WARN_ON(!b))
 		return NULL;
 
-	flags |= SLAB_NO_MERGE;
-
 	for (idx = 0; idx < ARRAY_SIZE(kmalloc_caches[KMALLOC_NORMAL]); idx++) {
 		char *short_size, *cache_name;
 		unsigned int cache_useroffset, cache_usersize;
@@ -487,8 +481,8 @@ kmem_buckets *kmem_buckets_create(const char *name, slab_flags_t flags,
 			if (WARN_ON(!cache_name))
 				goto fail;
 			(*b)[aligned_idx] = kmem_cache_create_usercopy(cache_name, size,
-					0, flags, cache_useroffset,
-					cache_usersize, ctor);
+					0, SLAB_NO_MERGE, cache_useroffset,
+					cache_usersize, NULL);
 			kfree(cache_name);
 			if (WARN_ON(!(*b)[aligned_idx]))
 				goto fail;
diff --git a/mm/util.c b/mm/util.c
index bf0513d1d3d0..0cd125f1ea99 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -199,7 +199,7 @@ static kmem_buckets *user_buckets __ro_after_init;
 
 static int __init init_user_buckets(void)
 {
-	user_buckets = kmem_buckets_create("memdup_user", 0, 0, INT_MAX, NULL);
+	user_buckets = kmem_buckets_create("memdup_user", 0, INT_MAX);
 
 	return 0;
 }
-- 
2.55.0

