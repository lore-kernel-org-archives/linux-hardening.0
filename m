Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398DD282F05
	for <linux-hardening@vger.kernel.org>; Mon, 30 Mar 2026 23:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774913074; cv=pass; b=ZAoaFoGFMcvehZ62o90xyOWQfENsw9s/4sWIrdViRs8BhRwQ/ymXWyFbyW9VcYf0c5L6gxJcMwJma5HnPfFhLq420AzAEKAsW5nHIaJ0p+YKpYw9e5v3fgI9EDUewjs2asYoP1Ff9TKJIN9DA95ObnxlxIK9qJWsMyuOieTdm30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774913074; c=relaxed/simple;
	bh=Yg/Wzcwr8nuTOj+aY3bK0uncV0Afs/fkAKyBSA43g1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M9nJQ3lEBCcv06MNQ9wiD31LZJAkH49hT+zM4Jfd7nCV614F/QOywEbMUxOwt0NO1+bjBTViVwjqz1QnICQaUSy/2+Fv/Bvi5zc6hQnrKG+Fq71A2oiwg40GQb+bzhPkmaCQdLXA9UPPYH7sXfg+QVNDtIuSq2A7fQGb/U+iCZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZD4Nznx; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZD4Nznx"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-66ba9dfe83bso3120600a12.3
        for <linux-hardening@vger.kernel.org>; Mon, 30 Mar 2026 16:24:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774913071; cv=none;
        d=google.com; s=arc-20240605;
        b=LbqtqUtILXBpmBEM8bL/HHflTgmzwuRzRkFJ46p9oNVEZPa0FoZNrQZaStnhxjCfzx
         G97EgCI9lRbtAvXzX857N/oDcu+fU/v+DcI5RLIubeO5n7fGW9zaOvp+rFmSw6L3m80+
         7kFeZvesA31CEzzqh2Lst2vytcq8ZyNPT+7QpRWmWWyIj3wsS/yy+vGDFCzl5XVA/oRG
         O8HQNeanMo03szECGxDqxIzjXkk5CBpZrGcpXKveHJJl5oQGPaGzFtgmthmiXpQL19F3
         T7eQZYPRfBGbdrrI0dcwecEVEeC7KzYwrRs1kdIUdfhiQRM/7y03O04dU0Kdc7MiWQvI
         iBdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RGfKApATujoLitWhmu/Cx+UsmpT3qyPoRiwmqHbs/r4=;
        fh=aMe4IP3BEyVP6rQfT+VoqSE+RAkA4Up2ltWIY+11qpw=;
        b=hPQPtkDqVIYE1oT8iRLy76eFHXp6fElxMGwHce1zZOMMIwf11P5L1Jvx73RxqvkLNJ
         U/x2In8+OzMUXPVy0vEqQGRTFev9195Sgyq7Y4kRCW+u9KJVq7JPYzj0eDaUIcYG+AlF
         4kjbSYM6piVBXnliTtTCvkacfjovlos9VZudOkBHbFCq6uErf+hRhSkfKGLq/8VHv8Zm
         TrxcxKvDvjTsUfyhJ5ubifiz4k5dkGC+optUyxkpGo8IOCxja0WF4RygNDbYwREruMOh
         /Svbz7WvCnDOODJ0nOKiyN8nXvhFjcCAUOSXn6MHh9sE/DthDf9pg/cjeE34pkUEjsnT
         k39w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774913071; x=1775517871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RGfKApATujoLitWhmu/Cx+UsmpT3qyPoRiwmqHbs/r4=;
        b=RZD4NznxKAgRkoRaQC9NZNLDQJDH8G60CJdN0xO9SF6mzQn4pmjm0b/tFvgJfBnmhJ
         GS6SWTZK6OWfMqOlmjVzV6gMjALoiXb+BSfmvZsaedQ8J5Ejn66dmw9mpq1eunrWi1mv
         4d6yyjbSf2UbPWbi7OPLKe4MAuBAtwEOBJ0ii9gE/OwIs/1L223mqyyY5SdG4hGfjkJB
         2BVskOfAaibJoWbgtnL4lFVIlN4OU1Hd2gT9UnLHRVis3PdPp8+gDB16v7+zBN3ARsIE
         dpYnovikmBIprQ64aVCkzCgTzu4Ix/jbOyePKePFy1tWenKDZwOdyQEsN9mvj24j32SR
         ycwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774913071; x=1775517871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RGfKApATujoLitWhmu/Cx+UsmpT3qyPoRiwmqHbs/r4=;
        b=fwm7qbbMoMo77Np+Yzbhnv58iSlOlIiWvnaDFePIYukntcWt9Rnt7ac3Vk6KtnO/mg
         yayqwUTFVeOIk7xpm0Ju5yswIUei+8fYhDPMiLOiPK9iosp8fZOa1tGSf3EEUt9OoOhE
         ro7Yprzj2r5wxwUDLuSNZYEDjZwuQNlu7TTuKhIdsUKjBivzsxSQMOJlvJewjZGsOn53
         43pe/FpKmUbfc3WJBs/6iuyQOg9T54wwVy+oUlDSExQJaYyfqI9W1hvpjDf5NY891QBA
         ZgNnqXY6xs3VeXM8VYuShkTMyUEL3U6eXfI3UxMXKiAOaFNxfjSE+5480QkRr61r6KVB
         jiVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUykiUZwL9TxRZOUeuGYE/6E6yy1UOre1R1oTLzSbzSXrLRzz3HJmthGv9wURzHO1v7iH1ZsHGY8qRwcRTANUA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/ZUwRCx02VPlpQyMuDdkTCGTHrCBtvllJvL7h78+ka3BX9Fjr
	WERbtrOtBn/qWt6cnoqv9ZREaheEPnqu1jE/ThhaVv6ReRNip+3iqvpNrKFxdZgRh5VHZVVYoiT
	sneM0uDruWPwv+iY0mtElrcztGdbp0i4=
X-Gm-Gg: ATEYQzzoLlZ+/qjf6ZkplPsV4IQcn1BuWB5hGaKuAtONkVZmqK0k0V3o9YSkMLjSKgS
	qwvVNh4VQn+vfitJ8kaGAoh0444ikt1yDyZlwFtbubVLfoMClV1HW0OtZKWBOIXJiwXnMSnAPRr
	faw4ooqwGeai5hI9pEeJIvTsv9XrvMrjGZx+iDI2iGWEcFOi95awa+WcHLEIBHQjAczKSle+BBv
	2OzIo4Kuw2LSXdTbWTFND31N5o6P+MN2hdaD8x90UiRpXyZ3XLHMuEX1MInBBaNApu5kNpDk13v
	abSSP1R40TeTw6si2vdHUWdbAw2tnu3c0HriNyzuPLaowEM+Ae1ktTLOEeMAsnZArEdAreIu15U
	wOnAniA==
X-Received: by 2002:a50:fb99:0:b0:66b:3d06:bfff with SMTP id
 4fb4d7f45d1cf-66b3d06c24cmr5309095a12.21.1774913071422; Mon, 30 Mar 2026
 16:24:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326023747.54485-1-rosenp@gmail.com> <20260330161933.6471d473@shazbot.org>
In-Reply-To: <20260330161933.6471d473@shazbot.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 30 Mar 2026 16:24:19 -0700
X-Gm-Features: AQROBzAidcpIVCd1YiJIrE0vM9y7-srtU0yd-xhmfvOW4gWw8BUXK5VZROzReug
Message-ID: <CAKxU2N8rpaLXXsD7sUvw3ffMe8JUREGc9ru_HX0r4Uw4RT_q1g@mail.gmail.com>
Subject: Re: [PATCH] vfio: pci: use kzalloc_flex
To: Alex Williamson <alex@shazbot.org>
Cc: kvm@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>, Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 4:16=E2=80=AFPM Alex Williamson <alex@shazbot.org> =
wrote:
>
> [Cc +Leon]
>
> On Wed, 25 Mar 2026 19:37:47 -0700
> Rosen Penev <rosenp@gmail.com> wrote:
>
> > Simplify allocation by using a flexible array member and kzalloc_flex.
> > Less memory management needed.
> >
> > Use __counted_by for extra runtime analysis. Move assignment to after
> > allocation as required by __counted_by.
>
> I don't understand this statement, nr_ranges was previously set after
> the allocation of phys_vec.  The only reordering was relative to
> setting vdev, but that appears arbitrary.
Yes that one. My understanding is __counted_by mandates immediate
assignment after allocation. Otherwise UBSAN complains.
>
> In fact, we don't need to explicitly set the __counted_by variable at
> all, kzalloc_flex() handles that.  So if anything, it's now redundant.
Redundant with GCC`15 and above.
>
> Leon, any other comments?  This should have a v2 removing the
> redundancy and fixing the commit log.
>
> NB. This will be a bit messy to merge since kref and completion exist in
> linux-next via drm, but maybe Linus will consolidate the hole in the
> structure when he resolves it.  Thanks,
>
> Alex
>
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  drivers/vfio/pci/vfio_pci_dmabuf.c | 18 +++++-------------
> >  1 file changed, 5 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio=
_pci_dmabuf.c
> > index 3a803923141b..40e7e035a720 100644
> > --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> > +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> > @@ -14,12 +14,12 @@ struct vfio_pci_dma_buf {
> >       struct vfio_pci_core_device *vdev;
> >       struct list_head dmabufs_elm;
> >       size_t size;
> > -     struct phys_vec *phys_vec;
> >       struct p2pdma_provider *provider;
> >       u32 nr_ranges;
> >       struct kref kref;
> >       struct completion comp;
> >       u8 revoked : 1;
> > +     struct phys_vec phys_vec[] __counted_by(nr_ranges);
> >  };
> >
> >  static int vfio_pci_dma_buf_attach(struct dma_buf *dmabuf,
> > @@ -95,7 +95,6 @@ static void vfio_pci_dma_buf_release(struct dma_buf *=
dmabuf)
> >               up_write(&priv->vdev->memory_lock);
> >               vfio_device_put_registration(&priv->vdev->vdev);
> >       }
> > -     kfree(priv->phys_vec);
> >       kfree(priv);
> >  }
> >
> > @@ -258,33 +257,28 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci=
_core_device *vdev, u32 flags,
> >       if (ret)
> >               goto err_free_ranges;
> >
> > -     priv =3D kzalloc_obj(*priv);
> > +     priv =3D kzalloc_flex(*priv, phys_vec, get_dma_buf.nr_ranges);
> >       if (!priv) {
> >               ret =3D -ENOMEM;
> >               goto err_free_ranges;
> >       }
> > -     priv->phys_vec =3D kzalloc_objs(*priv->phys_vec, get_dma_buf.nr_r=
anges);
> > -     if (!priv->phys_vec) {
> > -             ret =3D -ENOMEM;
> > -             goto err_free_priv;
> > -     }
> >
> > -     priv->vdev =3D vdev;
> >       priv->nr_ranges =3D get_dma_buf.nr_ranges;
> > +     priv->vdev =3D vdev;
> >       priv->size =3D length;
> >       ret =3D vdev->pci_ops->get_dmabuf_phys(vdev, &priv->provider,
> >                                            get_dma_buf.region_index,
> >                                            priv->phys_vec, dma_ranges,
> >                                            priv->nr_ranges);
> >       if (ret)
> > -             goto err_free_phys;
> > +             goto err_free_priv;
> >
> >       kfree(dma_ranges);
> >       dma_ranges =3D NULL;
> >
> >       if (!vfio_device_try_get_registration(&vdev->vdev)) {
> >               ret =3D -ENODEV;
> > -             goto err_free_phys;
> > +             goto err_free_priv;
> >       }
> >
> >       exp_info.ops =3D &vfio_pci_dmabuf_ops;
> > @@ -323,8 +317,6 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_c=
ore_device *vdev, u32 flags,
> >       dma_buf_put(priv->dmabuf);
> >  err_dev_put:
> >       vfio_device_put_registration(&vdev->vdev);
> > -err_free_phys:
> > -     kfree(priv->phys_vec);
> >  err_free_priv:
> >       kfree(priv);
> >  err_free_ranges:
>
