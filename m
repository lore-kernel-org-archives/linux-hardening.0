Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.207
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795149405;
	b=aFarC+j7Q212Cxtktc0Bj1MIMxVEf3hKkK6FZqqNBpKbard4wBPOeglwzsMfEeyB3HLa
	 maXrda8ZduYbB1ODtgp8Vpx0xnJ+2EwnUmaMoeDoDlmxZhgutKu1Uf3Z4P+olICdrrYz4
	 dWEtj6IkCCFrQ0bSlrYQC6Vv93+k95w9K6JZUNPFPm0nPpOiyke31j+XPN1Lv/JMuQvq0
	 rg4RYim8TRe0X/DnfU9/8i+EF/QhRDuE6AW0dJmPFeeRSt5MomxcohxWOPjTn5UU5cNpw
	 H7+XVd4C5On1tidQYRcgJBOFhsUN58xfE0vb001dnwA3YY/YO3pzpQd/HXPVLcj41rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795149405;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:MIME-Version:Date:Content-Type:
	 Content-Transfer-Encoding:From:Message-ID:TLS-Required:Subject:To:Cc:
	 In-Reply-To:References;
	bh=kXl1nUu33uWwxOKNxp2etrsx1DfSrs/u7Ukst+7XTH8=;
	b=z8gXelcJ64muKbhn9kPzE/EPV8XrP/ki4EtbEVP/vxuR5iEN/e/NUs8ijTIxrhDJHjHR
	 orL4KzbH1Oa/KlaKJyPmgXmJz0EMc8zHhuUEedOEDigCw1rbZ36z/tLSDCLDHNYO7Jr5k
	 ET2kbPBwuK0LvG06xySQgOLQ8yohpi59XI4wGAYA2muwH3dGBTsMOmFS9mGH0ISMfthZl
	 uvpqyLeKWj+D2wdt34qFSfhb6xzi5feRwOy6TKF47I1/cw1GDk4WLylio5jxSMsH7+7tS
	 eTVLNVJncddHZU2tg76AWqvQ4kJweD25CawOBpuVIBHYCdK2BZTa+ogV4iAhJb0Csiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="D/4UmECt";
	arc=none smtp.remote-ip=91.218.175.207
Received: from mta0.migadu.com (out-207.mta0.migadu.com [91.218.175.207])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0361606A326
	for <linux-hardening@vger.kernel.org>; Fri, 20 Nov 2026 04:36:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0361606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=D/4UmECt
X-Envelope-To: linux-hardening@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=jUHEmy5aQrelaM46tN2mShBpZvbPpUeJMifUGNUAsDE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795149403; v=1; x=1795754203;
 b=D/4UmECtowJf+CgMxFBNUkckxWI1l9OT2YKi9M8Dk0Ww/PjYKeAMdNG5sRpyIqh8ZHWHIq5A
 bdiuyei2xIbWrN+qpUxxBASCJOzfYTJbavYyAzdF9Ajvtfpkzfl3XblMaFMs+d/tYpE0nbm8zrV
 lNQzq4vJLp1xC0Efq6v4I6lU=
X-Envelope-To: linux-hardening@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 81e24f6d10068c4f;
	Fri, 20 Nov 2026 04:36:42 +0000
X-Mizu-Trace-ID: 81e24f6d10068c4f
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
Date: Fri, 20 Nov 2026 04:36:42 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Kunwu Chan" <kunwu.chan@linux.dev>
Message-ID: <13f1e8fe71c2de81b9d87b824561414f48b41c00@linux.dev>
TLS-Required: No
Subject: Re: [RFC PATCH v4 11/18] mm/swap: remove available list
To: "Lian Wang" <lianux.mm@gmail.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, "Andrew Morton"
 <akpm@linux-foundation.org>, "Chris Li" <chrisl@kernel.org>, "Nhat Pham"
 <nphamcs@gmail.com>, "Baoquan He" <baoquan.he@linux.dev>, "Barry Song"
 <baohua@kernel.org>, "Youngjun Park" <youngjun.park@lge.com>, "Kemeng
 Shi" <shikemeng@huaweicloud.com>, "Kairui Song" <kasong@tencent.com>,
 "Jihan LIN" <linjh22s@gmail.com>, "Kees Cook" <kees@kernel.org>, "Gustavo
 A. R. Silva" <gustavoars@kernel.org>, "Thomas Gleixner"
 <tglx@kernel.org>, linux-hardening@vger.kernel.org
In-Reply-To: <3bb9571ebf783db7a86a0ee2e7b00883c1de850b.1794666741.git.lianux.mm@gmail.com>
References: <cover.1794666741.git.lianux.mm@gmail.com>
 <3bb9571ebf783db7a86a0ee2e7b00883c1de850b.1794666741.git.lianux.mm@gmail.com>

Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>

Thanks,
Kunwu

>=20
>=20From: Kairui Song <kasong@tencent.com>
>=20
>=20The allocator now selects devices from the priority queue. Move the
> remaining block-cgroup throttle traversal from swap_avail_head to
> swap_active_head under swapon_rwsem. Check SWP_WRITEOK, the off-list
> state and the backing block device to retain priority-ordered target
> selection.
>=20
>=20Remove swap_avail_head, swap_avail_lock, the per-device avail_list fi=
eld
> and their maintenance now that no consumer needs the available plist.
> Queue masking and the embedded availability state remain serialized by
> swap_queue_update_lock.
>=20
>=20Signed-off-by: Kairui Song <kasong@tencent.com>
> Signed-off-by: Lian Wang <lianux.mm@gmail.com>
> ---
>  include/linux/swap.h | 1 -
>  mm/swapfile.c | 33 ++++++---------------------------
>  2 files changed, 6 insertions(+), 28 deletions(-)
>=20
>=20diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 6f32de173fb9..d31f3f023d36 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -289,7 +289,6 @@ struct swap_info_struct {
>  struct work_struct discard_work; /* discard worker */
>  struct work_struct reclaim_work; /* reclaim worker */
>  struct list_head discard_clusters; /* discard clusters list */
> - struct plist_node avail_list; /* entry in swap_avail_head */
>  const struct swap_ops *ops;
>  };
>=20=20
>=20diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 21d27da95898..5c5e449e9da3 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -96,21 +96,6 @@ static const char Bad_offset[] =3D "Bad swap offset =
entry ";
>  */
>  static PLIST_HEAD(swap_active_head);
>=20=20
>=20-/*
> - * all available (active, not full) swap_info_structs
> - * protected with swap_avail_lock, ordered by priority.
> - * This is used by folio_alloc_swap() instead of swap_active_head
> - * because swap_active_head includes all swap_info_structs,
> - * but folio_alloc_swap() doesn't need to look at full ones.
> - * This uses its own lock instead of swapon_rwsem because when a
> - * swap_info_struct changes between not-full/full, it needs to
> - * add/remove itself to/from this list, but the swap_info_struct->lock
> - * is held and the locking order requires swapon_rwsem to be taken
> - * before any swap_info_struct->lock.
> - */
> -static PLIST_HEAD(swap_avail_head);
> -static DEFINE_SPINLOCK(swap_avail_lock);
> -
>  static inline struct swap_info_struct *__swap_iter(int *i, unsigned lo=
ng flag)
>  {
>  lockdep_assert_held(&swapon_rwsem);
> @@ -1713,7 +1698,6 @@ static void del_from_avail_list(struct swap_info_=
struct *si, bool swapoff)
>  {
>  unsigned long pages;
>=20=20
>=20- spin_lock(&swap_avail_lock);
>  spin_lock(&swap_queue_update_lock);
>=20=20
>=20 /*
> @@ -1736,10 +1720,8 @@ static void del_from_avail_list(struct swap_info=
_struct *si, bool swapoff)
>  }
>=20=20
>=20 swap_queue_mask(si);
> - plist_del(&si->avail_list, &swap_avail_head);
>  skip:
>  spin_unlock(&swap_queue_update_lock);
> - spin_unlock(&swap_avail_lock);
>  }
>=20=20
>=20 /* SWAP_USAGE_OFFLIST_BIT can only be cleared by this helper. */
> @@ -1748,7 +1730,6 @@ static void add_to_avail_list(struct swap_info_st=
ruct *si)
>  long val;
>  unsigned long pages;
>=20=20
>=20- spin_lock(&swap_avail_lock);
>  spin_lock(&swap_queue_update_lock);
>=20=20
>=20 /*
> @@ -1779,10 +1760,8 @@ static void add_to_avail_list(struct swap_info_s=
truct *si)
>  }
>=20=20
>=20 swap_queue_unmask(si);
> - plist_add(&si->avail_list, &swap_avail_head);
>  skip:
>  spin_unlock(&swap_queue_update_lock);
> - spin_unlock(&swap_avail_lock);
>  }
>=20=20
>=20 /*
> @@ -3910,7 +3889,6 @@ static struct swap_info_struct *alloc_swap_info(v=
oid)
>  }
>  p->swap_extent_root =3D RB_ROOT;
>  plist_node_init(&p->list, 0);
> - plist_node_init(&p->avail_list, 0);
>  p->flags =3D SWP_USED;
>  percpu_up_write(&swapon_rwsem);
>  if (defer) {
> @@ -4326,7 +4304,6 @@ SYSCALL_DEFINE2(swapon, const char __user *, spec=
ialfile, int, swap_flags)
>  */
>  si->prio =3D prio;
>  si->list.prio =3D -si->prio;
> - si->avail_list.prio =3D -si->prio;
>=20=20
>=20 /*
>  * Publish swap_file before making the percpu ref live, then add the de=
vice
> @@ -4475,14 +4452,16 @@ void __folio_throttle_swaprate(struct folio *fo=
lio, gfp_t gfp)
>  if (current->throttle_disk)
>  return;
>=20=20
>=20- spin_lock(&swap_avail_lock);
> - plist_for_each_entry(si, &swap_avail_head, avail_list) {
> - if (si->bdev) {
> + percpu_down_read(&swapon_rwsem);
> + plist_for_each_entry(si, &swap_active_head, list) {
> + if ((si->flags & SWP_WRITEOK) &&
> + !(atomic_long_read(&si->inuse_pages) &
> + SWAP_USAGE_OFFLIST_BIT) && si->bdev) {
>  blkcg_schedule_throttle(si->bdev->bd_disk, true);
>  break;
>  }
>  }
> - spin_unlock(&swap_avail_lock);
> + percpu_up_read(&swapon_rwsem);
>  }
>  #endif
>
