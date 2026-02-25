Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544B424A05D;
	Wed, 25 Feb 2026 01:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983604; cv=none; b=D5s3y1FiAdAlfOuELly2zRT4vQk0BxfJ7Mky87jLr3l8If0bSZCM2reZ6XUTj34eOvYmPqirOou7OoCrd1l02FYwNWAbUNWdKI2/nt8gKvH/beba2RoR+/Z3Ytoj++G+511HT6UCpb4/Dcbcxwb0uyM9MdmiLI2volN+dSl2HgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983604; c=relaxed/simple;
	bh=/vhqQFuGoe48JWJKQbmTtsW8NfhyeO+Zgc9RwDLnpHU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=myBPwADSmSB2HsQTX0/7Y2my1PoCfMvBlaLU4KAP5Z9mrWq2n9dkp13o305PUAOZ/POHFqBh9qMfW3F9yEUZ16R6TMR/mAb5O6AAGe/VWCcQnv8VBiyD6CeSZyytQltpbLo9Qz+8VEAWY0mgT2M4+N5fICnmeGIa1nGefDwhYLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r+Vj8Idc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r+Vj8Idc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15146C116D0;
	Wed, 25 Feb 2026 01:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771983604;
	bh=/vhqQFuGoe48JWJKQbmTtsW8NfhyeO+Zgc9RwDLnpHU=;
	h=From:To:Cc:Subject:Date:From;
	b=r+Vj8IdcOLhJtUtOQzh254rqvzA3uB/Iye7mW2zJnKE1QoXEBJZwneCUmDAMQSl63
	 7mHUl0l92fNWBWeeNR/ikW1O6FbCag2yrnh5OAlaQatcoNr3zfCK1v1vsWF0FKqA9e
	 8dW4DoHYKeMyLD6z93jef3FZco/su92gf6Nicx2RFJvCeucfO27dUq1CzyC7hS+iqk
	 EcdGcm2ALXOgaR4cdZ2/e2wMfGzFymM6111pCjwIosZnBu03Db/elcQmwAvLrq13b6
	 mWFkahThS0zCNqtezFIpfYCWQwbEcOoK5zKXviU67EWgtWFgfGtWx5itFIN2XzA6KP
	 VHPAXFFU5J6ww==
From: Kees Cook <kees@kernel.org>
To: Vlastimil Babka <vbabka@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] slab: Saturate to SIZE_MAX for allocation size overflows
Date: Tue, 24 Feb 2026 17:40:02 -0800
Message-Id: <20260225013954.work.319-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2209; i=kees@kernel.org; h=from:subject:message-id; bh=/vhqQFuGoe48JWJKQbmTtsW8NfhyeO+Zgc9RwDLnpHU=; b=owGbwMvMwCVmps19z/KJym7G02pJDJnzgj7G3faYZqv3iPHMylti0ey+N15vWpz6ovTHke3+h 5tZrvot6yhlYRDjYpAVU2QJsnOPc/F42x7uPlcRZg4rE8gQBi5OAZjI88+MDCunsujwCF3b7cWt PPPyMd6Dt4vilMQ8YxcqG4Ss/sta2sLwh2+H4YHUnGcW0Q+fx/zYL1XXriwetf+/ZkvAoY4MVi5 jBgA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Instead of silently returning NULL on size overflows from array
allocations, saturate the request to SIZE_MAX so the error will be
surfaced to the allocator (and still return NULL).

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Link: https://lore.kernel.org/lkml/a144cd1e-8bfc-4380-8f1b-071db0af0b2c@suse.cz/
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Lameter <cl@gentwo.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Harry Yoo <harry.yoo@oracle.com>
Cc: <linux-mm@kvack.org>
---
 include/linux/slab.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index a5a5e4108ae5..8453c81c75c3 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -1105,7 +1105,7 @@ static inline __alloc_size(1, 2) void *kmalloc_array_noprof(size_t n, size_t siz
 	size_t bytes;
 
 	if (unlikely(check_mul_overflow(n, size, &bytes)))
-		return NULL;
+		bytes = SIZE_MAX;
 	return kmalloc_noprof(bytes, flags);
 }
 #define kmalloc_array(...)			alloc_hooks(kmalloc_array_noprof(__VA_ARGS__))
@@ -1135,7 +1135,7 @@ static inline __realloc_size(2, 3) void * __must_check krealloc_array_noprof(voi
 	size_t bytes;
 
 	if (unlikely(check_mul_overflow(new_n, new_size, &bytes)))
-		return NULL;
+		bytes = SIZE_MAX;
 
 	return krealloc_noprof(p, bytes, flags);
 }
@@ -1175,7 +1175,7 @@ static inline __alloc_size(1, 2) void *kmalloc_array_node_noprof(size_t n, size_
 	size_t bytes;
 
 	if (unlikely(check_mul_overflow(n, size, &bytes)))
-		return NULL;
+		bytes = SIZE_MAX;
 	if (__builtin_constant_p(n) && __builtin_constant_p(size))
 		return kmalloc_node_noprof(bytes, flags, node);
 	return __kmalloc_node_noprof(PASS_BUCKET_PARAMS(bytes, NULL), flags, node);
@@ -1223,7 +1223,7 @@ kvmalloc_array_node_noprof(size_t n, size_t size, gfp_t flags, int node)
 	size_t bytes;
 
 	if (unlikely(check_mul_overflow(n, size, &bytes)))
-		return NULL;
+		bytes = SIZE_MAX;
 
 	return kvmalloc_node_align_noprof(bytes, 1, flags, node);
 }
-- 
2.34.1

