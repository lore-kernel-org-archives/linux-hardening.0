Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795714002;
	b=18TkRn/Mc/vux7LcsxQuMPzxKm+WKcfJIOozNE0eJ57rmd/LR/561tcPBBjopERbQUHo
	 U28nnJ1dnoDoKBQJvctqx6Hcwbs6QYUjVXv/D413maiXfavOKdm4KcYzgRxgQLMOy3GxW
	 Ar3ZSRv80Fo1TQD/W8KXLVhW3n8uGvAIId5L6pSaYI9ChcQSpXIUJdI9qV8ClSKJ+yW3C
	 hYV7jL77sjeD8jk3f6Za680+Y05NvWehPzIXO5TlTVCwQSgl3NM28nycXL9zqsvNSa5KV
	 D061JXLlP4uQh0MGmwkmks3Mt+z/bkt07rehiBDjQ7cpfgL+YdmqRzysZ9daGtPXZEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795714002;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=3TsAdFflCae5+igj5qVBS4hOwgiKQAIIPXHogQ5HlvU=;
	b=gRzO5Eq38v7YHFKpqKNo0GPHvz9F/ep99uue76BOOzCACGkYMYAB2HeiNaWQ4Uodj30r
	 3ozqMWb75UJfDh6aNbKz+yDQBHwJN9sE4uisoz8k7uRdKvdlh3vKBCEnV+xrELosjuJSt
	 EmFLk+Iu+Qty0SJ8lrfLTEDf8aDVO9TLk2iro/i030hj6soIIdu7MCm0WkpdY3qhxqa8M
	 O6amtfmJUsgfPi0DMIfn9wJ+AwMzVrQd12EBnA5416I0MiaI7mWn5VmZ+6bOt1ArJjeD2
	 jAc+y32EE8lpPxWjfKP4jmoG7Q2T+hst/uSHWYo25gLVh0fPUd490K8esQDNzobLxDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nXW9C6+2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4130606A31E
	for <linux-hardening@vger.kernel.org>; Thu, 26 Nov 2026 17:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nXW9C6+2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60FA31F000C0
	for <linux-hardening@vger.kernel.org>; Thu, 26 Nov 2026 17:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795714002;
	bh=3TsAdFflCae5+igj5qVBS4hOwgiKQAIIPXHogQ5HlvU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=nXW9C6+2gF1Q3zHNBPh8fBgfcJl1KF5jCuJOoyL8o79r4Jo4Qi8RYCE+y3y4gVhgg
	 nc0b1UM4KedhJ77WRrrMSxTvgEbywdv1OgVa9r0kq3ZJ3XScT//RfFOmrX2BOiVeBi
	 hdZiOKM3USpja0gYDwehlfItA/pcQkbB79zrz4+otu/2TxbHHZIs3uRTsihpvOIgdX
	 aNP0NmKyp/EvuGg+wAtzZgJvFcratHTWORY+eT96S0iegXqA0+5VQVnkSsKLgGOz78
	 bxi3hI5Ea+s3u6VibI5gvHyAO6QM854aMb9ECLC1130omghVqMrOtr9fPNXW3bMvT8
	 fRYG6YNFRth8g==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6bab10844b5so8207791a12.1
        for <linux-hardening@vger.kernel.org>; Thu, 26 Nov 2026 09:26:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErG67aBdVkOZMZ0UbiQS3j/Ik5Q45piwxCPsXODTc/C5SkL1AzuSjZJBpNVHf/QnlOkB9fj6UOy+lcpz9peGS14=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Lot6MxjkAc7f+pf6VauAuWMfitExKmeMHj7b7EiBKvMK23KU2
	kqJe7kcjhuMSiEyXeHV9RIgJjJS9yUhLrOqrbSC8tlpLnB5wA63D9pjc10dpxAi8tnyIdXIFNM3
	TxORRL6Ri5MJAzjI5b4DABcdQRrY/kukuq+TzFt9cqw==
X-Received: by 2002:aa7:d8c6:0:b0:6b7:8b02:726e with SMTP id
 4fb4d7f45d1cf-6ba1fc20931mr13487563a12.18.1795714001262; Thu, 26 Nov 2026
 09:26:41 -0800 (PST)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1795439990.git.lianux.mm@gmail.com> <be6ef058f4a6babd3562270daa5b61c4ff9a6a50.1795439990.git.lianux.mm@gmail.com>
In-Reply-To: <be6ef058f4a6babd3562270daa5b61c4ff9a6a50.1795439990.git.lianux.mm@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 26 Nov 2026 09:26:29 -0800
X-Gmail-Original-Message-ID: <CACePvbU2cg1EVBjONWjYcsanDM0JS4eLXgX9aGYeEaXu4zZ2-w@mail.gmail.com>
X-Gm-Features: Aa3M54rq-_aDaC2IZzYFQcaEVIrU54eEGaMwFyEv8kqdmSEUInVdyb4y-llAiSs
Message-ID: <CACePvbU2cg1EVBjONWjYcsanDM0JS4eLXgX9aGYeEaXu4zZ2-w@mail.gmail.com>
Subject: Re: [PATCH v5 04/19] mm/swap: introduce swap device iteration helper
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

On Mon, Nov 23, 2026 at 6:16=E2=80=AFAM Lian Wang <lianux.mm@gmail.com> wro=
te:
>
> From: Kairui Song <kasong@tencent.com>
>
> Separate iteration over allocated swap_info descriptors from iteration
> over writable devices. Hibernation lookups require SWP_USED and
> SWP_WRITEOK under swap_lock. Take a single snapshot for each flag
> test, since unrelated bits in the same word can change during setup.
>
> drain_mmlist() only needs the atomic usage count; walk every
> descriptor without loading flags there. In si_swapinfo(), count
> usage only for descriptors that are in use but no longer writable.
>
> Move the live-reference warning from __swap_type_to_info() into
> __swap_entry_to_info(). The iterator must inspect descriptors before
> applying its flag filter, including descriptors whose device reference
> is dead; entry-based lookup retains the warning.

The patches looks good. Some minor nitpick follows.

Acked-by: Chris Li <chrisl@kernel.org>

Chris

>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Signed-off-by: Lian Wang <lianux.mm@gmail.com>
> ---
>  mm/swap.h     | 12 ++++----
>  mm/swapfile.c | 77 ++++++++++++++++++++++++++++++++-------------------
>  2 files changed, 54 insertions(+), 35 deletions(-)
>
> diff --git a/mm/swap.h b/mm/swap.h
> index d488a69c2809..70fd3ab655ff 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -108,16 +108,16 @@ static inline unsigned int swp_cluster_offset(swp_e=
ntry_t entry)
>   */
>  static inline struct swap_info_struct *__swap_type_to_info(int type)
>  {
> -       struct swap_info_struct *si;
> -
> -       si =3D READ_ONCE(swap_info[type]); /* rcu_dereference() */
> -       VM_WARN_ON_ONCE(percpu_ref_is_zero(&si->users)); /* race with swa=
poff */
> -       return si;
> +       return READ_ONCE(swap_info[type]); /* rcu_dereference() */
>  }
>
>  static inline struct swap_info_struct *__swap_entry_to_info(swp_entry_t =
entry)
>  {
> -       return __swap_type_to_info(swp_type(entry));
> +       struct swap_info_struct *si;
> +
> +       si =3D __swap_type_to_info(swp_type(entry)); /* rcu_dereference()=
 */
> +       VM_WARN_ON_ONCE(percpu_ref_is_zero(&si->users)); /* race with swa=
poff */
> +       return si;
>  }
>
>  static inline struct swap_cluster_info *__swap_offset_to_cluster(
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index f22197a6286c..56b75770d320 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -106,6 +106,34 @@ static DEFINE_SPINLOCK(swap_avail_lock);
>
>  struct swap_info_struct *swap_info[MAX_SWAPFILES];
>
> +static inline struct swap_info_struct *__swap_iter(int *i, unsigned long=
 flag)
> +{
> +       lockdep_assert_held(&swap_lock);
Nitpick: Suggest have a internal version of "int _i", then sync to
"int *i" at function exit.

> +       while (*i < nr_swapfiles) {

The trick part of this is that, if the caller change *i between you
test *i < nr_swapfile and you use *i for __swap_type_to_info(*i), you
can visit out of bound array.  So having an internal version of  *i as
scalor will remove that abuse. It is likely the compiler can generate
better code as well because it avoids needing to know about pointer
aliasing with pointer. I think your later verison might need to use
more complicate inter state that "int i", so you might as well make it
a inter struct which contains "int index" now.

> +               struct swap_info_struct *si =3D __swap_type_to_info(*i);
> +
> +               VM_WARN_ON(!si);

You don't need this WARN ON. When i < nr_swapfile, the swap_info[i]
array can never the NULL. If you are paranoid you can continue if "si"
is NULL.

> +               (*i)++;
> +               if (flag && (READ_ONCE(si->flags) & flag) !=3D flag)
> +                       continue;
> +               return si;
> +       }
> +       return NULL;
> +}
> +
> +#define __for_each_swap(si, flag)                      \
> +       for (int __i =3D 0; ((si) =3D __swap_iter(&__i, flag));)

This is a bit too cose to for_each_swap_info. May be __for_each_swap_dev_fl=
ag()

> +
> +/*
> + * for_each_swap_info - iterate over all allocated swap descriptors
> + * @si: the iterator
> + *
> + * Context: The caller must hold swap_lock. The lock may be dropped duri=
ng
> + * the loop body but must be re-acquired before the next iteration.
> + */
> +#define for_each_swap_info(si) __for_each_swap(si, 0)

NITPICK: for_each_swap_dev()?

> +#define for_each_avail_swap(si) __for_each_swap(si, SWP_USED | SWP_WRITE=
OK)

NITPICK: for_each_avail_swap_dev()?

> +
>  static struct kmem_cache *swap_table_cachep;
>
>  /* Protects si->swap_file for /proc/swaps usage */
> @@ -2284,26 +2312,18 @@ void swap_free_hibernation_slot(swp_entry_t entry=
)
>
>  static int __find_hibernation_swap_type(dev_t device, sector_t offset)
>  {
> -       int type;
> -
> -       lockdep_assert_held(&swap_lock);
> +       struct swap_info_struct *si;
>
>         if (!device)
>                 return -EINVAL;
>
> -       for (type =3D 0; type < nr_swapfiles; type++) {
> -               struct swap_info_struct *sis =3D swap_info[type];
> -
> -               if (!(sis->flags & SWP_WRITEOK))
> -                       continue;
> -
> -               if (device =3D=3D sis->bdev->bd_dev) {
> -                       struct swap_extent *se =3D first_se(sis);
> -
> -                       if (se->start_block =3D=3D offset)
> -                               return type;
> +       for_each_avail_swap(si) {
> +               if (device =3D=3D si->bdev->bd_dev) {
> +                       if (first_se(si)->start_block =3D=3D offset)
> +                               return si->type;
>                 }
>         }
> +
>         return -ENODEV;
>  }
>
> @@ -2470,16 +2490,13 @@ int find_hibernation_swap_type(dev_t device, sect=
or_t offset)
>
>  int find_first_swap(dev_t *device)
>  {
> -       int type, ret =3D -ENODEV;
> +       int ret =3D -ENODEV;
> +       struct swap_info_struct *si;
>
>         spin_lock(&swap_lock);
> -       for (type =3D 0; type < nr_swapfiles; type++) {
> -               struct swap_info_struct *sis =3D swap_info[type];
> -
> -               if (!(sis->flags & SWP_WRITEOK))
> -                       continue;
> -               *device =3D sis->bdev->bd_dev;
> -               ret =3D type;
> +       for_each_avail_swap(si) {
> +               *device =3D si->bdev->bd_dev;
> +               ret =3D si->type;
>                 break;
>         }
>         spin_unlock(&swap_lock);
> @@ -2996,12 +3013,14 @@ static int try_to_unuse(unsigned int type)
>   */
>  static void drain_mmlist(void)
>  {
> +       struct swap_info_struct *si;
>         struct list_head *p, *next;
> -       unsigned int type;
>
> -       for (type =3D 0; type < nr_swapfiles; type++)
> -               if (swap_usage_in_pages(swap_info[type]))
> +       for_each_swap_info(si) {
> +               if (swap_usage_in_pages(si))
>                         return;
> +       }
> +
>         spin_lock(&mmlist_lock);
>         list_for_each_safe(p, next, &init_mm.mmlist)
>                 list_del_init(p);
> @@ -3997,14 +4016,14 @@ SYSCALL_DEFINE2(swapon, const char __user *, spec=
ialfile, int, swap_flags)
>
>  void si_swapinfo(struct sysinfo *val)
>  {
> -       unsigned int type;
> +       struct swap_info_struct *si;
>         unsigned long nr_to_be_unused =3D 0;
>
>         spin_lock(&swap_lock);
> -       for (type =3D 0; type < nr_swapfiles; type++) {
> -               struct swap_info_struct *si =3D swap_info[type];
> +       for_each_swap_info(si) {
> +               unsigned long flags =3D READ_ONCE(si->flags);

Hmm. There is a READ_ONCE(si->flags) inside for_each_swap_info() as
well. Now you have two READ_ONCE(si->flags). How do you ensure that
flag between two READ_ONCE is always synced?

>
> -               if ((si->flags & SWP_USED) && !(si->flags & SWP_WRITEOK))
> +               if ((flags & (SWP_USED | SWP_WRITEOK)) =3D=3D SWP_USED)

I think for_each_swap_info() requested flags as SWP_USED |
SWP_WRITEOK. Is this intent here to catch the race that SWP_WRITEOK
get dropped after the for_each_swap_info()?

Chris

>                         nr_to_be_unused +=3D swap_usage_in_pages(si);
>         }
>         val->freeswap =3D atomic_long_read(&nr_swap_pages) + nr_to_be_unu=
sed;
