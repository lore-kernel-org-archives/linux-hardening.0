Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778C448BD35
	for <linux-hardening@vger.kernel.org>; Wed, 26 Aug 2026 22:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787781957; cv=pass; b=fyRgVRxoNd+nhuiopLSleSDHLk+NSIaSueW0jOod06TNxhXrszWqz6fu2rwAaDsIx7Zwfh18b+PASty+ZAgKFz2tFwwtHxVe3d8GmsFrG4ldZW1lSXHrjY/3HHTvwUj2dwzJOtCONwSy5RONjybjzsqKt+YaY/OEbrRFkpdQ4yU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787781957; c=relaxed/simple;
	bh=91iL9f66E+wP8pylRCnex07f+0OG4EAgBRLF2xhH3XM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fv4ykIS6M/Wd4Ff17QO6qffSklsiSQPFGRu6SOOhSTLaC/4enGneOEqqd+++HCAmLAUn+B1T9qKSVuxr1gdZgKEdjQ9F1H5kyGepPpzK4X5EvRngDtorM7M7KpTGkn/zRYUCZ3ep+EfbBpaucs63B5yAgmoLYDP2L4oFJGMp5RU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BZutVFYt; arc=pass smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BZutVFYt"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5c664b8c3f3so840244e0c.0
        for <linux-hardening@vger.kernel.org>; Wed, 26 Aug 2026 15:05:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787781952; cv=none;
        d=google.com; s=arc-20260327;
        b=skAJK80g1oeRh6HDY/WQbKFIRzb1mQP95oou3cnkqS+mO24Fq7F9kTnmLz44kp4405
         eNpyr1XF4nEGD3Z4r/A4ox+bvtFDx761ylLVC5cQWeH759VGnpkOO4hS0PZhqhkg5qSm
         WWjMWb/hvQI/c7rpDpeh5eFD/hKiVvvN7VzVsCKREgFp4qlngGZQQJFztiLZSaX1w46y
         cOqLDdx3q2Ix5Dw/JyQl/p25EpcWFZGmxJkMX70rzg5qJH0FJyMw9GBHsHkVVBtelR62
         lmSrwwG79FceMexisDbE9HCeC36BIFcbDlyK0pgLXw1YC2yarlGcF6Ym+iGyfpA8tgU5
         5FVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VjNbxpuIxc8u8B4OZa7lx8RIdcA7nogA195cjmoHW0I=;
        fh=1f4cGkgVZ7k3D1cfBmc7x9qYV5m6ypsKBcCZgiuPFXE=;
        b=buvg+MwgkGYS940URZP5avU4EMqEaFa3mMcMgUVxQBHFRrsRV6b7A/ZWGCNevUSUrM
         lWlwBt0GXc4MnKl3OgQH9KHFlzl5lgHh0xuGPaPUi1hqf9RbJAvAP+katNA8oI9EEkt6
         GNcyK/x1c8V243R8eCJHk6UfJBf7KkUQMcff6BCiEbm7aPJoVvgMLAVcBB5zzOkuKJmb
         ns+cR54GdLCBoUWs9q/cpJdCtaLD80pCE+b/NDJry+0p+F5zx/pnsU3jb0/Pd1uYDnX5
         A+wpFzgobnVLaaZMUPi+IWE3CJFWQI0Vh0bBY+DVSRb0fRDmJteNibnVN+T1wiVicBRw
         ZTew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787781952; x=1788386752; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VjNbxpuIxc8u8B4OZa7lx8RIdcA7nogA195cjmoHW0I=;
        b=BZutVFYti3QgMatmn8loY8f1RKPvHX+jT3tgoi7KGiMPyshbgT06GgnLqi9uUJPmPh
         zi+kcj3L/crDHMUuu+//ugOG7mW8Glk9AV9lF4T5hpyrVUdAqkcZzEIFuvB9mWai4CqC
         8z8mGfYxj6Ft68I43L/PuNJNJ3UksrDy44Bb6/YRERUgUY2NnWNGRUbxNr8e2zGKMRqE
         v4trOG7xKU3f9JaD/SK3PrL+zDR2ywgnOEuQ52qCh8c/W87LxBjGFXIwXUR2gChKCUNN
         N+P0IoHn9SWtnUtJTw/Z0Iack+bR6seuoK+hxcFPKVy1HLtCP3LP0LXKx2H/hkj81czx
         ieCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787781952; x=1788386752;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VjNbxpuIxc8u8B4OZa7lx8RIdcA7nogA195cjmoHW0I=;
        b=i775aI+RS4uiQ8ag5CsIr/V+q13QOQXhqdgXEYVCiAukjojuriAeYWRElq7QsgyX0+
         FgaqKaayXI5t0JvYuL+RM8nOxgEL0MWb54MtL+ZvoCxWkUUj4ZdJyE6Teb/YWc1SHoaE
         DFmy1zr2Zi1/TpLefzVme31QdIsWBYO0Wu9/5vNEwFDZfHel998U0ElGjSUgoPaWRHYy
         OM2RgJoiqbVSZkpY9MdjK8esi9IrlA+Yx0JduyYfyfHtdWJMwKKB0o1zPJtFiho56yxb
         /XT7Pv1oNOG5/p2WUOnwhLEfFcDZOXnmd2elUCShqFrs7QIOnX+KlQt8wOHDv8HjmYF5
         Gn9g==
X-Forwarded-Encrypted: i=1; AHgh+RrLfZXLlncOPodmFGMCRa6hi0splKaZ4t2EZ0d6aKAr39Ucg0OX0HSHMvi7Iah2xB7J5hzE9Y07raGUQABmfHQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nslAKTiKhTOViAY33EM1b4dFK2I6G/gBTGB3q8y6zrj45UqxWE
	VMDNefC1oziz9mpKAvI4otK4a+e8lS4K/lI0W+WeeOqPgQsi/NhnpbRLybeKkQkqXQEOCu/yXbf
	Sa+sErfUltTl3Zp8nFUpl0HzmOOh418VhGVU97VM=
X-Gm-Gg: AR+sD11uct0CgGsGDSbiXRxliMYdwvZDBLL9MlsY3PCzJmMkpv1tpRtXSB4CpnQ3TaZ
	v7EGpmKHGUJCEv3LNGsYl7kKhpqeyDz0OQWkiIgfRN2LTmXDkG8yxrHhddBrVfEYz6c7uszljJA
	0Y7sS/6YVijHDemp7YVbk8/l+wuS3wA3T5m58PLB0PW1QOdYioAZNcKl5azkffcXpfKk002wzvo
	C72iIs/HF6VRtQnreNNEXUHB0KnP+FlRXRPN7gDy+MeHgTt//AJdK/vIooeH23GV0kPVCTuQ/B3
	BNK0SQCob0EoNSptX5BtG4AKmwAnR+D6u5d4uErHxbhMpSfqxRH6FBcl3jN1j8kQHCk7QRJ9KSl
	dHXa1lKv5xB0TYoj5j7obTPtr4xB9PronQx5lIxo7HA==
X-Received: by 2002:a05:6122:4885:b0:5bd:a5e1:c7c7 with SMTP id
 71dfb90a1353d-5c65ba22909mr4924761e0c.1.1787781951366; Wed, 26 Aug 2026
 15:05:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260823125155.1136740-1-morbo@google.com> <20260823125155.1136740-2-morbo@google.com>
 <aosJJXsQbUUcCDpx@redhat.com>
In-Reply-To: <aosJJXsQbUUcCDpx@redhat.com>
From: Bill Wendling <morbo@google.com>
Date: Wed, 26 Aug 2026 15:05:34 -0700
X-Gm-Features: AcwNN1U-TxlG5zIoBUs2QqswLbS96u-jmZfkR3Z0OUMS7ZiUU8YcDxnDYuExDFQ
Message-ID: <CAGG=3QXo7bvOJn+T=fLYYZMdC-1SiSicThAHkj_hfyO5i6=pEg@mail.gmail.com>
Subject: Re: [PATCH 1/2] userns: Add __counted_by_ptr attribute to struct uid_gid_map
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Aleksa Sarai <cyphar@cyphar.com>, Jan Kara <jack@suse.cz>, Nathan Chancellor <nathan@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Alice Ryhl <aliceryhl@google.com>, Douglas Anderson <dianders@chromium.org>, 
	Anand Moon <linux.amoon@gmail.com>, codemender-patching+linux@google.com, 
	linux-hardening@vger.kernel.org, Alexey Gladkov <legion@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 23, 2026 at 7:52=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 08/23, Bill Wendling wrote:
> >
> > The compiler attribute __counted_by_ptr associates a pointer field of a
> > struct with a sibling field within the same struct that specifies the
> > element count of the allocated memory. This enables KASAN and fortified
> > bounds-checking to detect out-of-bounds accesses to the pointer field a=
t
> > runtime.
> >
> > We can add the __counted_by_ptr attribute to the 'forward' and 'reverse=
'
> > pointer fields of 'struct uid_gid_map', which are counted by
> > 'nr_extents'. Since 'nr_extents' is defined in a sibling anonymous
> > struct inside an anonymous union, the nearest common non-anonymous
> > struct level is 'struct uid_gid_map' itself, which is supported by the
> > compiler.
> >
> > However, doing so has runtime implications. In the original
> > implementation of insert_extent(), elements are written to
> > map->forward[map->nr_extents] before map->nr_extents is incremented:
> >
> >       if (map->nr_extents < UID_GID_MAP_MAX_BASE_EXTENTS)
> >               dest =3D &map->extent[map->nr_extents];
> >       else
> >               dest =3D &map->forward[map->nr_extents];
> >
> >       *dest =3D *extent;
> >       map->nr_extents++;
> >
> > At the time of writing to 'map->forward[map->nr_extents]',
> > map->nr_extents is still 5, but we are accessing index 5 (which is the
> > 6th element). Under __counted_by_ptr(nr_extents), the compiler and
> > KASAN expect the accessed index to be strictly less than
> > map->nr_extents. Therefore, accessing index 5 when the count is 5
> > triggers an out-of-bounds panic/trap at runtime.
> >
> > To resolve this, insert_extent() is refactored to increment
> > map->nr_extents first, and then use map->nr_extents - 1 as the index:
> >
> >       map->nr_extents++;
> >       if (map->nr_extents <=3D UID_GID_MAP_MAX_BASE_EXTENTS)
> >               dest =3D &map->extent[map->nr_extents - 1];
> >       else
> >               dest =3D &map->forward[map->nr_extents - 1];
> >
> >       *dest =3D *extent;
>
> I leave this to you and other reviewers (add Alexey), you can safely
> ignore my nit.
>
> To me
>
>         if (map->nr_extents < UID_GID_MAP_MAX_BASE_EXTENTS)
>                 dest =3D &map->extent;
>         else
>                 dest =3D &map->forward;
>
>         map->nr_extents++;
>         dest[map->nr_extents - 1] =3D *extent;
>
> looks a bit more clear, but this is minor/subjective.
>
> Either way, I think this needs a short comment to explain why do we
> need to increment ->nr_extents first, then subtract 1. IOW, to explain
> why (say)
>
>         dest[map->nr_extents++] =3D *extent;
>
> would be wrong.
>
Hi Oleg,

I added a comment before the code in question explaining why it's
organized that way. I certainly don't hate your version, but for
simplicity of reviews I just left the code as is.

-bw

> Oleg.
>
> > Assisted-by: Gemini Next
> > Signed-off-by: Bill Wendling <morbo@google.com>
> > ---
> > Cc: Kees Cook <kees@kernel.org>
> > Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Aleksa Sarai <cyphar@cyphar.com>
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: Nathan Chancellor <nathan@kernel.org>
> > Cc: Miguel Ojeda <ojeda@kernel.org>
> > Cc: Thomas Gleixner <tglx@kernel.org>
> > Cc: Nicolas Schier <nsc@kernel.org>
> > Cc: Gary Guo <gary@garyguo.net>
> > Cc: "Thomas Wei=C3=9Fschuh" <thomas.weissschuh@linutronix.de>
> > Cc: Alice Ryhl <aliceryhl@google.com>
> > Cc: Douglas Anderson <dianders@chromium.org>
> > Cc: Anand Moon <linux.amoon@gmail.com>
> > Cc: Oleg Nesterov <oleg@redhat.com>
> > Cc: codemender-patching+linux@google.com
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-hardening@vger.kernel.org
> > ---
> >  include/linux/user_namespace.h | 4 ++--
> >  kernel/user_namespace.c        | 8 ++++----
> >  2 files changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/linux/user_namespace.h b/include/linux/user_namesp=
ace.h
> > index e38d9e60569f..2962256eddf7 100644
> > --- a/include/linux/user_namespace.h
> > +++ b/include/linux/user_namespace.h
> > @@ -29,8 +29,8 @@ struct uid_gid_map { /* 64 bytes -- 1 cache line */
> >                       u32 nr_extents;
> >               };
> >               struct {
> > -                     struct uid_gid_extent *forward;
> > -                     struct uid_gid_extent *reverse;
> > +                     struct uid_gid_extent *forward __counted_by_ptr(n=
r_extents);
> > +                     struct uid_gid_extent *reverse __counted_by_ptr(n=
r_extents);
> >               };
> >       };
> >  };
> > diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> > index 0bed462e9b2a..7e5371d8f515 100644
> > --- a/kernel/user_namespace.c
> > +++ b/kernel/user_namespace.c
> > @@ -809,13 +809,13 @@ static int insert_extent(struct uid_gid_map *map,=
 struct uid_gid_extent *extent)
> >               map->reverse =3D NULL;
> >       }
> >
> > -     if (map->nr_extents < UID_GID_MAP_MAX_BASE_EXTENTS)
> > -             dest =3D &map->extent[map->nr_extents];
> > +     map->nr_extents++;
> > +     if (map->nr_extents <=3D UID_GID_MAP_MAX_BASE_EXTENTS)
> > +             dest =3D &map->extent[map->nr_extents - 1];
> >       else
> > -             dest =3D &map->forward[map->nr_extents];
> > +             dest =3D &map->forward[map->nr_extents - 1];
> >
> >       *dest =3D *extent;
> > -     map->nr_extents++;
> >       return 0;
> >  }
> >
> > --
> > 2.55.0.860.g4b6b3295ed-goog
> >
>
