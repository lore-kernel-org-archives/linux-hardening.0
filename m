Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2064028E7;
	Fri, 21 Mar 2025 20:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742589669; cv=none; b=pWTOSqO66bxKfldV3BHmbZYNelS0f88Wo+Wvi1BHiYGFr0JhcysgIpQGuc2o4jFBcQCOxykmc6U8GpajKUMCie3d3Ubyzq1jlA2QfNpJIYeKQzINcq1SsJL3VmvaSGcs7v4pn04zSCO1hb7e4F7iDBeZ3HCXlfzQhF2z/ekSMYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742589669; c=relaxed/simple;
	bh=LFQAzM70Y8/4bSi3hs970uFuPutGXlC4X01Ugec4ydw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kPQUh886RHjydFRBFfsxoim+IjWonkMSXsLjL67WzVZVbS3c98692tnyWVEgWHbZolXiAaFQeIDqlqCUdLobfZwU2EOKKH8eN6/cLfwKQeDsgvopEXbUtv8HD9mX9wZz2RMl7pc9ll+dDot8y0EkxLQwwolnEncdJ4tSiBCQ00A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qgCd6kW/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qgCd6kW/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6729C4CEE3;
	Fri, 21 Mar 2025 20:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742589669;
	bh=LFQAzM70Y8/4bSi3hs970uFuPutGXlC4X01Ugec4ydw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qgCd6kW/4cf5U9VoXqzgie8/lOZnRnTBbNsmqaM8c9IgwSMdkh10zu+Gf4/x+4QMz
	 F77o/Q6Xpu/bj0wUyHlY2hb8b6ENvPRFa2xUYnNmS3xYrXxVAsvnxUxvx+QqQ/Cy+H
	 F9IVLpAqbwbjLZB0zrRPOYHj6MDmvqHfZEoc7f+s8w3u6sU7FfcgFOzXHfqc3JOL4e
	 /3vykj1nDJIwjNY8EUKJzXbCSyUeq4FOTEerXoDOQHcK5jrzoRnfXfs0dUb4jq1HUF
	 eg5XsILMLFaClPNQxQ/dWoZdN7XUndWFU+Ejv0mg4IdZ/UoVVixTOnlp2XbDCapAKS
	 /TPIkUpZymQSg==
From: Kees Cook <kees@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Kees Cook <kees@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Marco Elver <elver@google.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 2/5] treewide: Prepare for kfree() to __kfree() rename
Date: Fri, 21 Mar 2025 13:40:58 -0700
Message-Id: <20250321204105.1898507-2-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250321202620.work.175-kees@kernel.org>
References: <20250321202620.work.175-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4240; i=kees@kernel.org; h=from:subject; bh=LFQAzM70Y8/4bSi3hs970uFuPutGXlC4X01Ugec4ydw=; b=owGbwMvMwCVmps19z/KJym7G02pJDOl3z93unF6W+Z710Pvrd5tj3dhqnk3pnaPV9KjkmGxzj XnZ811qHaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABN5s5zhf6q2cNeSL3tOJdg3 tE7/WPyDx4DPcfLRlaFGdhP9S+8dMmNkeBv3dM7qAGEe+c/zVpsduXh00xmxq/ll6cnHcx2dfIw 1uAE=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In preparation for making kfree() a wrapper macro, replace address-taken
instances of kfree with __kfree so the future renaming of kfree to
__kfree will work correctly. (Or to avoid needing to create a union for
a cast.)

This is an example subset needed to build my bootable image. I'm sure
there are more, but they immediately throw build errors when encountered
so they cannot be silently missed.

Signed-off-by: Kees Cook <kees@kernel.org>
---
 arch/mips/alchemy/common/dbdma.c |  2 +-
 include/linux/slab.h             |  2 ++
 io_uring/futex.c                 |  2 +-
 io_uring/io_uring.c              | 12 ++++++------
 kernel/bpf/core.c                |  3 ++-
 5 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/mips/alchemy/common/dbdma.c b/arch/mips/alchemy/common/dbdma.c
index 6a3c890f7bbf..08548e5daead 100644
--- a/arch/mips/alchemy/common/dbdma.c
+++ b/arch/mips/alchemy/common/dbdma.c
@@ -422,7 +422,7 @@ u32 au1xxx_dbdma_ring_alloc(u32 chanid, int entries)
 		 * Lost....do it again, allocate extra, and round
 		 * the address base.
 		 */
-		kfree((const void *)desc_base);
+		__kfree((const void *)desc_base);
 		i = entries * sizeof(au1x_ddma_desc_t);
 		i += (sizeof(au1x_ddma_desc_t) - 1);
 		desc_base = (u32)kmalloc(i, GFP_KERNEL|GFP_DMA);
diff --git a/include/linux/slab.h b/include/linux/slab.h
index 09eedaecf120..3e807ccc8583 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -469,6 +469,8 @@ void kfree(const void *objp);
 void kfree_sensitive(const void *objp);
 size_t __ksize(const void *objp);
 
+#define __kfree(x)	kfree(x)
+
 DEFINE_FREE(kfree, void *, if (!IS_ERR_OR_NULL(_T)) kfree(_T))
 DEFINE_FREE(kfree_sensitive, void *, if (_T) kfree_sensitive(_T))
 
diff --git a/io_uring/futex.c b/io_uring/futex.c
index 43e2143255f5..e46a019fbd08 100644
--- a/io_uring/futex.c
+++ b/io_uring/futex.c
@@ -41,7 +41,7 @@ bool io_futex_cache_init(struct io_ring_ctx *ctx)
 
 void io_futex_cache_free(struct io_ring_ctx *ctx)
 {
-	io_alloc_cache_free(&ctx->futex_cache, kfree);
+	io_alloc_cache_free(&ctx->futex_cache, __kfree);
 }
 
 static void __io_futex_complete(struct io_kiocb *req, struct io_tw_state *ts)
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index ceacf6230e34..0a41a3a981b1 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -360,11 +360,11 @@ static __cold struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
 free_ref:
 	percpu_ref_exit(&ctx->refs);
 err:
-	io_alloc_cache_free(&ctx->apoll_cache, kfree);
+	io_alloc_cache_free(&ctx->apoll_cache, __kfree);
 	io_alloc_cache_free(&ctx->netmsg_cache, io_netmsg_cache_free);
 	io_alloc_cache_free(&ctx->rw_cache, io_rw_cache_free);
-	io_alloc_cache_free(&ctx->uring_cache, kfree);
-	io_alloc_cache_free(&ctx->msg_cache, kfree);
+	io_alloc_cache_free(&ctx->uring_cache, __kfree);
+	io_alloc_cache_free(&ctx->msg_cache, __kfree);
 	io_futex_cache_free(ctx);
 	kvfree(ctx->cancel_table.hbs);
 	xa_destroy(&ctx->io_bl_xa);
@@ -2702,11 +2702,11 @@ static __cold void io_ring_ctx_free(struct io_ring_ctx *ctx)
 	io_sqe_files_unregister(ctx);
 	io_cqring_overflow_kill(ctx);
 	io_eventfd_unregister(ctx);
-	io_alloc_cache_free(&ctx->apoll_cache, kfree);
+	io_alloc_cache_free(&ctx->apoll_cache, __kfree);
 	io_alloc_cache_free(&ctx->netmsg_cache, io_netmsg_cache_free);
 	io_alloc_cache_free(&ctx->rw_cache, io_rw_cache_free);
-	io_alloc_cache_free(&ctx->uring_cache, kfree);
-	io_alloc_cache_free(&ctx->msg_cache, kfree);
+	io_alloc_cache_free(&ctx->uring_cache, __kfree);
+	io_alloc_cache_free(&ctx->msg_cache, __kfree);
 	io_futex_cache_free(ctx);
 	io_destroy_buffers(ctx);
 	io_free_region(ctx, &ctx->param_region);
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index da729cbbaeb9..9d2721d24c40 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -280,7 +280,8 @@ void __bpf_prog_free(struct bpf_prog *fp)
 		mutex_destroy(&fp->aux->used_maps_mutex);
 		mutex_destroy(&fp->aux->dst_mutex);
 		kfree(fp->aux->poke_tab);
-		kfree(fp->aux);
+		/* "fp" may be in read-only memory */
+		__kfree(fp->aux);
 	}
 	free_percpu(fp->stats);
 	free_percpu(fp->active);
-- 
2.34.1

