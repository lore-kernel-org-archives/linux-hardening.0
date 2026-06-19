Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B638532470A
	for <linux-hardening@vger.kernel.org>; Fri, 19 Jun 2026 06:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781852239; cv=none; b=Gyuz3r2h052D5dmefvINJrxC1VPIlwuwBc3O8ntmhq39sw+9FYEInkC4dvomaX7VOuQJ9xUQfSw+9Gd2e5Rr8zCsxkKIuvGX0FFXMxtFJIHQuHDOJq9Vvj2MH+buV/L033K11jdgzqbyFFD+EYYciJ+CQ8r05ZjmkzCgnwgNW1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781852239; c=relaxed/simple;
	bh=QhZq1bmj8TZarO+dOZgnmUMT4cdjoowsIkZsx59yZ5k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=seRQja4pdw+6/MusVa77rULYWBeFx3AdNDYYswCLQiW7t4DfLzSFKdjrcLl+GWKbHpZiv3HKkKNFvMBBb+EGkJWbEg7HGwDMyfXQf3ti1Cwjuss18GIwMF+/Dl1OCjRHdsuzs9FxMCDa6rCTgj3pI/5+uwKLwvkpgkWVPPgohVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Is5rWY+f; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Is5rWY+f"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c68190ade4so21486215ad.0
        for <linux-hardening@vger.kernel.org>; Thu, 18 Jun 2026 23:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781852237; x=1782457037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PQSCwdnu8XDe9M7EjSg+qYWUorf1yt+gzbjybBX7cw4=;
        b=Is5rWY+fUPdf7UYi5YG6FVzB8aPMxMVlCO4pyiUbXWCtyFUsvuuDhyQrRn386lmuli
         avtM018UZKum+QM35tqCU0eLqoOPSUaEN+HQoAmcykrEGb8TSu43aRFI8+0d+Bmk/2Z9
         Sz/0Rp1VV8+kl0ZLlWankJ6zeNRH2a+Ft1AL5+9M08tgbUaUQ6EQPBylIXEkmGCJXQBH
         BSHmWqWbvoA2hi1OZGU6Un7MCTOOZyvvIw4J2675J+S1Wq69gPqPhgBurHrUCZfiMg26
         dRprP7t4PiIe26n98MUuHLaMHq/6inQb9lkELTZhEYwLNRnBfZ7u4ks/l3/fwXraqjRL
         nAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781852237; x=1782457037;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQSCwdnu8XDe9M7EjSg+qYWUorf1yt+gzbjybBX7cw4=;
        b=bcI2+VldX46dW1Q8YoWSROhnUF3QcO5kpRIlZPaPO5w5xemhso+ScxoTvI1rkTREty
         8xzsQx5GMGY94Z6RfJVrTEabKfdS6/g8WYE+aZa+xsTrSZLbix7pKCm6OLF0hcgkSzad
         E+XuKi69Jy2e5oj5JnV65eye+PFF5ij0cILLDxnu5CJrMZkD2M+91llKdjg7dyzbY2M6
         MxtY5CJHUyMAW1N4f/16qgg6V4sXKoTA2V+qYd9w4pTRsz6lGEJk8P4S2KKLtsYL7Q9D
         KNVnweduBGsy413dlFCw1VyhPbgSmoA2ta6ve3GjdhDQRDV3ryR0GlhtkeQYMTbGrAjJ
         DGKA==
X-Forwarded-Encrypted: i=1; AFNElJ9fzzZdDC8rkF+POpqIP8XEEhuk9yGpQIisVsLmsRke7LArXhxWozAoXIvffFIAho+7hxGggjXuowrVlWOWKyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVBYDZCOtVTf/doEg6yFrLamTNohzncguc1qezJpYszfEVqRvz
	ozQyWzdvHyLunywdok9Ri3I/fnh5OnH+s3rIaS3CTXw4eqVCCv8Ttgpt
X-Gm-Gg: AfdE7clRfwnrUHT0ger8dTWWoEVnavuC8Rkb4GoYnyyS76QiXkgp3IFD8dpQ7Z7zSXH
	YmeVvpMbC28+/r3/SsC8egPmqqVg6Rrm8THm0sIjFMFz4DbrWTQxRRp7RSz0Q54HXJzGaaSMKz2
	VgEp/SoDfJjqbetFOFbPh7J+dtohNNc4DREcadr3Sru37q3fRyt+rEriFsAwl87zQSLbJK9IYFY
	51Y4MgrXhDU/tZNCm3Y3hyrf2i1cBFNBIiiqzT8KUPDlAAkmb2W3tD6gKjZ4IfbB2oZyAGfTCUm
	hP5KjkMHYAA7WHUz+jEbuyrSv5Wo5z2gkPMfDujbL8ADFECny4manwl4xgiO/dbRR+jQw4sQlCz
	wX/yJz3IWzpY7fydY6ZsnlaIP/bcor2sqk17+07MrLmw+z4Ht2dKnxLezsw4MGpUIVhNnPDYEQu
	fxpVFGy2gub15Z2ftD6xCX8miQ148848UolJknOG6kSd7KYw==
X-Received: by 2002:a17:902:f689:b0:2ba:6601:8e3d with SMTP id d9443c01a7336-2c71952b30fmr20040255ad.9.1781852237066;
        Thu, 18 Jun 2026 23:57:17 -0700 (PDT)
Received: from Athena ([58.146.97.175])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7209dc406sm12662955ad.55.2026.06.18.23.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 23:57:16 -0700 (PDT)
From: harshal24-chavan <harshal24.chavan@gmail.com>
To: io-uring@vger.kernel.org,
	axboe@kernel.dk
Cc: krisman@kernel.org,
	kees@kernel.org,
	gustavoars@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	harshal24-chavan <harshal24.chavan@gmail.com>
Subject: [PATCH v3] io_uring/register: add IORING_REGISTER_CLONE_FILES opcode
Date: Fri, 19 Jun 2026 12:27:00 +0530
Message-ID: <20260619065700.12465-1-harshal24.chavan@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, if an application wants to duplicate registered file
descriptors from one io_uring instance to another, it must manually
unregister and re-register them, incurring unnecessary overhead.

Add IORING_REGISTER_CLONE_FILES to allow direct cloning of the file
table from a source ring to a destination ring. This implementation
strictly mirrors the io_clone_buffers UAPI, supporting partial offsets
and the IORING_REGISTER_DST_REPLACE flag.

To ensure lock synchronization safety, destination nodes are strictly
allocated as new, private io_rsrc_nodes rather than sharing references
across rings.

---
v3:
  - Rewrote the cloning loop to allocate private destination nodes via io_rsrc_node_alloc to fix non-atomic ref lock synchronization (Jens).
  - Maintained partial offset/copy support to mirror io_clone_buffers UAPI (Jens).
  - Gated the replacement free check on ctx->file_table.data.nr (Gabriel).
  - Prevented self-cloning by checking ctx == src_ctx (Gabriel).
  - Removed submitter_task check to allow cross-thread pooling setups (Gabriel).
v2: Dropped unrelated whitespace formatting changes from v1

Signed-off-by: harshal24-chavan <harshal24.chavan@gmail.com>
---
 include/uapi/linux/io_uring.h |  12 +++
 io_uring/register.c           |   6 ++
 io_uring/rsrc.c               | 149 ++++++++++++++++++++++++++++++++++
 io_uring/rsrc.h               |   1 +
 4 files changed, 168 insertions(+)

diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 909fb7aea638..0727602ce12f 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -723,6 +723,9 @@ enum io_uring_register_op {
 	/* register bpf filtering programs */
 	IORING_REGISTER_BPF_FILTER		= 37,
 
+	/* clone file descriptors from another ring*/
+	IORING_REGISTER_CLONE_FILES		= 38,
+
 	/* this goes last */
 	IORING_REGISTER_LAST,
 
@@ -854,6 +857,15 @@ struct io_uring_clone_buffers {
 	__u32	pad[3];
 };
 
+struct io_uring_clone_files {
+	__u32 src_fd;
+	__u32 flags;
+	__u32 src_off;
+	__u32 dst_off;
+	__u32 nr;
+	__u32 pad[3];
+};
+
 struct io_uring_buf {
 	__u64	addr;
 	__u32	len;
diff --git a/io_uring/register.c b/io_uring/register.c
index dce5e2f9cf77..bbc8c506ea2d 100644
--- a/io_uring/register.c
+++ b/io_uring/register.c
@@ -924,6 +924,12 @@ static int __io_uring_register(struct io_ring_ctx *ctx, unsigned opcode,
 			break;
 		ret = io_register_clone_buffers(ctx, arg);
 		break;
+	case IORING_REGISTER_CLONE_FILES:
+		ret = -EINVAL;
+		if (!arg || nr_args != 1)
+			break;
+		ret = io_register_clone_files(ctx, arg);
+		break;
 	case IORING_REGISTER_ZCRX_IFQ:
 		ret = -EINVAL;
 		if (!arg || nr_args != 1)
diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 650303626be6..a598e5af4c0a 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1303,6 +1303,155 @@ int io_register_clone_buffers(struct io_ring_ctx *ctx, void __user *arg)
 	return ret;
 }
 
+static int io_clone_file_node(struct io_ring_ctx *ctx,
+			      struct io_rsrc_node *src_node,
+			      int dst_index,
+			      struct io_file_table *new_table)
+{
+	struct io_rsrc_node *dst_node;
+	struct file *file;
+
+	dst_node = io_rsrc_node_alloc(ctx, IORING_RSRC_FILE);
+	if (!dst_node)
+		return -ENOMEM;
+
+	file = io_slot_file(src_node);
+	get_file(file);
+	io_fixed_file_set(dst_node, file);
+
+	new_table->data.nodes[dst_index] = dst_node;
+	io_file_bitmap_set(new_table, dst_index);
+
+	return 0;
+}
+
+static int io_clone_files(struct io_ring_ctx *ctx, struct io_ring_ctx *src_ctx,
+			  struct io_uring_clone_files *arg)
+{
+	struct io_file_table new_file_table;
+	unsigned int dst_nr = ctx->file_table.data.nr;
+	unsigned int src_nr = src_ctx->file_table.data.nr;
+	unsigned int new_nr, i;
+
+	lockdep_assert_held(&ctx->uring_lock);
+	lockdep_assert_held(&src_ctx->uring_lock);
+
+	if (ctx->user != src_ctx->user || ctx->mm_account != src_ctx->mm_account)
+		return -EINVAL;
+
+	if (dst_nr && !(arg->flags & IORING_REGISTER_DST_REPLACE))
+		return -EBUSY;
+
+	if (!src_nr)
+		return -ENXIO;
+
+	if (!arg->nr)
+		arg->nr = src_nr;
+	else if (arg->nr > src_nr)
+		return -EINVAL;
+
+	if (check_add_overflow(arg->src_off, arg->nr, &i) || i > src_nr)
+		return -EINVAL;
+	if (check_add_overflow(arg->dst_off, arg->nr, &i))
+		return -EINVAL;
+
+	new_nr = max(dst_nr, arg->dst_off + arg->nr);
+	if (new_nr > IORING_MAX_FIXED_FILES)
+		return -EINVAL;
+
+	memset(&new_file_table, 0, sizeof(new_file_table));
+	if (!io_alloc_file_tables(ctx, &new_file_table, new_nr))
+		return -ENOMEM;
+
+	/* Copy original nodes from before the cloned range */
+	for (i = 0; i < min(arg->dst_off, dst_nr); i++) {
+		struct io_rsrc_node *src_node = io_rsrc_node_lookup(&ctx->file_table.data, i);
+
+		if (!src_node)
+			continue;
+		if (io_clone_file_node(ctx, src_node, i, &new_file_table))
+			goto out;
+	}
+
+	/* Copy the actual cloned range from the source ring */
+	for (i = 0; i < arg->nr; i++) {
+		struct io_rsrc_node *src_node = io_rsrc_node_lookup(&src_ctx->file_table.data,
+				arg->src_off + i);
+
+		if (!src_node)
+			continue;
+		if (io_clone_file_node(ctx, src_node, arg->dst_off + i, &new_file_table))
+			goto out;
+	}
+
+	/* Copy original nodes from after the cloned range */
+	for (i = arg->dst_off + arg->nr; i < dst_nr; i++) {
+		struct io_rsrc_node *src_node = io_rsrc_node_lookup(&ctx->file_table.data, i);
+
+		if (!src_node)
+			continue;
+		if (io_clone_file_node(ctx, src_node, i, &new_file_table))
+			goto out;
+	}
+
+	/* free the old file table if there is any data present */
+	if (dst_nr)
+		io_free_file_tables(ctx, &ctx->file_table);
+
+	WARN_ON_ONCE(ctx->file_table.data.nr);
+	ctx->file_table = new_file_table;
+	io_file_table_set_alloc_range(ctx, 0, ctx->file_table.data.nr);
+	return 0;
+
+out:
+	/* Error Path: Safely destroy whatever we partially built */
+	io_free_file_tables(ctx, &new_file_table);
+	return -ENOMEM;
+}
+
+int io_register_clone_files(struct io_ring_ctx *ctx, void __user *arg)
+{
+	struct io_uring_clone_files clone_arg;
+	struct io_ring_ctx *src_ctx;
+	bool registered_src;
+	struct file *file;
+	int ret;
+
+	if (copy_from_user(&clone_arg, arg, sizeof(clone_arg)))
+		return -EFAULT;
+	if (clone_arg.flags &
+	    ~(IORING_REGISTER_SRC_REGISTERED | IORING_REGISTER_DST_REPLACE))
+		return -EINVAL;
+
+	if (memchr_inv(clone_arg.pad, 0, sizeof(clone_arg.pad)))
+		return -EINVAL;
+
+	registered_src = (clone_arg.flags & IORING_REGISTER_SRC_REGISTERED) != 0;
+	file = io_uring_ctx_get_file(clone_arg.src_fd, registered_src);
+	if (IS_ERR(file))
+		return PTR_ERR(file);
+
+	src_ctx = file->private_data;
+	/* Same ring clone is not allowed */
+	if (src_ctx == ctx) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	mutex_unlock(&ctx->uring_lock);
+	lock_two_rings(ctx, src_ctx);
+
+	ret = io_clone_files(ctx, src_ctx, &clone_arg);
+
+out:
+	if (src_ctx != ctx)
+		mutex_unlock(&src_ctx->uring_lock);
+
+	if (!registered_src)
+		fput(file);
+	return ret;
+}
+
 void io_vec_free(struct iou_vec *iv)
 {
 	if (!iv->iovec)
diff --git a/io_uring/rsrc.h b/io_uring/rsrc.h
index 44e3386f7c1c..32f5c47c46af 100644
--- a/io_uring/rsrc.h
+++ b/io_uring/rsrc.h
@@ -75,6 +75,7 @@ int io_prep_reg_iovec(struct io_kiocb *req, struct iou_vec *iv,
 			const struct iovec __user *uvec, size_t uvec_segs);
 
 int io_register_clone_buffers(struct io_ring_ctx *ctx, void __user *arg);
+int io_register_clone_files(struct io_ring_ctx *ctx, void __user *arg);
 int io_sqe_buffers_unregister(struct io_ring_ctx *ctx);
 int io_sqe_buffers_register(struct io_ring_ctx *ctx, void __user *arg,
 			    unsigned int nr_args, u64 __user *tags);
-- 
2.54.0

