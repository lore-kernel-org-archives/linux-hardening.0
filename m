Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795149082;
	b=zKx/C6xx3XcmW9Kh9srw6JOCWwBhXxwQQPa5+NTlnvqWmSwF0udeRP+qGzHYPIJDxSTo
	 fpGS84s+dOWs4BcVUOeEym5TE4YBSOaxNgitLRzV285qHdJMXgE3VHaqNHTSfCXo8nX0x
	 HXi4G13oplJ0y2g3/Xu3crna0t6NKgnTfe8/fXp2mmy7CTt44i+at31dcLdnztVtxFlwW
	 DaJUS6BR7ZJMsERhemrXzuoczQQkcUexiw0qmZBou5QRimKWi462sySu/LPeSfTKRpbab
	 njuucAfUAcsSwUz9wcAaeKQfxWon6IzeuzFXVB/IjElapeVtEsMhGpwAe9MujnICtUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795149082;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:MIME-Version:Date:Content-Type:
	 Content-Transfer-Encoding:From:Message-ID:TLS-Required:Subject:To:Cc:
	 In-Reply-To:References;
	bh=Nwhj8DMDx4+b2UKqJ68aK5dN6E//9Nil3bdxBsikFV0=;
	b=DYYNR5xSViscvitFpSQvQU6l2YRah1Ym+5TZjBwxIMv7ons/Rkjlcre/35oqhCIhTsqx
	 Xl8lJFg8eEO2OKeGapv2SiBsKUMEjnMfC52UaRG/AJtxZDPw/Kk/7vjbkcHvy963rxJeL
	 yjE5xzLW6+hZNvpuBgoxQXcAXC5sUzx07X6WjP/rliPiBRI7KZcPL8XrvHyi32saGr/i3
	 ktVCvbZrFASIsjrHiYeDCIOcpiSPmGodlc5NHZVNpHifImlsPP9uSY7sZgOil9QK/Tsvw
	 E28+ez/ywIhELWlo2yBWqpEUBJoenjYyRlcPj1HbtFpA23+yCAGGOFsmW8Ax3T84XXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=I4TBGmPy;
	arc=none smtp.remote-ip=95.215.58.13
Received: from mta1.migadu.com (out-13.mta1.migadu.com [95.215.58.13])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65B0606A320
	for <linux-hardening@vger.kernel.org>; Fri, 20 Nov 2026 04:31:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A65B0606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=I4TBGmPy
X-Envelope-To: linux-hardening@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=yfDOGbuzzCaGS5d0FjcMKMDjKwVJVnK1Aw37/lhp9NA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795149079; v=1; x=1795753879;
 b=I4TBGmPy38A2ZGWgqDGTSMWwqcF3fCcn2F8+ry4YPXgzPqDfmbd8+MEyWREyLaJ26/EXJqa+
 T7sJ+YXLx/tOWp/D9Izc97/1NADty5RtO6rQpVq96f+n5qkpTGSMfdo7/9uLSdoyPSEfsz6BKpM
 Epb/CWTfcfQKfmOhblhiSRwM=
X-Envelope-To: linux-hardening@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5fab9f52fe5d2e24;
	Fri, 20 Nov 2026 04:31:19 +0000
X-Mizu-Trace-ID: 5fab9f52fe5d2e24
X-Migadu-Flow: FLOW_OUT
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Fri, 20 Nov 2026 04:31:18 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Kunwu Chan" <kunwu.chan@linux.dev>
Message-ID: <7cacd2a09ef50b1480dee84d8a2f160f60e113ab@linux.dev>
TLS-Required: No
Subject: Re: [RFC PATCH v4 08/18] mm/swap: change back to use each swap
 device's percpu cluster
To: "Lian Wang" <lianux.mm@gmail.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, "Andrew Morton"
 <akpm@linux-foundation.org>, "Chris Li" <chrisl@kernel.org>, "Nhat Pham"
 <nphamcs@gmail.com>, "Baoquan He" <baoquan.he@linux.dev>, "Barry Song"
 <baohua@kernel.org>, "Youngjun Park" <youngjun.park@lge.com>, "Kemeng
 Shi" <shikemeng@huaweicloud.com>, "Kairui Song" <kasong@tencent.com>,
 "Jihan LIN" <linjh22s@gmail.com>, "Kees Cook" <kees@kernel.org>, "Gustavo
 A. R. Silva" <gustavoars@kernel.org>, "Thomas Gleixner"
 <tglx@kernel.org>, linux-hardening@vger.kernel.org
In-Reply-To: <f9cb4b2c57360c07bb1ff0d305e089635cb7e56e.1794666741.git.lianux.mm@gmail.com>
References: <cover.1794666741.git.lianux.mm@gmail.com>
 <f9cb4b2c57360c07bb1ff0d305e089635cb7e56e.1794666741.git.lianux.mm@gmail.com>

Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>

Thanks,
Kunwu


>=20
>=20From: Youngjun Park <youngjun.park@lge.com>
>=20
>=20This reverts commit 1b7e90020eb7 ("mm, swap: use percpu cluster as
> allocation fast path").
>=20
>=20The global percpu cluster causes several issues:
>=20
>=201) It prevents efficient swap allocation for users that do not want
>  the default swap device policy. Because the cluster cache sits
>  above device selection, users that need a different policy must
>  bypass or replace the cache. This complicates incoming ideas like
>  swap tiering.
>=20
>=202) It can bypass a caller's preferred device policy. Consider a futur=
e
>  policy with per-memcg device restrictions: memcg1 can access devices
>  A and B, where A has higher priority; memcg2 can only access B. Memcg2
>  can write the global percpu cluster with device B, then memcg1 takes B
>  in the fast path even though higher-priority device A is not exhausted=
.
>=20
>=203) The fast-path / slow-path design bundled with the global per-CPU
>  cache is problematic: only the fast path uses the global cache,
>  and the slow path is forced to rotate the allocation list. This
>  complicates consumers like discard.
>=20
>=20Revert to per-device percpu clusters first. A later patch will
> introduce new infrastructure for a high-performance global
> allocation path.
>=20
>=20Suggested-by: Kairui Song <kasong@tencent.com>
> Co-developed-by: Baoquan He <bhe@redhat.com>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Signed-off-by: Youngjun Park <youngjun.park@lge.com>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Signed-off-by: Lian Wang <lianux.mm@gmail.com>
> ---
>  include/linux/swap.h | 13 +++-
>  mm/swapfile.c | 170 ++++++++++++++-----------------------------
>  2 files changed, 63 insertions(+), 120 deletions(-)
>=20
>=20diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 717387e16a2d..c8a5684b2f4f 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -241,10 +241,17 @@ enum {
>  #endif
>=20=20
>=20 /*
> - * We keep using same cluster for rotational device so IO will be sequ=
ential.
> - * The purpose is to optimize SWAP throughput on these device.
> + * We assign a cluster to each CPU, so each CPU can allocate swap entr=
y from
> + * its own cluster and swapout sequentially. The purpose is to optimiz=
e swapout
> + * throughput.
>  */
> +struct percpu_cluster {
> + local_lock_t lock; /* Protect the percpu_cluster above */
> + unsigned int next[SWAP_NR_ORDERS]; /* Likely next allocation offset *=
/
> +};
> +
>  struct swap_sequential_cluster {
> + spinlock_t lock; /* Serialize usage of global cluster */
>  unsigned int next[SWAP_NR_ORDERS]; /* Likely next allocation offset */
>  };
>=20=20
>=20@@ -267,8 +274,8 @@ struct swap_info_struct {
>  /* list of cluster that are fragmented or contented */
>  unsigned int pages; /* total of usable pages of swap */
>  atomic_long_t inuse_pages; /* number of those currently in use */
> + struct percpu_cluster __percpu *percpu_cluster; /* per cpu's swap loc=
ation */
>  struct swap_sequential_cluster *global_cluster; /* Use one global clus=
ter for rotating device */
> - spinlock_t global_cluster_lock; /* Serialize usage of global cluster =
*/
>  struct rb_root swap_extent_root;/* root of the swap extent rbtree */
>  struct block_device *bdev; /* swap device or bdev of swap file */
>  struct file *swap_file; /* seldom referenced */
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index aa020f2706b4..c46b43414bf4 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -145,18 +145,6 @@ static atomic_t proc_poll_event =3D ATOMIC_INIT(0)=
;
>=20=20
>=20 atomic_t nr_rotate_swap =3D ATOMIC_INIT(0);
>=20=20
>=20-struct percpu_swap_cluster {
> - struct swap_info_struct *si[SWAP_NR_ORDERS];
> - unsigned long offset[SWAP_NR_ORDERS];
> - local_lock_t lock;
> -};
> -
> -static DEFINE_PER_CPU(struct percpu_swap_cluster, percpu_swap_cluster)=
 =3D {
> - .si =3D { NULL },
> - .offset =3D { SWAP_ENTRY_INVALID },
> - .lock =3D INIT_LOCAL_LOCK(),
> -};
> -
>  /* May return NULL on invalid type, caller must check for NULL return =
*/
>  static struct swap_info_struct *swap_type_to_info(int type)
>  {
> @@ -523,9 +511,10 @@ static int swap_cluster_alloc_table(struct swap_in=
fo_struct *si,
>  lock:
>  if (!locked) {
>  if (si) {
> - local_lock(&percpu_swap_cluster.lock);
> - if (!(si->flags & SWP_SOLIDSTATE))
> - spin_lock(&si->global_cluster_lock);
> + if (si->flags & SWP_SOLIDSTATE)
> + local_lock(&si->percpu_cluster->lock);
> + else
> + spin_lock(&si->global_cluster->lock);
>  }
>  spin_lock(&ci->lock);
>  }
> @@ -610,9 +599,10 @@ swap_cluster_populate(struct swap_info_struct *si,
>  * Only cluster isolation from the allocator does table allocation.
>  * Swap allocator uses percpu clusters and holds the local lock.
>  */
> - lockdep_assert_held(&this_cpu_ptr(&percpu_swap_cluster)->lock);
> - if (!(si->flags & SWP_SOLIDSTATE))
> - lockdep_assert_held(&si->global_cluster_lock);
> + if (si->flags & SWP_SOLIDSTATE)
> + lockdep_assert_held(this_cpu_ptr(&si->percpu_cluster->lock));
> + else
> + lockdep_assert_held(&si->global_cluster->lock);
>  lockdep_assert_held(&ci->lock);
>=20=20
>=20 if (!swap_cluster_alloc_table(si, ci, __GFP_HIGH | __GFP_NOMEMALLOC =
|
> @@ -625,9 +615,10 @@ swap_cluster_populate(struct swap_info_struct *si,
>  * the potential recursive allocation is limited.
>  */
>  spin_unlock(&ci->lock);
> - if (!(si->flags & SWP_SOLIDSTATE))
> - spin_unlock(&si->global_cluster_lock);
> - local_unlock(&percpu_swap_cluster.lock);
> + if (si->flags & SWP_SOLIDSTATE)
> + local_unlock(&si->percpu_cluster->lock);
> + else
> + spin_unlock(&si->global_cluster->lock);
>=20=20
>=20 ret =3D swap_cluster_alloc_table(si, ci, __GFP_HIGH | __GFP_NOMEMALL=
OC |
>  GFP_KERNEL, false);
> @@ -749,7 +740,7 @@ static bool swap_do_scheduled_discard(struct swap_i=
nfo_struct *si)
>  ci =3D list_first_entry(&si->discard_clusters, struct swap_cluster_inf=
o, list);
>  /*
>  * Delete the cluster from list to prepare for discard, but keep
> - * the CLUSTER_FLAG_DISCARD flag, percpu_swap_cluster could be
> + * the CLUSTER_FLAG_DISCARD flag, there could be percpu_cluster
>  * pointing to it, or ran into by relocate_cluster.
>  */
>  list_del(&ci->list);
> @@ -1104,12 +1095,10 @@ static unsigned int alloc_swap_scan_cluster(str=
uct swap_info_struct *si,
>  out:
>  relocate_cluster(si, ci);
>  swap_cluster_unlock(ci);
> - if (si->flags & SWP_SOLIDSTATE) {
> - this_cpu_write(percpu_swap_cluster.offset[order], next);
> - this_cpu_write(percpu_swap_cluster.si[order], si);
> - } else {
> + if (si->flags & SWP_SOLIDSTATE)
> + this_cpu_write(si->percpu_cluster->next[order], next);
> + else
>  si->global_cluster->next[order] =3D next;
> - }
>  return found;
>  }
>=20=20
>=20@@ -1210,13 +1199,17 @@ static unsigned long cluster_alloc_swap_entry=
(struct swap_info_struct *si,
>  if (order && !(si->flags & SWP_BLKDEV))
>  return 0;
>=20=20
>=20- if (!(si->flags & SWP_SOLIDSTATE)) {
> + if (si->flags & SWP_SOLIDSTATE) {
> + /* Fast path using per CPU cluster */
> + local_lock(&si->percpu_cluster->lock);
> + offset =3D __this_cpu_read(si->percpu_cluster->next[order]);
> + } else {
>  /* Serialize HDD SWAP allocation for each device. */
> - spin_lock(&si->global_cluster_lock);
> + spin_lock(&si->global_cluster->lock);
>  offset =3D si->global_cluster->next[order];
> - if (offset =3D=3D SWAP_ENTRY_INVALID)
> - goto new_cluster;
> + }
>=20=20
>=20+ if (offset !=3D SWAP_ENTRY_INVALID) {
>  ci =3D swap_cluster_lock(si, offset);
>  /* Cluster could have been used by another order */
>  if (cluster_is_usable(ci, order)) {
> @@ -1230,7 +1223,6 @@ static unsigned long cluster_alloc_swap_entry(str=
uct swap_info_struct *si,
>  goto done;
>  }
>=20=20
>=20-new_cluster:
>  if (swap_prefer_free_cluster(si)) {
>  found =3D alloc_swap_scan_list(si, &si->free_clusters, folio, false);
>  if (found)
> @@ -1283,8 +1275,10 @@ static unsigned long cluster_alloc_swap_entry(st=
ruct swap_info_struct *si,
>  goto done;
>  }
>  done:
> - if (!(si->flags & SWP_SOLIDSTATE))
> - spin_unlock(&si->global_cluster_lock);
> + if (si->flags & SWP_SOLIDSTATE)
> + local_unlock(&si->percpu_cluster->lock);
> + else
> + spin_unlock(&si->global_cluster->lock);
>=20=20
>=20 return found;
>  }
> @@ -1440,41 +1434,8 @@ static bool get_swap_device_info(struct swap_inf=
o_struct *si)
>  return true;
>  }
>=20=20
>=20-/*
> - * Fast path try to get swap entries with specified order from current
> - * CPU's swap entry pool (a cluster).
> - */
> -static bool swap_alloc_fast(struct folio *folio)
> -{
> - unsigned int order =3D folio_order(folio);
> - struct swap_cluster_info *ci;
> - struct swap_info_struct *si;
> - unsigned int offset;
> -
> - /*
> - * Once allocated, swap_info_struct will never be completely freed,
> - * so checking it's liveness by get_swap_device_info is enough.
> - */
> - si =3D this_cpu_read(percpu_swap_cluster.si[order]);
> - offset =3D this_cpu_read(percpu_swap_cluster.offset[order]);
> - if (!si || !offset || !get_swap_device_info(si))
> - return false;
> -
> - ci =3D swap_cluster_lock(si, offset);
> - if (cluster_is_usable(ci, order)) {
> - if (cluster_is_empty(ci))
> - offset =3D cluster_offset(si, ci);
> - alloc_swap_scan_cluster(si, ci, folio, offset);
> - } else {
> - swap_cluster_unlock(ci);
> - }
> -
> - put_swap_device(si);
> - return folio_test_swapcache(folio);
> -}
> -
>  /* Rotate the device and switch to a new cluster */
> -static void swap_alloc_slow(struct folio *folio)
> +static void swap_alloc_entry(struct folio *folio)
>  {
>  struct swap_info_struct *si, *next;
>=20=20
>=20@@ -1842,10 +1803,7 @@ int folio_alloc_swap(struct folio *folio)
>  }
>=20=20
>=20 again:
> - local_lock(&percpu_swap_cluster.lock);
> - if (!swap_alloc_fast(folio))
> - swap_alloc_slow(folio);
> - local_unlock(&percpu_swap_cluster.lock);
> + swap_alloc_entry(folio);
>=20=20
>=20 if (!order && unlikely(!folio_test_swapcache(folio))) {
>  if (swap_sync_discard())
> @@ -2251,31 +2209,14 @@ void swap_put_entries_direct(swp_entry_t entry,=
 int nr)
>  */
>  swp_entry_t swap_alloc_hibernation_slot(int type)
>  {
> - struct swap_info_struct *pcp_si, *si =3D swap_type_to_info(type);
> - unsigned long pcp_offset, offset =3D SWAP_ENTRY_INVALID;
> - struct swap_cluster_info *ci;
> + struct swap_info_struct *si =3D swap_type_to_info(type);
> + unsigned long offset =3D SWAP_ENTRY_INVALID;
>  swp_entry_t entry =3D {0};
>=20=20
>=20 if (!si)
>  goto fail;
>=20=20
>=20- /*
> - * Try the local cluster first if it matches the device. If
> - * not, try grab a new cluster and override local cluster.
> - */
> - local_lock(&percpu_swap_cluster.lock);
> - pcp_si =3D this_cpu_read(percpu_swap_cluster.si[0]);
> - pcp_offset =3D this_cpu_read(percpu_swap_cluster.offset[0]);
> - if (pcp_si =3D=3D si && pcp_offset) {
> - ci =3D swap_cluster_lock(si, pcp_offset);
> - if (cluster_is_usable(ci, 0))
> - offset =3D alloc_swap_scan_cluster(si, ci, NULL, pcp_offset);
> - else
> - swap_cluster_unlock(ci);
> - }
> - if (!offset)
> - offset =3D cluster_alloc_swap_entry(si, NULL);
> - local_unlock(&percpu_swap_cluster.lock);
> + offset =3D cluster_alloc_swap_entry(si, NULL);
>  if (offset)
>  entry =3D swp_entry(si->type, offset);
>=20=20
>=20@@ -3253,27 +3194,6 @@ static void free_swap_cluster_info(struct swap=
_cluster_info *cluster_info,
>  kvfree(cluster_info);
>  }
>=20=20
>=20-/*
> - * Called after swap device's reference count is dead, so
> - * neither scan nor allocation will use it.
> - */
> -static void flush_percpu_swap_cluster(struct swap_info_struct *si)
> -{
> - int cpu, i;
> - struct swap_info_struct **pcp_si;
> -
> - for_each_possible_cpu(cpu) {
> - pcp_si =3D per_cpu_ptr(percpu_swap_cluster.si, cpu);
> - /*
> - * Invalidate the percpu swap cluster cache, si->users
> - * is dead, so no new user will point to it, just flush
> - * any existing user.
> - */
> - for (i =3D 0; i < SWAP_NR_ORDERS; i++)
> - cmpxchg(&pcp_si[i], si, NULL);
> - }
> -}
> -
>  SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
>  {
>  struct swap_info_struct *p =3D NULL;
> @@ -3325,7 +3245,6 @@ SYSCALL_DEFINE1(swapoff, const char __user *, spe=
cialfile)
>=20=20
>=20 flush_work(&p->discard_work);
>  flush_work(&p->reclaim_work);
> - flush_percpu_swap_cluster(p);
>=20=20
>=20 destroy_swap_extents(p, p->swap_file);
>=20=20
>=20@@ -3346,6 +3265,8 @@ SYSCALL_DEFINE1(swapoff, const char __user *, s=
pecialfile)
>  percpu_up_write(&swapon_rwsem);
>  arch_swap_invalidate_area(p->type);
>  zswap_swapoff(p->type);
> + free_percpu(p->percpu_cluster);
> + p->percpu_cluster =3D NULL;
>  kfree(p->global_cluster);
>  p->global_cluster =3D NULL;
>  free_swap_cluster_info(cluster_info, maxpages);
> @@ -3694,7 +3615,7 @@ static int setup_swap_clusters_info(struct swap_i=
nfo_struct *si,
>  {
>  unsigned long nr_clusters =3D DIV_ROUND_UP(maxpages, SWAPFILE_CLUSTER)=
;
>  struct swap_cluster_info *cluster_info;
> - int err =3D -ENOMEM;
> + int cpu, err =3D -ENOMEM;
>  unsigned long i;
>=20=20
>=20 cluster_info =3D kvzalloc_objs(*cluster_info, nr_clusters);
> @@ -3704,13 +3625,26 @@ static int setup_swap_clusters_info(struct swap=
_info_struct *si,
>  for (i =3D 0; i < nr_clusters; i++)
>  spin_lock_init(&cluster_info[i].lock);
>=20=20
>=20- if (!(si->flags & SWP_SOLIDSTATE)) {
> + if (si->flags & SWP_SOLIDSTATE) {
> + si->percpu_cluster =3D alloc_percpu(struct percpu_cluster);
> + if (!si->percpu_cluster)
> + goto err;
> +
> + for_each_possible_cpu(cpu) {
> + struct percpu_cluster *cluster;
> +
> + cluster =3D per_cpu_ptr(si->percpu_cluster, cpu);
> + for (i =3D 0; i < SWAP_NR_ORDERS; i++)
> + cluster->next[i] =3D SWAP_ENTRY_INVALID;
> + local_lock_init(&cluster->lock);
> + }
> + } else {
>  si->global_cluster =3D kmalloc_obj(*si->global_cluster);
>  if (!si->global_cluster)
>  goto err;
>  for (i =3D 0; i < SWAP_NR_ORDERS; i++)
>  si->global_cluster->next[i] =3D SWAP_ENTRY_INVALID;
> - spin_lock_init(&si->global_cluster_lock);
> + spin_lock_init(&si->global_cluster->lock);
>  }
>=20=20
>=20 /*
> @@ -3984,6 +3918,8 @@ SYSCALL_DEFINE2(swapon, const char __user *, spec=
ialfile, int, swap_flags)
>  bad_swap_unlock_inode:
>  inode_unlock(inode);
>  bad_swap:
> + free_percpu(si->percpu_cluster);
> + si->percpu_cluster =3D NULL;
>  kfree(si->global_cluster);
>  si->global_cluster =3D NULL;
>  inode =3D NULL;
>
