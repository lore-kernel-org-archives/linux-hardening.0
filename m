Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF3CEED61A
	for <linux-hardening@archiver.kernel.org>; Fri, 15 Sep 2023 17:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236156AbjIORho (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 15 Sep 2023 13:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236369AbjIORh0 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 15 Sep 2023 13:37:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F19130EC
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 10:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694799285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8ADserGfGNqzJMHzEpo3paKGXY72Phfqf685UnddVgE=;
        b=KfYsyAtwQVlYIu5VsoSe5l7BGpLYhGw3i1W7LczR/Lum7jMgDJZyhv/oLITAFMkoPhtSyp
        mmOIYegIOU/bGrPFhqBEleWZpIlVjbVvlw4Nl0Z39ONLhTXVSBhvnbYdGfEXB5mwuIxHdc
        GpCiVPt5sNDzl/5M4dwBK2rW1quUy3Q=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-s1XEvPsYMCKIlPhDWtVsqg-1; Fri, 15 Sep 2023 13:34:43 -0400
X-MC-Unique: s1XEvPsYMCKIlPhDWtVsqg-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-41219864601so25668821cf.0
        for <linux-hardening@vger.kernel.org>; Fri, 15 Sep 2023 10:34:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694799283; x=1695404083;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I8Q7NvhKrNUpZ1wyEQLmlUvhyw6KnFkbyTR3LCH8q2k=;
        b=G3EgqSxAfxbO6vrcLmMOHalMb5+5Zocg442w5wJ9HUtroFJLoIkmVftVIUmDAASpaI
         kg8TR1wij2iqMmk78qJG7oTk93CnmFUHz3r8NL33oE9RmL/FKeBuw/YYMDQDlwB3VD0E
         IuqC1IWMJ+qUTBCKdFGQQ6z/bsP2pNEGFtedBeIhcsWmp/EhIw4VqMSHS3URsfy36KtA
         BhZglZQhRGTLbkzpT3dCgftvHtrZSi3zKkDeDwKWHoZTsGiWydbPAH+GGEtnHqxuxOss
         QU8qrfHXDJjL77xQyGh18yImcEScE1dSIcAqPbGIkuRqWw8u7EXULa/W7nim0nbwFsca
         L13w==
X-Gm-Message-State: AOJu0YzJ+XMiXRulxMg1I9vjTv/OvuAfvkgEaXBYjDVCAP7bz6sPbsSW
        Jmb/7Bb8aI+2drvW8PJ+vXGRvxQqZvn+ZcHKXa4iXHb6IzCzD2ohuQFAr6wG1FWKMrcNigrdVSn
        kT0Y7m6sSsG3x/U79cDBGcCBY+DPz
X-Received: by 2002:ac8:5701:0:b0:403:cecf:4ade with SMTP id 1-20020ac85701000000b00403cecf4ademr3237065qtw.32.1694799283263;
        Fri, 15 Sep 2023 10:34:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH23IQ3dxGhZ9gN1USPsCNMq0X92TLWKItrONedXesd3PQqAjirC0kn2Zv9fgi5UN/hQwH9sw==
X-Received: by 2002:ac8:5701:0:b0:403:cecf:4ade with SMTP id 1-20020ac85701000000b00403cecf4ademr3237049qtw.32.1694799283049;
        Fri, 15 Sep 2023 10:34:43 -0700 (PDT)
Received: from ?IPv6:2600:4040:5c6c:a300::feb? ([2600:4040:5c6c:a300::feb])
        by smtp.gmail.com with ESMTPSA id b6-20020a05620a126600b007675c4b530fsm1370418qkl.28.2023.09.15.10.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 10:34:42 -0700 (PDT)
Message-ID: <cf0f001fe5688d956c6a8521af494694377efb5b.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau/pm: refactor deprecated strncpy
From:   Lyude Paul <lyude@redhat.com>
To:     Justin Stitt <justinstitt@google.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Date:   Fri, 15 Sep 2023 13:34:41 -0400
In-Reply-To: <20230914-strncpy-drivers-gpu-drm-nouveau-nvkm-engine-pm-base-c-v1-1-4b09ed453f84@google.com>
References: <20230914-strncpy-drivers-gpu-drm-nouveau-nvkm-engine-pm-base-c-v1-1-4b09ed453f84@google.com>
Organization: Red Hat Inc.
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

...oops, responded to the wrong email :P

Reviewed-by: Lyude Paul <lyude@redhat.com>


On Thu, 2023-09-14 at 22:17 +0000, Justin Stitt wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings [1]=
.
>=20
> We should prefer more robust and less ambiguous string interfaces.
>=20
> A suitable replacement is `strscpy` [2] due to the fact that it guarantee=
s
> NUL-termination on the destination buffer without unnecessarily NUL-paddi=
ng.
>=20
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strn=
cpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.h=
tml [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
>  drivers/gpu/drm/nouveau/nvkm/engine/pm/base.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/pm/base.c b/drivers/gpu/=
drm/nouveau/nvkm/engine/pm/base.c
> index 8fe0444f761e..131db2645f84 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/pm/base.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/pm/base.c
> @@ -462,7 +462,7 @@ nvkm_perfmon_mthd_query_domain(struct nvkm_perfmon *p=
erfmon,
> =20
>  =09=09args->v0.id         =3D di;
>  =09=09args->v0.signal_nr  =3D nvkm_perfdom_count_perfsig(dom);
> -=09=09strncpy(args->v0.name, dom->name, sizeof(args->v0.name) - 1);
> +=09=09strscpy(args->v0.name, dom->name, sizeof(args->v0.name));
> =20
>  =09=09/* Currently only global counters (PCOUNTER) are implemented
>  =09=09 * but this will be different for local counters (MP). */
> @@ -513,8 +513,7 @@ nvkm_perfmon_mthd_query_signal(struct nvkm_perfmon *p=
erfmon,
>  =09=09=09snprintf(args->v0.name, sizeof(args->v0.name),
>  =09=09=09=09 "/%s/%02x", dom->name, si);
>  =09=09} else {
> -=09=09=09strncpy(args->v0.name, sig->name,
> -=09=09=09=09sizeof(args->v0.name) - 1);
> +=09=09=09strscpy(args->v0.name, sig->name, sizeof(args->v0.name));
>  =09=09}
> =20
>  =09=09args->v0.signal =3D si;
> @@ -572,7 +571,7 @@ nvkm_perfmon_mthd_query_source(struct nvkm_perfmon *p=
erfmon,
> =20
>  =09=09args->v0.source =3D sig->source[si];
>  =09=09args->v0.mask   =3D src->mask;
> -=09=09strncpy(args->v0.name, src->name, sizeof(args->v0.name) - 1);
> +=09=09strscpy(args->v0.name, src->name, sizeof(args->v0.name));
>  =09}
> =20
>  =09if (++si < source_nr) {
>=20
> ---
> base-commit: 3669558bdf354cd352be955ef2764cde6a9bf5ec
> change-id: 20230914-strncpy-drivers-gpu-drm-nouveau-nvkm-engine-pm-base-c=
-38bf9c78bc0f
>=20
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
>=20

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

