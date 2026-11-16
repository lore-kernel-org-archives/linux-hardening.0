Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794799837;
	b=3rmIz9rWhiLKRdlCLjlPUFjj67++k5z0qwV3tRYnwzd5FlgKueI72e3HbNEKhfXrIO4M
	 UCwo0fUIciOIlziNwasBOULyP6gZSGknmxqfZoXz0wMSE2nuPD04L5i6MtMWDhevxKCFI
	 6aFg/Il4aUpim/olFwJTjAOlV2reaFgsErXVRTopPifwzTFaqbnObWWGSql6ltRXhRKMr
	 TszMtt1igHrVFNMZn5AhBQ4W/5vwHj3znGCz5AF41V6L9cCjJPmH0yB8IB2983aCW673X
	 QfQBuM+ODrfPXfmoJkFU5GtBShNf60djDr6dLIpgjS0uwrM7aOQCRwNMVWxccQhvF1A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794799837;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=EbvHpp+DKB9Zn3Fe95YeqAT/79gj7Jwj0DQknuaYym4=;
	b=m21rsVgNcGNE8o8zDfYeSoFiC7ZegkVSWStUdg7Rb8DNK85xTk9UolO8L+uOa1HGjVga
	 ljkNMJTHs8dclxWX9w0pNW8BnaDs8n4GUlrFH4IDLF1AZKW+upnIR0q/JgAJJOjyPIatG
	 fJhn68clQq1YZFmo2hJgE1kgG5jKzyMRQpSstU5TX2nyXX3nCF4bVLnQzwuDL73P9pgSe
	 H04B+TthUEcTA5VCGZMLCZ3O8aE7Ljhye8J4VBuuehh6WQ/MnnqeFnfbNNX9kl6hTc+RK
	 tPlPDyCNHbgVDDjxYiLQGlzcX2ybtVmTu4n3NFRz4OlFnARgxDf72JIFiDKAsu/j0BA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fY1BliL+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A2C606A32C
	for <linux-hardening@vger.kernel.org>; Mon, 16 Nov 2026 03:30:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2A2C606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fY1BliL+
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c4cdc606b47so513796366b.0
        for <linux-hardening@vger.kernel.org>; Sun, 15 Nov 2026 19:30:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794799835; cv=none;
        d=google.com; s=arc-20260327;
        b=ivb/Fj08IfwHdwNC+u/ZXOA/eZTw0k8ZLY6362Ba7EoTg/roliJ1dqPuf/qTbNlt5H
         sEJGeJXpAeGXWEpMxfKgEQiUfsWJH5NtJ73MP8KjxyAI4FQanaZ3NMiHod2SvFhnt5fB
         UiZULbcc0gDPLtIrB5W/gVrjvWzxkE2FEZooqdEatgTW/5mTutNjVU2FjzDDYDAou6fE
         F8BTxhSsyaEY5yls4uabhFjxPWBBTp5j5SzJes1vHbelorP3fvt6bbDqDCvKj0azKayF
         u+Ffhgwr5b3m/XJt4VXNNhESdx4k6kRce/S6UmhX3M0tfcFXiUcPjCQ+MTxVf/7zVXFu
         ce8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EbvHpp+DKB9Zn3Fe95YeqAT/79gj7Jwj0DQknuaYym4=;
        fh=ub+TYm7mpAFh8+SvkZnVNZO4k0Y/nkAIUTJrTQCY66M=;
        b=m3XSMD3m1Njt0X3U5P40g+SjhEVrrFLP3iFzLbgFGIE9H0IW7MOo2VRsP2lihoWMPl
         0l4XXiPSNDcwef6R082t63G71MYIqEvepy7kwp/ZXU0zCR0EPixxRlWTYu3wVyi4DUs8
         erXTHD8E+1GFzHZ0fIL4RkLak8HBaXDt6il2Gy5K/NgINvfw11YjS8bf2CpzEhwna8ml
         CoBlJEofAwasSepqqw5nntYGRo3D89rnvZIvX9rzfV3ls801+/qcRr45Y66T5OdgPRon
         56/KEdYamYvrznniH2C3HtdFlHoB69AsDuJWa/qZHmM4PvH/u6rPp2pbU7P4mdE6bW/P
         ujnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794799835; x=1795404635; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EbvHpp+DKB9Zn3Fe95YeqAT/79gj7Jwj0DQknuaYym4=;
        b=fY1BliL+9zdQv8nZG93UnuIRJP9g3H679zNhHC4NgeKVWInAENp2suO49I3jAkA8L3
         FXTOks3vWrDcjYzIzkNXRce4GaaNqE68ugazs+0cn/ijOr2h4JH1hr9oZ4Syek/qFKNY
         0ME32RZb8j9NExJJdycfEEwEE+/gOYvP3jHr84wnZvmGdg7AMR/HHYBHaS2m7USUTIDN
         TqrtT6tSAC7QOREjfQuQYWAn4kdH3E+NR8y+nCGsgxMEvE+nC4EHrhmzsQH8xZHzUtup
         TB6W9hWqpz0Dp/FT49c64jiCmFBkWOkMDhvh7I83h3U2uHvSXtchqE/ltHGf9YVVEyGj
         /29A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794799835; x=1795404635;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EbvHpp+DKB9Zn3Fe95YeqAT/79gj7Jwj0DQknuaYym4=;
        b=BIC4zq4/CfkVJikm4Bz8HkcdnVzZrLohgh0+CLRjLu+HZFnHJbgLG0IfOwith67PUl
         MjIdjRi98sWAUAdXTnJ5m6CRKX5oYsL74nm897XLBH2CqVPmwZbF3bzgLGzIknwUETBO
         d+9A5p29yaQK7+ixHq0dpnCbzUIrJs9Ij3HfWmpvP+IAVx4Sfsj+BNIaG+bbnVRvEfG4
         yngRAHK+eJeHRjsywdUCBy1P5cD9VN/AcWHwPatW4TCDCb1tQzbwgVjPtL4GB3TTG1dg
         3rfrk4xXWByt/Oq8A/ltxWzk3yUOsouPiWLNXS9CdNjJr8ILWxIu60wkUwD+Nwv4sSt9
         o8BA==
X-Forwarded-Encrypted: i=1; AL+hErGy3hPSuEB2x1DwfrmdcsD2ZvJkGACyYkkBaC29c88MEvrwLzb3M3iO8MT4oQGIpGz6x3dDV6a2py6iRnc496A=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ZNZPLmhT5nE3Ww2ST3GZQrmEHuonmvdbX9IUPb1xEzw/UaHrT
	OtixDW5K6MP7zTT43dK9E4w4qDHW67+3FZm1gKo2KmEIuAEbOfaBZbPsPeDAHpCqEarvAE+Ntie
	/h4B6D3oL7IrWtpWemsVPiwYiu9Vx1Dk=
X-Gm-Gg: AYBFou0Q4GC+UJsndQGNsDsnlxBmm1u51cWQqDN4wtejdmkRcpNaVA2MRWQabYp8pMr
	2VK0qMGvIjL2spIE+j4w5pYsRn7aW/R8I1xdi/dcJoTiMffxqJQrhqxpEnCvdJDktwBc1NFTIF8
	wfAnsmgE811YWEacggX6wPu5M/+fF2crx+Ollzexrcwgm2rEYQ31efhNaGD5ScQjbHlB/P3sD8+
	tUDlpoY38PnXK6ydLZgOLWx3dk6okuJ5TnOx1oT1jvZwgACRHnyGqiKDg1hgVj7PEXJWQl8xYeW
	O2lRs8sG3ZFA0TAk1/33oDd8rT4MKDwWXEXV/Bsngkmw6OGTQgSqSRCvI4cqmMs4MYy5am6Qisa
	Iw6DI1yJ9ARaNdkpRCLigvTdnEOLz7J8IopBp5OkQV6FM2sl9e3/y2Qy8hOK1eVtKXyGpqw==
X-Received: by 2002:a17:907:ea6:b0:c46:7ec3:fde7 with SMTP id
 a640c23a62f3a-c50963da4damr741558066b.31.1794799835006; Sun, 15 Nov 2026
 19:30:35 -0800 (PST)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1794666741.git.lianux.mm@gmail.com> <fbb87083afcc51fce533308d723edc55263bdf06.1794666741.git.lianux.mm@gmail.com>
In-Reply-To: <fbb87083afcc51fce533308d723edc55263bdf06.1794666741.git.lianux.mm@gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 16 Nov 2026 11:29:58 +0800
X-Gm-Features: AclHuK9SY3SoH2arw4UJU6ntA6zZEp479wBVJLO_t_nMFXkiHdyE_Stm0Vxwk-U
Message-ID: <CAMgjq7BE_i5FxYFrzSfnNsysBQ8UQzcULRo7AD985_1o27-jDg@mail.gmail.com>
Subject: Re: [RFC PATCH v4 18/18] mm/swap: redistribute queue readers after
 membership changes
To: Lian Wang <lianux.mm@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>, 
	Youngjun Park <youngjun.park@lge.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Jihan LIN <linjh22s@gmail.com>, Kunwu Chan <kunwu.chan@linux.dev>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Thomas Gleixner <tglx@kernel.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 14, 2026 at 10:53=E2=80=AFPM Lian Wang <lianux.mm@gmail.com> wr=
ote:
>
> Adding a device to an existing priority ring reuses the per-CPU reader
> storage. A ring that previously contained one device can therefore keep
> every CPU at the old common starting offset after peers are added.
> Deleting devices or rings can likewise leave offsets and quotas that
> describe the previous membership.
>
> Reset the valid per-CPU ring offsets and quotas after peer insertion and
> every nonempty deletion. Run the initialization helper under the topology
> writer, which excludes allocation walks, without allocating new reader
> storage or adding selector hot-path work.
>
> Use cpu-id modulo placement for a fresh best-effort rotation across all
> valid rings. This does not move existing slots or guarantee strict balanc=
e
> for every active CPU subset. Mask and availability transitions do not
> trigger the topology reset.
>
> Signed-off-by: Lian Wang <lianux.mm@gmail.com>
> ---
>  mm/swapfile.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 0c192844b121..eb2128132455 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -497,6 +497,7 @@ static int swap_queue_add(struct swap_info_struct *si=
,
>         spin_unlock(&swap_queue_update_lock);
>         memalloc_noreclaim_restore(noreclaim_flag);
>         kfree(old_ring);
> +       swap_queue_reset_readers();
>         return 0;
>
>  failed:
> @@ -569,6 +570,8 @@ static void swap_queue_del(struct swap_info_struct *s=
i)
>                         swap_queue_install_readers(NULL, 0);
>         }
>         spin_unlock(&swap_queue_update_lock);
> +       if (swap_queue_len)
> +               swap_queue_reset_readers();
>
>         kfree(old_ring);
>         kfree(old_queue);
>

Makes sense, thanks!

Reviewed-by: Kairui Song <kasong@tencent.com>
