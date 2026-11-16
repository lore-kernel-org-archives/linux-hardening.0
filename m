Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794801121;
	b=DU+xB1iqkyvZelgO9LHN418sbnHizzw1nIv2XnnIn72B2y1sOygxYTOn+A8gj++hgi2Z
	 TiaY4tAfP+7VkNwwn8fjJpyfS3oVlBnKuLXZBQRBJzo+Gsa+1jhooszpNxnx8+ZqK/lNr
	 igt9Nw8ZMOSKHtl9UmtBpe9qoBNSLvgNsnCC4/JO7IW7Jrsnng7tQfgc0ObBQVajKoIT2
	 s/T6NGD9KqiK6Zy0HsApDYaqE0Q8Rb6JM3aeIv0C7Mso0XGmQblHh+u1y2QMCdx6UFRW/
	 5cpPDAqpesHgR8Zbs2Tze8HSKqX30Dv3X8bIr3RavXhL0I8h7XbeuCzGK8zNjVBSVTQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794801121;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=mHMeLHBcjlpdKQvivDV94WV6xZA1r0k1UiU5sTtS58g=;
	b=ZW870J7D1tbHE/W0kVEOF1lC0u12Qx+9382oauCsuBFNjhTIiR0wMWvpaQDuTSFbtrOJ
	 nUVBo8g5e6KSPy1EGxjT9wtec8Gc9FLnsDFjXQGxXYnPmEoBJQJIgiyYG2ITMX3t2r+7S
	 OLrqJPFZ96KW7qxhYCCp/kS4scOYQt9ewXqoeEDNhfBT1NGj70PFCo+KbtK077FlV8nNs
	 iOYfNdZfgP38UAq/8BBwUQorIxypMjR96ukB9AsIA+f3SRfgVuN+h18P6pOBl/LFvoswY
	 EbgVTPeRXlmEwCumYo388dd3qthePeO8oc+D/Z7bykByPKD1c1/kN6wLOwJ1zHBrKGA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E5G3DvU+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E84606A31F
	for <linux-hardening@vger.kernel.org>; Mon, 16 Nov 2026 03:52:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06E84606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E5G3DvU+
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c50cc8e0f84so106556866b.1
        for <linux-hardening@vger.kernel.org>; Sun, 15 Nov 2026 19:52:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794801119; cv=none;
        d=google.com; s=arc-20260327;
        b=p39U3q2O3efesLBMGA5CaSXnJAML3pRyyl2Vc1KC02l0fYCPNKnd5EsQBTo2+E8k3C
         mFnB9AsVATgmKd8ExJMjTYU+vHHeWUPqsgfNUHS7mw0mhxNH0dTFFLgFztNMXt0F7KX1
         nS4Fy22WvOOH5ucc6Y0/tLR4aW5cFDXmCpee6U+0Zp7SQLtkCGcx0l6mVSlxPkg3fPTT
         vLWAI5BkE65Ul8V+/za1JTkq2dYXb8Hi2ksvF7DXY+NKXsY7xOd9F/Vz0Oyjto6JviSg
         5gucMDxZmjd4vsccHuPK3XHmLt8mm3AWVdFjmvT7O7mahujd03hKiAqVJiILll0SYRSv
         j2Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mHMeLHBcjlpdKQvivDV94WV6xZA1r0k1UiU5sTtS58g=;
        fh=PXjcGVu26B5SP9+4wGnWf4OMqlZrT2Z4E5ShzDSnpbk=;
        b=FiU/A9lBO6m+3vZAy1M33rAK2FpdF+qt8WdyxLucC2zMAu4LxABmZLu8VmmTpPc0HS
         ebtALM8Bz5u94zlDc5yv658GAp4g9O9Ws/dYSPoOEGPJR7V4LzMtFUq2EaFJPum2eArB
         YP3jyjfkDQKFO6uYR7vm41rF2kbQNQ4BACxU11mqAcIy9DI18zbykehWgBwtmjxPjIXK
         sbs4ztCt72GAEGKJwllxz48X+gJ23F0YG3KZm93vwtYqGOOEHSV60tn8+5URuSk9ik7J
         p46ydRTYdcDrosCQIGPMbKY/79KHPaLx+1Gp7CdljBLLW58nMsCHd6LNmzAQCQitbQO7
         CAZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794801119; x=1795405919; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mHMeLHBcjlpdKQvivDV94WV6xZA1r0k1UiU5sTtS58g=;
        b=E5G3DvU+Yq5hFKIs0mhcY6Hs07QWT1xclq1ysyigPuiQHNZy8hEJXg6Vez8Q21U3Pv
         y4J+5tE7Pwoi/bC7LJCcLpXBfV4PoPFGx8NrELUjUEvrqjQXL/QEiOYTe5regi0EJVst
         QCU4VTzy1xsR5rs5hhFbSSK8lEtYZTk6ohRDDtXuWo9arIzhHNf+9k6sTv2j1JiKEK90
         rF+pkTiCxpBfqFWys58HY9cWQZmGMbMeaI6y2YHtI2MJ5K9Q63kaiFecOOtSS7bK6BX7
         B+Wsaf1kJk+703Ayop/wlRglRUoNkGhZW86EYnVR/hgHK73fN2Lu7R3ZrfYKMqS3ZCa9
         QKeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794801119; x=1795405919;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mHMeLHBcjlpdKQvivDV94WV6xZA1r0k1UiU5sTtS58g=;
        b=t507GzI3mXoF7mhM6mm2JkzFdgQMrPxJDyXfMYmWSy/o8ETpNTFhjxdI9fEYXCUIUM
         ERD7R9UyxB+fhuEZyj0DHVZDqtj6Xj2jEn4EckI5YuYrAkhYKauBrEtIgM3x6FD9mxUA
         dXTfEmaXw2u94AJkALC8prXxq8P3+ifrXzTI1KqTjhSrBSjVZabTcK79itPvAnT5PE0S
         CLMy6UvGTCyezwtgTQzFVchAaxcfplIo1BlKRvlAf3JGX9SlUlwj6eomLXo6/g043nzF
         /TXbj3d4evAvAMwg/MR9sg/geXs0ppAaNPmeV5svEuU210hAPkt09GvGPeGb4xSAQVvf
         r8LA==
X-Forwarded-Encrypted: i=1; AL+hErGqSioz3z784oAM9w7R5PVoTaMyX1Jv3j/jB/ci52aa+uwTeFEIr5deiF0svEodku4J+nVdRHcxvLcF2iPB1aY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9PrxxOBR6d+0wTFUriIU+YYPMoxDMCKrpJDhiAgHeOig3z5mjK
	GVvF0izFwYTzs3CnaKFZ86Tyv6dYGfl+HniYqYvSIGk+ju4hzqCKuKdFBglZyWR0lCdXBWJksTy
	BNOHW62DMS+z1UGMhgCaRX3oS8/uAn8I=
X-Gm-Gg: AYBFou2/H2XmInFGP0rNCfRS0jfrb8/uahSW7dVOAjAd2JQoV7smNSyyfqi9rLXlkVl
	Lj+omLrnWrm2oi8LlK+1m1Zw5DWy8owiNrAYwnolBEaSxphj1P4itvC9Fb2uVzep7LtjrXJlBx4
	XXBUPNp4HGLTYb1kqxkOfhbfLjjJdzaTZAkxqMxDcxRUvkTXdKqcaSaWYpiOqRsqg81rgSQG3ci
	IwY69oM5NQBP0oZ0IniUaC4Yoww1wY3fKhDuPGZKO42Fq1Hv5PTRQj+y5EYoiIkedHBOcoT+7zL
	fqMWDzM9/txR1DSLQFoom1LIhuxE0IrI/VOQgr1EyZBIJFM4XYcmI4RumWDBaaiAjY/d5U+9O31
	nv0yeq7YmY78yB6EOb0IFj8R+VuMHQMc9bhU+sgod9eLDSwsdj7LHlDDgCYaLQqyecCb2yQ==
X-Received: by 2002:a17:907:8687:b0:c4c:f85f:aa2b with SMTP id
 a640c23a62f3a-c509641c620mr670977166b.24.1794801119103; Sun, 15 Nov 2026
 19:51:59 -0800 (PST)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1794666741.git.lianux.mm@gmail.com> <62dce3641b589e9cd42edccf0d4e9b31e7d91e36.1794666741.git.lianux.mm@gmail.com>
In-Reply-To: <62dce3641b589e9cd42edccf0d4e9b31e7d91e36.1794666741.git.lianux.mm@gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 16 Nov 2026 11:51:22 +0800
X-Gm-Features: AclHuK_Gbzghz_9r5pcBeCg-HWxSEX1oN3xYkrnwlrCQzsB1W6e7M40eujJdLuM
Message-ID: <CAMgjq7BnyM76DR8cdaz4o5PEg0=4rBAcGvWwoHqFDfPpoqu4BQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4 10/18] mm/swap: add priority queue for swap device allocation
To: Lian Wang <lianux.mm@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>, 
	Youngjun Park <youngjun.park@lge.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Jihan LIN <linjh22s@gmail.com>, Kunwu Chan <kunwu.chan@linux.dev>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Thomas Gleixner <tglx@kernel.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 14, 2026 at 10:51=E2=80=AFPM Lian Wang <lianux.mm@gmail.com> wr=
ote:
>
> From: Kairui Song <kasong@tencent.com>
>
> Swap device selection rotates swap_avail_head with plist_requeue(),
> serializing cluster transitions on swap_avail_lock. Separate selection
> from device-local cluster allocation with same-priority device rings
> ordered from highest priority to lowest.
>
> Keep membership and sizes stable under swapon_rwsem during each
> allocation walk. Full or disabled devices remain as masked pointers.
> Serialize tag writers with swap_queue_update_lock and use READ_ONCE()
> and WRITE_ONCE() for complete tagged-pointer accesses.
>
> Each CPU has a starting offset and base-page quota per ring. A task-local
> cursor snapshots its starting device so retries visit every peer once,
> even if another task changes the shared reader. Disable migration across
> the sleepable walk. Large folios retry same-priority peers before asking
> the caller to split instead of falling through after one fragmented
> device.
>
> Prepare reader storage with GFP_NOIO outside the topology writer, then
> recheck priority and required length before publication. Transfer the
> prepared storage only on successful installation; otherwise free it
> after unlocking. Keep per-CPU backing allocation outside the writer's
> noreclaim scope because it filters caller GFP flags. Constrain small
> queue/ring allocations with a scoped noreclaim context and
> __GFP_NOMEMALLOC, restoring context before cleanup. Deletion keeps reader
> storage until replacement or an empty queue, avoiding shrinking backing
> allocations beneath the writer.
>
> These boundaries prevent queue updates from reclaiming into a swap
> allocation that would acquire a reader behind the same writer. The
> cluster metadata fallback also avoids direct reclaim while the walk
> retains its outer reader. These recursive paths were identified by
> source inspection rather than reproduced hangs.
>
> Publish swap_file, the live reference, queue membership and SWP_WRITEOK
> under the same writer. Complete the disable flag and queue mask
> transition before releasing that writer, so a new allocation reader
> cannot select a device that is no longer writable.
>
> Mask the off-list flag from the old in-use counter before its full-device
> comparison so concurrent freeing/refilling keeps availability state
> consistent.
>
> Keep the old available plist in parallel while migrating its remaining
> consumers.
>
> Link: https://lore.kernel.org/20260714-swap-pcp-priq-v1-9-de9b164ed419@te=
ncent.com

Hmm, this patch is now quite different from what I posted in the link
above, e.g. there wasn't a "struct swap_queue_cursor", and some of the
naming in it is quite confusing:
e.g. "ring_only", I think what you actually want is "fallback_allowed"
or "no_fallback".

And since there are three iterator-like structs, we better reorganize
the naming; 'iterator' vs 'cursor' is confusing. e.g. maybe reame
swap_ring_iterator to swap_queue_reader_head.

And why do we need a "cursor->valid"? I see a following commit dropped
that, so perhaps accetable to keep it as intermediate step though.
