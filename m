Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04B63F4122;
	Mon, 14 Sep 2026 22:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789425141; cv=none; b=r/KtdkavxFH5tj2BMR2/mRXeHu5mSWCStOeRgzyTUh0DGUfCtDt315CuA0obxO6VSwOM7pFu21Fz+W/5kf7i3W4KdQVmAlj9D6kteWMiGQ4PWY9f2zmIqDfr7dlufIGvhJqFgWgoXXd9f4bZKuNyn7/oJI/2ceHgpGblv++5SOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789425141; c=relaxed/simple;
	bh=cc1KgfUAzVgKTtRm7QSgi2oe8h4u5bnXQnDl9nlpys0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PBg4rZwTFiOpLux5ieASZdV5K/bN6e9W5urll/Oc+F+wG75Tadz+jCmcyGDXJ0Ymt/KDfulywsyt96MMLo4JF2J361Q9w6Rt6W6Eqj+YMxhR8Y7UHTdyo6IT7rUg5bltwa6Taz+0IsLWdlrQB1seoJIt/FM3OxciUl5pIts8E5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GYHbVuIv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GYHbVuIv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D5021F00893;
	Mon, 14 Sep 2026 22:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789425139;
	bh=3GXZPrWtCIjbM7MzBizS35UrFZBS63lQ6m5ygI5gZN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GYHbVuIvpBANoOBSPEKv4Z894y1qDNv39u2mQR4BwX1FRY0/TRyT0RimsmUh4RbPd
	 Lti5s6H+YXVHDVyCidrK4YidWwvUinzMRMRkHg0VIF1uudcW6lght2qsSviRUZn8Zm
	 zBGm8Gosu3tkEeBiYS5+FDJmlrz5JJrz5GUfGq/3bCJdn7QIN4RtOgRCyYM9aTsNW2
	 vdoSnTfRDNBzf/gpS34uNYDDaqtatllMo5EHQPp4Ne6RADmK+BkwDc37RbFJVJU0c/
	 lexiv0GSYMeH0ZT0ABvZl4F1NFN+EAKg0VHiDxu70BqHxJsmB7gwKVz/AqzV94BqKx
	 zhlJEa4SOnnng==
From: Kees Cook <kees@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kees Cook <kees@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: [PATCH 1/2] mm: Move default_gfp() into gfp_types.h
Date: Mon, 14 Sep 2026 15:32:16 -0700
Message-Id: <20260914223219.901347-1-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260914223212.i.829-kees@kernel.org>
References: <20260914223212.i.829-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1894; i=kees@kernel.org; h=from:subject; bh=cc1KgfUAzVgKTtRm7QSgi2oe8h4u5bnXQnDl9nlpys0=; b=owGbwMvMwCVmps19z/KJym7G02pJDFkrSj9Gy66X3ffw3tOPNgwW0a1HC59oy1+taxXUiX//0 ehkgrN2RykLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwERUWhj+xzFGvQyQjN0Y6PAr 8NFkz6PnRFirGGs0/O9OP379teIqNoZ/uj8Pqwp96cn9rV39JO8oY5H9tkDlnKJu9iWZMqem16a zAQA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Using default_gfp() only depends on the GFP_KERNEL value. Move
default_gfp() into gfp_types.h so that future use in devres.h doesn't
require pulling in all of gfp.h.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: "Liam R. Howlett" <liam@infradead.org>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Brendan Jackman <brendan.jackman@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Zi Yan <ziy@nvidia.com>
Cc: <linux-mm@kvack.org>
---
 include/linux/gfp.h       | 4 ----
 include/linux/gfp_types.h | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 872bc53f32ec..b62e2fd53cb4 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -13,10 +13,6 @@
 struct vm_area_struct;
 struct mempolicy;
 
-/* Helper macro to avoid gfp flags if they are the default one */
-#define __default_gfp(a,b,...) b
-#define default_gfp(...) __default_gfp(,##__VA_ARGS__,GFP_KERNEL)
-
 static inline bool gfpflags_allow_blocking(const gfp_t gfp_flags)
 {
 	return !!(gfp_flags & __GFP_DIRECT_RECLAIM);
diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
index 190191411009..b1cd143f3c42 100644
--- a/include/linux/gfp_types.h
+++ b/include/linux/gfp_types.h
@@ -382,4 +382,8 @@ enum {
 			 __GFP_NOMEMALLOC | __GFP_NOWARN) & ~__GFP_RECLAIM)
 #define GFP_TRANSHUGE	(GFP_TRANSHUGE_LIGHT | __GFP_DIRECT_RECLAIM)
 
+/* Helper macro to avoid gfp flags if they are the default one */
+#define __default_gfp(a,b,...) b
+#define default_gfp(...) __default_gfp(,##__VA_ARGS__,GFP_KERNEL)
+
 #endif /* __LINUX_GFP_TYPES_H */
-- 
2.34.1

