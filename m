Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AEC78C91;
	Wed,  2 Apr 2025 21:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743629951; cv=none; b=Jd700IWr4GzrjztplhhdXdX2l20yNgjqrh55nW1GrTEEg719FkCNSIrJOyTsVcL7SVa8ecTpmgUhHqeVY8ZoEc9Ddp53nhcMZfo6h0xchDhfM7rMo/UnGTL6atM17+RiHTWatqhQL8sLU4jlEn464sRkzBsPdVERJD2G8V4SajA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743629951; c=relaxed/simple;
	bh=TSUZ/BtivkLRiKLsU2XCL8Ugofa5D2b//TRkx+fWb90=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QLkVgokIt+4yC+zGVavDIeaUulAB+KVZVgXKi0yZHp43aOrFNYd2Z0WjxZ9IWFdXsKWFlN1TieECixHn2Uurw+UTneAkiB+yLdsTUACFanAeIjQRTswxu59klGA6HCThwuikL2lEgbBrkkva5HYj/QPEPnd1f6Y9aS/Kf93i0u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gd1zNfiK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gd1zNfiK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B5DC4CEEA;
	Wed,  2 Apr 2025 21:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743629950;
	bh=TSUZ/BtivkLRiKLsU2XCL8Ugofa5D2b//TRkx+fWb90=;
	h=Date:From:To:Cc:Subject:From;
	b=Gd1zNfiK12s9/7C+9AiJxdL37Jazmrvm2NVQveKCMeStcTD8bdgZ4g5vPmXFMZfF4
	 FHo9du/fzkGCwZ6RbnqQnnVAVTt+70lJqq33GWG6m8wnNDEJG0w9azwVqpdI0drjyN
	 SX9I/vDWWXiKYFWADa0UgE06UZ6rTQpjCh+6YX3USklPSEWgm+OBqxTdVdy48yA4Rf
	 VmUWYuaI3hNv7gHNaztS5eNgFmjMoxwKmtQV/qrGAnNbI+ja3b4L9wRCf89rBLRD4U
	 MOqD3nKvhtoWRiyUN9WLal56LDporgVl4J9aJyQe6ORkhNHcgcwcZarkc6Qu7g2mr0
	 tR8TzxA8/8sYw==
Date: Wed, 2 Apr 2025 15:39:07 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] drm/nouveau: svm: Avoid -Wflex-array-member-not-at-end
 warning
Message-ID: <Z-2uezeHt1aaHH6x@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Use the `DEFINE_RAW_FLEX()` helper for an on-stack definition of
a flexible structure where the size of the flexible-array member
is known at compile-time, and refactor the rest of the code,
accordingly.

So, with these changes, fix the following warning:

drivers/gpu/drm/nouveau/nouveau_svm.c:724:44: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/gpu/drm/nouveau/nouveau_svm.c | 39 +++++++++++++--------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
index e12e2596ed84..6fa387da0637 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -720,10 +720,7 @@ nouveau_svm_fault(struct work_struct *work)
 	struct nouveau_svm *svm = container_of(buffer, typeof(*svm), buffer[buffer->id]);
 	struct nvif_object *device = &svm->drm->client.device.object;
 	struct nouveau_svmm *svmm;
-	struct {
-		struct nouveau_pfnmap_args i;
-		u64 phys[1];
-	} args;
+	DEFINE_RAW_FLEX(struct nouveau_pfnmap_args, args, p.phys, 1);
 	unsigned long hmm_flags;
 	u64 inst, start, limit;
 	int fi, fn;
@@ -772,11 +769,11 @@ nouveau_svm_fault(struct work_struct *work)
 	mutex_unlock(&svm->mutex);
 
 	/* Process list of faults. */
-	args.i.i.version = 0;
-	args.i.i.type = NVIF_IOCTL_V0_MTHD;
-	args.i.m.version = 0;
-	args.i.m.method = NVIF_VMM_V0_PFNMAP;
-	args.i.p.version = 0;
+	args->i.version = 0;
+	args->i.type = NVIF_IOCTL_V0_MTHD;
+	args->m.version = 0;
+	args->m.method = NVIF_VMM_V0_PFNMAP;
+	args->p.version = 0;
 
 	for (fi = 0; fn = fi + 1, fi < buffer->fault_nr; fi = fn) {
 		struct svm_notifier notifier;
@@ -802,9 +799,9 @@ nouveau_svm_fault(struct work_struct *work)
 		 * fault window, determining required pages and access
 		 * permissions based on pending faults.
 		 */
-		args.i.p.addr = start;
-		args.i.p.page = PAGE_SHIFT;
-		args.i.p.size = PAGE_SIZE;
+		args->p.addr = start;
+		args->p.page = PAGE_SHIFT;
+		args->p.size = PAGE_SIZE;
 		/*
 		 * Determine required permissions based on GPU fault
 		 * access flags.
@@ -832,16 +829,16 @@ nouveau_svm_fault(struct work_struct *work)
 
 		notifier.svmm = svmm;
 		if (atomic)
-			ret = nouveau_atomic_range_fault(svmm, svm->drm,
-							 &args.i, sizeof(args),
+			ret = nouveau_atomic_range_fault(svmm, svm->drm, args,
+							 __struct_size(args),
 							 &notifier);
 		else
-			ret = nouveau_range_fault(svmm, svm->drm, &args.i,
-						  sizeof(args), hmm_flags,
-						  &notifier);
+			ret = nouveau_range_fault(svmm, svm->drm, args,
+						  __struct_size(args),
+						  hmm_flags, &notifier);
 		mmput(mm);
 
-		limit = args.i.p.addr + args.i.p.size;
+		limit = args->p.addr + args->p.size;
 		for (fn = fi; ++fn < buffer->fault_nr; ) {
 			/* It's okay to skip over duplicate addresses from the
 			 * same SVMM as faults are ordered by access type such
@@ -855,14 +852,14 @@ nouveau_svm_fault(struct work_struct *work)
 			if (buffer->fault[fn]->svmm != svmm ||
 			    buffer->fault[fn]->addr >= limit ||
 			    (buffer->fault[fi]->access == FAULT_ACCESS_READ &&
-			     !(args.phys[0] & NVIF_VMM_PFNMAP_V0_V)) ||
+			     !(args->p.phys[0] & NVIF_VMM_PFNMAP_V0_V)) ||
 			    (buffer->fault[fi]->access != FAULT_ACCESS_READ &&
 			     buffer->fault[fi]->access != FAULT_ACCESS_PREFETCH &&
-			     !(args.phys[0] & NVIF_VMM_PFNMAP_V0_W)) ||
+			     !(args->p.phys[0] & NVIF_VMM_PFNMAP_V0_W)) ||
 			    (buffer->fault[fi]->access != FAULT_ACCESS_READ &&
 			     buffer->fault[fi]->access != FAULT_ACCESS_WRITE &&
 			     buffer->fault[fi]->access != FAULT_ACCESS_PREFETCH &&
-			     !(args.phys[0] & NVIF_VMM_PFNMAP_V0_A)))
+			     !(args->p.phys[0] & NVIF_VMM_PFNMAP_V0_A)))
 				break;
 		}
 
-- 
2.43.0

