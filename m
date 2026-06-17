Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C4039183A
	for <linux-hardening@vger.kernel.org>; Wed, 17 Jun 2026 22:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781735649; cv=none; b=IolqRTm/DEN2dQbTZZktXr5r1GQQsZiFIHAkzhjyDbcVNTMBRHydMLkz5a8B+gpsP8rmLNbq219FAlXtmLlbelpdjUHzlpJAVjIMGb7cwuo1bnPINQ3yT65CRm+hg0PzFkFgFrDtScSwT+Y1Nu+07d6NHo8ktJRLj57UGPG3U+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781735649; c=relaxed/simple;
	bh=7dP1HhxjtxeWYjAtcKXQmUA5VLNKmnsS+ydxepXRlfY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q38iEWoVSVB7XpIg869pbULHBZtCpbVKVwmlI1jk4cSHRkYwUuHoXvEh/9itiANkVzQS+Szs3/DNHhpsugnzI1si1w9Z+Oycpti+5PBygqG+ggVKWgLgMr+0IooJOwvV7ZgOLl6QKT1xbtWrUSFhVzh90n6VPDE2JfVE8os7qy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 214BF6C132;
	Wed, 17 Jun 2026 22:34:06 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C528B779A8;
	Wed, 17 Jun 2026 22:34:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OtHhI90gM2qnegAAD6G6ig
	(envelope-from <krisman@kernel.org>); Wed, 17 Jun 2026 22:34:05 +0000
From: Gabriel Krisman Bertazi <krisman@kernel.org>
To: harshal24-chavan <harshal24.chavan@gmail.com>, axboe@kernel.dk,
 kees@kernel.org
Cc: gustavoars@kernel.org, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 harshal24-chavan <harshal24.chavan@gmail.com>
Subject: Re: [PATCH v2] [PATCH v2] io_uring/register: add
 IORING_REGISTER_CLONE_FILES opcode
In-Reply-To: <20260617081622.32823-1-harshal24.chavan@gmail.com>
References: <20260617081622.32823-1-harshal24.chavan@gmail.com>
Date: Wed, 17 Jun 2026 18:33:59 -0400
Message-ID: <87a4ssyey0.fsf@mailhost.krisman.be>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.dk,kernel.org];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

harshal24-chavan <harshal24.chavan@gmail.com> writes:

> Currently, if an application wants to duplicate registered file descriptors
> from one io_uring instance to another, it must manually unregister and
> re-register them, incurring unnecessary overhead.
>
> Add IORING_REGISTER_CLONE_FILES to allow direct cloning of the file table
> from a source ring to a destination ring. This includes support for
> partial offsets and the IORING_REGISTER_DST_REPLACE flag.
>
> Signed-off-by: harshal24-chavan <harshal24.chavan@gmail.com>
>
> ---
> v2: Dropped unrelated whitespace formatting changes from v1
> ---
>  include/uapi/linux/io_uring.h |  12 +++
>  io_uring/register.c           |   6 ++
>  io_uring/rsrc.c               | 160 ++++++++++++++++++++++++++++++++++
>  io_uring/rsrc.h               |   1 +
>  4 files changed, 179 insertions(+)
>
> diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
> index 909fb7aea638..0727602ce12f 100644
> --- a/include/uapi/linux/io_uring.h
> +++ b/include/uapi/linux/io_uring.h
> @@ -723,6 +723,9 @@ enum io_uring_register_op {
>  	/* register bpf filtering programs */
>  	IORING_REGISTER_BPF_FILTER		= 37,
>  
> +	/* clone file descriptors from another ring*/
> +	IORING_REGISTER_CLONE_FILES		= 38,
> +
>  	/* this goes last */
>  	IORING_REGISTER_LAST,
>  
> @@ -854,6 +857,15 @@ struct io_uring_clone_buffers {
>  	__u32	pad[3];
>  };
>  
> +struct io_uring_clone_files {
> +	__u32 src_fd;
> +	__u32 flags;
> +	__u32 src_off;
> +	__u32 dst_off;
> +	__u32 nr;
> +	__u32 pad[3];
> +};
> +
>  struct io_uring_buf {
>  	__u64	addr;
>  	__u32	len;
> diff --git a/io_uring/register.c b/io_uring/register.c
> index dce5e2f9cf77..bbc8c506ea2d 100644
> --- a/io_uring/register.c
> +++ b/io_uring/register.c
> @@ -924,6 +924,12 @@ static int __io_uring_register(struct io_ring_ctx *ctx, unsigned opcode,
>  			break;
>  		ret = io_register_clone_buffers(ctx, arg);
>  		break;
> +	case IORING_REGISTER_CLONE_FILES:
> +		ret = -EINVAL;
> +		if (!arg || nr_args != 1)
> +			break;
> +		ret = io_register_clone_files(ctx, arg);
> +		break;
>  	case IORING_REGISTER_ZCRX_IFQ:
>  		ret = -EINVAL;
>  		if (!arg || nr_args != 1)
> diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
> index 650303626be6..1e4e114ca5a5 100644
> --- a/io_uring/rsrc.c
> +++ b/io_uring/rsrc.c
> @@ -1303,6 +1303,166 @@ int io_register_clone_buffers(struct io_ring_ctx *ctx, void __user *arg)
>  	return ret;
>  }
>  
> +
> +static int io_clone_files(struct io_ring_ctx *ctx, struct io_ring_ctx *src_ctx,
> +			  struct io_uring_clone_files *arg)
> +{
> +	struct io_file_table new_file_table;
> +	int i, off, nr;
> +	unsigned int src_nr;
> +
> +	lockdep_assert_held(&ctx->uring_lock);
> +	lockdep_assert_held(&src_ctx->uring_lock);
> +
> +	/* if offsets are given, must have nr specified too */
> +	if (!arg->nr && (arg->dst_off || arg->src_off))
> +		return -EINVAL;
> +	/* not allowed unless REPLACE is set */
> +	if (ctx->file_table.data.nr &&
> +	    !(arg->flags & IORING_REGISTER_DST_REPLACE))
> +		return -EBUSY;
> +
> +	src_nr = src_ctx->file_table.data.nr;
> +	if (!src_nr)
> +		return -ENXIO;
> +	if (!arg->nr)
> +		arg->nr = src_nr;
> +	else if (arg->nr > src_nr)
> +		return -EINVAL;
> +	else if (arg->nr > IORING_MAX_FIXED_FILES)
> +		return -EINVAL;
> +	if (check_add_overflow(arg->nr, arg->src_off, &off) || off > src_nr)
> +		return -EOVERFLOW;
> +	if (check_add_overflow(arg->nr, arg->dst_off, &src_nr))
> +		return -EOVERFLOW;
> +	if (src_nr > IORING_MAX_FIXED_FILES)
> +		return -EINVAL;
> +	/* Allocate file tables memory {data + bitmap} into new_file_table */
> +	memset(&new_file_table, 0, sizeof(new_file_table));
> +	if (!io_alloc_file_tables(ctx, &new_file_table,
> +				  max(src_nr, ctx->file_table.data.nr)))
> +		return -ENOMEM;
> +
> +	/* Copy original dst nodes from before the cloned range */
> +	for (i = 0; i < min(arg->dst_off, ctx->file_table.data.nr); i++) {
> +		struct io_rsrc_node *node = ctx->file_table.data.nodes[i];
> +
> +		if (node) {
> +			new_file_table.data.nodes[i] = node;
> +			node->refs++;
> +			io_file_bitmap_set(&new_file_table, i);
> +		}
> +	}
> +
> +	off = arg->dst_off;
> +	i = arg->src_off;
> +	nr = arg->nr;
> +	while (nr--) {
> +		struct io_rsrc_node *dst_node, *src_node;
> +
> +		src_node = io_rsrc_node_lookup(&src_ctx->file_table.data, i);
> +		if (!src_node) {
> +			dst_node = NULL;
> +		} else {
> +			dst_node = io_rsrc_node_alloc(ctx, IORING_RSRC_FILE);
> +			if (!dst_node) {
> +				io_free_file_tables(ctx, &new_file_table);
> +				return -ENOMEM;
> +			}
> +
> +			struct file *file = io_slot_file(src_node);
> +
> +			get_file(file);
> +			io_fixed_file_set(dst_node, file);
> +		}
> +		new_file_table.data.nodes[off] = dst_node;
> +		if (dst_node)
> +			io_file_bitmap_set(&new_file_table, off);
> +
> +		i++;
> +		off++;
> +	}
> +
> +	/* Copy original dst nodes from after the cloned range */
> +	for (i = src_nr; i < ctx->file_table.data.nr; i++) {
> +		struct io_rsrc_node *node = ctx->file_table.data.nodes[i];
> +
> +		if (node) {
> +			new_file_table.data.nodes[i] = node;
> +			node->refs++;
> +			io_file_bitmap_set(&new_file_table, i);
> +		}
> +	}
> +
> +	/*
> +	 * If asked for replace, put the old table. new_file_table.data->nodes[] holds both
> +	 * old and new nodes at this point.
> +	 */
> +	if (arg->flags & IORING_REGISTER_DST_REPLACE)
> +		io_free_file_tables(ctx, &ctx->file_table);

IIUC, the IORING_REGISTER_DST_REPLACE exists for backward compatibility,
since originally the buffer cloning would fail if existing elements were
already there.  It is kind of superflous in a new operation but I suppose
it is here to mirror the semantics of io_clone_buffers, which is ok, but
then...

This free should at least be gated on ctx->file_table->data.nr.  We are
always replacing the ->file_table if it was initialized, so it is a bit
more logical to check the table directly.

> +
> +	/*
> +	 * ctx->file_table must be empty now - either the contents are being
> +	 * replaced and we just freed the table, or the contents are being
> +	 * copied to a ring that does not have buffers yet (checked at function
> +	 * entry).
> +	 */
> +	WARN_ON_ONCE(ctx->file_table.data.nr);
> +	ctx->file_table = new_file_table;
> +	io_file_table_set_alloc_range(ctx, 0, ctx->file_table.data.nr);
> +	return 0;
> +}
> +
> +int io_register_clone_files(struct io_ring_ctx *ctx, void __user *arg)
> +{
> +	struct io_uring_clone_files clone_arg;
> +	struct io_ring_ctx *src_ctx;
> +	bool registered_src;
> +	struct file *file;
> +	int ret;
> +
> +	if (copy_from_user(&clone_arg, arg, sizeof(clone_arg)))
> +		return -EFAULT;
> +	if (clone_arg.flags &
> +	    ~(IORING_REGISTER_SRC_REGISTERED | IORING_REGISTER_DST_REPLACE))
> +		return -EINVAL;
> +	/* not allowed unless REPLACE is set */
> +	if (!(clone_arg.flags & IORING_REGISTER_DST_REPLACE) &&
> +	    ctx->file_table.data.nr)
> +		return -EBUSY;

This check is duplicated in io_clone_files.

> +	if (memchr_inv(clone_arg.pad, 0, sizeof(clone_arg.pad)))
> +		return -EINVAL;
> +
> +	registered_src = (clone_arg.flags & IORING_REGISTER_SRC_REGISTERED) !=
> +			 0;
> +	file = io_uring_ctx_get_file(clone_arg.src_fd, registered_src);
> +	if (IS_ERR(file))
> +		return PTR_ERR(file);
> +
> +	src_ctx = file->private_data;
> +	if (src_ctx != ctx) {

Shouldn't we just fail if ctx == src_ctx ?

> +		mutex_unlock(&ctx->uring_lock);
> +		lock_two_rings(ctx, src_ctx);
> +
> +		/* Prevent cross-process hijacking */
> +		if (src_ctx->submitter_task &&
> +		    src_ctx->submitter_task != current) {
> +			ret = -EEXIST;
> +			goto out;

Is limiting the feature to the submitter_task necessary to safely copy
the table even if the lock is held?  The use-case for this feature would
be setting up a single ring with its file table and then replicating it
on other threads, on the common model of one-ring per thread. This check
limits it.

There's no cross-process hijacking, IIUC, because io_uring_ctx_get_file
sees rings belonging to the process.  But a thread could make use of
this feature to clone the process_table of another thread which is
useful.

>+ 
>+ out:
>+        if (src_ctx != ctx)
>+                mutex_unlock(&src_ctx->uring_lock);

-- 
Gabriel Krisman Bertazi
