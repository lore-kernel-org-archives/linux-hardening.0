Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092D44AF9D7
	for <linux-hardening@vger.kernel.org>; Fri, 11 Sep 2026 19:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789154619; cv=pass; b=QDphnWn6Ik2WT49OmHKAOhX27uiwcrPlADk9g5FIMR9fyIQM/2GxuWxJQm9EVs9+2EG11h3tflUW7W/wc6KJfoBW64RkFxyH8Rc19G0igK3vvHHkRQfcLih21tbPCnu3OVxMFZn8QER0To/n68kdvrl+ctXS8K3n1dvK8AwNKH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789154619; c=relaxed/simple;
	bh=62zlUVJSESl0HyWfkZ7/G3I1CiFlk4lNjkUBrylBGVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A3Gi86QPpOHDL4IMFPFY95z9nUfuyHT4bqg2onLVVy8El5Wu6mwgnFDU8Lw4+pg6Yt0n5RktduVYcJrxP2KGuroqVq+HjACSNcGbPtk0yVYN46txFocgEgg+TWWeJO8bVOSoBqKPirE4JDEzEesTPmyDV15zA1vayZ36RrK1oJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cExi0WMI; arc=pass smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cExi0WMI"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-79381a18412so449981137.2
        for <linux-hardening@vger.kernel.org>; Fri, 11 Sep 2026 12:23:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789154601; cv=none;
        d=google.com; s=arc-20260327;
        b=XoH9TYve+14HKb1sJM3igU6OBdJ9oFDF58WUVIQFuexHsdeP3s2Ja7CDsJvVzfnwgX
         FpOqz7POp8J+BQ1oR4gFBasNvcC5ntxgyjXit4I+8L4Td7yoNHjIEWWkr9I+dejztw68
         zD5ytBc4nBJPeOkUPUU3O8ZzSjkzFDJxiwV4CfNF/2XRbDbGV9p2IvUTGNLNAH1EReVN
         08FfgDkpzt8uE2gi6v2UFzDxdvmb8J0wZqdjksvr8GLqYbfLEmx+9r3uHIh4OJY5eTNF
         x5uWeeQyhVlrYIrH1FWP+4OacSI/ytpPF59TIHFqVS590NcSJr3aJnAgTI4FGe8b+wQP
         0N0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PhVX3j9HCCkbLuuqmLLwRW8XFC61fFVfA+SMOFYe1wg=;
        fh=Do84WBN7y+dNsiiU827GHvlB8wl1pIgLmLLtRYjCH/c=;
        b=I7phcQkV6nGXke7v9Z7FhBc7UDqQ2by9sTl3wmEh+rM9FHjVL2AS4HwvXAVx4V4g+B
         M1Kaz1pbdTaiYeUxumxgzBJShtlYLxa+Qg33SOpYDpbu+sMZKqCpHdY1d4p1WCRVpher
         V2+Zgq/qFoDWVGkPXHUOSc9wD5jisYcuyt6Qg2Nui3yyew6z2K1ZxGS2WIX9U+/ybbeL
         UYvLZmI2GqtG9b0H5AlxIzoJIMqc/R/ua9rEPkSwNV1g1QGGEe3NNwdnF3DsPP5V+sPE
         qQngx/hE3zV2BCHvqk8eSLqIdaWXSh0mwKdCr9cAmbszyMWnw+4yMOeiR0b0TiQY4w6c
         IGZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789154601; x=1789759401; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PhVX3j9HCCkbLuuqmLLwRW8XFC61fFVfA+SMOFYe1wg=;
        b=cExi0WMIHcOCZvcTqDLTdcqiQHap/r8BaZXoI/cJHB0jKopGTkgyYnyodeE0qLtr12
         CAuQCa92ppKueWCdv8wpcuvwkb/Ith6AWe/JvgaehGajN8KucWWO40kif7+RifulEUkt
         74ekcwWU4SslL+YNqn+EZ4ao+logDt588WjeP1sCCon7SE7HKcTfw0rLs642KpY6lVn4
         qU8hcBRQKyg8abAp+nhxUQERuSYWuAMsZ2oJjFr2YF78G7CvGdESF6gLeB/UAKuQRKRu
         8wxHUG+jSPULmfYf7t+iOwqSHHC6YXCvkbU3pB/EMRJEMDngEWs55MVeRyus4Mlm6pZ3
         ymxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789154601; x=1789759401;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PhVX3j9HCCkbLuuqmLLwRW8XFC61fFVfA+SMOFYe1wg=;
        b=bkRD2xr+1NxdZehOA3QWVTAxE4fPtstsvThUr3uMnTntm1oGcLKg1PDN3tk6ck9IAy
         Mzl3SPrx8F/fqE/eGj2zZDJehzJZ204jirzyxJr8R3c9PiUMx5YG1bvAxhgAzUYVbV9h
         5oLxSJhNsf2V+bQnhBxBZqfvXOsTWi7AAKJ+GKBJ/VNUFNjrXodzXAF3cf1tJXyhTdeO
         Lslc02wHsVlYK1+cbjnIAqPzZdZERbedoPuOJxYN90hOGCdDPp9dwgz+WKwgcen40+1R
         OvYyoJ7HlDBDjEOsPbZUVOyn+bMKZirDqVXAuYD4bHX+CQo5xIoZTJIxL3qyPbahDnfP
         /u4A==
X-Forwarded-Encrypted: i=1; AKwUvBxKsflt+ueBMCsIMXe4SyDngyoz6wxXBO4nartzF7uJWN5s0bNcAI/hi8Ks4OyKWW1mqGzaytiTDL023LRdfNM=@vger.kernel.org
X-Gm-Message-State: AFuF++lD+plHruu3hI8wdjNJgMq1la9o7JQ/b0Hb1+8cd+prJ2I29fa9
	kCLPrk36Nn3kcSDebSTIpgvgRBMZXIn3Ax3GQ7hwS+LFmI3CoOUWi0b4DuBN60xbiTCS+azzdcq
	eBIjCPR0suMJGhGl9tCc08SSyjoiE7DW/Ao0m+gk=
X-Gm-Gg: AYBFou3GpQRO9VqJSYg/TQLoEyT6uK+qF8byfeFWddVRJdwq/C30JZCktRNznXG0zh9
	24MedwgCSZ7pM/tai+TD1ZO/b4zWAz0LC07sYwS+sRuUVE+rq+Bs7UFr/MlZqVSa425X86hAiFe
	+Ww/PgAMrxKi/BnjuNiDYbzFca8thOkDWCHiNjMnylVSxPB4AybQXqAKZUlUF19aEVXllogo7nU
	9fn5XhZ3j1jhEiJZ47o6ixczUShqKQqMfL9T+12uFWGUCxSzfsAvwfrHoghlhCGtXQAHJZY44/Q
	fYOua5VK4FlnamjVbg7e5BWhuXaTnq4Iba+3JR8uaec9BMDvargDdudyzX1IHpnxXZzxAnHaF2z
	gpEqMzr0HXnbaCL69Itpm
X-Received: by 2002:a05:6102:41a2:b0:792:2a1e:f9bc with SMTP id
 ada2fe7eead31-792a69532e6mr7921413137.6.1789154595208; Fri, 11 Sep 2026
 12:23:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911-deftig-geprahlt-gesehen-16310bdf51f5@brauner> <20260911-suggerieren-suchaktion-fliehen-87b9cdf1d169@brauner>
In-Reply-To: <20260911-suggerieren-suchaktion-fliehen-87b9cdf1d169@brauner>
From: Bill Wendling <morbo@google.com>
Date: Fri, 11 Sep 2026 12:22:57 -0700
X-Gm-Features: AcwNN1U2UiftgU0O-MISENhtsAPDQT8m10Lr2mdv2yJrv7E3NkvZENDE4lT5Wgk
Message-ID: <CAGG=3QVc0yQ9Cjk5fPzqyqXDzPiWzGO2di2EG0Vwh-TRjtvnkQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] userns: rename insert_extent() and sort_idmaps()
To: Christian Brauner <brauner@kernel.org>
Cc: Bradley Morgan <brads@mainlining.org>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Aleksa Sarai <cyphar@cyphar.com>, Jan Kara <jack@suse.cz>, Nathan Chancellor <nathan@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Gary Guo <gary@garyguo.net>, Alice Ryhl <aliceryhl@google.com>, 
	Douglas Anderson <dianders@chromium.org>, Anand Moon <linux.amoon@gmail.com>, 
	Oleg Nesterov <oleg@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	kernel test robot <lkp@intel.com>, codemender-patching+linux@google.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 5:59=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> The KUnit test suite turned insert_extent() and sort_idmaps() into global
> symbols and declared them in include/linux/user_namespace.h. That header
> is pulled in nearly everywhere through linux/cgroup.h and the btrfs
> self-tests carry a static insert_extent() of their own, so any config
> with both test suites enabled fails to build:
>
>   fs/btrfs/tests/inode-tests.c:16:13: error: conflicting types for 'inser=
t_extent'
>   include/linux/user_namespace.h:212:12: note: previous declaration of 'i=
nsert_extent'
>
> A global symbol needs a prefix. Rename them to
> uid_gid_map_insert_extent() and uid_gid_map_sort(). It's the better name
> anyway.
>
> No functional changes.
>
> Fixes: f6f1a2496ba5 ("userns: Add KUnit test suite for uid_gid_map")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202609110843.okbPe7GM-lkp@i=
ntel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202609110937.zHKPPXJk-lkp@i=
ntel.com/
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Apologies for this. This version of the KUnit testing is susceptible
to exposting duplicate symbols. :-(

Reviewed-by: Bill Wendling <morbo@google.com>

-bw

> ---
>  include/linux/user_namespace.h   |  5 +++--
>  kernel/tests/user_ns_map_kunit.c |  6 +++---
>  kernel/user_namespace.c          | 19 ++++++++++---------
>  3 files changed, 16 insertions(+), 14 deletions(-)
>
> diff --git a/include/linux/user_namespace.h b/include/linux/user_namespac=
e.h
> index 633157781edc..637cd7e91a45 100644
> --- a/include/linux/user_namespace.h
> +++ b/include/linux/user_namespace.h
> @@ -209,8 +209,9 @@ extern bool current_in_userns(const struct user_names=
pace *target_ns);
>  struct ns_common *ns_get_owner(struct ns_common *ns);
>
>  #if IS_ENABLED(CONFIG_USER_NS_MAP_KUNIT_TEST)
> -extern int insert_extent(struct uid_gid_map *map, struct uid_gid_extent =
*extent);
> -extern int sort_idmaps(struct uid_gid_map *map);
> +extern int uid_gid_map_insert_extent(struct uid_gid_map *map,
> +                                    struct uid_gid_extent *extent);
> +extern int uid_gid_map_sort(struct uid_gid_map *map);
>  #endif /* CONFIG_USER_NS_MAP_KUNIT_TEST */
>
>  #else
> diff --git a/kernel/tests/user_ns_map_kunit.c b/kernel/tests/user_ns_map_=
kunit.c
> index 24c21e43a36c..033dccc6a535 100644
> --- a/kernel/tests/user_ns_map_kunit.c
> +++ b/kernel/tests/user_ns_map_kunit.c
> @@ -24,7 +24,7 @@ static void user_ns_map_insert(struct kunit *test)
>                 extent.lower_first =3D i * 100;
>                 extent.count =3D 5;
>
> -               ret =3D insert_extent(&map, &extent);
> +               ret =3D uid_gid_map_insert_extent(&map, &extent);
>                 KUNIT_ASSERT_EQ(test, ret, 0);
>         }
>
> @@ -54,14 +54,14 @@ static void user_ns_map_insert_extended(struct kunit =
*test)
>                 extent.lower_first =3D value * 100;
>                 extent.count =3D 5;
>
> -               ret =3D insert_extent(&map, &extent);
> +               ret =3D uid_gid_map_insert_extent(&map, &extent);
>                 KUNIT_ASSERT_EQ(test, ret, 0);
>         }
>
>         KUNIT_EXPECT_EQ(test, map.nr_extents, NR_EXTENTS);
>
>         /* Now sort the map to set up reverse mapping */
> -       ret =3D sort_idmaps(&map);
> +       ret =3D uid_gid_map_sort(&map);
>         KUNIT_ASSERT_EQ(test, ret, 0);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, map.reverse);
>
> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> index f9cbb4b92b48..98b0279b6cc6 100644
> --- a/kernel/user_namespace.c
> +++ b/kernel/user_namespace.c
> @@ -780,12 +780,13 @@ static bool mappings_overlap(struct uid_gid_map *ne=
w_map,
>  }
>
>  /*
> - * insert_extent - Safely insert a new idmap extent into struct uid_gid_=
map.
> + * uid_gid_map_insert_extent - Safely insert a new idmap extent into
> + * struct uid_gid_map.
>   * Takes care to allocate a 4K block of memory if the number of mappings=
 exceeds
>   * UID_GID_MAP_MAX_BASE_EXTENTS.
>   */
> -VISIBLE_IF_KUNIT int insert_extent(struct uid_gid_map *map,
> -                                  struct uid_gid_extent *extent)
> +VISIBLE_IF_KUNIT int uid_gid_map_insert_extent(struct uid_gid_map *map,
> +                                              struct uid_gid_extent *ext=
ent)
>  {
>         struct uid_gid_extent *dest;
>
> @@ -821,7 +822,7 @@ VISIBLE_IF_KUNIT int insert_extent(struct uid_gid_map=
 *map,
>         *dest =3D *extent;
>         return 0;
>  }
> -EXPORT_SYMBOL_IF_KUNIT(insert_extent);
> +EXPORT_SYMBOL_IF_KUNIT(uid_gid_map_insert_extent);
>
>  /* cmp function to sort() forward mappings */
>  static int cmp_extents_forward(const void *a, const void *b)
> @@ -854,10 +855,10 @@ static int cmp_extents_reverse(const void *a, const=
 void *b)
>  }
>
>  /*
> - * sort_idmaps - Sorts an array of idmap entries.
> + * uid_gid_map_sort - Sorts an array of idmap entries.
>   * Can only be called if number of mappings exceeds UID_GID_MAP_MAX_BASE=
_EXTENTS.
>   */
> -VISIBLE_IF_KUNIT int sort_idmaps(struct uid_gid_map *map)
> +VISIBLE_IF_KUNIT int uid_gid_map_sort(struct uid_gid_map *map)
>  {
>         if (map->nr_extents <=3D UID_GID_MAP_MAX_BASE_EXTENTS)
>                 return 0;
> @@ -878,7 +879,7 @@ VISIBLE_IF_KUNIT int sort_idmaps(struct uid_gid_map *=
map)
>
>         return 0;
>  }
> -EXPORT_SYMBOL_IF_KUNIT(sort_idmaps);
> +EXPORT_SYMBOL_IF_KUNIT(uid_gid_map_sort);
>
>  /**
>   * verify_root_map() - check the uid 0 mapping
> @@ -1047,7 +1048,7 @@ static ssize_t map_write(struct file *file, const c=
har __user *buf,
>                     (next_line !=3D NULL))
>                         goto out;
>
> -               ret =3D insert_extent(&new_map, &extent);
> +               ret =3D uid_gid_map_insert_extent(&new_map, &extent);
>                 if (ret < 0)
>                         goto out;
>                 ret =3D -EINVAL;
> @@ -1091,7 +1092,7 @@ static ssize_t map_write(struct file *file, const c=
har __user *buf,
>          * If we want to use binary search for lookup, this clones the ex=
tent
>          * array and sorts both copies.
>          */
> -       ret =3D sort_idmaps(&new_map);
> +       ret =3D uid_gid_map_sort(&new_map);
>         if (ret < 0)
>                 goto out;
>
> --
> 2.53.0
>
