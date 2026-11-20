Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.214
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795149423;
	b=FS4VlpaHXsduajpCijtdEyA7mE+PGt5Yv4i8swBFvKLtcxJcrLGJrS6neITzt4EruILl
	 30Rw7QmzdzO+yP3hIfYz1o6FK6JqhHT4WG8aC1bKhtr3bjx972rEXLX2CXhBTAKF9IZv+
	 aQLZ/60eKwKiveIN+e7AzEHtRKz3cP2+/PXlR+aWOJg3jqvQkLsL1SDzXUgBcYx7Wc0NY
	 gSXu2OOujGiDShOljbo+FfMC8ojDQX44ZcrVMr5eMUNG9DxuaaS5Pf7BCFky8uMFsdIvK
	 ao2FhW/XpQ4gz1/RQif/LGDsWwZRp5RT5hUU9SwqTD8a3CJmnrWMAfx3b3VZBvBaIVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795149423;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:MIME-Version:Date:Content-Type:
	 Content-Transfer-Encoding:From:Message-ID:TLS-Required:Subject:To:Cc:
	 In-Reply-To:References;
	bh=rfDSktGXNX0ExFvAd5yZdX3whk4tn/u9y+EZTgvGoCQ=;
	b=c4Hyg0UILYpelt1K82xA3Ri76cef2u1/x6kzOX3km1vD92XyjD/F1DdWfCxsfZQ3HQTr
	 O2cVFpoj7Z0y4DbUeyMi67gatqMRQxgKMlowB/8JYTwaZlX1syX8BvOfwm+sgyDHzo1CR
	 MIuBBfXferfuJ240sgFjp9dw7eV6Rk6rbJkE2tGZ7elJjujl3Ov5GY0tKcnbr/fRi6IKQ
	 pk6yflD5MCAfI5Qk4mY8R+nTQmPkDbRsJbMiAtJodRzOLGhH7QTASYiRhwIuJzBnK+7t7
	 rUoLuhnVx/j2WBSvr8vucMOO+gmPOs0EHOfr/9+tKzJslYJqRSajDzrsdjCN5HbMZEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Yav2Kdfq;
	arc=none smtp.remote-ip=91.218.175.214
Received: from mta0.migadu.com (out-214.mta0.migadu.com [91.218.175.214])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C074606A326
	for <linux-hardening@vger.kernel.org>; Fri, 20 Nov 2026 04:37:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C074606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Yav2Kdfq
X-Envelope-To: linux-hardening@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=fl9Tf/YHT7hNcJzVDUQi+oYQfBidaYiMuvo42+SZZSQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795149420; v=1; x=1795754220;
 b=Yav2KdfqdpdaA/+3lRbz+p6+twizwnnh+BG0t1Il72vIHOMs4AEwETrEWY3vNqdHjH6d5xsr
 eIpASGdAMnqL85J6IdKPFhIm4sjp9thmsF2hvjU2K+jGHrdIWB6W2tkROpRQi/WMYp/ceMDYTdn
 jWurZQgCJyoJrLRhB/jefz/I=
X-Envelope-To: linux-hardening@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e2912f04c13bb6c8;
	Fri, 20 Nov 2026 04:37:00 +0000
X-Mizu-Trace-ID: e2912f04c13bb6c8
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
Date: Fri, 20 Nov 2026 04:36:59 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Kunwu Chan" <kunwu.chan@linux.dev>
Message-ID: <0eb4c100d6c422b2cfd3dae074a487560d8ea28c@linux.dev>
TLS-Required: No
Subject: Re: [RFC PATCH v4 12/18] mm/swap: bound synchronous discard outside
 the allocation reader
To: "Lian Wang" <lianux.mm@gmail.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, "Andrew Morton"
 <akpm@linux-foundation.org>, "Chris Li" <chrisl@kernel.org>, "Nhat Pham"
 <nphamcs@gmail.com>, "Baoquan He" <baoquan.he@linux.dev>, "Barry Song"
 <baohua@kernel.org>, "Youngjun Park" <youngjun.park@lge.com>, "Kemeng
 Shi" <shikemeng@huaweicloud.com>, "Kairui Song" <kasong@tencent.com>,
 "Jihan LIN" <linjh22s@gmail.com>, "Kees Cook" <kees@kernel.org>, "Gustavo
 A. R. Silva" <gustavoars@kernel.org>, "Thomas Gleixner"
 <tglx@kernel.org>, linux-hardening@vger.kernel.org
In-Reply-To: <19155551d5c520add74b25f8d50d22fb890e3fbb.1794666741.git.lianux.mm@gmail.com>
References: <cover.1794666741.git.lianux.mm@gmail.com>
 <19155551d5c520add74b25f8d50d22fb890e3fbb.1794666741.git.lianux.mm@gmail.com>

Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>

Thanks,
Kunwu

>=20
>=20From: Kairui Song <kasong@tencent.com>
>=20
>=20The synchronous discard fallback drains a list that freeing paths can
> keep replenishing. Limit each foreground step to one cluster, retaining
> CLUSTER_FLAG_DISCARD while I/O is in flight and returning the cluster t=
o
> the free list only after completion. The background worker continues to
> process the remaining list.
>=20
>=20Keep synchronous discard outside the topology reader. Enter this fall=
back
> only after a complete normal order-0 allocation walk fails. A higher-
> priority device with only pending discard work does not force synchrono=
us
> I/O if a lower-priority device satisfies that walk.
>=20
>=20Find a writable discard-capable device under the reader and take its =
live
> reference, then release the reader before issuing I/O. Drop the referen=
ce
> after completion and restart allocation with a fresh cursor, so a
> concurrent topology change cannot leave stale ring state. This also see=
s
> discard work produced by the preceding reclaim scans.
>=20
>=20Track the swap types already processed during this folio allocation a=
nd
> check each candidate at most once per fallback search. An empty check
> does not consume the I/O budget. Each swap type can complete at most on=
e
> synchronous cluster discard, bounding successful retries by MAX_SWAPFIL=
ES
> even if membership changes. Do not keep discarding until this task wins
> a free cluster from a peer.
>=20
>=20Large folios retain the existing same-priority retry and split bounda=
ry;
> their reader-held cluster walk does not issue synchronous discard. The
> budget bounds work count, not device I/O completion latency.
>=20
>=20Link: https://lore.kernel.org/all/CAMgjq7CsYhEjvtN85XGkrONYAJxve7gG59=
3TFeOGV-oax++kWA@mail.gmail.com/
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Co-developed-by: Lian Wang <lianux.mm@gmail.com>
> Signed-off-by: Lian Wang <lianux.mm@gmail.com>
> ---
>  mm/swapfile.c | 175 ++++++++++++++++++++++++++++----------------------
>  1 file changed, 100 insertions(+), 75 deletions(-)
>=20
>=20diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 5c5e449e9da3..6b2dbaf33cb6 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -6,6 +6,7 @@
>  * Swap reorganised 29.12.95, Stephen Tweedie
>  */
>=20=20
>=20+#include <linux/bitmap.h>
>  #include <linux/blkdev.h>
>  #include <linux/mm.h>
>  #include <linux/sched/mm.h>
> @@ -585,6 +586,26 @@ static long swap_usage_in_pages(struct swap_info_s=
truct *si)
>  return atomic_long_read(&si->inuse_pages) & SWAP_USAGE_COUNTER_MASK;
>  }
>=20=20
>=20+/*
> + * Serialize the allocation on single CPU or globally to avoid
> + * fragmentation and make the workflow easier to follow.
> + */
> +static void swap_alloc_lock_device(struct swap_info_struct *si)
> +{
> + if (si->flags & SWP_SOLIDSTATE)
> + local_lock(&si->percpu_cluster->lock);
> + else
> + spin_lock(&si->global_cluster->lock);
> +}
> +
> +static void swap_alloc_unlock_device(struct swap_info_struct *si)
> +{
> + if (si->flags & SWP_SOLIDSTATE)
> + local_unlock(&si->percpu_cluster->lock);
> + else
> + spin_unlock(&si->global_cluster->lock);
> +}
> +
>  /* Reclaim the swap entry anyway if possible */
>  #define TTRS_ANYWAY 0x1
>  /*
> @@ -916,12 +937,8 @@ static int swap_cluster_alloc_table(struct swap_in=
fo_struct *si,
>=20=20
>=20 lock:
>  if (!locked) {
> - if (si) {
> - if (si->flags & SWP_SOLIDSTATE)
> - local_lock(&si->percpu_cluster->lock);
> - else
> - spin_lock(&si->global_cluster->lock);
> - }
> + if (si)
> + swap_alloc_lock_device(si);
>  spin_lock(&ci->lock);
>  }
>  lockdep_assert_held(&ci->lock);
> @@ -1024,10 +1041,7 @@ swap_cluster_populate(struct swap_info_struct *s=
i,
>  * which could give allocator hooks and failure cleanup reserve access.
>  */
>  spin_unlock(&ci->lock);
> - if (si->flags & SWP_SOLIDSTATE)
> - local_unlock(&si->percpu_cluster->lock);
> - else
> - spin_unlock(&si->global_cluster->lock);
> + swap_alloc_unlock_device(si);
>=20=20
>=20 gfp =3D (GFP_KERNEL | __GFP_HIGH | __GFP_NOMEMALLOC) &
>  ~__GFP_DIRECT_RECLAIM;
> @@ -1134,44 +1148,40 @@ static struct swap_cluster_info *isolate_lock_c=
luster(
>  }
>=20=20
>=20 /*
> - * Doing discard actually. After a cluster discard is finished, the cl=
uster
> - * will be added to free cluster list. Discard cluster is a bit specia=
l as
> - * they don't participate in allocation or reclaim, so clusters marked=
 as
> - * CLUSTER_FLAG_DISCARD must remain off-list or on discard list.
> + * Discard one cluster. After the discard is finished, the cluster wil=
l be
> + * added to the free cluster list. Discard clusters are special becaus=
e they
> + * don't participate in allocation or reclaim, so CLUSTER_FLAG_DISCARD=
 must
> + * remain set while a cluster is either queued or being discarded.
>  */
> -static bool swap_do_scheduled_discard(struct swap_info_struct *si)
> +static bool swap_discard_one_cluster(struct swap_info_struct *si)
>  {
>  struct swap_cluster_info *ci;
> - bool ret =3D false;
>  unsigned int idx;
>=20=20
>=20 spin_lock(&si->lock);
> - while (!list_empty(&si->discard_clusters)) {
> - ci =3D list_first_entry(&si->discard_clusters, struct swap_cluster_in=
fo, list);
> - /*
> - * Delete the cluster from list to prepare for discard, but keep
> - * the CLUSTER_FLAG_DISCARD flag, there could be percpu_cluster
> - * pointing to it, or ran into by relocate_cluster.
> - */
> - list_del(&ci->list);
> - idx =3D cluster_index(si, ci);
> + if (list_empty(&si->discard_clusters)) {
>  spin_unlock(&si->lock);
> - discard_swap_cluster(si, idx * SWAPFILE_CLUSTER,
> - SWAPFILE_CLUSTER);
> -
> - spin_lock(&ci->lock);
> - /*
> - * Discard is done, clear its flags as it's off-list, then
> - * return the cluster to allocation list.
> - */
> - ci->flags =3D CLUSTER_FLAG_NONE;
> - __free_cluster(si, ci);
> - spin_unlock(&ci->lock);
> - ret =3D true;
> - spin_lock(&si->lock);
> + return false;
>  }
> +
> + ci =3D list_first_entry(&si->discard_clusters,
> + struct swap_cluster_info, list);
> + /*
> + * Delete the cluster from the list, but keep CLUSTER_FLAG_DISCARD
> + * set while the discard is in flight. A percpu cluster may still
> + * point to it, or relocate_cluster() may encounter it.
> + */
> + list_del(&ci->list);
> + idx =3D cluster_index(si, ci);
>  spin_unlock(&si->lock);
> - return ret;
> +
> + discard_swap_cluster(si, idx * SWAPFILE_CLUSTER, SWAPFILE_CLUSTER);
> +
> + spin_lock(&ci->lock);
> + ci->flags =3D CLUSTER_FLAG_NONE;
> + __free_cluster(si, ci);
> + spin_unlock(&ci->lock);
> + return true;
>  }
>=20=20
>=20 static void swap_discard_work(struct work_struct *work)
> @@ -1180,7 +1190,8 @@ static void swap_discard_work(struct work_struct =
*work)
>=20=20
>=20 si =3D container_of(work, struct swap_info_struct, discard_work);
>=20=20
>=20- swap_do_scheduled_discard(si);
> + while (swap_discard_one_cluster(si))
> + cond_resched();
>  }
>=20=20
>=20 static void swap_users_ref_free(struct percpu_ref *ref)
> @@ -1609,15 +1620,11 @@ static unsigned long cluster_alloc_swap_entry(s=
truct swap_info_struct *si,
>  if (order && !(si->flags & SWP_BLKDEV))
>  return 0;
>=20=20
>=20- if (si->flags & SWP_SOLIDSTATE) {
> - /* Fast path using per CPU cluster */
> - local_lock(&si->percpu_cluster->lock);
> + swap_alloc_lock_device(si);
> + if (si->flags & SWP_SOLIDSTATE)
>  offset =3D __this_cpu_read(si->percpu_cluster->next[order]);
> - } else {
> - /* Serialize HDD SWAP allocation for each device. */
> - spin_lock(&si->global_cluster->lock);
> + else
>  offset =3D si->global_cluster->next[order];
> - }
>=20=20
>=20 if (offset !=3D SWAP_ENTRY_INVALID) {
>  ci =3D swap_cluster_lock(si, offset);
> @@ -1685,10 +1692,7 @@ static unsigned long cluster_alloc_swap_entry(st=
ruct swap_info_struct *si,
>  goto done;
>  }
>  done:
> - if (si->flags & SWP_SOLIDSTATE)
> - local_unlock(&si->percpu_cluster->lock);
> - else
> - spin_unlock(&si->global_cluster->lock);
> + swap_alloc_unlock_device(si);
>=20=20
>=20 return found;
>  }
> @@ -1883,33 +1887,50 @@ static int swap_alloc_entry(struct folio *folio=
)
>  }
>=20=20
>=20 /*
> - * Discard pending clusters in a synchronized way when under high pres=
sure.
> - * Return: true if any cluster is discarded.
> + * Discard outside the topology reader, holding only the selected devi=
ce's
> + * live reference across I/O. Each successful retry starts a fresh que=
ue walk.
>  */
> -static bool swap_sync_discard(void)
> +static bool swap_discard_for_alloc(unsigned long *discarded)
>  {
> - bool ret =3D false;
> - struct swap_info_struct *si, *next;
> + DECLARE_BITMAP(checked, MAX_SWAPFILES) =3D {};
> + struct swap_info_struct *si, *candidate;
> + unsigned int i, j;
> + bool done;
> + int type;
>=20=20
>=20- percpu_down_read(&swapon_rwsem);
> -start_over:
> - plist_for_each_entry_safe(si, next, &swap_active_head, list) {
> - percpu_up_read(&swapon_rwsem);
> - if (get_swap_device_info(si)) {
> - if (si->flags & SWP_PAGE_DISCARD)
> - ret =3D swap_do_scheduled_discard(si);
> - put_swap_device(si);
> + for (;;) {
> + candidate =3D NULL;
> + percpu_down_read(&swapon_rwsem);
> + for (i =3D 0; i < swap_queue_len && !candidate; i++) {
> + struct swap_prio_ring *ring =3D swap_queue[i];
> +
> + for (j =3D 0; j < ring->size; j++) {
> + si =3D swap_device_unmask_ptr(READ_ONCE(ring->dev[j]));
> + type =3D si->type;
> + if (test_bit(type, discarded) || test_bit(type, checked))
> + continue;
> + __set_bit(type, checked);
> + if ((READ_ONCE(si->flags) & (SWP_WRITEOK | SWP_PAGE_DISCARD)) !=3D
> + (SWP_WRITEOK | SWP_PAGE_DISCARD))
> + continue;
> + if (get_swap_device_info(si)) {
> + candidate =3D si;
> + break;
> + }
> + }
>  }
> - if (ret)
> - return true;
> + percpu_up_read(&swapon_rwsem);
> + if (!candidate)
> + return false;
>=20=20
>=20- percpu_down_read(&swapon_rwsem);
> - if (plist_node_empty(&next->list))
> - goto start_over;
> + type =3D candidate->type;
> + done =3D swap_discard_one_cluster(candidate);
> + if (done)
> + __set_bit(type, discarded);
> + put_swap_device(candidate);
> + if (done)
> + return true;
>  }
> - percpu_up_read(&swapon_rwsem);
> -
> - return false;
>  }
>=20=20
>=20 static int swap_extend_table_alloc(struct swap_info_struct *si,
> @@ -2213,12 +2234,16 @@ int folio_alloc_swap(struct folio *folio)
>  }
>  }
>=20=20
>=20-again:
>  swap_alloc_entry(folio);
>=20=20
>=20 if (!order && unlikely(!folio_test_swapcache(folio))) {
> - if (swap_sync_discard())
> - goto again;
> + DECLARE_BITMAP(discarded, MAX_SWAPFILES) =3D {};
> +
> + while (swap_discard_for_alloc(discarded)) {
> + swap_alloc_entry(folio);
> + if (folio_test_swapcache(folio))
> + break;
> + }
>  }
>=20=20
>=20 /* Need to call this even if allocation failed, for MEMCG_SWAP_FAIL.=
 */
>
