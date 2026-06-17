Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4A72D2385
	for <linux-hardening@vger.kernel.org>; Wed, 17 Jun 2026 14:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781708062; cv=none; b=kZTYj++PS/cMeKrg1+4WHivZk/GC6/gWNMcAdeejLh5Q3L0a+cvWj99hvl4Clc4GwAfhSG73VkH0BpSFFb9YxA7kA2ouoUfqn+dQ8TDscSd+d77LxLbDjnUTCQpFWvKdVcZ5CmR9sG31B+5SQX8DOelrm02TAmBe2554QobWlOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781708062; c=relaxed/simple;
	bh=JYvlfimKSqygNvWjrm0SJL/OntXTf5oSDKuVqv/4Qgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gNhHg3HDcAjXNDBvyRCX3ZNk8+FWEccGeWTp6coqqW0hehxKGCbNZnsXVLYdWC92F+cNLgbkMhWNtj901HeaAeIDdGSmQa1QoDgZxmBcTfQhteSv+gApB5eLx/7WMNu2NxjpF1hMoLp5/lA/hsKUsrVoynxSnsiHYVXsYFAyi2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=D9poun7u; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="D9poun7u"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-43bfe209e45so3580840fac.0
        for <linux-hardening@vger.kernel.org>; Wed, 17 Jun 2026 07:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1781708058; x=1782312858; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K8Wv7VCkyaLN0s61xd4QXGQ88sPTQ0XGFCHSINh9F+E=;
        b=D9poun7u32mr2DCGJwc6cMYl7qlGIpMo1ilH8qatgFINlnGlNBsz9S0NxGOKmqnXKR
         TZ1NYE8YGdPgPZMDRLU0jGicSav6uH7X9ML7lqwkohB2vhHQMdsko66hgHZ12efGtifk
         8o5dx6sx5DU5Jf1wu4PqUHOL7km3rwARuWZXz847r6RNsOZxtSiEzUx6QCLyKX1JPcfN
         I5w2pk5ZcP9QQfIy+DS+OGz16gF6hEnAtdeCsUOyu+cMBliRJg8mcFyIMhVKZ0DeIRMA
         ZiuUf6/ljytzwY+4g1u+IeOax7aiA7yygB59215WNzVdhMNEEg2fdnx8Qjo5EgRRFRCp
         74HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781708058; x=1782312858;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K8Wv7VCkyaLN0s61xd4QXGQ88sPTQ0XGFCHSINh9F+E=;
        b=c5tVREdubUOS7LTcZiYiZPbTOgwZLkG14/F88I7Gcjh0QFCUGTWigo53GTf3fjB+IA
         7vKzS9izdZwOA03LuZc9b5TnTJqK1+oHbElp4qD3SohBWOxM0mxiIeOyvIW7Ra4rGGgG
         2i896Mw0NOXhfhWxNUJCglI6z2EFUNQ1H2cCLofLJjHDrKu827CUE8RsIXi8pH9/eyz+
         IBPYpEjUx6FAk1RLFr07IOZ7ssTrnFVaeeYaKpX6doC0+icSHhSEC5yWEtkRExLyN0nc
         o5OVQBFEgYLTn06UlyUdMK/Z5vq2/1JnipMXCWhzSyXttg9VKY4WmgW2zFAMX7FFiCzN
         cuBA==
X-Forwarded-Encrypted: i=1; AFNElJ/FlLqIO4wQqOrSFeqnSgDkYWem0lVpZi3LkGA4UIJCJrekLJTvPqdkqcwB2IbY2ubqnseDzIhJMA7lsJiR5w4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsvQueHp88AvO5t6Z6XGry03eegM9bqj46sxUE+yd0VvqD+5i4
	rWe+ZllljF0WHg/PFuWxJxIPm7ji7slax7mW7XBKanQrEpiVz+5LmkXTBWf44TVBc/8=
X-Gm-Gg: AfdE7cnm1aKxfmYCQj2TIOP1ilbyrMMYGVaLjsxUEkjja04Dt3SygBmUEl+MORke+Ag
	pA+SFM9F/kQJ3lA9/sMu9V/mC7e3+ElJ6J3fn+6NVUrBpVVNXDtCQa4ecKyUzHZCGQ25MEDt1xz
	HxRfsJlzjyfZ3gJXF/oUFznp77+UNXG3JK1/gU3A0Gnl1A8bVrPTkHtRTx0i8pmh0rImysBbq9a
	31zvO8pnyZBabEK1WBdirEqTMT2+DfBN9+iewkOjv2pU2w2E01yHfzqNsOguFAmC9XFbWLlBg6n
	PkYoKAgENHemz8FtZqBMYFkHPUgbVXGDUNm3dC8QvcHlDP0Vp8HcwcmzM+M2MuLV1Zlw/hpRUpr
	/tlw0Ki+A5geo7YQqDIF2Zk6wh8jFGU/5geMT9D4nVqc9XVRXrSzxagTjZUEwPF35iqWAM6IAp9
	ETR2SS6BqwQCERERag+9VrPpg4EZe8CaW/RZu8JQc=
X-Received: by 2002:a05:6870:819d:b0:43c:3ae7:5e83 with SMTP id 586e51a60fabf-44690549596mr2920062fac.31.1781708058411;
        Wed, 17 Jun 2026 07:54:18 -0700 (PDT)
Received: from [172.19.0.220] ([99.196.128.98])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4430900e368sm4484893fac.16.2026.06.17.07.54.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 07:54:17 -0700 (PDT)
Message-ID: <2d35e4d2-72ec-4ae8-90ba-8c9b1e53c58f@kernel.dk>
Date: Wed, 17 Jun 2026 08:54:04 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] [PATCH v2] io_uring/register: add
 IORING_REGISTER_CLONE_FILES opcode
To: harshal24-chavan <harshal24.chavan@gmail.com>, kees@kernel.org
Cc: gustavoars@kernel.org, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20260617081622.32823-1-harshal24.chavan@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260617081622.32823-1-harshal24.chavan@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/17/26 2:16 AM, harshal24-chavan wrote:
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

Not sure the offsets and partial copies are going to be worth it, but
I'm willing to have my mind changed. But that's a minor thing really.

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

Also a question whether the destination should've already allocated a
sparse table. This kind of bundles the two into one. In general, as
mention on the GH link, I do think this should work exactly like cloning
buffers. It'd be somewhat confusing if they don't match up, as it's
essentially the same operation, just on a different node type.


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

This definitely won't work - I also mentioned in the GH link that nodes
cannot be shared, you have to allocate new nodes on the destination
side.

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

Same here, it needs a new node that's private to the destination. Hence
you'd need to _always_ allocate one, assign the file, and get a
reference to it.

The file nodes rely on non-atomic refs when being used, which is
protected by the ctx->uring_lock as that's always held for the fast path
issue. If you just assign the node by reference, now you have two
different rings manipulating the same node in memory, but they don't
agree on synchronization.

-- 
Jens Axboe
