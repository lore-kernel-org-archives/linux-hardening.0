Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382FB2D59E8
	for <linux-hardening@vger.kernel.org>; Wed, 24 Jun 2026 12:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782304837; cv=none; b=NNVTvk3mib65TY7zqImSixSr5pLPjCYZPbmGMRrzUdm0NkGspsDB3NRJPqgrHCOOVz1tZ0u7sgKZZyHuUGogXWPx6Vkh9Ya/BRGIN3bp4NLF0E+fs8dMdSt11Y5XaWzpX5VuhQem0RbwJbVDt5Fl++f5SIrZciZzH5Fkj8YoxAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782304837; c=relaxed/simple;
	bh=fozbEgUdV6Nl9j1tU8jiOl2E8a0JIeKeUAbwX81skvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fti4BOYKTirHOT9RpcK+wdbawVWEuPTN5DY7mtuNK3F1hEaQ98NvHk4J9FnYCA5pCugXBNqMZn/JjyXqxET4HuJsPY0gdcLocLPzl6Ijpd6lZMya/zM71Mgr3CkZ/ie3eKGEBC62n5NeGnJLxxTJCI/Yu/DYoGTmhPQSWMTZi4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MAM9T7Rv; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAM9T7Rv"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c6be9cd7afso4428165ad.1
        for <linux-hardening@vger.kernel.org>; Wed, 24 Jun 2026 05:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782304835; x=1782909635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sj1/r6PSBgTcEwpvh5LJRIV/sQ/a60P8qbpxL8SWO1k=;
        b=MAM9T7RvfsxuVd8JD7b3C9mQ3wzdkIObuiKSF7VAs2q4M7JANay7I+dr2PI4eQ5Kfl
         xV6ypHEdiwkCpsqabdksZt9So1z2FCw33u4Z56/v9VLffL3gUvegkDzOk5LC/rN7fbac
         NzoRHf5oPRM0/28QtysNXnR5gtbfRWbbYTQe1FZTXDcoNDhwDz+Z5PcJRErTB22n3kBZ
         UaVqVvRv9c6us3it8QmlTyVDMSFdG0JI4Qac+4E9GVfiKY0ttlR+MZzknaQxmbJvPd4B
         UFUQ9xGCGS2a6ysft4mvwpyJeqNA/nA3YfZrfgwwkXIbuKQPOn1IR6pG5yYyIq6MLkk/
         9JOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782304835; x=1782909635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sj1/r6PSBgTcEwpvh5LJRIV/sQ/a60P8qbpxL8SWO1k=;
        b=MMIwt6mloV1r6HsaFef6Yb9DVZ0ZonIn2q5QglqiFK/GKMWyBK8Hq8VONfblu2Jdlj
         3gLVaoYwyg4UQCJI/6K6Z724JhGDqgfiO4tU3LgJ5Snzgxsg8XfndlUxbv2G8oMKc4aw
         yd3f+NxWjJKmDOz7nnbRyjrGgsZMr+ocnhz4EFdxzVjERBKGL1PQJwyXe10zzMwrO7UU
         XVYzTp5nU/2btfl+E4M/CDZpNiolsihIR6qOvxhMz0gnUY7DeMP347ZJg1w/QDpAT1Nj
         +EBiiLVEJSzi6mP6iMrX447sv7o4ObXSPG8pBlkkNlCUmlW3kSeeWuyXy+Th24/Ro+HQ
         UdmA==
X-Forwarded-Encrypted: i=1; AHgh+Ro1rs9atzt5GbYpbEbGd5LqzMuiZp/IRN9+kuoFxdgbqsz8ncuCi8hKoabbgm3DQIFPhmVG5CrOYozIgU2XtNU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5vI0RBFrDYcx3viSCE/hJpDeMjim1ZDpRkcQkeYaQscMhMHhB
	9Smtqbq9J/r+kYC4PVnWnBsAsOts6fntig6VzBAK0oPKlvcz7TM2Wj2F
X-Gm-Gg: AfdE7cn0We6KJfprRmLgXW4SQS6XLKJQ+dfZWiA6l0llTIcUwhKmbL0EUe8cCMZOLAg
	wYb5NsPhkw+VXXZYxkPegyO3xzZJCgKOg2Re6Xndus44ABO+0e0MjoEmNMYT2ieremfE4KpjV3y
	idAn4oiSmpIsBz+yJxYnlI3je0bUEF5w76zq/pVVPXv8496qgoZp2V9LtLZzMtV4l7meJL48x3H
	rEDdYdn8FhfJB0b9OIs/+Ls6SjS2VXucv44zjRlCvcDXWNamQwM97WdWJsm7zmEbXXMUBhrzjUX
	0QhGc6Dnzh0IwTeETzvKHqY31hHVtfhTy/HeSKCB8YKi3DnfKzBsVUnKHeu0efRKNb5Et9dIKwc
	Zub2IgIcJnTCr+LPjD5jY4SsC/01hhvLtjLkZGlY+/wyOmaiUtu2kX133VeCN18w/k7bLZvJwPy
	qqkYy0HV22Nt5A4pMwAHklmDGisn35sf0aMF+y3FDldiYAyQ==
X-Received: by 2002:a17:902:e94f:b0:2c0:f807:56b2 with SMTP id d9443c01a7336-2c7e170f604mr36791325ad.34.1782304835306;
        Wed, 24 Jun 2026 05:40:35 -0700 (PDT)
Received: from Athena ([58.146.97.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f1a914b8sm3690645ad.26.2026.06.24.05.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 05:40:34 -0700 (PDT)
From: Harshal Chavan <harshal24.chavan@gmail.com>
To: harshal24.chavan@gmail.com
Cc: axboe@kernel.dk,
	gregkh@linuxfoundation.org,
	gustavoars@kernel.org,
	io-uring@vger.kernel.org,
	kees@kernel.org,
	krisman@suse.de,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6] io_uring/register: add IORING_REGISTER_CLONE_FILES opcode
Date: Wed, 24 Jun 2026 18:10:19 +0530
Message-ID: <20260624124019.4521-1-harshal24.chavan@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260624073921.11037-1-harshal24.chavan@gmail.com>
References: <20260624073921.11037-1-harshal24.chavan@gmail.com>
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

Signed-off-by: Harshal Chavan <harshal24.chavan@gmail.com>

---
Sorry for the noise on the previous email! I accidentally sent the patch 
before running checkpatch and missed a whitespace error. This v6 corrects it.

v6:
  - Fixed trailing whitespace checkpatch error.
v5:
  - Added missing spacing in comment (Gabriel).
  - Removed ctx->user and mm_account checks (Gabriel).
  - Used !! for boolean conversion (Gabriel).
  - Moved mutex_unlock unconditionally above the out label (Gabriel).
  - liburing implementation and tests: https://github.com/axboe/liburing/pull/1606
v4:
  - Updated Signed-off-by to use real name and moved above the scissors line (Greg KH).
v3:
  - Rewrote the cloning loop to allocate private destination nodes via io_rsrc_node_alloc to fix non-atomic ref lock synchronization (Jens).
  - Maintained partial offset/copy support to mirror io_clone_buffers UAPI (Jens).
  - Gated the replacement free check on ctx->file_table.data.nr (Gabriel).
  - Prevented self-cloning by checking ctx == src_ctx (Gabriel).
  - Removed submitter_task check to allow cross-thread pooling setups (Gabriel).
v2:
  - Dropped unrelated whitespace formatting changes from v1
---
 include/uapi/linux/io_uring.h |  12 +++
 io_uring/register.c           |   6 ++
 io_uring/rsrc.c               | 145 ++++++++++++++++++++++++++++++++++
 io_uring/rsrc.h               |   1 +
 4 files changed, 164 insertions(+)

diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 909fb7aea638..67fcc40f8dfc 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -723,6 +723,9 @@ enum io_uring_register_op {
 	/* register bpf filtering programs */
 	IORING_REGISTER_BPF_FILTER		= 37,
 
+	/* clone file descriptors from another ring */
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
index 650303626be6..1d58c256b3a5 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1303,6 +1303,151 @@ int io_register_clone_buffers(struct io_ring_ctx *ctx, void __user *arg)
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
+	registered_src = !!(clone_arg.flags & IORING_REGISTER_SRC_REGISTERED);
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
+	mutex_unlock(&src_ctx->uring_lock);
+
+out:
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

