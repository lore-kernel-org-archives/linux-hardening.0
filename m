Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFC43D1CAD;
	Fri, 20 Mar 2026 17:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774029080; cv=none; b=pHcDksGwxYCIzKYMpphM9GH5P2gQWg33h2oeQKJUVEaZyIqiJPN8JZaJfCYm06MAHNhOJv33Wq8HjGE/KvCVlXXI0HtJ+frZqG9xosxc2qWyat+s7uQ4LRSWOhwjSvWwN4CEmtRgKrPh0+AOX2ZcCao1+wllXYISmgO6PzDkMb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774029080; c=relaxed/simple;
	bh=5zBHZBiRQnxI63nFpcUxKUAqSHpyESQ+S3fdO2jglgU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HI9RASO1FVOg/prGU7ishPRyuw4Cf8nwmNd3Zj3+kjLuIDgsn2bWK2aEbmIWyjRxDqi+sxtikAO7eZcw+TmmYSgMJbaocKx3jDOkUS2O41YU5yxALKPvCuSU1hIOTIjbyb46InhXsGsB7FsmBOPk0t6h1spmMhTKB+a73ybHtAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=twDK+uz9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="twDK+uz9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8568AC4CEF7;
	Fri, 20 Mar 2026 17:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774029079;
	bh=5zBHZBiRQnxI63nFpcUxKUAqSHpyESQ+S3fdO2jglgU=;
	h=From:To:Cc:Subject:Date:From;
	b=twDK+uz9rKvmsAMW9HdKITQjmjPRJSQTvm4E5aIp7MR18F3xeSHzzBbLRh/HhnhnJ
	 Piitn6JhoSNIxl2SSqQoD2LkLHUQg6Wk0nQf0mBwD72kZvEcRV26h84mIpXvOEjZxT
	 Lx7hvnyffOp1WU4+3kIYLwcLNJ1Ucx0AjqHYosCL/BN5v9A27U0UITOQo7FsHDdtga
	 MRp3l0+T465wakVza87OW5m4P9skBGhDNyESNFi4PmMx33/QQ9/VbNs7F5nBEgAV/U
	 ngQ3cVJPQFvKFVoPpUdZK5Y494/jUFwDgfysaGeDnchyoYKjxOlhYz/1yC7Ni5ksz8
	 BozhIJDW0hLCA==
From: Kees Cook <kees@kernel.org>
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: Kees Cook <kees@kernel.org>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	cocci@inria.fr,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] coccinelle: kmalloc_obj: Remove default GFP_KERNEL arg
Date: Fri, 20 Mar 2026 10:51:18 -0700
Message-Id: <20260320175113.work.016-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1253; i=kees@kernel.org; h=from:subject:message-id; bh=5zBHZBiRQnxI63nFpcUxKUAqSHpyESQ+S3fdO2jglgU=; b=owGbwMvMwCVmps19z/KJym7G02pJDJl7O0VnVyr17zb+ni6ta+Cw/PnHTseFs1nvH+QpnFnv0 8+83/51RykLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwET2z2H4wxNdcGBfowfv9fUB k379aGqfdeLxj3rF0scPT87btbQwKJvhn0FV9clPH4Jl3/h9TYvcp9s87UHUJd76p6smuwSt38L 9kxcA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Remove any GFP_KERNEL arguments found in the new kmalloc_obj-family
helpers. This captures the script used in commit 189f164e573e ("Convert
remaining multi-line kmalloc_obj/flex GFP_KERNEL uses").

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Julia Lawall <Julia.Lawall@inria.fr>
Cc: Nicolas Palix <nicolas.palix@imag.fr>
Cc: <cocci@inria.fr>
---
 scripts/coccinelle/api/kmalloc_objs.cocci | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/scripts/coccinelle/api/kmalloc_objs.cocci b/scripts/coccinelle/api/kmalloc_objs.cocci
index db12b7be7247..e9a415b7b6f4 100644
--- a/scripts/coccinelle/api/kmalloc_objs.cocci
+++ b/scripts/coccinelle/api/kmalloc_objs.cocci
@@ -122,3 +122,14 @@ fresh identifier ALLOC_OBJS = script:python(ALLOC_ARRAY) { alloc_array(ALLOC_ARR
 -	ALLOC(struct_size_t(TYPE, FLEX, COUNT), GFP)
 +	ALLOC_FLEX(TYPE, FLEX, COUNT, GFP)
 )
+
+@drop_gfp_kernel depends on patch && !(file in "tools") && !(file in "samples")@
+identifier ALLOC = {kmalloc_obj,kmalloc_objs,kmalloc_flex,
+		    kzalloc_obj,kzalloc_objs,kzalloc_flex,
+		    kvmalloc_obj,kvmalloc_objs,kvmalloc_flex,
+		    kvzalloc_obj,kvzalloc_objs,kvzalloc_flex};
+@@
+
+	ALLOC(...
+-		 , GFP_KERNEL
+	     )
-- 
2.34.1

