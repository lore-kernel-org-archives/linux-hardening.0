Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795717738;
	b=b+az/GhAfn/uzfWFrXrfJWbuTnR2Q9AS9IvPT3FZjiGjzi8q5PztDt3+FUOOBqkeyvWe
	 Skg55GJCRdosDtTo1dmjgowe4cXX3i1QzhoWvGNTYESFDTksosmtWJ4aQSHIufHu0Q2Y9
	 CWg/sJ7369T54Coxemfcy9sXSDOzYwJxC0XCQ11b590Ve5sNC8wX2U2nyb5yQggcAib27
	 CoJ/RYm5Zx/3+5t3Jsisb3YuaOsrf+CycchhI3NvjoxavzdfmC+v0PfdPhJWNmxVX5jaY
	 IY7uSjZ2VAhHpk34kvnWzMbMdFGRHmqZ6TU7GaYOWF1dlRWGRhhQsxD8o8z9ZO92p/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795717738;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=fy4FeiswXzq1j88p/JhuFwnuTWoAZdPa04FxELFxjTc=;
	b=QgEmf8IwKNacxyxn4zmNPOFZbKx7c82RFmDGqM/RVqbuiBt8Z/CSDRDsUMBOb9BcU/vE
	 Xy8CTSr6S3rJJXaRAyzEHglJKQTJUp/LyzNWSVp9vbpNFnGz3W3gfm99bAd6NXtFFzRWA
	 PfQveqz1/3f+zg68Te4ql8ukgwNR9t/DsVrSecXacomQoGyQZuDFNh6AIVi1W/OvA8t1b
	 Ur2fBRClYqSYUNWRUf0b29Ybd+LolA/IGG1pOpCViSiWh5MbjoY3BP0aGyYKQiNzzlMGE
	 dobsOCHqls88FNbOj+fi8LQTzQqQbdWJr5arK1T5EAjWhx0SGSCpDP7dieQb2Rh5YQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WjDyojuP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA3D606A31E
	for <linux-hardening@vger.kernel.org>; Thu, 26 Nov 2026 18:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WjDyojuP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A261F000EB
	for <linux-hardening@vger.kernel.org>; Thu, 26 Nov 2026 18:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795717738;
	bh=fy4FeiswXzq1j88p/JhuFwnuTWoAZdPa04FxELFxjTc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=WjDyojuP5VEPHjvWyFVdHF5wPll5tmhutY0Kckkl8jUG5WOBSi4QIYYiV3YhwbRBZ
	 /0LS0uINU5zFt7YueJm3PyeyFaR6ShrFkkIkIO4tV1DvmwR2MtptJiIqB/9qfnhrXI
	 946W6D3AJ65QBefdpGSuZjtQ5jzrjukOUrE4ZN1hcuFbyXgR/pI9q7uTWYv7Ll3wkG
	 URoZILg8U6iNAI74mLKcEfzWqqVfoJSfOcH6mnADx1ozl8GoHOvuzDXLM+VWt3Biab
	 kqGbfY9l226DG09TeJSoaPQUIT9B87WYCN3nooygkEOo/A7jD97Vd9VjJm5mxL7Rbn
	 u7MvC/bsjlxMw==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c4d28f75d62so1195578466b.0
        for <linux-hardening@vger.kernel.org>; Thu, 26 Nov 2026 10:28:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEI61JI8Wl2aqMVv/q5EI2l7w0JCT3jzB4d5ASAIEfHNOCToWuacwqJAeVFu8IjgozyYgd8GEwu5DcbM30HSI0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9gZ9FeG/ZRtSSrKnABYxS1NHZCnnYqt0KPgDTuSupLjR+GNmha
	VvIg/62O7eqP0T8t6g/TmM3ckNrO6pBWYWhLXoDaLHPIUl+7gWl/qnF9zExbVruEm3bhpp71lAF
	zBZMKOyO1+2LcTCmyytEgcx2PzBTaB124cL/DFihm0w==
X-Received: by 2002:a17:907:6d03:b0:c35:d50a:1352 with SMTP id
 a640c23a62f3a-c513aace66bmr1729318866b.11.1795717736630; Thu, 26 Nov 2026
 10:28:56 -0800 (PST)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1795439990.git.lianux.mm@gmail.com> <8d0a8b9726974ec0dc73d2400f817c9ebe193c47.1795439990.git.lianux.mm@gmail.com>
In-Reply-To: <8d0a8b9726974ec0dc73d2400f817c9ebe193c47.1795439990.git.lianux.mm@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 26 Nov 2026 10:28:45 -0800
X-Gmail-Original-Message-ID: <CACePvbUtpY=KD8-yMAr4zxHdv7=R=k+y4jVrQ7B5OB8KTG92xw@mail.gmail.com>
X-Gm-Features: Aa3M54pnbXfhK_2XF1PS1gW7m0Ow150ilmyMUzY7xPAt9Q11UnmQ6aAm7jXckfQ
Message-ID: <CACePvbUtpY=KD8-yMAr4zxHdv7=R=k+y4jVrQ7B5OB8KTG92xw@mail.gmail.com>
Subject: Re: [PATCH v5 08/19] mm/swap: change back to use each swap device's
 percpu cluster
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

On Mon, Nov 23, 2026 at 6:18=E2=80=AFAM Lian Wang <lianux.mm@gmail.com> wro=
te:
>
> From: Youngjun Park <youngjun.park@lge.com>
>
> This reverts commit 1b7e90020eb7 ("mm, swap: use percpu cluster as
> allocation fast path").
>
> The global percpu cluster causes several issues:
>
> 1) It prevents efficient swap allocation for users that do not want
>    the default swap device policy.  Because the cluster cache sits
>    above device selection, users that need a different policy must
>    bypass or replace the cache. This complicates incoming ideas like
>    swap tiering.
>
> 2) It can bypass a caller's preferred device policy. Consider a future
>    policy with per-memcg device restrictions: memcg1 can access devices
>    A and B, where A has higher priority; memcg2 can only access B. Memcg2
>    can write the global percpu cluster with device B, then memcg1 takes B
>    in the fast path even though higher-priority device A is not exhausted=
.
>
> 3) The fast-path / slow-path design bundled with the global per-CPU
>    cache is problematic: only the fast path uses the global cache,
>    and the slow path is forced to rotate the allocation list.  This
>    complicates consumers like discard.
>
> Revert to per-device percpu clusters first.  A later patch will
> introduce new infrastructure for a high-performance global
> allocation path.
>
> Suggested-by: Kairui Song <kasong@tencent.com>
> Co-developed-by: Baoquan He <bhe@redhat.com>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Signed-off-by: Youngjun Park <youngjun.park@lge.com>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>
> Signed-off-by: Lian Wang <lianux.mm@gmail.com>

Acked-by: Chris Li <chrisl@kernel.org>

Chris

> ---
>  include/linux/swap.h |  13 +++-
>  mm/swapfile.c        | 170 ++++++++++++++-----------------------------
>  2 files changed, 63 insertions(+), 120 deletions(-)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 717387e16a2d..c8a5684b2f4f 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -241,10 +241,17 @@ enum {
>  #endif
>
>  /*
> - * We keep using same cluster for rotational device so IO will be sequen=
tial.
> - * The purpose is to optimize SWAP throughput on these device.
> + * We assign a cluster to each CPU, so each CPU can allocate swap entry =
from
> + * its own cluster and swapout sequentially. The purpose is to optimize =
swapout
> + * throughput.
>   */
> +struct percpu_cluster {
> +       local_lock_t lock; /* Protect the percpu_cluster above */
> +       unsigned int next[SWAP_NR_ORDERS]; /* Likely next allocation offs=
et */
> +};
> +
>  struct swap_sequential_cluster {
> +       spinlock_t lock; /* Serialize usage of global cluster */
>         unsigned int next[SWAP_NR_ORDERS]; /* Likely next allocation offs=
et */
>  };
>
> @@ -267,8 +274,8 @@ struct swap_info_struct {
>                                         /* list of cluster that are fragm=
ented or contented */
>         unsigned int pages;             /* total of usable pages of swap =
*/
>         atomic_long_t inuse_pages;      /* number of those currently in u=
se */
> +       struct percpu_cluster   __percpu *percpu_cluster; /* per cpu's sw=
ap location */
>         struct swap_sequential_cluster *global_cluster; /* Use one global=
 cluster for rotating device */
> -       spinlock_t global_cluster_lock; /* Serialize usage of global clus=
ter */
>         struct rb_root swap_extent_root;/* root of the swap extent rbtree=
 */
>         struct block_device *bdev;      /* swap device or bdev of swap fi=
le */
>         struct file *swap_file;         /* seldom referenced */
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 4fac894f8c2a..cd2cb360f274 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -145,18 +145,6 @@ static atomic_t proc_poll_event =3D ATOMIC_INIT(0);
>
>  atomic_t nr_rotate_swap =3D ATOMIC_INIT(0);
>
> -struct percpu_swap_cluster {
> -       struct swap_info_struct *si[SWAP_NR_ORDERS];
> -       unsigned long offset[SWAP_NR_ORDERS];
> -       local_lock_t lock;
> -};
> -
> -static DEFINE_PER_CPU(struct percpu_swap_cluster, percpu_swap_cluster) =
=3D {
> -       .si =3D { NULL },
> -       .offset =3D { SWAP_ENTRY_INVALID },
> -       .lock =3D INIT_LOCAL_LOCK(),
> -};
> -
>  /* May return NULL on invalid type, caller must check for NULL return */
>  static struct swap_info_struct *swap_type_to_info(int type)
>  {
> @@ -523,9 +511,10 @@ static int swap_cluster_alloc_table(struct swap_info=
_struct *si,
>  lock:
>         if (!locked) {
>                 if (si) {
> -                       local_lock(&percpu_swap_cluster.lock);
> -                       if (!(si->flags & SWP_SOLIDSTATE))
> -                               spin_lock(&si->global_cluster_lock);
> +                       if (si->flags & SWP_SOLIDSTATE)
> +                               local_lock(&si->percpu_cluster->lock);
> +                       else
> +                               spin_lock(&si->global_cluster->lock);
>                 }
>                 spin_lock(&ci->lock);
>         }
> @@ -610,9 +599,10 @@ swap_cluster_populate(struct swap_info_struct *si,
>          * Only cluster isolation from the allocator does table allocatio=
n.
>          * Swap allocator uses percpu clusters and holds the local lock.
>          */
> -       lockdep_assert_held(&this_cpu_ptr(&percpu_swap_cluster)->lock);
> -       if (!(si->flags & SWP_SOLIDSTATE))
> -               lockdep_assert_held(&si->global_cluster_lock);
> +       if (si->flags & SWP_SOLIDSTATE)
> +               lockdep_assert_held(this_cpu_ptr(&si->percpu_cluster->loc=
k));
> +       else
> +               lockdep_assert_held(&si->global_cluster->lock);
>         lockdep_assert_held(&ci->lock);
>
>         if (!swap_cluster_alloc_table(si, ci, __GFP_HIGH | __GFP_NOMEMALL=
OC |
> @@ -625,9 +615,10 @@ swap_cluster_populate(struct swap_info_struct *si,
>          * the potential recursive allocation is limited.
>          */
>         spin_unlock(&ci->lock);
> -       if (!(si->flags & SWP_SOLIDSTATE))
> -               spin_unlock(&si->global_cluster_lock);
> -       local_unlock(&percpu_swap_cluster.lock);
> +       if (si->flags & SWP_SOLIDSTATE)
> +               local_unlock(&si->percpu_cluster->lock);
> +       else
> +               spin_unlock(&si->global_cluster->lock);
>
>         ret =3D swap_cluster_alloc_table(si, ci, __GFP_HIGH | __GFP_NOMEM=
ALLOC |
>                                              GFP_KERNEL, false);
> @@ -749,7 +740,7 @@ static bool swap_do_scheduled_discard(struct swap_inf=
o_struct *si)
>                 ci =3D list_first_entry(&si->discard_clusters, struct swa=
p_cluster_info, list);
>                 /*
>                  * Delete the cluster from list to prepare for discard, b=
ut keep
> -                * the CLUSTER_FLAG_DISCARD flag, percpu_swap_cluster cou=
ld be
> +                * the CLUSTER_FLAG_DISCARD flag, there could be percpu_c=
luster
>                  * pointing to it, or ran into by relocate_cluster.
>                  */
>                 list_del(&ci->list);
> @@ -1104,12 +1095,10 @@ static unsigned int alloc_swap_scan_cluster(struc=
t swap_info_struct *si,
>  out:
>         relocate_cluster(si, ci);
>         swap_cluster_unlock(ci);
> -       if (si->flags & SWP_SOLIDSTATE) {
> -               this_cpu_write(percpu_swap_cluster.offset[order], next);
> -               this_cpu_write(percpu_swap_cluster.si[order], si);
> -       } else {
> +       if (si->flags & SWP_SOLIDSTATE)
> +               this_cpu_write(si->percpu_cluster->next[order], next);
> +       else
>                 si->global_cluster->next[order] =3D next;
> -       }
>         return found;
>  }
>
> @@ -1210,13 +1199,17 @@ static unsigned long cluster_alloc_swap_entry(str=
uct swap_info_struct *si,
>         if (order && !(si->flags & SWP_BLKDEV))
>                 return 0;
>
> -       if (!(si->flags & SWP_SOLIDSTATE)) {
> +       if (si->flags & SWP_SOLIDSTATE) {
> +               /* Fast path using per CPU cluster */
> +               local_lock(&si->percpu_cluster->lock);
> +               offset =3D __this_cpu_read(si->percpu_cluster->next[order=
]);
> +       } else {
>                 /* Serialize HDD SWAP allocation for each device. */
> -               spin_lock(&si->global_cluster_lock);
> +               spin_lock(&si->global_cluster->lock);
>                 offset =3D si->global_cluster->next[order];
> -               if (offset =3D=3D SWAP_ENTRY_INVALID)
> -                       goto new_cluster;
> +       }
>
> +       if (offset !=3D SWAP_ENTRY_INVALID) {
>                 ci =3D swap_cluster_lock(si, offset);
>                 /* Cluster could have been used by another order */
>                 if (cluster_is_usable(ci, order)) {
> @@ -1230,7 +1223,6 @@ static unsigned long cluster_alloc_swap_entry(struc=
t swap_info_struct *si,
>                         goto done;
>         }
>
> -new_cluster:
>         if (swap_prefer_free_cluster(si)) {
>                 found =3D alloc_swap_scan_list(si, &si->free_clusters, fo=
lio, false);
>                 if (found)
> @@ -1283,8 +1275,10 @@ static unsigned long cluster_alloc_swap_entry(stru=
ct swap_info_struct *si,
>                         goto done;
>         }
>  done:
> -       if (!(si->flags & SWP_SOLIDSTATE))
> -               spin_unlock(&si->global_cluster_lock);
> +       if (si->flags & SWP_SOLIDSTATE)
> +               local_unlock(&si->percpu_cluster->lock);
> +       else
> +               spin_unlock(&si->global_cluster->lock);
>
>         return found;
>  }
> @@ -1440,41 +1434,8 @@ static bool get_swap_device_info(struct swap_info_=
struct *si)
>         return true;
>  }
>
> -/*
> - * Fast path try to get swap entries with specified order from current
> - * CPU's swap entry pool (a cluster).
> - */
> -static bool swap_alloc_fast(struct folio *folio)
> -{
> -       unsigned int order =3D folio_order(folio);
> -       struct swap_cluster_info *ci;
> -       struct swap_info_struct *si;
> -       unsigned int offset;
> -
> -       /*
> -        * Once allocated, swap_info_struct will never be completely free=
d,
> -        * so checking it's liveness by get_swap_device_info is enough.
> -        */
> -       si =3D this_cpu_read(percpu_swap_cluster.si[order]);
> -       offset =3D this_cpu_read(percpu_swap_cluster.offset[order]);
> -       if (!si || !offset || !get_swap_device_info(si))
> -               return false;
> -
> -       ci =3D swap_cluster_lock(si, offset);
> -       if (cluster_is_usable(ci, order)) {
> -               if (cluster_is_empty(ci))
> -                       offset =3D cluster_offset(si, ci);
> -               alloc_swap_scan_cluster(si, ci, folio, offset);
> -       } else {
> -               swap_cluster_unlock(ci);
> -       }
> -
> -       put_swap_device(si);
> -       return folio_test_swapcache(folio);
> -}
> -
>  /* Rotate the device and switch to a new cluster */
> -static void swap_alloc_slow(struct folio *folio)
> +static void swap_alloc_entry(struct folio *folio)
>  {
>         struct swap_info_struct *si, *next;
>
> @@ -1842,10 +1803,7 @@ int folio_alloc_swap(struct folio *folio)
>         }
>
>  again:
> -       local_lock(&percpu_swap_cluster.lock);
> -       if (!swap_alloc_fast(folio))
> -               swap_alloc_slow(folio);
> -       local_unlock(&percpu_swap_cluster.lock);
> +       swap_alloc_entry(folio);
>
>         if (!order && unlikely(!folio_test_swapcache(folio))) {
>                 if (swap_sync_discard())
> @@ -2251,31 +2209,14 @@ void swap_put_entries_direct(swp_entry_t entry, i=
nt nr)
>   */
>  swp_entry_t swap_alloc_hibernation_slot(int type)
>  {
> -       struct swap_info_struct *pcp_si, *si =3D swap_type_to_info(type);
> -       unsigned long pcp_offset, offset =3D SWAP_ENTRY_INVALID;
> -       struct swap_cluster_info *ci;
> +       struct swap_info_struct *si =3D swap_type_to_info(type);
> +       unsigned long offset =3D SWAP_ENTRY_INVALID;
>         swp_entry_t entry =3D {0};
>
>         if (!si)
>                 goto fail;
>
> -       /*
> -        * Try the local cluster first if it matches the device. If
> -        * not, try grab a new cluster and override local cluster.
> -        */
> -       local_lock(&percpu_swap_cluster.lock);
> -       pcp_si =3D this_cpu_read(percpu_swap_cluster.si[0]);
> -       pcp_offset =3D this_cpu_read(percpu_swap_cluster.offset[0]);
> -       if (pcp_si =3D=3D si && pcp_offset) {
> -               ci =3D swap_cluster_lock(si, pcp_offset);
> -               if (cluster_is_usable(ci, 0))
> -                       offset =3D alloc_swap_scan_cluster(si, ci, NULL, =
pcp_offset);
> -               else
> -                       swap_cluster_unlock(ci);
> -       }
> -       if (!offset)
> -               offset =3D cluster_alloc_swap_entry(si, NULL);
> -       local_unlock(&percpu_swap_cluster.lock);
> +       offset =3D cluster_alloc_swap_entry(si, NULL);
>         if (offset)
>                 entry =3D swp_entry(si->type, offset);
>
> @@ -3253,27 +3194,6 @@ static void free_swap_cluster_info(struct swap_clu=
ster_info *cluster_info,
>         kvfree(cluster_info);
>  }
>
> -/*
> - * Called after swap device's reference count is dead, so
> - * neither scan nor allocation will use it.
> - */
> -static void flush_percpu_swap_cluster(struct swap_info_struct *si)
> -{
> -       int cpu, i;
> -       struct swap_info_struct **pcp_si;
> -
> -       for_each_possible_cpu(cpu) {
> -               pcp_si =3D per_cpu_ptr(percpu_swap_cluster.si, cpu);
> -               /*
> -                * Invalidate the percpu swap cluster cache, si->users
> -                * is dead, so no new user will point to it, just flush
> -                * any existing user.
> -                */
> -               for (i =3D 0; i < SWAP_NR_ORDERS; i++)
> -                       cmpxchg(&pcp_si[i], si, NULL);
> -       }
> -}
> -
>  SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
>  {
>         struct swap_info_struct *p =3D NULL;
> @@ -3325,7 +3245,6 @@ SYSCALL_DEFINE1(swapoff, const char __user *, speci=
alfile)
>
>         flush_work(&p->discard_work);
>         flush_work(&p->reclaim_work);
> -       flush_percpu_swap_cluster(p);
>
>         destroy_swap_extents(p, p->swap_file);
>
> @@ -3346,6 +3265,8 @@ SYSCALL_DEFINE1(swapoff, const char __user *, speci=
alfile)
>         percpu_up_write(&swapon_rwsem);
>         arch_swap_invalidate_area(p->type);
>         zswap_swapoff(p->type);
> +       free_percpu(p->percpu_cluster);
> +       p->percpu_cluster =3D NULL;
>         kfree(p->global_cluster);
>         p->global_cluster =3D NULL;
>         free_swap_cluster_info(cluster_info, maxpages);
> @@ -3690,7 +3611,7 @@ static int setup_swap_clusters_info(struct swap_inf=
o_struct *si,
>  {
>         unsigned long nr_clusters =3D DIV_ROUND_UP(maxpages, SWAPFILE_CLU=
STER);
>         struct swap_cluster_info *cluster_info;
> -       int err =3D -ENOMEM;
> +       int cpu, err =3D -ENOMEM;
>         unsigned long i;
>
>         cluster_info =3D kvzalloc_objs(*cluster_info, nr_clusters);
> @@ -3700,13 +3621,26 @@ static int setup_swap_clusters_info(struct swap_i=
nfo_struct *si,
>         for (i =3D 0; i < nr_clusters; i++)
>                 spin_lock_init(&cluster_info[i].lock);
>
> -       if (!(si->flags & SWP_SOLIDSTATE)) {
> +       if (si->flags & SWP_SOLIDSTATE) {
> +               si->percpu_cluster =3D alloc_percpu(struct percpu_cluster=
);
> +               if (!si->percpu_cluster)
> +                       goto err;
> +
> +               for_each_possible_cpu(cpu) {
> +                       struct percpu_cluster *cluster;
> +
> +                       cluster =3D per_cpu_ptr(si->percpu_cluster, cpu);
> +                       for (i =3D 0; i < SWAP_NR_ORDERS; i++)
> +                               cluster->next[i] =3D SWAP_ENTRY_INVALID;
> +                       local_lock_init(&cluster->lock);
> +               }
> +       } else {
>                 si->global_cluster =3D kmalloc_obj(*si->global_cluster);
>                 if (!si->global_cluster)
>                         goto err;
>                 for (i =3D 0; i < SWAP_NR_ORDERS; i++)
>                         si->global_cluster->next[i] =3D SWAP_ENTRY_INVALI=
D;
> -               spin_lock_init(&si->global_cluster_lock);
> +               spin_lock_init(&si->global_cluster->lock);
>         }
>
>         /*
> @@ -3980,6 +3914,8 @@ SYSCALL_DEFINE2(swapon, const char __user *, specia=
lfile, int, swap_flags)
>  bad_swap_unlock_inode:
>         inode_unlock(inode);
>  bad_swap:
> +       free_percpu(si->percpu_cluster);
> +       si->percpu_cluster =3D NULL;
>         kfree(si->global_cluster);
>         si->global_cluster =3D NULL;
>         inode =3D NULL;
