Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795149022;
	b=o8QhTyy62AVYA6wwX+52mQ3JyfxYYBJ9+AFzm+27wz8KCsw/sOYf5rvZBQk2IdBUYhhZ
	 517+h+tveA+Bthcoy2ONnU00nkuNzMTDaDtE1JB86/DIO88+tAaTPMsxVcH34hKeHAqXe
	 GLt8hUUy+6dJ4DC4ppBNQsl9Oc0smsXXz7I/EOmclLLsljSFPTR0VbSYEOZjvFzxpHa/G
	 PbJX9g08KL7xOEgMvnXmYn9NI7X0bC9V0fJ/ikj+3UbMn4A/v04jp1JjCQhxPZ37SFySk
	 qOB0y09T6PfZnFoCkTOr4pf5FNsk2Ru0b7to+oOBxRarXyL8JzOwY+tPdwL1Fg5mG2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795149022;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:MIME-Version:Date:Content-Type:
	 Content-Transfer-Encoding:From:Message-ID:TLS-Required:Subject:To:Cc:
	 In-Reply-To:References;
	bh=roL0FQDRW/fqTvKyUOnLi52ZhKE+0i4/LlevVoVyflc=;
	b=yDsdDtYowX38NSlzgI0CYx2kXfgYU4XWFySVz5hX1vMz+gboQb+2kCghrOE/66mephcj
	 U1z2Z5XWVAKaObhzCpURaKXcEmq9LIyNBMHEazJ7i+GAYVrx8Oaz3wMFMvHOe3vxdUal7
	 GylYgZPZnwE1Sx6hCBFPHSb9Ed2ryyr+Z/8tKp1wlAL5ZS+AvnM85kH9ykY8P/zLGKC5H
	 o03PkDDOAoRQCTK5j/C6q2FI4Cff0tvuqChPYlgQCS87S4/EFUi0Gagk8bCY9hIQ3fZl8
	 27cN77TfMJn0WH8nfQvGwyEpDdLULKdGveSUk/8yANfQ8jrjXZj3K+kLa2ZOCiEP9oA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BYc7TJyA;
	arc=none smtp.remote-ip=91.218.175.155
Received: from mta0.migadu.com (out-155.mta0.migadu.com [91.218.175.155])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8150E606A334
	for <linux-hardening@vger.kernel.org>; Fri, 20 Nov 2026 04:30:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8150E606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=BYc7TJyA
X-Envelope-To: linux-hardening@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=YW3SrjZDBSs+f8ut+cA/sj4nFs4B9HPB8O+mdX/NYzA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795149019; v=1; x=1795753819;
 b=BYc7TJyAaemoKxzTFRyXTEApuH7UARqQ5ms8GpzzTaPiWIHylOedNQFrSpwynKO1J+FcgkL3
 NOY6XRBya0cWXhmFPrEY35frPAV0PUIbdP/LMMY7Lpyxd2MOnNiQchXNeSU5vsSBqR3Pv25xUxm
 5W+2grovpvTq1ZD9F2OihYno=
X-Envelope-To: linux-hardening@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id def76d0e62afee0d;
	Fri, 20 Nov 2026 04:30:17 +0000
X-Mizu-Trace-ID: def76d0e62afee0d
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
Date: Fri, 20 Nov 2026 04:30:16 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Kunwu Chan" <kunwu.chan@linux.dev>
Message-ID: <f9cbc65ebeda9ebbc71c0488bb7df016f5c34961@linux.dev>
TLS-Required: No
Subject: Re: [RFC PATCH v4 06/18] mm/swap: serialize swap publication before
 removing swapon mutex
To: "Lian Wang" <lianux.mm@gmail.com>, linux-mm@kvack.org,
 kunwu.chan@gmail.com
Cc: linux-kernel@vger.kernel.org, "Andrew Morton"
 <akpm@linux-foundation.org>, "Chris Li" <chrisl@kernel.org>, "Nhat Pham"
 <nphamcs@gmail.com>, "Baoquan He" <baoquan.he@linux.dev>, "Barry Song"
 <baohua@kernel.org>, "Youngjun Park" <youngjun.park@lge.com>, "Kemeng
 Shi" <shikemeng@huaweicloud.com>, "Kairui Song" <kasong@tencent.com>,
 "Jihan LIN" <linjh22s@gmail.com>, "Kees Cook" <kees@kernel.org>, "Gustavo
 A. R. Silva" <gustavoars@kernel.org>, "Thomas Gleixner"
 <tglx@kernel.org>, linux-hardening@vger.kernel.org
In-Reply-To: <ed10255256780c856689549e65654f8b01d40c2e.1794666741.git.lianux.mm@gmail.com>
References: <cover.1794666741.git.lianux.mm@gmail.com>
 <ed10255256780c856689549e65654f8b01d40c2e.1794666741.git.lianux.mm@gmail.com>

>=20
>=20From: Kairui Song <kasong@tencent.com>
>=20
>=20Move publication of swap_file, resurrection of the device reference a=
nd
> the writable transition into one swapon_rwsem writer section. Split out
> a writer-held enable helper so initial publication can share this
> section, while failed swapoff can use the locking wrapper.
>=20
>=20With file publication and teardown serialized by the writer, remove
> swapon_mutex and use a topology reader across /proc/swaps iteration.
> Keep the SWP_USED filter when advancing the swap_info array.
>=20
>=20The publication boundary excludes proc readers from partially publish=
ed
> state and gives the lockless live-reference users initialized device
> metadata before the device becomes an allocation candidate.
>=20
>=20Signed-off-by: Kairui Song <kasong@tencent.com>
> Co-developed-by: Lian Wang <lianux.mm@gmail.com>
> Signed-off-by: Lian Wang <lianux.mm@gmail.com>
> ---
>  mm/swapfile.c | 39 +++++++++++++++++++--------------------
>  1 file changed, 19 insertions(+), 20 deletions(-)
>=20
>=20diff --git a/mm/swapfile.c b/mm/swapfile.c
> index ae8421e18448..277a5c749987 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -139,9 +139,6 @@ static inline struct swap_info_struct *__swap_iter(=
int *i, unsigned long flag)
>=20=20
>=20 static struct kmem_cache *swap_table_cachep;
>=20=20
>=20-/* Protects si->swap_file for /proc/swaps usage */
> -static DEFINE_MUTEX(swapon_mutex);
> -
>  static DECLARE_WAIT_QUEUE_HEAD(proc_poll_wait);
>  /* Activity counter to indicate that a swapon or swapoff has occurred =
*/
>  static atomic_t proc_poll_event =3D ATOMIC_INIT(0);
> @@ -3161,9 +3158,9 @@ static int setup_swap_extents(struct swap_info_st=
ruct *sis,
>  * Mark a fully initialized swap device writable and expose it to the
>  * allocator. The caller must have resurrected its percpu ref first.
>  */
> -static void swap_device_enable(struct swap_info_struct *si)
> +static void __swap_device_enable(struct swap_info_struct *si)
>  {
> - percpu_down_write(&swapon_rwsem);
> + lockdep_assert_held_write(&swapon_rwsem);
>  spin_lock(&si->lock);
>  spin_lock(&swap_avail_lock);
>  si->flags |=3D SWP_WRITEOK;
> @@ -3173,11 +3170,16 @@ static void swap_device_enable(struct swap_info=
_struct *si)
>  atomic_long_add(si->pages, &nr_swap_pages);
>  total_swap_pages +=3D si->pages;
>  plist_add(&si->list, &swap_active_head);
> - percpu_up_write(&swapon_rwsem);
> -
>  add_to_avail_list(si);
>  }
>=20=20
>=20+static void swap_device_enable(struct swap_info_struct *si)
> +{
> + percpu_down_write(&swapon_rwsem);
> + __swap_device_enable(si);
> + percpu_up_write(&swapon_rwsem);
> +}
> +
>  static int swap_device_disable(struct address_space *mapping,
>  struct swap_info_struct **swap_info)
>  {
> @@ -3340,7 +3342,6 @@ SYSCALL_DEFINE1(swapoff, const char __user *, spe=
cialfile)
>  if (!(p->flags & SWP_SOLIDSTATE))
>  atomic_dec(&nr_rotate_swap);
>=20=20
>=20- mutex_lock(&swapon_mutex);
>  percpu_down_write(&swapon_rwsem);
>  spin_lock(&p->lock);
>  drain_mmlist();
> @@ -3355,7 +3356,6 @@ SYSCALL_DEFINE1(swapoff, const char __user *, spe=
cialfile)
>  percpu_up_write(&swapon_rwsem);
>  arch_swap_invalidate_area(p->type);
>  zswap_swapoff(p->type);
> - mutex_unlock(&swapon_mutex);
>  kfree(p->global_cluster);
>  p->global_cluster =3D NULL;
>  free_swap_cluster_info(cluster_info, maxpages);
> @@ -3401,20 +3401,18 @@ static __poll_t swaps_poll(struct file *file, p=
oll_table *wait)
>  return EPOLLIN | EPOLLRDNORM;
>  }
>=20=20
>=20-/* iterator */
>  static void *swap_start(struct seq_file *swap, loff_t *pos)
>  {
>  struct swap_info_struct *si;
> - int type;
>  loff_t l =3D *pos;
>=20=20
>=20- mutex_lock(&swapon_mutex);
> + percpu_down_read(&swapon_rwsem);
>=20=20
>=20 if (!l)
>  return SEQ_START_TOKEN;
>=20=20
>=20- for (type =3D 0; (si =3D swap_type_to_info(type)); type++) {
> - if (!(si->swap_file))
> + for_each_swap(si) {
> + if (!si->swap_file)
>  continue;
>  if (!--l)
>  return si;
> @@ -3435,7 +3433,7 @@ static void *swap_next(struct seq_file *swap, voi=
d *v, loff_t *pos)
>=20=20
>=20 ++(*pos);
>  for (; (si =3D swap_type_to_info(type)); type++) {
> - if (!(si->swap_file))
> + if (!(si->flags & SWP_USED) || !(si->swap_file))



Could we keep checking just si->swap_file here and in swap_start()?
swapon() can set SWP_SOLIDSTATE before taking swapon_rwsem to
publish the file.

Thanks,
Kunwu

>  continue;
>  return si;
>  }
> @@ -3445,7 +3443,7 @@ static void *swap_next(struct seq_file *swap, voi=
d *v, loff_t *pos)
>=20=20
>=20 static void swap_stop(struct seq_file *swap, void *v)
>  {
> - mutex_unlock(&swapon_mutex);
> + percpu_up_read(&swapon_rwsem);
>  }
>=20=20
>=20 static int swap_show(struct seq_file *swap, void *v)
> @@ -3958,7 +3956,6 @@ SYSCALL_DEFINE2(swapon, const char __user *, spec=
ialfile, int, swap_flags)
>  goto free_swap_zswap;
>  }
>=20=20
>=20- mutex_lock(&swapon_mutex);
>  prio =3D DEF_SWAP_PRIO;
>  if (swap_flags & SWAP_FLAG_PREFER)
>  prio =3D swap_flags & SWAP_FLAG_PRIO_MASK;
> @@ -3970,11 +3967,14 @@ SYSCALL_DEFINE2(swapon, const char __user *, sp=
ecialfile, int, swap_flags)
>  si->prio =3D prio;
>  si->list.prio =3D -si->prio;
>  si->avail_list.prio =3D -si->prio;
> + /* Publish the file, live reference and writable state together. */
> + percpu_down_write(&swapon_rwsem);
>  si->swap_file =3D swap_file;
>=20=20
>=20- /* Sets SWP_WRITEOK, resurrect the percpu ref, expose the swap devi=
ce */
> + /* Make the reference live before exposing the writable device. */
>  percpu_ref_resurrect(&si->users);
> - swap_device_enable(si);
> + __swap_device_enable(si);
> + percpu_up_write(&swapon_rwsem);
>=20=20
>=20 pr_info("Adding %uk swap on %s. Priority:%d extents:%d across:%lluk =
%s%s%s%s\n",
>  K(si->pages), name->name, si->prio, nr_extents,
> @@ -3984,7 +3984,6 @@ SYSCALL_DEFINE2(swapon, const char __user *, spec=
ialfile, int, swap_flags)
>  (si->flags & SWP_AREA_DISCARD) ? "s" : "",
>  (si->flags & SWP_PAGE_DISCARD) ? "c" : "");
>=20=20
>=20- mutex_unlock(&swapon_mutex);
>  atomic_inc(&proc_poll_event);
>  wake_up_interruptible(&proc_poll_wait);
>


Using the same rwsem for publication and /proc/swaps looks good.
