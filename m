Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795149439;
	b=joCjGhUvZ16HNYO4KDvZfR802FnwiFxu5iXvCrYMne97dnWtJy1DMrH/5L9kDicRqNWK
	 HHLYl5A8V/6hQAGCQqSi106n2hqvUY/MTRpu/XyUBwNa5nkGk4Alasrb6jWkuiCac3jhX
	 Toym/PfKXvia/xSBO71EXMWFoCRa4hAls6srCRqNmsJxe6SVHvNbyfMR/tXBdXPegIT7f
	 w3CDMGh9MqgVs4/l4Ko5Py3zQ8qqn2iuu1XZuixqobZ5MkrtaoFXfzR6PzzJnvkenIEMI
	 6mOnlzAWyW+KETzYzV615mtxKqJorkUIFtpNONorqzSdWEouLfKVotp5OocMZPoWSZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795149439;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:MIME-Version:Date:Content-Type:
	 Content-Transfer-Encoding:From:Message-ID:TLS-Required:Subject:To:Cc:
	 In-Reply-To:References;
	bh=wC9eJUz4DKLJpJ6vBDEqFE43JAvCeQg51GGXML5L67M=;
	b=rxQVc0maB5bCl6KBnZcHcpkWPdf5xWzHs7/P7VziIrblCLnNy7pdTQH4n9WlZsKIf83n
	 jdlKdIoluZpBwW0gWw9yTDTWAV0xM0LpKgTwJNTvy75Kgfn1xn0OzpbcHhxrcxAPEPZ1j
	 u9v4QDz3RjBcLMjbl+2pm4FNfVJc80/COFxl65FdnF+rIyxpEyRGXJcn1qByVhitw/gPH
	 L3eSQglx5wQ14TGlD1Jk29XVc2Q4pf93fGxdVPyUTuN92X+uSHK/xTdUjZa2JcCqlMdYE
	 aK2sqdEFIa1C37QsMwqvKdrW53MBZQqw1ox/MtAlej2hi4Dc/+zTdJ6eQTwTps5fp1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="m/FcdppI";
	arc=none smtp.remote-ip=95.215.58.62
Received: from mta1.migadu.com (out-62.mta1.migadu.com [95.215.58.62])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F15F606A320
	for <linux-hardening@vger.kernel.org>; Fri, 20 Nov 2026 04:37:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F15F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=m/FcdppI
X-Envelope-To: linux-hardening@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=zcFjEBIqj6cBYiwCe459AugAgTcvIrqKO3mRoQbcdtQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795149436; v=1; x=1795754236;
 b=m/FcdppIgHJYfuLm3Jz15SS48v1ECsydPsIwzykwvxsv7uWMy2hNOLPu29xj4bQ7ffnTZgw4
 UBEFF6PBVpWC50sOXx3+vAEXgueh73gIGzUqHz6KmFuqFB/R6826ht7kMXpbyK0v/h4WgY3rGV+
 YvflVYmruXWy+w3ZAXB+u2co=
X-Envelope-To: linux-hardening@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id eddd8fd8e6334fde;
	Fri, 20 Nov 2026 04:37:16 +0000
X-Mizu-Trace-ID: eddd8fd8e6334fde
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
Date: Fri, 20 Nov 2026 04:37:15 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Kunwu Chan" <kunwu.chan@linux.dev>
Message-ID: <c766c294502b5df1cf14e5941f79080a61f17bcf@linux.dev>
TLS-Required: No
Subject: Re: [RFC PATCH v4 13/18] mm/swap: drop swap active plist
To: "Lian Wang" <lianux.mm@gmail.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, "Andrew Morton"
 <akpm@linux-foundation.org>, "Chris Li" <chrisl@kernel.org>, "Nhat Pham"
 <nphamcs@gmail.com>, "Baoquan He" <baoquan.he@linux.dev>, "Barry Song"
 <baohua@kernel.org>, "Youngjun Park" <youngjun.park@lge.com>, "Kemeng
 Shi" <shikemeng@huaweicloud.com>, "Kairui Song" <kasong@tencent.com>,
 "Jihan LIN" <linjh22s@gmail.com>, "Kees Cook" <kees@kernel.org>, "Gustavo
 A. R. Silva" <gustavoars@kernel.org>, "Thomas Gleixner"
 <tglx@kernel.org>, linux-hardening@vger.kernel.org
In-Reply-To: <9ccd81f6f036eb1c3e50d396b44b5e43cff77d2a.1794666741.git.lianux.mm@gmail.com>
References: <cover.1794666741.git.lianux.mm@gmail.com>
 <9ccd81f6f036eb1c3e50d396b44b5e43cff77d2a.1794666741.git.lianux.mm@gmail.com>

Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>

Thanks,
Kunwu

>=20
>=20From: Kairui Song <kasong@tencent.com>
>=20
>=20Remove swap_active_head and the associated plist_node. Device identit=
y
> lookups can use the writable swap_info iterator without ordering.
>=20
>=20Keep priority ordering for the block-cgroup swap throttle target by
> walking the priority queue under the topology reader. Choose the first
> unmasked, writable, non-offlist device with a backing block device.
> Check OFFLIST as well as the pointer tag because full transitions can
> temporarily leave an unmasked entry, and keep the explicit WRITEOK
> check. The disable transition already publishes its mask before
> releasing the topology writer.
>=20
>=20This read-only lookup does not consume per-CPU allocation quotas or
> change retry cursors. It avoids making the throttle disk depend on
> swapon's swap-type assignment order when devices have different
> priorities.
>=20
>=20Signed-off-by: Kairui Song <kasong@tencent.com>
> Signed-off-by: Lian Wang <lianux.mm@gmail.com>
> ---
>  include/linux/swap.h | 1 -
>  mm/swapfile.c | 60 +++++++++++++++++++++++---------------------
>  2 files changed, 32 insertions(+), 29 deletions(-)
>=20
>=20diff --git a/include/linux/swap.h b/include/linux/swap.h
> index d31f3f023d36..ce8a800751ca 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -263,7 +263,6 @@ struct swap_info_struct {
>  struct percpu_ref users; /* indicate and keep swap device valid. */
>  unsigned long flags; /* SWP_USED etc: see above */
>  signed short prio; /* swap priority of this type */
> - struct plist_node list; /* entry in swap_active_head */
>  signed char type; /* strange name for an index */
>  unsigned int max; /* size of this swap device */
>  struct swap_cluster_info *cluster_info; /* array, one entry per cluste=
r */
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 6b2dbaf33cb6..bd098114ee4b 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -42,7 +42,6 @@
>  #include <linux/completion.h>
>  #include <linux/suspend.h>
>  #include <linux/zswap.h>
> -#include <linux/plist.h>
>=20=20
>=20 #include <asm/tlbflush.h>
>  #include <linux/leafops.h>
> @@ -91,12 +90,6 @@ bool swap_migration_ad_supported;
>  static const char Bad_file[] =3D "Bad swap file entry ";
>  static const char Bad_offset[] =3D "Bad swap offset entry ";
>=20=20
>=20-/*
> - * all active swap_info_structs
> - * protected with swapon_rwsem, and ordered by priority.
> - */
> -static PLIST_HEAD(swap_active_head);
> -
>  static inline struct swap_info_struct *__swap_iter(int *i, unsigned lo=
ng flag)
>  {
>  lockdep_assert_held(&swapon_rwsem);
> @@ -3535,7 +3528,6 @@ static void __swap_device_enable(struct swap_info=
_struct *si)
>  spin_unlock(&si->lock);
>  atomic_long_add(si->pages, &nr_swap_pages);
>  total_swap_pages +=3D si->pages;
> - plist_add(&si->list, &swap_active_head);
>  add_to_avail_list(si);
>  }
>=20=20
>=20@@ -3555,9 +3547,8 @@ static int swap_device_disable(struct address_s=
pace *mapping,
>  int err =3D -EINVAL;
>=20=20
>=20 percpu_down_write(&swapon_rwsem);
> - plist_for_each_entry(si, &swap_active_head, list) {
> - if ((si->flags & SWP_WRITEOK) &&
> - si->swap_file->f_mapping =3D=3D mapping) {
> + for_each_avail_swap(si) {
> + if (si->swap_file->f_mapping =3D=3D mapping) {
>  err =3D 0;
>  break;
>  }
> @@ -3583,8 +3574,6 @@ static int swap_device_disable(struct address_spa=
ce *mapping,
>  spin_lock(&si->lock);
>  del_from_avail_list(si, true);
>  spin_unlock(&si->lock);
> -
> - plist_del(&si->list, &swap_active_head);
>  total_swap_pages -=3D si->pages;
>  atomic_long_sub(si->pages, &nr_swap_pages);
>=20=20
>=20@@ -3913,7 +3902,6 @@ static struct swap_info_struct *alloc_swap_info=
(void)
>  */
>  }
>  p->swap_extent_root =3D RB_ROOT;
> - plist_node_init(&p->list, 0);
>  p->flags =3D SWP_USED;
>  percpu_up_write(&swapon_rwsem);
>  if (defer) {
> @@ -4323,12 +4311,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, spe=
cialfile, int, swap_flags)
>  if (swap_flags & SWAP_FLAG_PREFER)
>  prio =3D swap_flags & SWAP_FLAG_PRIO_MASK;
>=20=20
>=20- /*
> - * The plist prio is negated because plist ordering is
> - * low-to-high, while swap ordering is high-to-low
> - */
>  si->prio =3D prio;
> - si->list.prio =3D -si->prio;
>=20=20
>=20 /*
>  * Publish swap_file before making the percpu ref live, then add the de=
vice
> @@ -4454,7 +4437,33 @@ int swap_dup_entry_direct(swp_entry_t entry)
>  #if defined(CONFIG_MEMCG) && defined(CONFIG_BLK_CGROUP)
>  static bool __has_usable_swap(void)
>  {
> - return !plist_head_empty(&swap_active_head);
> + return READ_ONCE(total_swap_pages) > 0;
> +}
> +
> +static struct swap_info_struct *swap_queue_first_usable_bdev(void)
> +{
> + struct swap_prio_ring *ring;
> + struct swap_info_struct *si;
> + unsigned int ring_idx, dev_idx;
> +
> + lockdep_assert_held(&swapon_rwsem);
> + for (ring_idx =3D 0; ring_idx < swap_queue_len; ring_idx++) {
> + ring =3D swap_queue[ring_idx];
> + for (dev_idx =3D 0; dev_idx < ring->size; dev_idx++) {
> + si =3D READ_ONCE(ring->dev[dev_idx]);
> + if (swap_device_masked(si))
> + continue;
> + si =3D swap_device_unmask_ptr(si);
> + if (!(READ_ONCE(si->flags) & SWP_WRITEOK))
> + continue;
> + if (atomic_long_read(&si->inuse_pages) &
> + SWAP_USAGE_OFFLIST_BIT)
> + continue;
> + if (si->bdev)
> + return si;
> + }
> + }
> + return NULL;
>  }
>=20=20
>=20 void __folio_throttle_swaprate(struct folio *folio, gfp_t gfp)
> @@ -4478,14 +4487,9 @@ void __folio_throttle_swaprate(struct folio *fol=
io, gfp_t gfp)
>  return;
>=20=20
>=20 percpu_down_read(&swapon_rwsem);
> - plist_for_each_entry(si, &swap_active_head, list) {
> - if ((si->flags & SWP_WRITEOK) &&
> - !(atomic_long_read(&si->inuse_pages) &
> - SWAP_USAGE_OFFLIST_BIT) && si->bdev) {
> - blkcg_schedule_throttle(si->bdev->bd_disk, true);
> - break;
> - }
> - }
> + si =3D swap_queue_first_usable_bdev();
> + if (si)
> + blkcg_schedule_throttle(si->bdev->bd_disk, true);
>  percpu_up_read(&swapon_rwsem);
>  }
>  #endif
>
