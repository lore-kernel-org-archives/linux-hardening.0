Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFD33CFF4C
	for <linux-hardening@vger.kernel.org>; Mon, 27 Jul 2026 22:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785190991; cv=pass; b=ZYYz54EEd/a49xm+TyXEfK/XltP8uzIqDQ+uPJk8V+tE5ErWSdHNw4RgVb1vdgj+iSsz2e44xt4mmELDr6q4bVvQvWB60c9OMPw27A2HmoDwcV9qJR646IreSPqjuW57YRQmnfTxNqlIzDmM6NqCo3aIRvepydS7OZ7hpaRT1Sc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785190991; c=relaxed/simple;
	bh=TDzhutHzD/sLLfpYZ28FeavD6O7Gf5eUb9sdeBATOs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PsujIt3+SI/QL4Pj62pYqjCsTiXG/ykH75uNOBgTh6TFAO36zmKksj4g+hDaCGpp0YCSGixgfwGugCJ2DSzLCMxeF+YrrCVcTkr50tVVGEt5ed+KTELPkMrNlUWbPHDVq+ihjjaLnfoH4Xyi/acpPTbZ/moqmgx/S3Qrnu283Mo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RnoxqzBz; arc=pass smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RnoxqzBz"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8ee43b3e5abso25315996d6.3
        for <linux-hardening@vger.kernel.org>; Mon, 27 Jul 2026 15:23:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785190989; cv=none;
        d=google.com; s=arc-20260327;
        b=VkBXveC2lDcftjSrCnmZhnFq7xHhj6VWArmbaUI2DmVRkjaXJauYQDNT8HVSJQlxWU
         Zz2Dd2OHRtaqgl6rXn/g9IhvrWhMzFfPDSLEYpAoXWnk2jafX0PU5b37m+yOYUeKISAQ
         sT2tIjMpT2hVhm/78ByVBy68xn7rHd5N3b5OvBnRTUjuJBOHwCnuL8ghxmW9i9d+kUu9
         5GK91/YaALU/J/lsS6hq8KE1y3aaEc/Ex1DdSDbh+DZLLpKWi2l4mF/NglrmKwbxz0y0
         GR/sauWr3VMcxc+Cm2bsM+RoqqWAo0Ug8vqcP55hG3dqiD53usfPE5uFRqePwt67VgPW
         /PLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/XC5XGybgP6aQhVoIMQftnKAoc955dwi/B0eQbg7BB0=;
        fh=73mGjPZvxdD0Uyk7QzF6FQVvTDl0cYK7+25U92FFU8Q=;
        b=oD4x32RWgPaf2FS1h1cv/aF0wRab+fw+ebHPP1d9biUXa5R3q2UNyYpshtHV4mdJsw
         S8Bnjr2RiADjBBoqDzWnWd+WbboVEiadX0kPjMkV+QZZM5Zy0GnlyzI3HUzIsIpIuHIC
         /xEDc6w6f+BE4k2CyT3gd2P1xj3/8saSBQ0SWrDoARqOjG2VOtkYZbmBj9/UD4yaB63F
         TTesIoPDSljckPhiPNHDxthgSp+K4Z0QC464EXcfK0ESvb8p6pOF1qXAkyBuz0VQObhL
         kl4sZT1nsDqs0d8rjxfqnyD1n1f9qXMPqcll+IS5s9dpzH5P3EwIlJLEhx2j5qSQIu1B
         ETVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785190989; x=1785795789; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/XC5XGybgP6aQhVoIMQftnKAoc955dwi/B0eQbg7BB0=;
        b=RnoxqzBzndfDO3k66QF2x4YIt3oXVD8+izQJCbsxa86IBxId1kyWnU/npJoAqFawyF
         Jp0i06kmKoKh6gSqaiyWyKIrs8wlWqZoIyVnu9+za/Iew3qzn0VMfFDpJSJbFGqg7IdN
         r5uzv46DqPvVOGRnZjzUZjatUoBo1AkH67YI00I2bRyYzEntX5K65ml08/slMAQQiW46
         GcgrCD2Cf1OKjsfFqrjL9wcOC7bfVUVkpfBjSw0F12EJ9CcCH5k8zSra6wTipHGTJCVQ
         Mys505Bjk3lirIyNxIPSrQ4FM+Os2Rfou/hVpR0BxdMc5zbxA/IGdoNWSLHvsTjsrenZ
         t+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785190989; x=1785795789;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/XC5XGybgP6aQhVoIMQftnKAoc955dwi/B0eQbg7BB0=;
        b=VJkTMzvprwQdk6uNkgQ87Jq/UqL8MkO9Dskl7dsr7nI3YkoAHlFSgli5acjiMS6nC1
         C0/H+nhw/KRxQpxOOOwXx3PupQjOTZaiBnaXr7Ct2pMbu7CXej2/YP7I/UaGoC7h/dnC
         fvaa+3Ywh6767hbC1i5yc8E9bMpeTtF+4JwVSW1bIgrsyGiEJDMJ5defQaxZkKLctn4z
         O9f7duQXaCXbiJoIRjXBYjdH70a8WAM1gYieJVVh+OxXw+Lre/Cba9Q8GsYJRliJVXYc
         9C7Sfl3oLDPfiIUvTbvZucj1ClJsuhF6au1HibT6Ijkb7v9kuy0JYRwJqCLhJaSGCBLS
         A/Tw==
X-Forwarded-Encrypted: i=1; AHgh+Rpf9hlzE/146Txu5Pk+aM1rK1NIl5yQ82Pr++e9TgNPqYH9N0q5P/NvdGLwZ5g7Ef5KaZBySE1HJ2fXECDHOVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YybBkFWtcOfZ1IL3lG5iV6NzaNBov/HY6HraB/W6ZSGA4YYIwgq
	nWQPl6zzn30mGJCjJzJZ4QDUSiUglc52lKQXRkY0M5aGDzvuc+58wH/hzze0LnClx6c5lO4ASj8
	xJHx1ayMFFnEBPpkBPtwGjLJBSPoiX5w=
X-Gm-Gg: AR+sD10blfdIMgnKisPJBl/Mx34cSYZ165JdesALSsEDnvKY4T9IQahJ9t66k2yUK9w
	p1CJbE88vV26duPq8g+Egp/z0NytA0nIwUDdulIAh2YqjKgPWGLtmQC0fSmxWR7eD1oduCudoNU
	xbBSkztSK/kPtncKoxJ4lhHOgS6/8/hlh5T6Rz5fXFpeI972VciPwIizh14IxaxuPWRK4/2cTrP
	gSPtrAxexBoRWvPfrJw63mJYFQ92tpPxeWSXcIRfNUWkEgQ51VURA0KrAUrIgUs098AsVlTl/za
	qF8/TWeI/De+uJ6sLL8mALkcKBEig3lMVm5QJQ1FWWamTBYmVgzxMgjAYQJ3LFDCxSTQrEFJUgE
	=
X-Received: by 2002:ad4:5944:0:b0:8ea:fb8c:2e0a with SMTP id
 6a1803df08f44-9081274b851mr17710856d6.28.1785190988688; Mon, 27 Jul 2026
 15:23:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722142936.3287702-1-dev.jain@arm.com> <f3db438e-6cf7-4ccf-bd4f-379c549d1e9d@arm.com>
 <amXldUo3LfIGs-zs@casper.infradead.org> <0a312983-3d63-4d60-8ff4-d53dcfff7819@arm.com>
 <amckUdXO-7TtzhNg@milan>
In-Reply-To: <amckUdXO-7TtzhNg@milan>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 28 Jul 2026 06:22:57 +0800
X-Gm-Features: AUfX_mwpfZInPOMiAbDmvtGKNJf_UoBehbwRIpXxIReBo68o9x-57uEnqdR_TZ0
Message-ID: <CAGsJ_4wGGSf2mhwykH137aA5enhgLGj=-asKe0B09tAOVP8qvg@mail.gmail.com>
Subject: Re: [PATCH] mm/usercopy: harden bounds checking for vmalloc allocations
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Dev Jain <dev.jain@arm.com>, Matthew Wilcox <willy@infradead.org>, kees@kernel.org, 
	akpm@linux-foundation.org, gustavoars@kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, ryan.roberts@arm.com, anshuman.khandual@arm.com, 
	david@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 5:32=E2=80=AFPM Uladzislau Rezki <urezki@gmail.com>=
 wrote:
>
> On Mon, Jul 27, 2026 at 12:33:49PM +0530, Dev Jain wrote:
> >
> >
> > On 26/07/26 4:16 pm, Matthew Wilcox wrote:
> > > On Sun, Jul 26, 2026 at 02:23:20PM +0530, Dev Jain wrote:
> > >> On 22/07/26 7:59 pm, Dev Jain wrote:
> > >>> The vmalloc allocator stores the actual allocation size inside the
> > >>> vm_struct structure. We can use this bound in usercopy instead of t=
he
> > >>> page-aligned va_end to catch usercopy beyond the actual allocation =
size.
> > >>>
> > >>> For vmap, the requested_size field is always page-aligned since it =
maps a
> > >>> certain number of pages. Same for vm_map_ram (alongwith, not even h=
aving
> > >>> a vm_struct). So the check is only relevant for vmalloc mappings.
> > >>>
> > >>> Because there are early vm areas registered even before vmalloc_ini=
t,
> > >>> requested_size may be zero. So also check whether the requested_siz=
e
> > >>> is set.
> > >>>
> > >>> Signed-off-by: Dev Jain <dev.jain@arm.com>
> > >>> ---
> > >>
> > >> Sashiko:
> > >>
> > >> 1. "Does this locklessly access area->vm after find_vmap_area() has =
dropped
> > >> the busy tree lock?
> > >>
> > >> If an out-of-bounds pointer falls into an adjacent vmap_area, and th=
at
> > >> adjacent area is concurrently freed by another thread, its vm_struct
> > >> is freed. Additionally, when the vmap_area is moved to the free tree=
,
> > >> area->vm (which shares a union with subtree_max_size) is overwritten
> > >> with an integer size.
> > >>
> > >> Would dereferencing vm->flags later in this function cause a use-aft=
er-free
> > >> or a wild pointer dereference?"
> > >>
> > >>
> > >> I don't get it. So usercopy is checking OOB for an object but should=
n't
> > >> assume the existence of that object while using it?
> > >>
> > >> It is a bug in the caller if someone does vfree() while usercopy is =
operating
> > >> on the vmalloc object. I don't think usercopy should handle it. For =
example
> > >> we don't handle it for slabs currently.
> > >
> > > I think the question Sashiko is getting to is how we handle:
> > >
> > >     char *p =3D vmalloc();
> > >     copy_to_user(p - 4);
> >
> > Thanks Willy, I completely misread Sashiko's point.
> >
> > I think this is an existing problem? We are using area->va_end currentl=
y,
> > so we can access freed memory.
> >
> It is a bit mess here since now we need also take into account a
> requested_size due to vrealloc. We have requested_size, nr_pages
> and size in the vm_struct.


I see that vrealloc() always updates vm->requested_size to the new size.
So we could always use requested_size? no?

void *vrealloc_node_align_noprof(const void *p, size_t size, unsigned
long align,
                                 gfp_t flags, int nid)
{
        ...
        if (size <=3D old_size) {
                ...
                vm->requested_size =3D size;
                kasan_vrealloc(p, old_size, size);
                return (void *)p;
        }

        /*
         * We already have the bytes available in the allocation; use them.
         */
        if (size <=3D vm->nr_pages << PAGE_SHIFT) {
                /*
                 * No need to zero memory here, as unused memory will have
                 * already been zeroed at initial allocation time or during
                 * realloc shrink time.
                 */
                vm->requested_size =3D size;
                kasan_vrealloc(p, old_size, size);
                return (void *)p;
        }

Best Regards
Barry
