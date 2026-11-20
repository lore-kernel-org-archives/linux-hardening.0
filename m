Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.234
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795147191;
	b=P+uABFvZVeyjuIOr2TrLtGwhg8IKEGKGDUJXZR70xi7hnElLW7u39XfvT0f+sKQ1/Upd
	 F0q18rVRNPKl80PA4yPYzHqvo4P18m4QwJInFj15PIRV/ZVMUVHOoNwwsz43mujB678VC
	 a3DnZdtjYQc/qsWV7o5+hePna/2yz3i1vxe6sTMJyj4GXej2RF5+R3Q2qBwQsOGrVHE3u
	 /hPt+VELmraBcLbU7Gomja5sgNPGBPnMKa65zC1npeCqwjrxm/jn76xxxRIAQoy4r/VUW
	 csy2V1ZNw024nr+RfEDjqtCnQoPXbZ1FhgSwoyiy8KuJBw43Jtl3g9UPA4TNTnsBOTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795147191;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:MIME-Version:Date:Content-Type:
	 Content-Transfer-Encoding:From:Message-ID:TLS-Required:Subject:To:Cc:
	 In-Reply-To:References;
	bh=BevtVguUeQNyWju/jMWBB/Dczk4xrw2DuDLihw+PuYY=;
	b=0F6mhnTBEjtKM03Y0K9WVif8jxuAWoLC+QTys8m36g9A4899bEztF3fqvuf3qk5Lsz5T
	 nzHCRZ/y5+Q9oqepLi1wYhRlNlcUid/A9Kof/YhLkf9qmBASEKut0rCZxXj/NJslrCiOH
	 jOoTSbWoKkYkEHjdPbq9WCTRXR5xMos5SIOO8tMu5MieBcMB4CnQ5jE6VsIlX/4Vmg4X0
	 jH733xe/wg5jLw7gDrc47huPIs6rP+UMQ66iPO/lgTaUMFtPHT0xejqiySSwvszuLFEKy
	 K/pt6fab83WLIPIlDWMgwrWLTpL72Jq7krUE9ze0qqOumzqs9OkH0qhYgKKBUhinXIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ph5i5kv5;
	arc=none smtp.remote-ip=91.218.175.234
Received: from mta0.migadu.com (out-234.mta0.migadu.com [91.218.175.234])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15334606A32C
	for <linux-hardening@vger.kernel.org>; Fri, 20 Nov 2026 03:59:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15334606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ph5i5kv5
X-Envelope-To: linux-hardening@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=1eEQ2mT1dDnX4nxZxFauoQ+3gLHeK/si6v01CaLfQ3o=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795147188; v=1; x=1795751988;
 b=ph5i5kv5YBIXQiUpZX0L/NFpN6noqe5Bbfsz0qeDWSIUKZVsOwTaayjQ0++23Si9JoxLIpko
 R3Gc2Q78EQNwPnt0A7P9lfO4VdovSAaYGBFtbWEtAOnq6zLaQUvpwXx0KOmBNIeVbZmZKZKkLZD
 eT9Fp1KdldMB4ljvYviFk1Qw=
X-Envelope-To: linux-hardening@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 84dd2801765fca3b;
	Fri, 20 Nov 2026 03:59:48 +0000
X-Mizu-Trace-ID: 84dd2801765fca3b
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
Date: Fri, 20 Nov 2026 03:59:47 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Kunwu Chan" <kunwu.chan@linux.dev>
Message-ID: <01e78c2f91fa0320a5bee69f6cb47a1dcacab31f@linux.dev>
TLS-Required: No
Subject: Re: [RFC PATCH v4 04/18] mm/swap: introduce swap device iteration
 helper
To: "Lian Wang" <lianux.mm@gmail.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, "Andrew Morton"
 <akpm@linux-foundation.org>, "Chris Li" <chrisl@kernel.org>, "Nhat Pham"
 <nphamcs@gmail.com>, "Baoquan He" <baoquan.he@linux.dev>, "Barry Song"
 <baohua@kernel.org>, "Youngjun Park" <youngjun.park@lge.com>, "Kemeng
 Shi" <shikemeng@huaweicloud.com>, "Kairui Song" <kasong@tencent.com>,
 "Jihan LIN" <linjh22s@gmail.com>, "Kees Cook" <kees@kernel.org>, "Gustavo
 A. R. Silva" <gustavoars@kernel.org>, "Thomas Gleixner"
 <tglx@kernel.org>, linux-hardening@vger.kernel.org
In-Reply-To: <8e1766da4ddbf22e36f8689360dfea64377269fd.1794666741.git.lianux.mm@gmail.com>
References: <cover.1794666741.git.lianux.mm@gmail.com>
 <8e1766da4ddbf22e36f8689360dfea64377269fd.1794666741.git.lianux.mm@gmail.com>

Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>

Thanks,
Kunwu

>=20
>=20From: Kairui Song <kasong@tencent.com>
>=20
>=20Several swap users scan the swap_info array to find in-use or writabl=
e
> devices. Add for_each_swap() and for_each_avail_swap() with SWP_USED an=
d
> SWP_USED | SWP_WRITEOK filtering, and use them for hibernation lookups,
> drain_mmlist() and si_swapinfo(). Keep the swap_lock requirement for
> iteration.
>=20
>=20Move the live-reference warning from __swap_type_to_info() into
> __swap_entry_to_info(). The iterator must inspect descriptors before
> applying its flag filter, including descriptors whose device reference
> is dead; entry-based lookup retains the warning.
>=20
>=20Signed-off-by: Kairui Song <kasong@tencent.com>
> Signed-off-by: Lian Wang <lianux.mm@gmail.com>
> ---
>  mm/swap.h | 12 ++++----
>  mm/swapfile.c | 77 +++++++++++++++++++++++++++++++--------------------
>  2 files changed, 53 insertions(+), 36 deletions(-)
>=20
>=20diff --git a/mm/swap.h b/mm/swap.h
> index d488a69c2809..70fd3ab655ff 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -108,16 +108,16 @@ static inline unsigned int swp_cluster_offset(swp=
_entry_t entry)
>  */
>  static inline struct swap_info_struct *__swap_type_to_info(int type)
>  {
> - struct swap_info_struct *si;
> -
> - si =3D READ_ONCE(swap_info[type]); /* rcu_dereference() */
> - VM_WARN_ON_ONCE(percpu_ref_is_zero(&si->users)); /* race with swapoff=
 */
> - return si;
> + return READ_ONCE(swap_info[type]); /* rcu_dereference() */
>  }
>=20=20
>=20 static inline struct swap_info_struct *__swap_entry_to_info(swp_entr=
y_t entry)
>  {
> - return __swap_type_to_info(swp_type(entry));
> + struct swap_info_struct *si;
> +
> + si =3D __swap_type_to_info(swp_type(entry)); /* rcu_dereference() */
> + VM_WARN_ON_ONCE(percpu_ref_is_zero(&si->users)); /* race with swapoff=
 */
> + return si;
>  }
>=20=20
>=20 static inline struct swap_cluster_info *__swap_offset_to_cluster(
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 6485c8020d3a..1669a46515cd 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -106,6 +106,34 @@ static DEFINE_SPINLOCK(swap_avail_lock);
>=20=20
>=20 struct swap_info_struct *swap_info[MAX_SWAPFILES];
>=20=20
>=20+static inline struct swap_info_struct *__swap_iter(int *i, unsigned =
long flag)
> +{
> + lockdep_assert_held(&swap_lock);
> + while (*i < nr_swapfiles) {
> + struct swap_info_struct *si =3D __swap_type_to_info(*i);
> +
> + VM_WARN_ON(!si);
> + (*i)++;
> + if (flag && !((si->flags & flag) =3D=3D flag))
> + continue;
> + return si;
> + }
> + return NULL;
> +}
> +
> +#define __for_each_swap(si, flag) \
> + for (int __i =3D 0; ((si) =3D __swap_iter(&__i, flag));)
> +
> +/*
> + * for_each_swap - iterate through all allocated and inuse swap device=
s
> + * @si: the iterator
> + *
> + * Context: The caller must hold swap_lock. The lock may be dropped du=
ring
> + * the loop body but must be re-acquired before the next iteration.
> + */
> +#define for_each_swap(si) __for_each_swap(si, SWP_USED)
> +#define for_each_avail_swap(si) __for_each_swap(si, SWP_USED | SWP_WRI=
TEOK)
> +
>  static struct kmem_cache *swap_table_cachep;
>=20=20
>=20 /* Protects si->swap_file for /proc/swaps usage */
> @@ -2284,26 +2312,18 @@ void swap_free_hibernation_slot(swp_entry_t ent=
ry)
>=20=20
>=20 static int __find_hibernation_swap_type(dev_t device, sector_t offse=
t)
>  {
> - int type;
> -
> - lockdep_assert_held(&swap_lock);
> + struct swap_info_struct *si;
>=20=20
>=20 if (!device)
>  return -EINVAL;
>=20=20
>=20- for (type =3D 0; type < nr_swapfiles; type++) {
> - struct swap_info_struct *sis =3D swap_info[type];
> -
> - if (!(sis->flags & SWP_WRITEOK))
> - continue;
> -
> - if (device =3D=3D sis->bdev->bd_dev) {
> - struct swap_extent *se =3D first_se(sis);
> -
> - if (se->start_block =3D=3D offset)
> - return type;
> + for_each_avail_swap(si) {
> + if (device =3D=3D si->bdev->bd_dev) {
> + if (first_se(si)->start_block =3D=3D offset)
> + return si->type;
>  }
>  }
> +
>  return -ENODEV;
>  }
>=20=20
>=20@@ -2470,16 +2490,13 @@ int find_hibernation_swap_type(dev_t device, =
sector_t offset)
>=20=20
>=20 int find_first_swap(dev_t *device)
>  {
> - int type, ret =3D -ENODEV;
> + int ret =3D -ENODEV;
> + struct swap_info_struct *si;
>=20=20
>=20 spin_lock(&swap_lock);
> - for (type =3D 0; type < nr_swapfiles; type++) {
> - struct swap_info_struct *sis =3D swap_info[type];
> -
> - if (!(sis->flags & SWP_WRITEOK))
> - continue;
> - *device =3D sis->bdev->bd_dev;
> - ret =3D type;
> + for_each_avail_swap(si) {
> + *device =3D si->bdev->bd_dev;
> + ret =3D si->type;
>  break;
>  }
>  spin_unlock(&swap_lock);
> @@ -2996,12 +3013,14 @@ static int try_to_unuse(unsigned int type)
>  */
>  static void drain_mmlist(void)
>  {
> + struct swap_info_struct *si;
>  struct list_head *p, *next;
> - unsigned int type;
>=20=20
>=20- for (type =3D 0; type < nr_swapfiles; type++)
> - if (swap_usage_in_pages(swap_info[type]))
> + for_each_swap(si) {
> + if (swap_usage_in_pages(si))
>  return;
> + }
> +
>  spin_lock(&mmlist_lock);
>  list_for_each_safe(p, next, &init_mm.mmlist)
>  list_del_init(p);
> @@ -3997,14 +4016,12 @@ SYSCALL_DEFINE2(swapon, const char __user *, sp=
ecialfile, int, swap_flags)
>=20=20
>=20 void si_swapinfo(struct sysinfo *val)
>  {
> - unsigned int type;
> + struct swap_info_struct *si;
>  unsigned long nr_to_be_unused =3D 0;
>=20=20
>=20 spin_lock(&swap_lock);
> - for (type =3D 0; type < nr_swapfiles; type++) {
> - struct swap_info_struct *si =3D swap_info[type];
> -
> - if ((si->flags & SWP_USED) && !(si->flags & SWP_WRITEOK))
> + for_each_swap(si) {
> + if (!(si->flags & SWP_WRITEOK))
>  nr_to_be_unused +=3D swap_usage_in_pages(si);
>  }
>  val->freeswap =3D atomic_long_read(&nr_swap_pages) + nr_to_be_unused;
>
