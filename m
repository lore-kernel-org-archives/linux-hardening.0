Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795717671;
	b=FOSZueCL9D/RyzfKo7wP9qbb/hRoIunEWGBLr1EnOkIK8jQpxR7dsg4A7NmG24rYkJ2K
	 fbMGxqftl32EgGlW3FDH91R/xD8mhD5qhM7TEk6jFQx3RsGPMKg5VRmORulzAMkaw/3Nb
	 GNa3VTCm/NJpXa2t6wa1PBltWn75HBHtJrdNxoJNjghJb6IRp6wXiJZKUyuUjXMYBQynT
	 IbFsKOmDsLA06eI45wIWYajmZhelPkSKHOBeUPenWIs2kPyIZ7U+5XAClNR8ndHqkEjEg
	 AGD6Et/aEfG3yUU9MYF6wcBKMggfNTNYrbLtP5VKQWhiRjrzPFz8TRvXqEwRPaYuB6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795717671;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=5K4oceCXr/VXDTO4Y4qBl2iEPAqAOK0JNPL5oIiLS6M=;
	b=1aceNYPXEbVlGbgodhFjwJWMFmskbmbE/ET4h9uU+XjvXTjDJAL6dX3bakKpMKHnni+e
	 rqbafb6Cl3xJ68/8LLxy29Vf+kCQZAGV558XmPhsnb47ONYNwvfDpvm3KYntKMmzCqhbj
	 v74peShLU2eJNylV18PWYB8DkANYEP5R6HqbgjWILPgc8tqD1X5AI/9n7Ui9XS86mE4Ns
	 66P/k6HZvszLJv10NdbKQmfLhM22HSyDdRn6YDJ9tHh0sn2zB+n7utmzidNsYNjHmFjrR
	 akR1TLLGRoWruEjlBgYFvYP4Mr0HUUIOTnvWb4vHeL3qWleYL6ow3cVPzHcLNAi4iZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DTb2SEps;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C178606A323
	for <linux-hardening@vger.kernel.org>; Thu, 26 Nov 2026 18:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DTb2SEps
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F304B1F000E1
	for <linux-hardening@vger.kernel.org>; Thu, 26 Nov 2026 18:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795717671;
	bh=5K4oceCXr/VXDTO4Y4qBl2iEPAqAOK0JNPL5oIiLS6M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=DTb2SEpsG/OJgvnnqbLEI6eTJ3pSBQoNmAiiIrCU2HBdR66BZOzkZLW1xkvl6juvY
	 7qjj+cLa+otr/1W/qu1WztzntNd1kbCYncmCKm74YbrWo938qHO1oD+u7TihxE7kx8
	 BeMaIOZREUJrlC2vb1qHZ0p3rOGonS/gZVpQmJH9EousemwwYagOdjSgqKbLQM7+BP
	 s8C57Br+gl0ACAdfV9vzXoeP4mJkncVYL8axNTOCHoJapGQhYv9BY23owhyNl6lPm5
	 d16XFxd+F2yzjho9socaZAF4XVZvTLkXHGfmdhtK4ImNFQ15ak3JXRC2WaksdZYnr4
	 ucGCxWAineKcg==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c51c294cef6so112070966b.3
        for <linux-hardening@vger.kernel.org>; Thu, 26 Nov 2026 10:27:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHk7MGiiB1Qd5W1h5RusJsK++RWTZ1zQpQ/CsnYLjD2DMV8vlMp2fBqnELe6H1kb3H1nq5HePfnvosXkUsIsPg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/cxV57HuPKWNJzyJyLJQtHcdgTbikg0j8T5b9kwU5jLOztAeo8
	EKxG2TXDCi+L3WvWPzxEpe5HCwdfb+DrwwYBDNSoMrr6lEB4Wy9dg6AqrUdCTzJoRJB9WMnAUV7
	+dDy0JgQGm4YDOJcnd1Xvzz/ZIo6WpqOrZ4rVyk6Wqw==
X-Received: by 2002:a17:907:940a:b0:c29:5d41:dfe8 with SMTP id
 a640c23a62f3a-c513acbb4a8mr1802032666b.43.1795717669825; Thu, 26 Nov 2026
 10:27:49 -0800 (PST)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1795439990.git.lianux.mm@gmail.com> <21e7cb1a16aed56568fa400f5385acd36513aa46.1795439990.git.lianux.mm@gmail.com>
In-Reply-To: <21e7cb1a16aed56568fa400f5385acd36513aa46.1795439990.git.lianux.mm@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 26 Nov 2026 10:27:38 -0800
X-Gmail-Original-Message-ID: <CACePvbXsmTWf6GNXi6W7HabdskuGRO8gfUtVgzmr03+oi20itQ@mail.gmail.com>
X-Gm-Features: Aa3M54rUfkNKGj0MHFID9_rOhmYrB4UNx4i-cNC5HQDaUNLT2BJCrclHNYAVT2w
Message-ID: <CACePvbXsmTWf6GNXi6W7HabdskuGRO8gfUtVgzmr03+oi20itQ@mail.gmail.com>
Subject: Re: [PATCH v5 07/19] mm/swap: consolidate swap inuse accounting helpers
To: Lian Wang <lianux.mm@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>, 
	Youngjun Park <youngjun.park@lge.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Kairui Song <kasong@tencent.com>, Jihan LIN <linjh22s@gmail.com>, 
	Kunwu Chan <kunwu.chan@linux.dev>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Thomas Gleixner <tglx@kernel.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 6:17=E2=80=AFAM Lian Wang <lianux.mm@gmail.com> wro=
te:
>
> From: Kairui Song <kasong@tencent.com>
>
> Inline the swap_usage_add/sub helpers into their only callers and
> rename the callers to better reflect what they actually do: track
> per-device inuse page counts.
>
> Keep the existing accounting and allocation policy. In the inlined
> full-device path, reclaim work is scheduled before availability removal
> rather than afterwards. Slot-free notifications and zswap invalidation
> retain their existing order.

Can you confirm this patch has no behavioral change? It is only about
manual inline and rename functions. If so, add that to the commit
message. It can help the reviewer.

Any way, that is my read of the patch so far.

Chris

>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>
> Signed-off-by: Lian Wang <lianux.mm@gmail.com>
> ---
>  mm/swapfile.c | 64 ++++++++++++++++++++++-----------------------------
>  1 file changed, 27 insertions(+), 37 deletions(-)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 24f301ef4e3a..4fac894f8c2a 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -49,8 +49,8 @@
>  #include "internal.h"
>  #include "swap.h"
>
> -static void swap_range_alloc(struct swap_info_struct *si,
> -                            unsigned int nr_entries);
> +static void swap_device_inuse_add(struct swap_info_struct *si,
> +                                 unsigned int nr_entries);
>  static bool folio_swapcache_freeable(struct folio *folio);
>  static void move_cluster(struct swap_info_struct *si,
>                          struct swap_cluster_info *ci, struct list_head *=
list,
> @@ -1045,7 +1045,7 @@ static bool __swap_cluster_alloc_entries(struct swa=
p_info_struct *si,
>         if (cluster_is_empty(ci))
>                 ci->order =3D order;
>         ci->count +=3D nr_pages;
> -       swap_range_alloc(si, nr_pages);
> +       swap_device_inuse_add(si, nr_pages);
>
>         return true;
>  }
> @@ -1363,53 +1363,36 @@ static void add_to_avail_list(struct swap_info_st=
ruct *si)
>  }
>
>  /*
> - * swap_usage_add / swap_usage_sub of each slot are serialized by ci->lo=
ck
> - * within each cluster, so the total contribution to the global counter =
should
> - * always be positive and cannot exceed the total number of usable slots=
.
> + * swap_device_inuse_add / swap_device_inuse_sub are called within clust=
er
> + * update critical sections and serialized by ci->lock within each clust=
er,
> + * so the total contribution to the global counter should always be posi=
tive
> + * and cannot exceed the total number of usable slots.
>   */
> -static bool swap_usage_add(struct swap_info_struct *si, unsigned int nr_=
entries)
> +static void swap_device_inuse_add(struct swap_info_struct *si,
> +                                 unsigned int nr_entries)
>  {
> -       long val =3D atomic_long_add_return_relaxed(nr_entries, &si->inus=
e_pages);
> +       long inuse_pages;
>
>         /*
>          * If device is full, and SWAP_USAGE_OFFLIST_BIT is not set,
>          * remove it from the plist.
>          */
> -       if (unlikely(val =3D=3D si->pages)) {
> -               del_from_avail_list(si, false);
> -               return true;
> -       }
> -
> -       return false;
> -}
> -
> -static void swap_usage_sub(struct swap_info_struct *si, unsigned int nr_=
entries)
> -{
> -       long val =3D atomic_long_sub_return_relaxed(nr_entries, &si->inus=
e_pages);
> -
> -       /*
> -        * If device is not full, and SWAP_USAGE_OFFLIST_BIT is set,
> -        * add it to the plist.
> -        */
> -       if (unlikely(val & SWAP_USAGE_OFFLIST_BIT))
> -               add_to_avail_list(si);
> -}
> -
> -static void swap_range_alloc(struct swap_info_struct *si,
> -                            unsigned int nr_entries)
> -{
> -       if (swap_usage_add(si, nr_entries)) {
> +       inuse_pages =3D atomic_long_add_return_relaxed(nr_entries, &si->i=
nuse_pages);
> +       if (unlikely(inuse_pages =3D=3D si->pages)) {
>                 if (vm_swap_full())
>                         schedule_work(&si->reclaim_work);
> +               del_from_avail_list(si, false);
>         }
> +
>         atomic_long_sub(nr_entries, &nr_swap_pages);
>  }
>
> -static void swap_range_free(struct swap_info_struct *si, unsigned long o=
ffset,
> -                           unsigned int nr_entries)
> +static void swap_device_inuse_sub(struct swap_info_struct *si, unsigned =
long offset,
> +                                 unsigned int nr_entries)
>  {
>         unsigned long end =3D offset + nr_entries - 1;
>         void (*swap_slot_free_notify)(struct block_device *, unsigned lon=
g);
> +       long inuse_pages;
>
>         zswap_invalidate(si->type, offset, nr_entries);
>
> @@ -1431,7 +1414,14 @@ static void swap_range_free(struct swap_info_struc=
t *si, unsigned long offset,
>          */
>         smp_wmb();
>         atomic_long_add(nr_entries, &nr_swap_pages);
> -       swap_usage_sub(si, nr_entries);
> +
> +       /*
> +        * If device is not full, and SWAP_USAGE_OFFLIST_BIT is set,
> +        * add it back to the plist.
> +        */
> +       inuse_pages =3D atomic_long_sub_return_relaxed(nr_entries, &si->i=
nuse_pages);
> +       if (unlikely(inuse_pages & SWAP_USAGE_OFFLIST_BIT))
> +               add_to_avail_list(si);
>  }
>
>  static bool get_swap_device_info(struct swap_info_struct *si)
> @@ -2059,7 +2049,7 @@ void __swap_cluster_free_entries(struct swap_info_s=
truct *si,
>         if (batch_id)
>                 mem_cgroup_uncharge_swap(batch_id, ci_off - batch_off);
>
> -       swap_range_free(si, ci_head + ci_start, nr_pages);
> +       swap_device_inuse_sub(si, ci_head + ci_start, nr_pages);
>         swap_cluster_assert_empty(ci, ci_start, nr_pages, false);
>
>         if (!ci->count)
> @@ -2999,7 +2989,7 @@ static int try_to_unuse(unsigned int type)
>  success:
>         /*
>          * Make sure that further cleanups after try_to_unuse() returns h=
appen
> -        * after swap_range_free() reduces si->inuse_pages to 0.
> +        * after swap_device_inuse_sub() reduces si->inuse_pages to 0.
>          */
>         smp_mb();
>         return 0;
