Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B41366557
	for <linux-hardening@vger.kernel.org>; Fri, 19 Jun 2026 09:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781861830; cv=none; b=WiJmVJZzQODLwVtbKAuCC/w0x5ChTzJxcLKbzjVpYcF00BUtSHJL3s/Si7HBnW9Eq7vql59jIP9HcNW3AW6orbBjUN09feYaTDK9hpAMmOFaU6kovZe/QGxkkjSc3OhP72l76Haw3A/caMV8zpk79/o4KVOsApvz4+oVfwVn5b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781861830; c=relaxed/simple;
	bh=Z8TkROFLM0xkFwPYNXiMm7jXh9wbNRuFi5+CXq37OlI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pLzXBNK1gEuX6UkNpuAMisCXn21psBsXJ7qF2oiMriQ3wrSfdjIpNIXsQq/gnmWyLL4w2d7prVYhdNSgeNDMmGcWK+/NpooQ4O1YKcdl93245zP3lfGbYAvvwKuDA5penQY/+f7qOn5hPn39zPzVjaVLkfyyl3f+UBOuPfEJNyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/dBmjEY; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/dBmjEY"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2bf125989f2so12521455ad.3
        for <linux-hardening@vger.kernel.org>; Fri, 19 Jun 2026 02:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781861826; x=1782466626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mt66HBgSzj4nAKrKflgHaRn6sKn42QXfIFAEBho8e/o=;
        b=E/dBmjEYIAp87bdUUAPPVgtlqevp3fYvcmVEnLaEvtaBCMzYDFg4srg9GLACisSzaa
         fl08Sf9kSoAe9I90WiceVaGBkgitZD/KS39cbo5qmL3oCv8LqqwhalR5+rS60/V3Yfx4
         jqYCrITmIENSkcBWmD69LVrIQT/7EGsB2crfytKHIhcFJH5Sk/qYB8jS70jYetvpq0dn
         DzNEZJthmx3Uavgj2v9lK6bTCbR/RAqhVkuoUvdF5fxct9eIOJCJLk6j/ncEbeYhkche
         ddY4BokOmzmcotle2zTMvdJn+ycEdcTquuDsrnrL1U9Wd4suZqcnpZMCuL2PRICMxLox
         d4nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781861826; x=1782466626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mt66HBgSzj4nAKrKflgHaRn6sKn42QXfIFAEBho8e/o=;
        b=Nj2e9rTzJXcyQb1nWqJlhKDzx/dPxghWjkzLSsNJ+ySLFH86bFGKYBZMbbE+h5983v
         88tLKehIK5WWlMb1fmWMU0K+8y2+I0WSbajCvmXH/s+oCqd/rdUhnjojIvGCnlh4KdT8
         6pRkkvDUz9SkKM52LuoXU0nYNOBBNL+sdMvAKVy7+JIuRCxjCjnyHOhbuplMQ71i0Orm
         bwpCCz/fDYORUcB9BtcvUpoxvzAMElIehI6Mc88ksnhR+PyniD2xqVuXwUakVQrgPk9/
         evJA8Jj9ifauiAyiGodODoOIYm07CeU2skYV32jeXleOl6Q2wbg2zfu+H0VmWP7NMFqZ
         cqzw==
X-Forwarded-Encrypted: i=1; AFNElJ8d6UHdWm8kbw313AX6GspD0NmlnDnFiAn0VyXbKGXJht3t+UD8c/G4lccGH6h4cPHtIcd8NiVwhPhtTrJaUOc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn+xvjHQUX8meM7Zomq7eMBQFgRp4AKDZPOFHqwC5eb6KLhCby
	NggwXBrko7pe1aAypu77nrZCYCknNkBoYyQ6r9QR7/ySt4M6sUHBOn4g
X-Gm-Gg: AfdE7ckKxug5X4nc/4SPjqO+p18PGsr6YeFo2Fx4E0z5Hf2G0IjFndXEYkm0Gy4gGy/
	pLTNZI67wjb6qSkVWhB00AmDqThc5Yp3dauk0myl0ud1sBG3ZQpHBakdzcB62FanBnS53t2MtMo
	4r8b1X6By1mynLMnPuvAIZSFTB+BffIQhvgDqDCpr1v1FoXvuFVrQ0LHjoBh7cVwcXA9KhJQQCh
	km0BxnZ4htja86j1vyqINNajttPtpgHz7Xv84UBTGwYqFKDX5Cxof3j8o+wMOae3DlyjwCTtdgj
	gqvw+jm/85bhAR/obmNrYOYqQqbbKO9AbJ1SGmntSk4GiJ3M9mpma2s3HNBKbYnZIgDa4mtWoVc
	xB3Dt1BU5BQU7atGpTmBvrok1VXy36VLDRTZ3WiJC47rae6mJUk9wEgJ9H/2hrwGVfkbi/glJeM
	uY1zfjJ7v0bd/mYCRbmBMKQN2cG4lQo9DbRyp1INeIOIlzVA==
X-Received: by 2002:a17:902:f68d:b0:2bc:b80f:677e with SMTP id d9443c01a7336-2c718f4a742mr31309725ad.25.1781861825668;
        Fri, 19 Jun 2026 02:37:05 -0700 (PDT)
Received: from Athena ([58.146.97.175])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7208c44c7sm18224015ad.18.2026.06.19.02.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 02:37:05 -0700 (PDT)
From: Harshal Chavan <harshal24.chavan@gmail.com>
To: io-uring@vger.kernel.org,
	axboe@kernel.dk
Cc: krisman@kernel.org,
	gregkh@linuxfoundation.org,
	kees@kernel.org,
	gustavoars@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Harshal Chavan <harshal24.chavan@gmail.com>
Subject: [PATCH v4] io_uring/register: add IORING_REGISTER_CLONE_FILES opcode
Date: Fri, 19 Jun 2026 15:06:41 +0530
Message-ID: <20260619093641.25339-1-harshal24.chavan@gmail.com>
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

Signed-off-by: Harshal Chavan <harshal24.chavan@gmail.com>

---
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

