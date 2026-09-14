Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66773F6610;
	Mon, 14 Sep 2026 22:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789425142; cv=none; b=sNzS/M0s8SzkM+H7V2QzyWTsIxSU8AQlQSABugFlCWaQ2gOwhv+7yUcgvx1wdB410Jt6+JspeJvw+vKTDYUiXJnh61GqZyomLljuKkpg3gx8Jx4hj9Gb1P4x/i5+6z7//g9W4gXk43hVySM2vbO6q8upwilaiwcXxNYc5ap4yeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789425142; c=relaxed/simple;
	bh=bLnfQpX9WteOicTADYo7gVjLmdCzHpRn4PMQO2GTuCM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FbVfocRli5YnjYvNPpqpDXi3XY5qS34H/uhH3vlQJrsOtrO5N4EIiPexW/1o9aHj2bhoicIuFE8QMpaWVepQ5ftSUlFItfQI1H+9RCqQqqLbrjzo/H/q/xIW5QZCyJg0/CdRYmgR7mYTgMjkxhWhtGg+LB0SxuXYFjZVRrAJ+co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nRlV+Ypv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nRlV+Ypv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 726D81F00898;
	Mon, 14 Sep 2026 22:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789425139;
	bh=Ps1Pf9HY55XJc6hUxZI1FWG+aZ4DlvyxQbmpujBPK50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nRlV+YpvxHQVtVRWHIbygpj+OZVvjJfHQQnKrKTOJhBpvRhGTy4ZjBujWyve0WKGA
	 w435enXlS2HHNW1DJmrDvB02MD6uRMC6FSFxadfIWa4zRR51XZvQaQIMcvWDnDANdK
	 t6MJ+Lyt4Agr05qu9eBxp3Rnm5l6crb30IfsRXAQZzW6+6Lkipmre5C0QlWeXisZfk
	 8GjeaR5kxEVJ3pl+ciP2lL9/G5ZTVB3ItA5KJXcFFls+TjRVi0i9raU19+EJQaJ8va
	 4j2eI+QyO/ZBjqiE7S4f+jixrGcNW+DqjWKSXbZULTLTyuTiEciTjWbik/faUHtNBt
	 juvas0SA0gB0g==
From: Kees Cook <kees@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kees Cook <kees@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	driver-core@lists.linux.dev,
	linux-hardening@vger.kernel.org,
	Lorenzo Stoakes <ljs@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	David Hildenbrand <david@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/2] devres: Provide kmalloc_obj*-style API for devm_kmalloc
Date: Mon, 14 Sep 2026 15:32:17 -0700
Message-Id: <20260914223219.901347-2-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260914223212.i.829-kees@kernel.org>
References: <20260914223212.i.829-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5602; i=kees@kernel.org; h=from:subject; bh=bLnfQpX9WteOicTADYo7gVjLmdCzHpRn4PMQO2GTuCM=; b=owGbwMvMwCVmps19z/KJym7G02pJDFkrSj8WbJVbIJ/P8uXHLbbr6tu0z805uPEx7//mnV9eT GtRNGZ72FHKwiDGxSArpsgSZOce5+Lxtj3cfa4izBxWJpAhDFycAjCRpTMZGZ7Vnl9ktbGh5Md7 u7/cSyXbtJLZ7+UYRtnb/53SLrJg6QSG/8XWj8wN7068lWp5hqnkg7LBmYTp7plVikKWzI0Vkz/ asgMA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Mirroring the type-based allocation now in use for the kmalloc family of
APIs, provide the same for the devm_kmalloc family of APIs. This will
allow for future plumbing of type information (e.g. alignment) into the
underlying allocations. This immediately gains type check on return
values (instead of the prior "void *" return type).

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: <driver-core@lists.linux.dev>
Cc: <linux-hardening@vger.kernel.org>
---
 include/linux/device/devres.h | 102 ++++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/include/linux/device/devres.h b/include/linux/device/devres.h
index 14ab9159bdda..7656c9ecd4da 100644
--- a/include/linux/device/devres.h
+++ b/include/linux/device/devres.h
@@ -62,6 +62,108 @@ static inline void *devm_kcalloc(struct device *dev, size_t n, size_t size, gfp_
 {
 	return devm_kmalloc_array(dev, n, size, flags | __GFP_ZERO);
 }
+
+/**
+ * __devm_alloc_objs - Device-managed allocation of objects of a given type
+ * @DEVM_ALLOC: which device-managed size-based allocator to use.
+ * @DEV: device to scope the allocation lifetime to.
+ * @GFP: GFP flags for the allocation.
+ * @TYPE: type to allocate space for.
+ * @COUNT: how many @TYPE objects to allocate.
+ *
+ * Device-managed counterpart of __alloc_objs().
+ * @DEVM_ALLOC takes (@DEV, size, gfp).
+ *
+ * Returns: Newly allocated pointer to (first) @TYPE of @COUNT-many allocated
+ * @TYPE objects, or NULL on failure.
+ */
+#define __devm_alloc_objs(DEVM_ALLOC, DEV, GFP, TYPE, COUNT)		\
+({									\
+	const size_t __obj_size = size_mul(sizeof(TYPE), COUNT);	\
+	(TYPE *)DEVM_ALLOC(DEV, __obj_size, GFP);			\
+})
+
+/**
+ * devm_kmalloc_obj - Device-managed allocation of a single typed object
+ * @DEV: Device to scope the allocation lifetime to.
+ * @VAR_OR_TYPE: Variable or type to allocate.
+ * @GFP: Optional GFP flags (defaults to %GFP_KERNEL).
+ *
+ * Device-managed counterpart of kmalloc_obj(): the allocation is sized from
+ * @VAR_OR_TYPE and returned as a pointer to that type, not void *.
+ *
+ * Returns: newly allocated pointer to a @VAR_OR_TYPE on success, or NULL on
+ * failure.
+ */
+#define devm_kmalloc_obj(DEV, VAR_OR_TYPE, ...)				\
+	__devm_alloc_objs(devm_kmalloc, DEV, default_gfp(__VA_ARGS__),	\
+			  typeof(VAR_OR_TYPE), 1)
+
+/**
+ * devm_kmalloc_objs - Device-managed allocation of an array of a typed object
+ * @DEV: Device to scope the allocation lifetime to.
+ * @VAR_OR_TYPE: Variable or type to allocate an array of.
+ * @COUNT: How many elements in the array.
+ * @GFP: Optional GFP flags (defaults to %GFP_KERNEL).
+ *
+ * Returns: newly allocated pointer to an array of @VAR_OR_TYPE on success, or
+ * NULL on failure (including when the total size overflows).
+ */
+#define devm_kmalloc_objs(DEV, VAR_OR_TYPE, COUNT, ...) \
+	__devm_alloc_objs(devm_kmalloc, DEV, default_gfp(__VA_ARGS__), \
+			  typeof(VAR_OR_TYPE), COUNT)
+
+/**
+ * __devm_alloc_flex - Device-managed allocation of a trailing-flex-array object
+ * @DEVM_ALLOC: which device-managed allocator to use.
+ * @DEV: device to scope the allocation lifetime to.
+ * @GFP: GFP flags for the allocation.
+ * @TYPE: type of structure to allocate space for.
+ * @FAM: name of the flexible array member of @TYPE.
+ * @COUNT: how many @FAM elements to allocate space for.
+ *
+ * Device-managed counterpart of __alloc_flex().
+ * @DEVM_ALLOC takes (@DEV, size, gfp).
+ *
+ * Returns: Newly allocated pointer to @TYPE with @COUNT-many trailing @FAM
+ * elements, or NULL on failure.
+ */
+#define __devm_alloc_flex(DEVM_ALLOC, DEV, GFP, TYPE, FAM, COUNT)	\
+({									\
+	const size_t __count = (COUNT);					\
+	const size_t __obj_size = struct_size_t(TYPE, FAM, __count);	\
+	TYPE *__obj_ptr = DEVM_ALLOC(DEV, __obj_size, GFP);		\
+	if (__obj_ptr)							\
+		__set_flex_counter(__obj_ptr->FAM, __count);		\
+	__obj_ptr;							\
+})
+
+/**
+ * devm_kmalloc_flex - Device-managed allocation of a flexible-array structure
+ * @DEV: Device to scope the allocation lifetime to.
+ * @VAR_OR_TYPE: Variable or type to allocate (with its flexible array).
+ * @FAM: The name of the flexible array member of the structure.
+ * @COUNT: How many flexible array member elements to allocate.
+ * @GFP: Optional GFP flags (defaults to %GFP_KERNEL).
+ *
+ * Returns: newly allocated pointer to @VAR_OR_TYPE on success, or NULL on
+ * failure. If @FAM has been annotated with __counted_by(), its counter is set
+ * to @COUNT.
+ */
+#define devm_kmalloc_flex(DEV, VAR_OR_TYPE, FAM, COUNT, ...) \
+	__devm_alloc_flex(devm_kmalloc, DEV, default_gfp(__VA_ARGS__), \
+			  typeof(VAR_OR_TYPE), FAM, COUNT)
+
+/* All devm_kzalloc aliases for devm_kmalloc_(obj|objs|flex). */
+#define devm_kzalloc_obj(DEV, P, ...) \
+	__devm_alloc_objs(devm_kzalloc, DEV, default_gfp(__VA_ARGS__), typeof(P), 1)
+#define devm_kzalloc_objs(DEV, P, COUNT, ...) \
+	__devm_alloc_objs(devm_kzalloc, DEV, default_gfp(__VA_ARGS__), \
+			  typeof(P), COUNT)
+#define devm_kzalloc_flex(DEV, P, FAM, COUNT, ...) \
+	__devm_alloc_flex(devm_kzalloc, DEV, default_gfp(__VA_ARGS__), \
+			  typeof(P), FAM, COUNT)
+
 static inline __realloc_size(3, 4) void * __must_check
 devm_krealloc_array(struct device *dev, void *p, size_t new_n, size_t new_size, gfp_t flags)
 {
-- 
2.34.1

