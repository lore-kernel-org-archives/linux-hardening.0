Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAF844C65C;
	Mon, 21 Sep 2026 07:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789977504; cv=none; b=I9C+GQPOWrVdXXZs2C1mLKxozYGPPJtneHJ8W4pcOt+SYlxzkvB0UPYZfi60n6KEgqkvRNHJbghup+uzTIFzjhEN0uSdsAXGaao+MugATFeWdvc8mA4yLu6cVcTJdTgsNlJWN2LJ57dHFCEzBB8ovFZ2Wx4cY8/V27DXuupNvVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789977504; c=relaxed/simple;
	bh=yoNf68AxG5w4U/BVM+cYoBMu5dGzeo9HzcEeFRFwN4A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Uffrb0DQbpmDiU6h1ofz1dOIGtBE8qqvhvi9Zv9ToksSAQR00mB0CazrPYL2scFOM2EuUuqscJSnV5HlMKBhogPKsA62dvAS7chpzJ3Yj7sh/mzGS0TAx8HJVt2Kh/bxO1kZCwArtyllUX9RxMO49e8em8EOckccEzY5/J7zmn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ouHcHhEn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ouHcHhEn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76CCD1F00899;
	Mon, 21 Sep 2026 07:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789977500;
	bh=pXEMn8PYoauzMFPqYoyRVQk4fKHRKQ7Pm/+2eUzLBwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ouHcHhEn3pF1QVHo3Sbazx3hPddkjUOD89SP/L9S0cHcaBKN2+A2Rc4sof5g++TcQ
	 xtgz9khnxu5eYU8LtTPSz1IosPFoOjs+erMVMkRaMkgks9irTWcn9stk6CP7gumuCk
	 DJMrd6hgPkrecnH+TQc4md2wYTvbjgzAjf/msUVgslIx30KHvAaMgb0nL1T3yxYO+9
	 rhYDqZVAMMXUB6bvKscdjGIkzXR4ua6fInw4hqN+PihF+6ynX/64IwcuwerJAFXS8W
	 3B8xV+zqDVo9H+bPTMTAp1EoUJe21NyRn8mrY5coc0C6iWF7Bnn/8P941Pr9nTLZpF
	 isN880f4ZFbIQ==
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
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jason Xing <kerneljasonxing@gmail.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Willem de Bruijn <willemb@google.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v4 1/7] mm/slab: Mark the kmem_buckets_create() context as a Context: section
Date: Mon, 21 Sep 2026 00:58:12 -0700
Message-Id: <20260921075820.1718334-1-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260921075811.too.775-kees@kernel.org>
References: <20260921075811.too.775-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2066; i=kees@kernel.org; h=from:subject; bh=yoNf68AxG5w4U/BVM+cYoBMu5dGzeo9HzcEeFRFwN4A=; b=owGbwMvMwCVmps19z/KJym7G02pJDFkbHs+w2O1WFJVu0y0uMin1v8cLsWNM4fPnBuyPdni3Q 2Jp/+v1HaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABNJ0GX4H3HjgaPAG2lOySjz D/KnFzll2SyvEQpcP3l65wyFVUsSJBgZ7mxoXb/3/x2WcLHVPIdkHWcafppsOI3vgHNYcW38MU5 /FgA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

kmem_buckets_create() had the same sentence about calling context as
kmem_cache_create(), but lacked the "Context:" prefix, so kernel-doc
rendered in the body instead of as a "context" section.

Give it the missing prefix. Additionally fix the "a interrupt" typo
__kmem_cache_create_args() had.

Fixes: b32801d1255be ("mm/slab: Introduce kmem_buckets_create() and family")
Assisted-by: LLM
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Harry Yoo <harry@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Hao Li <hao.li@linux.dev>
Cc: Christoph Lameter <cl@gentwo.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: <linux-mm@kvack.org>
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: Kuniyuki Iwashima <kuniyu@google.com>
Cc: <linux-hardening@vger.kernel.org>
---
 mm/slab_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index b19ba1b31484..270408ce5a9d 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -311,7 +311,7 @@ __kmem_cache_alias(const char *name, unsigned int size, slab_flags_t flags,
  * &SLAB_TYPESAFE_BY_RCU - Slab page (not individual objects) freeing delayed
  * by a grace period - see the full description before using.
  *
- * Context: Cannot be called within a interrupt, but can be interrupted.
+ * Context: Cannot be called within an interrupt, but can be interrupted.
  *
  * Return: a pointer to the cache on success, NULL on failure.
  */
@@ -422,7 +422,7 @@ static struct kmem_cache *kmem_buckets_cache __ro_after_init;
  *		to/from userspace.
  * @ctor: A constructor for the objects, run when new allocations are made.
  *
- * Cannot be called within an interrupt, but can be interrupted.
+ * Context: Cannot be called within an interrupt, but can be interrupted.
  *
  * Return: a pointer to the cache on success, NULL on failure. When
  * CONFIG_SLAB_BUCKETS is not enabled, ZERO_SIZE_PTR is returned, and
-- 
2.34.1

