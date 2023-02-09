Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF74CC61DA4
	for <linux-hardening@archiver.kernel.org>; Thu,  9 Feb 2023 20:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjBIU5Q (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 9 Feb 2023 15:57:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjBIU5N (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 9 Feb 2023 15:57:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DCE68AF3
        for <linux-hardening@vger.kernel.org>; Thu,  9 Feb 2023 12:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675976178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GOijvwsKDok7G2BOzmH1GSGEU6At5AF1U1zcEVVJWFM=;
        b=KwbRm0hOi1rkhZY7Z+lLDjrvhFYT2tpd81Ia9jAFTcl531Hed4/rc6Q6frlZr0tTnjVwzR
        JFvys886JvGeKQollYYuW/Akn1S2AwnUL5lUmQsk1w+TSlhA17fqKh0s52EVAeraPFazoi
        Y75xK577fXIZX79SDDDAwr9KdhUQlMo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-567-s-0tX-d3PQeLvqcyRgNexg-1; Thu, 09 Feb 2023 15:56:16 -0500
X-MC-Unique: s-0tX-d3PQeLvqcyRgNexg-1
Received: by mail-qv1-f72.google.com with SMTP id c3-20020ad44303000000b0056c23d82cffso1948532qvs.15
        for <linux-hardening@vger.kernel.org>; Thu, 09 Feb 2023 12:56:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MwvhZIExeC6pg1mA1eBczPhmNq0o9JVqra38D4tU9DA=;
        b=vWOpeRPBBvj6W8akYzZCHmerKr71lsDXxgw8+6v39D431gUTXd116Pxrl4EG8HuuO5
         79sbLs6tQAOvl3VTOLd1eQ/usX+TXV/W5yDU+XvK754ZW/0P3XFFou+duNiyGgt7FAXy
         eISjIAYACwvwPSqRanQ1VCICMjbqgvQFxoxX6+qDOB//oreZjHirkN5bP73q5fXevzvF
         73YI6b51dleCDeuad3AEq170MauAXXIJpyEILKj6Um/X9YscP7MpZCobf3SjyWjqvoUh
         bfcDijv3MRZyfprcnpk0hNL1KL++Ju+GdbdQEmwmKf+YCzMq56qabm6WgA7vTUBhtuZc
         SwOA==
X-Gm-Message-State: AO0yUKVBirUQ3fjl6NKgdsUCwu+a1FyRgGdMFOy70nLN6Vcdunfyp/OG
        dG8B4r4mZlJlaz7trkvPoFMs2hsvA2JOoJ0cTw2yivwN7RB2WoqsCCwxAEQZopSWaTE7qnlimAM
        f1gxZQvKSTEMm9/lbt5xoLmyTf5wWMI82Jg==
X-Received: by 2002:ac8:5842:0:b0:3b6:3508:2a3e with SMTP id h2-20020ac85842000000b003b635082a3emr22689018qth.4.1675976175877;
        Thu, 09 Feb 2023 12:56:15 -0800 (PST)
X-Google-Smtp-Source: AK7set/Sgu6IrdyuvSr/55VxeDEiDRADgmgMtUxxr0kepPtczgL94WYP5qNW4ED01WvYyZ4jpi+QiA==
X-Received: by 2002:ac8:5842:0:b0:3b6:3508:2a3e with SMTP id h2-20020ac85842000000b003b635082a3emr22688994qth.4.1675976175614;
        Thu, 09 Feb 2023 12:56:15 -0800 (PST)
Received: from ?IPv6:2600:4040:5c68:6800:3463:5df7:aced:152e? ([2600:4040:5c68:6800:3463:5df7:aced:152e])
        by smtp.gmail.com with ESMTPSA id 73-20020a370b4c000000b007259807a512sm2078501qkl.12.2023.02.09.12.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 12:56:15 -0800 (PST)
Message-ID: <4ecbb8cde92a422fab52e29f826b7d5dda0ac681.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau/disp: Fix nvif_outp_acquire_dp() argument
 size
From:   Lyude Paul <lyude@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Date:   Thu, 09 Feb 2023 15:56:14 -0500
In-Reply-To: <202301271141.6741F43@keescook>
References: <20221127183036.never.139-kees@kernel.org>
         <202301251214.8E52414D0@keescook>
         <9c53c624604b7415ceeedf7222e78abc2c64430f.camel@redhat.com>
         <202301271141.6741F43@keescook>
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

I think that shoud be fine, which branch is it on?

On Fri, 2023-01-27 at 11:42 -0800, Kees Cook wrote:
> On Wed, Jan 25, 2023 at 04:24:19PM -0500, Lyude Paul wrote:
> > Sorry! I've been pretty busy until now, this is:
> >=20
> > Reviewed-by: Lyude Paul <lyude@redhat.com>
> >=20
> > Let me know if you've pushed it already or if you want me to push it to=
 drm-
> > misc
>=20
> Either way is fine. I'm currently carrying it, but I can easily drop it
> if you prefer it go via drm-misc.
>=20
> Thanks!
>=20
> -Kees
>=20
> >=20
> > On Wed, 2023-01-25 at 12:15 -0800, Kees Cook wrote:
> > > Ping. I'll take this via my tree unless someone else wants to take it=
...
> > >=20
> > > On Sun, Nov 27, 2022 at 10:30:41AM -0800, Kees Cook wrote:
> > > > Both Coverity and GCC with -Wstringop-overflow noticed that
> > > > nvif_outp_acquire_dp() accidentally defined its second argument wit=
h 1
> > > > additional element:
> > > >=20
> > > > drivers/gpu/drm/nouveau/dispnv50/disp.c: In function 'nv50_pior_ato=
mic_enable':
> > > > drivers/gpu/drm/nouveau/dispnv50/disp.c:1813:17: error: 'nvif_outp_=
acquire_dp' accessing 16 bytes in a region of size 15 [-Werror=3Dstringop-o=
verflow=3D]
> > > >  1813 |                 nvif_outp_acquire_dp(&nv_encoder->outp, nv_=
encoder->dp.dpcd, 0, 0, false, false);
> > > >       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > drivers/gpu/drm/nouveau/dispnv50/disp.c:1813:17: note: referencing =
argument 2 of type 'u8[16]' {aka 'unsigned char[16]'}
> > > > drivers/gpu/drm/nouveau/include/nvif/outp.h:24:5: note: in a call t=
o function 'nvif_outp_acquire_dp'
> > > >    24 | int nvif_outp_acquire_dp(struct nvif_outp *, u8 dpcd[16],
> > > >       |     ^~~~~~~~~~~~~~~~~~~~
> > > >=20
> > > > Avoid these warnings by defining the argument size using the matchi=
ng
> > > > define (DP_RECEIVER_CAP_SIZE, 15) instead of having it be a literal
> > > > (and incorrect) value (16).
> > > >=20
> > > > Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> > > > Addresses-Coverity-ID: 1527269 ("Memory - corruptions")
> > > > Addresses-Coverity-ID: 1527268 ("Memory - corruptions")
> > > > Link: https://lore.kernel.org/lkml/202211100848.FFBA2432@keescook/
> > > > Link: https://lore.kernel.org/lkml/202211100848.F4C2819BB@keescook/
> > > > Fixes: 813443721331 ("drm/nouveau/disp: move DP link config into ac=
quire")
> > > > Cc: Ben Skeggs <bskeggs@redhat.com>
> > > > Cc: Karol Herbst <kherbst@redhat.com>
> > > > Cc: Lyude Paul <lyude@redhat.com>
> > > > Cc: David Airlie <airlied@gmail.com>
> > > > Cc: Daniel Vetter <daniel@ffwll.ch>
> > > > Cc: Dave Airlie <airlied@redhat.com>
> > > > Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
> > > > Cc: dri-devel@lists.freedesktop.org
> > > > Cc: nouveau@lists.freedesktop.org
> > > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > > ---
> > > >  drivers/gpu/drm/nouveau/include/nvif/outp.h | 3 ++-
> > > >  drivers/gpu/drm/nouveau/nvif/outp.c         | 2 +-
> > > >  2 files changed, 3 insertions(+), 2 deletions(-)
> > > >=20
> > > > diff --git a/drivers/gpu/drm/nouveau/include/nvif/outp.h b/drivers/=
gpu/drm/nouveau/include/nvif/outp.h
> > > > index 45daadec3c0c..fa76a7b5e4b3 100644
> > > > --- a/drivers/gpu/drm/nouveau/include/nvif/outp.h
> > > > +++ b/drivers/gpu/drm/nouveau/include/nvif/outp.h
> > > > @@ -3,6 +3,7 @@
> > > >  #define __NVIF_OUTP_H__
> > > >  #include <nvif/object.h>
> > > >  #include <nvif/if0012.h>
> > > > +#include <drm/display/drm_dp.h>
> > > >  struct nvif_disp;
> > > > =20
> > > >  struct nvif_outp {
> > > > @@ -21,7 +22,7 @@ int nvif_outp_acquire_rgb_crt(struct nvif_outp *)=
;
> > > >  int nvif_outp_acquire_tmds(struct nvif_outp *, int head,
> > > >  =09=09=09   bool hdmi, u8 max_ac_packet, u8 rekey, u8 scdc, bool h=
da);
> > > >  int nvif_outp_acquire_lvds(struct nvif_outp *, bool dual, bool bpc=
8);
> > > > -int nvif_outp_acquire_dp(struct nvif_outp *, u8 dpcd[16],
> > > > +int nvif_outp_acquire_dp(struct nvif_outp *outp, u8 dpcd[DP_RECEIV=
ER_CAP_SIZE],
> > > >  =09=09=09 int link_nr, int link_bw, bool hda, bool mst);
> > > >  void nvif_outp_release(struct nvif_outp *);
> > > >  int nvif_outp_infoframe(struct nvif_outp *, u8 type, struct nvif_o=
utp_infoframe_v0 *, u32 size);
> > > > diff --git a/drivers/gpu/drm/nouveau/nvif/outp.c b/drivers/gpu/drm/=
nouveau/nvif/outp.c
> > > > index 7da39f1eae9f..c24bc5eae3ec 100644
> > > > --- a/drivers/gpu/drm/nouveau/nvif/outp.c
> > > > +++ b/drivers/gpu/drm/nouveau/nvif/outp.c
> > > > @@ -127,7 +127,7 @@ nvif_outp_acquire(struct nvif_outp *outp, u8 pr=
oto, struct nvif_outp_acquire_v0
> > > >  }
> > > > =20
> > > >  int
> > > > -nvif_outp_acquire_dp(struct nvif_outp *outp, u8 dpcd[16],
> > > > +nvif_outp_acquire_dp(struct nvif_outp *outp, u8 dpcd[DP_RECEIVER_C=
AP_SIZE],
> > > >  =09=09     int link_nr, int link_bw, bool hda, bool mst)
> > > >  {
> > > >  =09struct nvif_outp_acquire_v0 args;
> > > > --=20
> > > > 2.34.1
> > > >=20
> > >=20
> >=20
> > --=20
> > Cheers,
> >  Lyude Paul (she/her)
> >  Software Engineer at Red Hat
> >=20
>=20

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

