Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795147954;
	b=wNysN5UIhDDQtego1qqiKd/GnbJlqL/9hHuqfwQqd0bwmYaZZ/Y+xlfcRyRIVHth/XUp
	 iyxzMDuPxo8YaBNwLYWdHp5rMI784WKe0ZHB5CmZdl93EdbrckS+Kd+T/XlSj7l5axGrp
	 Rx6YphID/2rHbRzdy58GQZZ23/pB/xOoln1AKgk95sq33HWDahtXLNqd4of+1sDecQlBW
	 C73AVrbVdOLORUO+u3DwyNhiLVVKJMzBhoBIew2NTUkKmzVHCeiZIWnkjlCe2EiEOw0S4
	 gTSe8rJDghD8Ol+4w9iGVgXZtRj9Hx4PU5agsYjMrQxCswQKN07QS9BypX2WOGXuB0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795147954;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:MIME-Version:Date:Content-Type:
	 Content-Transfer-Encoding:From:Message-ID:TLS-Required:Subject:To:Cc:
	 In-Reply-To:References;
	bh=IvU71sGuAAFYQZAClBQAvkz0zOXDzjMW0FPgKLZF3qI=;
	b=ZvQVn/Yz0D8zC8p8ufzrMH7rIsxMdwRtejmYuaYvjMiOIaVRpvtsKTH2faD8ZRpPWlDw
	 qQjGKFYKKllu3HPyL0MHcHYGAkbMy82Ul1SRrVdCTwyiqCZc4n+xaWxpvIC9yaNtFmfGP
	 ld2oClGIm6+Ftt+pVPalstBwN371nVUm4zy6FjErNKTn1UG2iprGRvPzGP76VqSxnA59s
	 l+gGyEfTw3YMObPr+MZE50Aj7G2zwSm4USPjvUhIEXHK7iNgju8Yaqx/8SqQ5PhFwe3lU
	 XRNYCXsloTHoGeUuiGz5LItcwVWe6/k+Bw6Gs3V41hzLOkTrgK8trp2ogg+3YBRiouw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=OHKZBPXe;
	arc=none smtp.remote-ip=91.218.175.50
Received: from mta0.migadu.com (out-50.mta0.migadu.com [91.218.175.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51DB606A325
	for <linux-hardening@vger.kernel.org>; Fri, 20 Nov 2026 04:12:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C51DB606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=OHKZBPXe
X-Envelope-To: linux-hardening@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=vwY4c5GNdbzU6cmKo5Vu3d2wqUEIhEoaPbVtcsDAeu4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795147951; v=1; x=1795752751;
 b=OHKZBPXeBBkdlrRDAhuhvcSEnS7gdddvuIgA69z73TtvPgAZzt4qubb08UFScbQFxBrNi7pa
 z2zeeKQ1Vak9Ay0Pl1iq+3YSVPQ24zR8tCou6t6IMjxScd5+Kq13vRZAinGkjT4xcAAyZglpOd2
 FE9ztlHpTioOw/j1r+Jd2daY=
X-Envelope-To: linux-hardening@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 87e7d6807f6d2431;
	Fri, 20 Nov 2026 04:12:31 +0000
X-Mizu-Trace-ID: 87e7d6807f6d2431
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
Date: Fri, 20 Nov 2026 04:12:30 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Kunwu Chan" <kunwu.chan@linux.dev>
Message-ID: <4f98fc9098d6a674f279ed2325f3426f01172b04@linux.dev>
TLS-Required: No
Subject: Re: [RFC PATCH v4 05/18] mm/swap: change the swapon lock into a
 percpu rwsem
To: "Lian Wang" <lianux.mm@gmail.com>, linux-mm@kvack.org,
 Kunwu.chan@gmail.com
Cc: linux-kernel@vger.kernel.org, "Andrew Morton"
 <akpm@linux-foundation.org>, "Chris Li" <chrisl@kernel.org>, "Nhat Pham"
 <nphamcs@gmail.com>, "Baoquan He" <baoquan.he@linux.dev>, "Barry Song"
 <baohua@kernel.org>, "Youngjun Park" <youngjun.park@lge.com>, "Kemeng
 Shi" <shikemeng@huaweicloud.com>, "Kairui Song" <kasong@tencent.com>,
 "Jihan LIN" <linjh22s@gmail.com>, "Kees Cook" <kees@kernel.org>, "Gustavo
 A. R. Silva" <gustavoars@kernel.org>, "Thomas Gleixner"
 <tglx@kernel.org>, linux-hardening@vger.kernel.org
In-Reply-To: <97d49d0477b3bde77936d734ae377fb19efda357.1794666741.git.lianux.mm@gmail.com>
References: <cover.1794666741.git.lianux.mm@gmail.com>
 <97d49d0477b3bde77936d734ae377fb19efda357.1794666741.git.lianux.mm@gmail.com>

>=20
>=20From: Kairui Song <kasong@tencent.com>
>=20
>=20Reading swap metadata is a common hot path, while swapon and swapoff
> are costly and rare. Convert swap_lock from a spinlock to the
> swapon_rwsem percpu rwsem so metadata readers can run concurrently.
> Writers still serialize topology changes and exclude readers.
>=20
>=20Preserve the atomic writable/off-list/available-list transition under
> swap_avail_lock. The device-selection and cluster-allocation paths do
> not yet hold swapon_rwsem; the priority queue patch adds that allocatio=
n
> reader protocol.
>=20
>=20Also update the comments in swap_info_struct to reflect the lock
> name change.
>=20
>=20Signed-off-by: Kairui Song <kasong@tencent.com>
> Signed-off-by: Lian Wang <lianux.mm@gmail.com>
> ---
>  include/linux/swap.h | 10 ++--
>  mm/swapfile.c | 130 ++++++++++++++++++++++---------------------
>  2 files changed, 73 insertions(+), 67 deletions(-)
>=20
>=20diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 0fa77f5679a2..717387e16a2d 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -192,18 +192,18 @@ struct swap_extent {
>  * Swap device flags, except the ones documented below, all are immutab=
le
>  * after exposed by swap_device_enable, and until the device is freed a=
gain
>  * (SWP_USED unset), except that teardown clears SWP_ACTIVATED after dr=
aining
> - * allocators and live references. The other exceptions:
> - * - SWP_USED: Protected by swap_lock. Indicates the device is inuse. =
Once
> + * allocators and live references. The other exceptions use swapon_rws=
em:
> + * - SWP_USED: Protected by swapon_rwsem. Indicates the device is inus=
e. Once
>  * set, won't be cleared unless all reference to this device is freed a=
nd
>  * swapoff finished.
> - * - SWP_WRITEOK: Protected by swap_lock, si->lock and swap_avail_lock=
.
> + * - SWP_WRITEOK: Protected by swapon_rwsem, si->lock and swap_avail_l=
ock.
>  * Clearing this flag is followed by waiting for all current cluster lo=
ck
>  * users to exit, so
>  * checking this flag while holding any of these locks ensures the devi=
ce
>  * is safe to use at the moment. Note: clearing this flag doesn't affec=
t
>  * pending IO or async requests, it only prevents further entry allocat=
ion
>  * or new async request (e.g. discard) from initiating.
> - * - SWP_HIBERNATION: Protected by swap_lock. Indicates if the device
> + * - SWP_HIBERNATION: Protected by swapon_rwsem. Indicates if the devi=
ce
>  * is pinned for hibernation.
>  */
>  enum {
> @@ -276,7 +276,7 @@ struct swap_info_struct {
>  spinlock_t lock; /*
>  * Protect cluster lists. Other fields
>  * are only changed at swapon/swapoff,
> - * so are protected by swap_lock.
> + * so are protected by swapon_rwsem.
>  */
>  struct work_struct discard_work; /* discard worker */
>  struct work_struct reclaim_work; /* reclaim worker */
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 1669a46515cd..ae8421e18448 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -57,23 +57,28 @@ static void move_cluster(struct swap_info_struct *s=
i,
>  enum swap_cluster_flags new_flags);
>=20=20
>=20 /*
> - * Protects the swap_info array, and the SWP_USED flag. swap_info cont=
ains
> - * lazily allocated & freed swap device info struts, and SWP_USED indi=
cates
> - * which device is used, ~SWP_USED devices and can be reused.
> - *
> - * Also protects swap_active_head total_swap_pages, and the SWP_WRITEO=
K flag.
> + * Serializes swapon/swapoff (writers) and protects the swap_info
> + * array, nr_swapfiles, total_swap_pages, and part of swap device
> + * info content (see comment of swap_info_struct). Read-side users
> + * take percpu_down_read() while inspecting this protected state.
> + */
> +DEFINE_STATIC_PERCPU_RWSEM(swapon_rwsem);
> +/*
> + * swap_info contains lazily allocated swap device info structs, and
> + * SWP_USED indicates which device is used, ~SWP_USED devices can be
> + * reused. Protected by swapon_rwsem, but reading could be lockless.
>  */
> -static DEFINE_SPINLOCK(swap_lock);
> +struct swap_info_struct *swap_info[MAX_SWAPFILES];
>  static unsigned int nr_swapfiles;
> -atomic_long_t nr_swap_pages;
> +long total_swap_pages;
> +
>  /*
>  * Some modules use swappable objects and may try to swap them out unde=
r
>  * memory pressure (via the shrinker). Before doing so, they may wish t=
o
>  * check to see if any swap space is available.
>  */
> +atomic_long_t nr_swap_pages;
>  EXPORT_SYMBOL_GPL(nr_swap_pages);
> -/* protected with swap_lock. reading in vm_swap_full() doesn't need lo=
ck */
> -long total_swap_pages;
>  #define DEF_SWAP_PRIO -1
>  unsigned long swapfile_maximum_size;
>  #ifdef CONFIG_MIGRATION
> @@ -85,7 +90,7 @@ static const char Bad_offset[] =3D "Bad swap offset e=
ntry ";
>=20=20
>=20 /*
>  * all active swap_info_structs
> - * protected with swap_lock, and ordered by priority.
> + * protected with swapon_rwsem, and ordered by priority.
>  */
>  static PLIST_HEAD(swap_active_head);
>=20=20
>=20@@ -95,20 +100,18 @@ static PLIST_HEAD(swap_active_head);
>  * This is used by folio_alloc_swap() instead of swap_active_head
>  * because swap_active_head includes all swap_info_structs,
>  * but folio_alloc_swap() doesn't need to look at full ones.
> - * This uses its own lock instead of swap_lock because when a
> + * This uses its own lock instead of swapon_rwsem because when a
>  * swap_info_struct changes between not-full/full, it needs to
>  * add/remove itself to/from this list, but the swap_info_struct->lock
> - * is held and the locking order requires swap_lock to be taken
> + * is held and the locking order requires swapon_rwsem to be taken
>  * before any swap_info_struct->lock.
>  */
>  static PLIST_HEAD(swap_avail_head);
>  static DEFINE_SPINLOCK(swap_avail_lock);
>=20=20
>=20-struct swap_info_struct *swap_info[MAX_SWAPFILES];
> -
>  static inline struct swap_info_struct *__swap_iter(int *i, unsigned lo=
ng flag)
>  {
> - lockdep_assert_held(&swap_lock);
> + lockdep_assert_held(&swapon_rwsem);
>  while (*i < nr_swapfiles) {
>  struct swap_info_struct *si =3D __swap_type_to_info(*i);
>=20=20
>=20@@ -128,7 +131,7 @@ static inline struct swap_info_struct *__swap_ite=
r(int *i, unsigned long flag)
>  * for_each_swap - iterate through all allocated and inuse swap devices
>  * @si: the iterator
>  *
> - * Context: The caller must hold swap_lock. The lock may be dropped du=
ring
> + * Context: The caller must hold swapon_rwsem. The lock may be dropped=
 during
>  * the loop body but must be re-acquired before the next iteration.
>  */
>  #define for_each_swap(si) __for_each_swap(si, SWP_USED)
> @@ -1309,7 +1312,7 @@ static void del_from_avail_list(struct swap_info_=
struct *si, bool swapoff)
>  pages | SWAP_USAGE_OFFLIST_BIT))
>  goto skip;
>  } else {
> - lockdep_assert_held(&swap_lock);
> + lockdep_assert_held_write(&swapon_rwsem);
>  lockdep_assert_held(&si->lock);
>  si->flags &=3D ~SWP_WRITEOK;
>  atomic_long_or(SWAP_USAGE_OFFLIST_BIT, &si->inuse_pages);
> @@ -1441,10 +1444,10 @@ static bool get_swap_device_info(struct swap_in=
fo_struct *si)
>  /*
>  * Guarantee the si->users are checked before accessing other
>  * fields of swap_info_struct, and si->flags (SWP_WRITEOK) is
> - * up to dated.
> + * up to date.
>  *
> - * Paired with the spin_unlock() after setup_swap_info() in
> - * swap_device_enable(), and smp_wmb() in swapoff.
> + * Paired with percpu_up_write() in swap_device_enable(), and
> + * smp_wmb() after clearing SWP_WRITEOK in swapoff.
>  */
>  smp_rmb();
>  return true;
> @@ -1529,10 +1532,10 @@ static bool swap_sync_discard(void)
>  bool ret =3D false;
>  struct swap_info_struct *si, *next;
>=20=20
>=20- spin_lock(&swap_lock);
> + percpu_down_read(&swapon_rwsem);
>  start_over:
>  plist_for_each_entry_safe(si, next, &swap_active_head, list) {
> - spin_unlock(&swap_lock);
> + percpu_up_read(&swapon_rwsem);
>  if (get_swap_device_info(si)) {
>  if (si->flags & SWP_PAGE_DISCARD)
>  ret =3D swap_do_scheduled_discard(si);
> @@ -1541,11 +1544,11 @@ static bool swap_sync_discard(void)
>  if (ret)
>  return true;
>=20=20
>=20- spin_lock(&swap_lock);
> + percpu_down_read(&swapon_rwsem);
>  if (plist_node_empty(&next->list))
>  goto start_over;
>  }
> - spin_unlock(&swap_lock);
> + percpu_up_read(&swapon_rwsem);
>=20=20
>=20 return false;
>  }
> @@ -2349,7 +2352,7 @@ int pin_hibernation_swap_type(dev_t device, secto=
r_t offset)
>  int ret;
>  struct swap_info_struct *si;
>=20=20
>=20- spin_lock(&swap_lock);
> + percpu_down_write(&swapon_rwsem);
>  ret =3D __find_hibernation_swap_type(device, offset);
>  if (ret < 0)
>  goto out;
> @@ -2373,7 +2376,7 @@ int pin_hibernation_swap_type(dev_t device, secto=
r_t offset)
>  si->flags |=3D SWP_HIBERNATION;
>=20=20
>=20 out:
> - spin_unlock(&swap_lock);
> + percpu_up_write(&swapon_rwsem);
>  return ret;
>  }
>=20=20
>=20@@ -2385,7 +2388,7 @@ int pin_hibernation_swap_type(dev_t device, sec=
tor_t offset)
>  *
>  * Look up the swap device for @device/@offset and atomically transfer
>  * the SWP_HIBERNATION pin from @old_type (if valid) to the new device,
> - * all under a single swap_lock critical section. This closes the
> + * all under a single swapon_rwsem writer section. This closes the
>  * swapoff() window that exists when callers unpin and re-pin in two
>  * separate operations.
>  *
> @@ -2405,28 +2408,28 @@ int repin_hibernation_swap_type(int old_type, d=
ev_t device, sector_t offset)
>  struct swap_info_struct *old_si, *new_si;
>  int new_type;
>=20=20
>=20- spin_lock(&swap_lock);
> + percpu_down_write(&swapon_rwsem);
>=20=20
>=20 new_type =3D __find_hibernation_swap_type(device, offset);
>  if (new_type < 0) {
> - spin_unlock(&swap_lock);
> + percpu_up_write(&swapon_rwsem);
>  return new_type;
>  }
>=20=20
>=20 new_si =3D swap_type_to_info(new_type);
>  if (WARN_ON_ONCE(!new_si)) {
> - spin_unlock(&swap_lock);
> + percpu_up_write(&swapon_rwsem);
>  return -ENODEV;
>  }
>=20=20
>=20 old_si =3D swap_type_to_info(old_type);
>  if (new_si =3D=3D old_si) {
> - spin_unlock(&swap_lock);
> + percpu_up_write(&swapon_rwsem);
>  return new_type;
>  }
>=20=20
>=20 if (WARN_ON_ONCE(new_si->flags & SWP_HIBERNATION)) {
> - spin_unlock(&swap_lock);
> + percpu_up_write(&swapon_rwsem);
>  return -EBUSY;
>  }
>=20=20
>=20@@ -2434,7 +2437,7 @@ int repin_hibernation_swap_type(int old_type, d=
ev_t device, sector_t offset)
>  old_si->flags &=3D ~SWP_HIBERNATION;
>  new_si->flags |=3D SWP_HIBERNATION;
>=20=20
>=20- spin_unlock(&swap_lock);
> + percpu_up_write(&swapon_rwsem);
>  return new_type;
>  }
>=20=20
>=20@@ -2452,11 +2455,11 @@ void unpin_hibernation_swap_type(int type)
>  {
>  struct swap_info_struct *si;
>=20=20
>=20- spin_lock(&swap_lock);
> + percpu_down_write(&swapon_rwsem);
>  si =3D swap_type_to_info(type);
>  if (si)
>  si->flags &=3D ~SWP_HIBERNATION;
> - spin_unlock(&swap_lock);
> + percpu_up_write(&swapon_rwsem);
>  }
>=20=20
>=20 /**
> @@ -2481,9 +2484,9 @@ int find_hibernation_swap_type(dev_t device, sect=
or_t offset)
>  {
>  int type;
>=20=20
>=20- spin_lock(&swap_lock);
> + percpu_down_read(&swapon_rwsem);
>  type =3D __find_hibernation_swap_type(device, offset);
> - spin_unlock(&swap_lock);
> + percpu_up_read(&swapon_rwsem);
>=20=20
>=20 return type;
>  }
> @@ -2493,13 +2496,13 @@ int find_first_swap(dev_t *device)
>  int ret =3D -ENODEV;
>  struct swap_info_struct *si;
>=20=20
>=20- spin_lock(&swap_lock);
> + percpu_down_read(&swapon_rwsem);
>  for_each_avail_swap(si) {
>  *device =3D si->bdev->bd_dev;
>  ret =3D si->type;
>  break;
>  }
> - spin_unlock(&swap_lock);
> + percpu_up_read(&swapon_rwsem);
>  return ret;
>  }
>=20=20
>=20@@ -2528,7 +2531,7 @@ unsigned int count_swap_pages(int type, int fre=
e)
>  {
>  unsigned int n =3D 0;
>=20=20
>=20- spin_lock(&swap_lock);
> + percpu_down_read(&swapon_rwsem);
>  if ((unsigned int)type < nr_swapfiles) {
>  struct swap_info_struct *sis =3D swap_info[type];
>=20=20
>=20@@ -2540,7 +2543,7 @@ unsigned int count_swap_pages(int type, int fre=
e)
>  }
>  spin_unlock(&sis->lock);
>  }
> - spin_unlock(&swap_lock);
> + percpu_up_read(&swapon_rwsem);
>  return n;
>  }
>  #endif /* CONFIG_HIBERNATION */
> @@ -2866,10 +2869,10 @@ static unsigned int find_next_to_unuse(struct s=
wap_info_struct *si,
>  unsigned long swp_tb;
>=20=20
>=20 /*
> - * No need for swap_lock here: we're just looking
> + * No need for swapon_rwsem here: we're just looking
>  * for whether an entry is in use, not modifying it; false
>  * hits are okay, and sys_swapoff() has already prevented new
> - * allocations from this area (while holding swap_lock).
> + * allocations from this area (while holding swapon_rwsem).
>  */
>  i =3D prev + 1;
>  while (i < si->max) {
> @@ -3007,8 +3010,8 @@ static int try_to_unuse(unsigned int type)
>=20=20
>=20 /*
>  * After a successful try_to_unuse, if no swap is now in use, we know
> - * we can empty the mmlist. swap_lock must be held on entry and exit.
> - * Note that mmlist_lock nests inside swap_lock, and an mm must be
> + * we can empty the mmlist. swapon_rwsem must be held on entry and exi=
t.
> + * Note that mmlist_lock nests inside swapon_rwsem, and an mm must be
>  * added to the mmlist just after page_duplicate - before would be racy=
.
>  */
>  static void drain_mmlist(void)
> @@ -3160,8 +3163,7 @@ static int setup_swap_extents(struct swap_info_st=
ruct *sis,
>  */
>  static void swap_device_enable(struct swap_info_struct *si)
>  {
> - spin_lock(&swap_lock);
> -
> + percpu_down_write(&swapon_rwsem);
>  spin_lock(&si->lock);
>  spin_lock(&swap_avail_lock);
>  si->flags |=3D SWP_WRITEOK;
> @@ -3171,7 +3173,7 @@ static void swap_device_enable(struct swap_info_s=
truct *si)
>  atomic_long_add(si->pages, &nr_swap_pages);
>  total_swap_pages +=3D si->pages;
>  plist_add(&si->list, &swap_active_head);
> - spin_unlock(&swap_lock);
> + percpu_up_write(&swapon_rwsem);
>=20=20
>=20 add_to_avail_list(si);
>  }
> @@ -3184,7 +3186,7 @@ static int swap_device_disable(struct address_spa=
ce *mapping,
>  unsigned long offset, end;
>  int err =3D -EINVAL;
>=20=20
>=20- spin_lock(&swap_lock);
> + percpu_down_write(&swapon_rwsem);
>  plist_for_each_entry(si, &swap_active_head, list) {
>  if ((si->flags & SWP_WRITEOK) &&
>  si->swap_file->f_mapping =3D=3D mapping) {
> @@ -3220,12 +3222,12 @@ static int swap_device_disable(struct address_s=
pace *mapping,
>=20=20
>=20 end =3D ALIGN(si->max, SWAPFILE_CLUSTER);
>  unlock:
> - spin_unlock(&swap_lock);
> + percpu_up_write(&swapon_rwsem);
>  if (err)
>  return err;
>=20=20
>=20 /*
> - * The swap allocator doesn't take swap_lock. Looping through every
> + * The swap allocator doesn't take swapon_rwsem. Looping through every
>  * cluster lock after clearing SWP_WRITEOK ensures that allocators see
>  * the updated flag and that no allocation remains in flight.
>  */
> @@ -3339,7 +3341,7 @@ SYSCALL_DEFINE1(swapoff, const char __user *, spe=
cialfile)
>  atomic_dec(&nr_rotate_swap);
>=20=20
>=20 mutex_lock(&swapon_mutex);
> - spin_lock(&swap_lock);
> + percpu_down_write(&swapon_rwsem);
>  spin_lock(&p->lock);
>  drain_mmlist();
>=20=20
>=20@@ -3350,7 +3352,7 @@ SYSCALL_DEFINE1(swapoff, const char __user *, s=
pecialfile)
>  p->max =3D 0;
>  p->cluster_info =3D NULL;
>  spin_unlock(&p->lock);
> - spin_unlock(&swap_lock);
> + percpu_up_write(&swapon_rwsem);
>  arch_swap_invalidate_area(p->type);
>  zswap_swapoff(p->type);
>  mutex_unlock(&swapon_mutex);
> @@ -3369,10 +3371,14 @@ SYSCALL_DEFINE1(swapoff, const char __user *, s=
pecialfile)
>  * Clear the SWP_USED flag after all resources are freed so that swapon
>  * can reuse this swap_info in alloc_swap_info() safely. It is ok to
>  * not hold p->lock after we cleared its SWP_WRITEOK.
> + *
> + * The write lock ensures the flag clear is visible to lockless
> + * readers of swap_type_to_info() before alloc_swap_info() reuses
> + * this slot.


Could we drop this paragraph? The comment above already explains slot
reuse, and swap_type_to_info() itself doesn't check SWP_USED.


>  */
> - spin_lock(&swap_lock);
> + percpu_down_write(&swapon_rwsem);
>  p->flags =3D 0;
> - spin_unlock(&swap_lock);
> + percpu_up_write(&swapon_rwsem);
>=20=20
>=20 atomic_inc(&proc_poll_event);
>  wake_up_interruptible(&proc_poll_wait);
> @@ -3532,13 +3538,13 @@ static struct swap_info_struct *alloc_swap_info=
(void)
>  return ERR_PTR(-ENOMEM);
>  }
>=20=20
>=20- spin_lock(&swap_lock);
> + percpu_down_write(&swapon_rwsem);
>  for (type =3D 0; type < nr_swapfiles; type++) {
>  if (!(swap_info[type]->flags & SWP_USED))
>  break;
>  }
>  if (type >=3D MAX_SWAPFILES) {
> - spin_unlock(&swap_lock);
> + percpu_up_write(&swapon_rwsem);
>  percpu_ref_exit(&p->users);
>  kvfree(p);
>  return ERR_PTR(-EPERM);
> @@ -3563,7 +3569,7 @@ static struct swap_info_struct *alloc_swap_info(v=
oid)
>  plist_node_init(&p->list, 0);
>  plist_node_init(&p->avail_list, 0);
>  p->flags =3D SWP_USED;
> - spin_unlock(&swap_lock);
> + percpu_up_write(&swapon_rwsem);
>  if (defer) {
>  percpu_ref_exit(&defer->users);
>  kvfree(defer);
> @@ -3999,9 +4005,9 @@ SYSCALL_DEFINE2(swapon, const char __user *, spec=
ialfile, int, swap_flags)
>  * Clear the SWP_USED flag after all resources are freed so
>  * alloc_swap_info can reuse this si safely.
>  */
> - spin_lock(&swap_lock);
> + percpu_down_write(&swapon_rwsem);
>  si->flags =3D 0;
> - spin_unlock(&swap_lock);
> + percpu_up_write(&swapon_rwsem);
>  if (inced_nr_rotate_swap)
>  atomic_dec(&nr_rotate_swap);
>  if (swap_file)
> @@ -4019,14 +4025,14 @@ void si_swapinfo(struct sysinfo *val)
>  struct swap_info_struct *si;
>  unsigned long nr_to_be_unused =3D 0;
>=20=20
>=20- spin_lock(&swap_lock);
> + percpu_down_read(&swapon_rwsem);
>  for_each_swap(si) {
>  if (!(si->flags & SWP_WRITEOK))
>  nr_to_be_unused +=3D swap_usage_in_pages(si);
>  }
>  val->freeswap =3D atomic_long_read(&nr_swap_pages) + nr_to_be_unused;
>  val->totalswap =3D total_swap_pages + nr_to_be_unused;
> - spin_unlock(&swap_lock);
> + percpu_up_read(&swapon_rwsem);
>  }
>=20=20
>=20 /*
>
