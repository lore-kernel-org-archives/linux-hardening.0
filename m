Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795149056;
	b=Lmj4gEb27lqWe9EI9feeBgFXCaMB+EAIJelRdIkO35PV1LqMrXCVzdZdew59mPMxYSKC
	 W/0i9ZWuDV6tgnZZiYiDFWmvv7BV99hk2gEcDu8qri+8z5+rJ/5yXet6ICnQ1/k5ieFJl
	 ncvFHActq0t5FYM2ooGLIFkluD2RWc0HRuxOV16b04DCWdR9Gd87cqnnAD4N1L34Ovqjz
	 RsPMjpcPcK0BUq9orCfajlj/eM06j9xHGcB8o/908nR7DJ0B4ThHJFiHDOkc8JOucewf9
	 1vdZXCQ5hI0SOizeChFhUOIW8gw84wuXh199yAVeKlZZWFAM7pLWwZUo2EiMz1WlJ2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795149056;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:MIME-Version:Date:Content-Type:
	 Content-Transfer-Encoding:From:Message-ID:TLS-Required:Subject:To:Cc:
	 In-Reply-To:References;
	bh=Aptt1+YlEug156mMrf3nxJcUGwW+DDxbfeu04F3jKtg=;
	b=AYouHYwJyg63Y75SS54QgNSatVY29MkOwUAFlmF+75CwBdJHANBXHYjqSqnCG4lijykj
	 E+YPW0avLxHFwAdyBj7NA6dWSRpjeKl9Psgu2TjeRtv31OhrIrNfegOzP6319MKUk5FXA
	 H0cS4NVttNwU4TBfkd08FiGqn4xkzEpn3phTZ3SNby/cjcPG+RMsWJ0BoCqjFlbxk2o6S
	 ZmocTaeRD4vyEtS0aKSBGqHyLV5fqf8Yc74jcTbRct91Dz09al1DA0sFvXB7LD4DWYbHd
	 YxPtAE95cVB98koQ0SKBJu5BwQllh/jRMvug0etzPNPmcIm5+cKVOpE4WtR2zp/b+7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XMa43BsW;
	arc=none smtp.remote-ip=91.218.175.163
Received: from mta0.migadu.com (out-163.mta0.migadu.com [91.218.175.163])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C15A606A332
	for <linux-hardening@vger.kernel.org>; Fri, 20 Nov 2026 04:30:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C15A606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=XMa43BsW
X-Envelope-To: linux-hardening@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=QQM+GciGMRe/j+gSSQmU++uIs6+IufRUD56p0aNRWo0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795149054; v=1; x=1795753854;
 b=XMa43BsW005DAY65ZhYoKhtzqjFEhkLX/TeVMxGKMR+GZaV6F2xDyc94bMqP2WqKPODp5T9D
 PR0Kd+qHcFRTRBhFsq12JwHC0Li3V/f+GEybGKhgrIcH8Ky7V7iNn7llhnLAjnwG0BGaF6OxQIi
 /zO7Ujgwb/+BxHtotbqxOT+0=
X-Envelope-To: linux-hardening@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c99f1d5ab03ce7ff;
	Fri, 20 Nov 2026 04:30:53 +0000
X-Mizu-Trace-ID: c99f1d5ab03ce7ff
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
Date: Fri, 20 Nov 2026 04:30:53 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Kunwu Chan" <kunwu.chan@linux.dev>
Message-ID: <132ae48e0317aa95b8d51c4534230878d6a57ff5@linux.dev>
TLS-Required: No
Subject: Re: [RFC PATCH v4 07/18] mm/swap: consolidate swap inuse accounting
 helpers
To: "Lian Wang" <lianux.mm@gmail.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, "Andrew Morton"
 <akpm@linux-foundation.org>, "Chris Li" <chrisl@kernel.org>, "Nhat Pham"
 <nphamcs@gmail.com>, "Baoquan He" <baoquan.he@linux.dev>, "Barry Song"
 <baohua@kernel.org>, "Youngjun Park" <youngjun.park@lge.com>, "Kemeng
 Shi" <shikemeng@huaweicloud.com>, "Kairui Song" <kasong@tencent.com>,
 "Jihan LIN" <linjh22s@gmail.com>, "Kees Cook" <kees@kernel.org>, "Gustavo
 A. R. Silva" <gustavoars@kernel.org>, "Thomas Gleixner"
 <tglx@kernel.org>, linux-hardening@vger.kernel.org
In-Reply-To: <4e554bbb557d0456c953d73f008875f6d983b12f.1794666741.git.lianux.mm@gmail.com>
References: <cover.1794666741.git.lianux.mm@gmail.com>
 <4e554bbb557d0456c953d73f008875f6d983b12f.1794666741.git.lianux.mm@gmail.com>

Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>

Thanks,
Kunwu

>=20
>=20From: Kairui Song <kasong@tencent.com>
>=20
>=20Inline the swap_usage_add/sub helpers into their only callers and
> rename the callers to better reflect what they actually do: track
> per-device inuse page counts.
>=20
>=20Keep the existing accounting and allocation policy. In the inlined
> full-device path, reclaim work is scheduled before availability removal
> rather than afterwards. Slot-free notifications and zswap invalidation
> retain their existing order.
>=20
>=20Signed-off-by: Kairui Song <kasong@tencent.com>
> Signed-off-by: Lian Wang <lianux.mm@gmail.com>
> ---
>  mm/swapfile.c | 64 ++++++++++++++++++++++-----------------------------
>  1 file changed, 27 insertions(+), 37 deletions(-)
>=20
>=20diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 277a5c749987..aa020f2706b4 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -49,8 +49,8 @@
>  #include "internal.h"
>  #include "swap.h"
>=20=20
>=20-static void swap_range_alloc(struct swap_info_struct *si,
> - unsigned int nr_entries);
> +static void swap_device_inuse_add(struct swap_info_struct *si,
> + unsigned int nr_entries);
>  static bool folio_swapcache_freeable(struct folio *folio);
>  static void move_cluster(struct swap_info_struct *si,
>  struct swap_cluster_info *ci, struct list_head *list,
> @@ -1045,7 +1045,7 @@ static bool __swap_cluster_alloc_entries(struct s=
wap_info_struct *si,
>  if (cluster_is_empty(ci))
>  ci->order =3D order;
>  ci->count +=3D nr_pages;
> - swap_range_alloc(si, nr_pages);
> + swap_device_inuse_add(si, nr_pages);
>=20=20
>=20 return true;
>  }
> @@ -1363,53 +1363,36 @@ static void add_to_avail_list(struct swap_info_=
struct *si)
>  }
>=20=20
>=20 /*
> - * swap_usage_add / swap_usage_sub of each slot are serialized by ci->=
lock
> - * within each cluster, so the total contribution to the global counte=
r should
> - * always be positive and cannot exceed the total number of usable slo=
ts.
> + * swap_device_inuse_add / swap_device_inuse_sub are called within clu=
ster
> + * update critical sections and serialized by ci->lock within each clu=
ster,
> + * so the total contribution to the global counter should always be po=
sitive
> + * and cannot exceed the total number of usable slots.
>  */
> -static bool swap_usage_add(struct swap_info_struct *si, unsigned int n=
r_entries)
> +static void swap_device_inuse_add(struct swap_info_struct *si,
> + unsigned int nr_entries)
>  {
> - long val =3D atomic_long_add_return_relaxed(nr_entries, &si->inuse_pa=
ges);
> + long inuse_pages;
>=20=20
>=20 /*
>  * If device is full, and SWAP_USAGE_OFFLIST_BIT is not set,
>  * remove it from the plist.
>  */
> - if (unlikely(val =3D=3D si->pages)) {
> - del_from_avail_list(si, false);
> - return true;
> - }
> -
> - return false;
> -}
> -
> -static void swap_usage_sub(struct swap_info_struct *si, unsigned int n=
r_entries)
> -{
> - long val =3D atomic_long_sub_return_relaxed(nr_entries, &si->inuse_pa=
ges);
> -
> - /*
> - * If device is not full, and SWAP_USAGE_OFFLIST_BIT is set,
> - * add it to the plist.
> - */
> - if (unlikely(val & SWAP_USAGE_OFFLIST_BIT))
> - add_to_avail_list(si);
> -}
> -
> -static void swap_range_alloc(struct swap_info_struct *si,
> - unsigned int nr_entries)
> -{
> - if (swap_usage_add(si, nr_entries)) {
> + inuse_pages =3D atomic_long_add_return_relaxed(nr_entries, &si->inuse=
_pages);
> + if (unlikely(inuse_pages =3D=3D si->pages)) {
>  if (vm_swap_full())
>  schedule_work(&si->reclaim_work);
> + del_from_avail_list(si, false);
>  }
> +
>  atomic_long_sub(nr_entries, &nr_swap_pages);
>  }
>=20=20
>=20-static void swap_range_free(struct swap_info_struct *si, unsigned lo=
ng offset,
> - unsigned int nr_entries)
> +static void swap_device_inuse_sub(struct swap_info_struct *si, unsigne=
d long offset,
> + unsigned int nr_entries)
>  {
>  unsigned long end =3D offset + nr_entries - 1;
>  void (*swap_slot_free_notify)(struct block_device *, unsigned long);
> + long inuse_pages;
>=20=20
>=20 zswap_invalidate(si->type, offset, nr_entries);
>=20=20
>=20@@ -1431,7 +1414,14 @@ static void swap_range_free(struct swap_info_s=
truct *si, unsigned long offset,
>  */
>  smp_wmb();
>  atomic_long_add(nr_entries, &nr_swap_pages);
> - swap_usage_sub(si, nr_entries);
> +
> + /*
> + * If device is not full, and SWAP_USAGE_OFFLIST_BIT is set,
> + * add it back to the plist.
> + */
> + inuse_pages =3D atomic_long_sub_return_relaxed(nr_entries, &si->inuse=
_pages);
> + if (unlikely(inuse_pages & SWAP_USAGE_OFFLIST_BIT))
> + add_to_avail_list(si);
>  }
>=20=20
>=20 static bool get_swap_device_info(struct swap_info_struct *si)
> @@ -2059,7 +2049,7 @@ void __swap_cluster_free_entries(struct swap_info=
_struct *si,
>  if (batch_id)
>  mem_cgroup_uncharge_swap(batch_id, ci_off - batch_off);
>=20=20
>=20- swap_range_free(si, ci_head + ci_start, nr_pages);
> + swap_device_inuse_sub(si, ci_head + ci_start, nr_pages);
>  swap_cluster_assert_empty(ci, ci_start, nr_pages, false);
>=20=20
>=20 if (!ci->count)
> @@ -2999,7 +2989,7 @@ static int try_to_unuse(unsigned int type)
>  success:
>  /*
>  * Make sure that further cleanups after try_to_unuse() returns happen
> - * after swap_range_free() reduces si->inuse_pages to 0.
> + * after swap_device_inuse_sub() reduces si->inuse_pages to 0.
>  */
>  smp_mb();
>  return 0;
>
