Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE76C54E94
	for <linux-hardening@archiver.kernel.org>; Wed, 25 Jan 2023 21:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236702AbjAYVZI (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 25 Jan 2023 16:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236709AbjAYVZB (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 25 Jan 2023 16:25:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2092341B55
        for <linux-hardening@vger.kernel.org>; Wed, 25 Jan 2023 13:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674681863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cxQ9RZ6BDN4CCiK3oNUgrfSexVDJhOUJCCoEg3ZH1Cs=;
        b=fKP1qQbzP8viS4mMWk6trs7IZ0IzvlvYRPj5tzwT/8o5IE4g7A19ShA6s6iyFSXab5OwWe
        FYDEXuIHpHl6iLWY6jT+Wlx91o1Qua3cGC488s3LVwPRSWjqgvgvIqvkln2nP/UP4P16Xp
        ffcfqk5n0RR22GpqGgjW08kEzphpDfw=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-10-wEDfGOkePqiJQk0AAR0g_g-1; Wed, 25 Jan 2023 16:24:22 -0500
X-MC-Unique: wEDfGOkePqiJQk0AAR0g_g-1
Received: by mail-vs1-f70.google.com with SMTP id j18-20020a0561023e1200b003e973484da5so310814vsv.15
        for <linux-hardening@vger.kernel.org>; Wed, 25 Jan 2023 13:24:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hmhxlAhlOmCwXTew7ghXOnO0YktD1VDCuEf789ahQyI=;
        b=OetUv+JkKAGU+zTymkXBheDOgfTQ3ufOqySMvEjmYYkpzvHqqzl0XsjtcD9EWkbQk+
         rm62973BDjOStyH61OI4N5xBwGAHjdtJ49bC5jGCWuBV6ewOBGHgSsCcoygDblsis428
         +7pZe4imk0+LU55r9H+JiU+m5+YgHOExZhlJIr1TnQVfKaLSmx0f1JRvuP6SAgmM258D
         hbCXhU6R+a+DkuBZYaxeUsxliAcOZKfRNo2yiub+8BtCzYHJJ24rbz1q0VXg7oSKerg5
         2bsrgXCOTosjFVqiHnHLOi3FLgsCo9NyGSkpCdPE6y9LwjlOm27hB5zZT5AXfMvZEpy9
         52eQ==
X-Gm-Message-State: AFqh2krlGRmQwFADXXqB7hQNQsmSrlkV+ncdY/21I9gQBDhGnP6xxWtn
        I8gcdpqsWc9Tlqa0SIOpNTjycMFgC93sPezmKKj6Tah3yC214J6TKc+nUhWEaSIqOhNF8PxAv+Y
        LPcJCh9PtJ7alPQ8g6xOe8lsV+jGm
X-Received: by 2002:a05:6122:106a:b0:3bd:795f:27b2 with SMTP id k10-20020a056122106a00b003bd795f27b2mr20159718vko.7.1674681861603;
        Wed, 25 Jan 2023 13:24:21 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtOnfUj95yQhJDTgNjUNUUoJY20NjO7nuQQD1QTAGs0DBrUgr7u7/iA/gKre3BzWAbIs7oCzA==
X-Received: by 2002:a05:6122:106a:b0:3bd:795f:27b2 with SMTP id k10-20020a056122106a00b003bd795f27b2mr20159711vko.7.1674681861340;
        Wed, 25 Jan 2023 13:24:21 -0800 (PST)
Received: from ?IPv6:2600:4040:5c68:6800::feb? ([2600:4040:5c68:6800::feb])
        by smtp.gmail.com with ESMTPSA id j28-20020a05620a001c00b007049f19c736sm4276928qki.7.2023.01.25.13.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 13:24:20 -0800 (PST)
Message-ID: <9c53c624604b7415ceeedf7222e78abc2c64430f.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau/disp: Fix nvif_outp_acquire_dp() argument
 size
From:   Lyude Paul <lyude@redhat.com>
To:     Kees Cook <keescook@chromium.org>, Ben Skeggs <bskeggs@redhat.com>
Cc:     Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Date:   Wed, 25 Jan 2023 16:24:19 -0500
In-Reply-To: <202301251214.8E52414D0@keescook>
References: <20221127183036.never.139-kees@kernel.org>
         <202301251214.8E52414D0@keescook>
Organization: Red Hat Inc.
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Sorry! I've been pretty busy until now, this is:

Reviewed-by: Lyude Paul <lyude@redhat.com>

Let me know if you've pushed it already or if you want me to push it to drm=
-
misc

On Wed, 2023-01-25 at 12:15 -0800, Kees Cook wrote:
> Ping. I'll take this via my tree unless someone else wants to take it...
>=20
> On Sun, Nov 27, 2022 at 10:30:41AM -0800, Kees Cook wrote:
> > Both Coverity and GCC with -Wstringop-overflow noticed that
> > nvif_outp_acquire_dp() accidentally defined its second argument with 1
> > additional element:
> >=20
> > drivers/gpu/drm/nouveau/dispnv50/disp.c: In function 'nv50_pior_atomic_=
enable':
> > drivers/gpu/drm/nouveau/dispnv50/disp.c:1813:17: error: 'nvif_outp_acqu=
ire_dp' accessing 16 bytes in a region of size 15 [-Werror=3Dstringop-overf=
low=3D]
> >  1813 |                 nvif_outp_acquire_dp(&nv_encoder->outp, nv_enco=
der->dp.dpcd, 0, 0, false, false);
> >       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/gpu/drm/nouveau/dispnv50/disp.c:1813:17: note: referencing argu=
ment 2 of type 'u8[16]' {aka 'unsigned char[16]'}
> > drivers/gpu/drm/nouveau/include/nvif/outp.h:24:5: note: in a call to fu=
nction 'nvif_outp_acquire_dp'
> >    24 | int nvif_outp_acquire_dp(struct nvif_outp *, u8 dpcd[16],
> >       |     ^~~~~~~~~~~~~~~~~~~~
> >=20
> > Avoid these warnings by defining the argument size using the matching
> > define (DP_RECEIVER_CAP_SIZE, 15) instead of having it be a literal
> > (and incorrect) value (16).
> >=20
> > Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> > Addresses-Coverity-ID: 1527269 ("Memory - corruptions")
> > Addresses-Coverity-ID: 1527268 ("Memory - corruptions")
> > Link: https://lore.kernel.org/lkml/202211100848.FFBA2432@keescook/
> > Link: https://lore.kernel.org/lkml/202211100848.F4C2819BB@keescook/
> > Fixes: 813443721331 ("drm/nouveau/disp: move DP link config into acquir=
e")
> > Cc: Ben Skeggs <bskeggs@redhat.com>
> > Cc: Karol Herbst <kherbst@redhat.com>
> > Cc: Lyude Paul <lyude@redhat.com>
> > Cc: David Airlie <airlied@gmail.com>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: Dave Airlie <airlied@redhat.com>
> > Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: nouveau@lists.freedesktop.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  drivers/gpu/drm/nouveau/include/nvif/outp.h | 3 ++-
> >  drivers/gpu/drm/nouveau/nvif/outp.c         | 2 +-
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/nouveau/include/nvif/outp.h b/drivers/gpu/=
drm/nouveau/include/nvif/outp.h
> > index 45daadec3c0c..fa76a7b5e4b3 100644
> > --- a/drivers/gpu/drm/nouveau/include/nvif/outp.h
> > +++ b/drivers/gpu/drm/nouveau/include/nvif/outp.h
> > @@ -3,6 +3,7 @@
> >  #define __NVIF_OUTP_H__
> >  #include <nvif/object.h>
> >  #include <nvif/if0012.h>
> > +#include <drm/display/drm_dp.h>
> >  struct nvif_disp;
> > =20
> >  struct nvif_outp {
> > @@ -21,7 +22,7 @@ int nvif_outp_acquire_rgb_crt(struct nvif_outp *);
> >  int nvif_outp_acquire_tmds(struct nvif_outp *, int head,
> >  =09=09=09   bool hdmi, u8 max_ac_packet, u8 rekey, u8 scdc, bool hda);
> >  int nvif_outp_acquire_lvds(struct nvif_outp *, bool dual, bool bpc8);
> > -int nvif_outp_acquire_dp(struct nvif_outp *, u8 dpcd[16],
> > +int nvif_outp_acquire_dp(struct nvif_outp *outp, u8 dpcd[DP_RECEIVER_C=
AP_SIZE],
> >  =09=09=09 int link_nr, int link_bw, bool hda, bool mst);
> >  void nvif_outp_release(struct nvif_outp *);
> >  int nvif_outp_infoframe(struct nvif_outp *, u8 type, struct nvif_outp_=
infoframe_v0 *, u32 size);
> > diff --git a/drivers/gpu/drm/nouveau/nvif/outp.c b/drivers/gpu/drm/nouv=
eau/nvif/outp.c
> > index 7da39f1eae9f..c24bc5eae3ec 100644
> > --- a/drivers/gpu/drm/nouveau/nvif/outp.c
> > +++ b/drivers/gpu/drm/nouveau/nvif/outp.c
> > @@ -127,7 +127,7 @@ nvif_outp_acquire(struct nvif_outp *outp, u8 proto,=
 struct nvif_outp_acquire_v0
> >  }
> > =20
> >  int
> > -nvif_outp_acquire_dp(struct nvif_outp *outp, u8 dpcd[16],
> > +nvif_outp_acquire_dp(struct nvif_outp *outp, u8 dpcd[DP_RECEIVER_CAP_S=
IZE],
> >  =09=09     int link_nr, int link_bw, bool hda, bool mst)
> >  {
> >  =09struct nvif_outp_acquire_v0 args;
> > --=20
> > 2.34.1
> >=20
>=20

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

