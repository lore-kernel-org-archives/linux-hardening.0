Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0821C360EC0
	for <linux-hardening@vger.kernel.org>; Wed, 24 Jun 2026 07:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782286788; cv=none; b=ggmFzsjhOUUIPIwB7FQGg8YkIvFtv/gklDR+0d+WMVXhUGNavcN8sPH0ZnRBcv4EKLY9FdNJmyye66D9GbWb/3z1KxxKTGBuWRgZucJCfPywWhM/InP1h4Hd1iA4KLesFgqOAgdFvMpyBd1dYtckzbQb8X2V44aFxrYL5GK0bzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782286788; c=relaxed/simple;
	bh=K9hXOjJNrOUVW4ZYqXx7EpTqNs3yz4MSR382ybbfthk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OdFgTGd/Gthj3/kcENT987aIeTswNNKLnXUaCOqaZMprd/nSV1X1bEWWFuHEZH53WXO6c8YjoCfI7FK/5aSL+mq1tiFHzNVroXukoF//cFaUERBp0hPc8PjBobuSMLZpJc2vgK5WulpUHX1h33L7VXaHy+TUd0DFx7hkH9shJWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBpcratL; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBpcratL"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8423610ec93so839481b3a.2
        for <linux-hardening@vger.kernel.org>; Wed, 24 Jun 2026 00:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782286786; x=1782891586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NG4dKTDv8JZYL7kS7cRIE6tHZ+j36hHvO+etffou0zY=;
        b=nBpcratL8BpqYna82iQSngCsqcqqV+jZrrfkZSZGv3hA99jDGOpf2NtGoufUL1PQAS
         uEr4mmfNsG5geOKoRETbUeU/m/kF8sMeeeZCuoWWEJoR8JeyEgHjcgh4w0x5sJo2SOYy
         ofEjzYei5W1loN+zuhmIOyOp7V/jV2lNuPYRStswjrLUdMe9se7gWXpUvyj63dLOjury
         1CrNj6PGvkkfRols1T+3ZxRv6L3gYiupkm84Hhq49rfeBlvhQ4G/3ayteatXxQZNwVW+
         qtwEdI2RHXiSRH9rD7zwghcxfdE8gHIKSjmshGiPiKNyiD49BA/RTxpo91tCeDCVzhXF
         jtXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782286786; x=1782891586;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NG4dKTDv8JZYL7kS7cRIE6tHZ+j36hHvO+etffou0zY=;
        b=p2ODZKdPoTnTRjmHMhbvzM1l+e5u6Q132vub/NO5aP0/yaYYwLSg8xdV2zTzYrHHzz
         LanWP9CnY9TDhnM1Q7Z3a4ebUh7/fHb7VyS5Au97UpZpOrPLbBrFDx8Bn8rwg9c+DQst
         M6ZPwbheIWzq9P6kRK79mbHzEJOXGxbUBi1YWaaJUdqJsbm/e8p2Ywy8Xtwqt6k1AKHB
         bcXoF2T3ZeEYKvcK3r9XIYbm7nRntNS/C0l6NCqUIQYi33gCNRVQnhgwRzo2KJk6Pl8i
         0jDPbzDOxV4W2dVnZIH6Gcla7d4HP2zVr7OrBkENsPWugn96n68zjAmMZDuAKYoyLfHe
         tTQQ==
X-Forwarded-Encrypted: i=1; AFNElJ/BzbEeFl9wZMt5wMgoJeVQC58M/W9kDFlVgaB2LN0om1QsP/ZKiuaWEZ7Wv8khULuMnOleEDPc8ZD89js8Hls=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3nAIPuxg/rzVQZrYp1pFFApI3Q3NsrtFdg5dDR6BHo9wXzFRz
	ysxQ+AI2WI6XGTWnidDg8GN24Etjq8JQIVkZg4ZieFSB2ImH1CkYK0rNN4V8B8P+
X-Gm-Gg: AfdE7cmcHgSPIo0ecti2Lu/t3nMNcAW/XHRHETM49gMbCMNj5uF9JzCaOH3vsWDbI4B
	7YTcGUrA/q7IGIOrxDCKZH5jOVtQzsWTNwhc+7U2P0Fz4gl5Yg7sv5c4zI7iA4c2PaPuZTKO8JV
	PlUqUphG/y8mt6wmxXJSZxqJo9v5TdWqyh8o+q9/8v2gwTyWd2bhm79VsLZnL3SYEMzM1v0mCLZ
	hM5RCrhvTj43C4B83IWnWDEe90qn52g0Pms0UGp4LCxT3us5FBHViuRzlp8hJsfyX8aFcbp1lPQ
	NFEEIrCDe51QnU1SawBFqmU8aCcKMDxySKd9LLGZl0AXfn2u2IJjgFUW3xImRuudMhG0ubE4tl4
	DQyCkQDXEc5djdYgsx4OZVEXCLUDXTW2MEb1qH0d+PV60fS0d73ciT9cunu1nKvauV4vN9UvIef
	j0/X/m3WHtc/NjoA0XdcmiafEr4E//W2oXLGWgi1YkNXuG1w==
X-Received: by 2002:a05:6a00:1ac6:b0:82f:6e9:d1c3 with SMTP id d2e1a72fcca58-845a2c82cc3mr3048248b3a.29.1782286786086;
        Wed, 24 Jun 2026 00:39:46 -0700 (PDT)
Received: from Athena ([58.146.97.171])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a3fecc06sm1370420b3a.21.2026.06.24.00.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 00:39:45 -0700 (PDT)
From: Harshal Chavan <harshal24.chavan@gmail.com>
To: io-uring@vger.kernel.org
Cc: axboe@kernel.dk,
	krisman@suse.de,
	gregkh@linuxfoundation.org,
	gustavoars@kernel.org,
	harshal24.chavan@gmail.com,
	kees@kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5] io_uring/register: add IORING_REGISTER_CLONE_FILES opcode
Date: Wed, 24 Jun 2026 13:09:21 +0530
Message-ID: <20260624073921.11037-1-harshal24.chavan@gmail.com>
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
index 650303626be6..5ddd715e2a63 100644
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

