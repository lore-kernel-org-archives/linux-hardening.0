Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DEFC7618E
	for <linux-hardening@archiver.kernel.org>; Mon, 24 Apr 2023 15:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbjDXPVR (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 24 Apr 2023 11:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjDXPVQ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 24 Apr 2023 11:21:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20162D53
        for <linux-hardening@vger.kernel.org>; Mon, 24 Apr 2023 08:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682349631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0ybXQpJGX8ksVbqeQTg5aMwu/7o/goFFitwiYzrK7BM=;
        b=iLWSstTU8RFdFouf+/9bbF0wRY5a22XyOHsBZdBww1Ueumuu/zMB4dnk03Aqzid/ba0OuY
        DEMrGKXlRU0KHPsTfjPcNvLsghxKTlz3XFRIG2lBVk7DQIAeJAOdIDdw/Txe/1832IkE6k
        eChzSTmhKna7fjboE8L9lkDu3uYsJZI=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-OKJAdkJnOLCmMSfyIB-GLw-1; Mon, 24 Apr 2023 11:20:29 -0400
X-MC-Unique: OKJAdkJnOLCmMSfyIB-GLw-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2a7a6393ba6so2670511fa.1
        for <linux-hardening@vger.kernel.org>; Mon, 24 Apr 2023 08:20:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682349628; x=1684941628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ybXQpJGX8ksVbqeQTg5aMwu/7o/goFFitwiYzrK7BM=;
        b=gn1rKtODTSMjdOElW34YZqatMIQ2agGgR0rIgQYmM1IgOcJxTp8yMwTzl3tG+ui7uF
         ufIsMdhKSEBDH2KMhN8El/kAxWqWl4NLGfKLQK0zUbW63ioC40BoKlB91ZH16tkPNcAa
         r9QVtty4+uZrVC0xehE7+nlvK5DbwucizlW/1N+9x8qrvnhydKpKOR3R1ljeUzmrice4
         Xe9wtmwe5UlRSsWlmF03WmxwT+SjFr4rYrQQB9kAwlkXQ40irHjYf+2+6q4nFuiRoVx8
         54UG3ERIBms25oOfSi135m5y4JyrxCGWY8Ia4YTg7KgfubTjsO4+0MFT4j5SAdfN83Mb
         YkOA==
X-Gm-Message-State: AAQBX9cdnwkpu9M4sjflbb3q4iHVh1hwBXvBAfpZcF8fedlhBTKpo5SM
        HnNTA+zxoFonEzqx8d8zmCI6FJMOIP1DosoqdHViwPS+gaOj0CehoDDnwtGgs8T6BvRIlqh0qq7
        3xWapjuAa0y2lFevaYclXI+UU/MfEjwvw1CVr60zOmpHm
X-Received: by 2002:a2e:924b:0:b0:2a9:f6f0:fc84 with SMTP id v11-20020a2e924b000000b002a9f6f0fc84mr3486693ljg.4.1682349628201;
        Mon, 24 Apr 2023 08:20:28 -0700 (PDT)
X-Google-Smtp-Source: AKy350brn3/2mvZw23jR8Revx5XmXXtkygZGuUo8HD5LLVeLxmu8zC85TkjrgP/HdRDXdUOJ1/BuBAsvCCX/3rAcWwU=
X-Received: by 2002:a2e:924b:0:b0:2a9:f6f0:fc84 with SMTP id
 v11-20020a2e924b000000b002a9f6f0fc84mr3486688ljg.4.1682349627904; Mon, 24 Apr
 2023 08:20:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230204184307.never.825-kees@kernel.org> <0a48d61b-6e11-9144-b11e-dd46de836c53@embeddedor.com>
In-Reply-To: <0a48d61b-6e11-9144-b11e-dd46de836c53@embeddedor.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Mon, 24 Apr 2023 17:20:16 +0200
Message-ID: <CACO55tv43F7TQGYCmifyzOxR-Ddt28wpj9t9RyK4sQPR6aU+bQ@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/disp: More DP_RECEIVER_CAP_SIZE array fixes
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Kees Cook <keescook@chromium.org>, Ben Skeggs <bskeggs@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Mar 22, 2023 at 10:40=E2=80=AFPM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
>
>
> On 2/4/23 12:43, Kees Cook wrote:
> > More arrays (and arguments) for dcpd were set to 16, when it looks like
> > DP_RECEIVER_CAP_SIZE (15) should be used. Fix the remaining cases, seen
> > with GCC 13:
> >
> > ../drivers/gpu/drm/nouveau/nvif/outp.c: In function 'nvif_outp_acquire_=
dp':
> > ../include/linux/fortify-string.h:57:33: warning: array subscript 'unsi=
gned char[16][0]' is partly outside array bounds of 'u8[15]' {aka 'unsigned=
 char[15]'} [-Warray-bounds=3D]
> >     57 | #define __underlying_memcpy     __builtin_memcpy
> >        |                                 ^
> > ...
> > ../drivers/gpu/drm/nouveau/nvif/outp.c:140:9: note: in expansion of mac=
ro 'memcpy'
> >    140 |         memcpy(args.dp.dpcd, dpcd, sizeof(args.dp.dpcd));
> >        |         ^~~~~~
> > ../drivers/gpu/drm/nouveau/nvif/outp.c:130:49: note: object 'dpcd' of s=
ize [0, 15]
> >    130 | nvif_outp_acquire_dp(struct nvif_outp *outp, u8 dpcd[DP_RECEIV=
ER_CAP_SIZE],
> >        |                                              ~~~^~~~~~~~~~~~~~=
~~~~~~~~~~~~
> >
> > Fixes: 813443721331 ("drm/nouveau/disp: move DP link config into acquir=
e")
> > Cc: Ben Skeggs <bskeggs@redhat.com>
> > Cc: Lyude Paul <lyude@redhat.com>
> > Cc: Karol Herbst <kherbst@redhat.com>
> > Cc: David Airlie <airlied@gmail.com>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: Dave Airlie <airlied@redhat.com>
> > Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: nouveau@lists.freedesktop.org
> > Signed-off-by: Kees Cook <keescook@chromium.org>
>
> Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>

Reviewed-by: Karol Herbst <kherbst@redhat.com>

sorry for not seeing this earlier.

> Thanks!
> --
> Gustavo
>
> > ---
> >   drivers/gpu/drm/nouveau/include/nvif/if0012.h    | 4 +++-
> >   drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.h  | 3 ++-
> >   drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c | 2 +-
> >   3 files changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/nouveau/include/nvif/if0012.h b/drivers/gp=
u/drm/nouveau/include/nvif/if0012.h
> > index eb99d84eb844..16d4ad5023a3 100644
> > --- a/drivers/gpu/drm/nouveau/include/nvif/if0012.h
> > +++ b/drivers/gpu/drm/nouveau/include/nvif/if0012.h
> > @@ -2,6 +2,8 @@
> >   #ifndef __NVIF_IF0012_H__
> >   #define __NVIF_IF0012_H__
> >
> > +#include <drm/display/drm_dp.h>
> > +
> >   union nvif_outp_args {
> >       struct nvif_outp_v0 {
> >               __u8 version;
> > @@ -63,7 +65,7 @@ union nvif_outp_acquire_args {
> >                               __u8 hda;
> >                               __u8 mst;
> >                               __u8 pad04[4];
> > -                             __u8 dpcd[16];
> > +                             __u8 dpcd[DP_RECEIVER_CAP_SIZE];
> >                       } dp;
> >               };
> >       } v0;
> > diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.h b/drivers/=
gpu/drm/nouveau/nvkm/engine/disp/outp.h
> > index b7631c1ab242..4e7f873f66e2 100644
> > --- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.h
> > +++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/outp.h
> > @@ -3,6 +3,7 @@
> >   #define __NVKM_DISP_OUTP_H__
> >   #include "priv.h"
> >
> > +#include <drm/display/drm_dp.h>
> >   #include <subdev/bios.h>
> >   #include <subdev/bios/dcb.h>
> >   #include <subdev/bios/dp.h>
> > @@ -42,7 +43,7 @@ struct nvkm_outp {
> >                       bool aux_pwr_pu;
> >                       u8 lttpr[6];
> >                       u8 lttprs;
> > -                     u8 dpcd[16];
> > +                     u8 dpcd[DP_RECEIVER_CAP_SIZE];
> >
> >                       struct {
> >                               int dpcd; /* -1, or index into SUPPORTED_=
LINK_RATES table */
> > diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c b/drivers=
/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c
> > index 4f0ca709c85a..fc283a4a1522 100644
> > --- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c
> > +++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/uoutp.c
> > @@ -146,7 +146,7 @@ nvkm_uoutp_mthd_release(struct nvkm_outp *outp, voi=
d *argv, u32 argc)
> >   }
> >
> >   static int
> > -nvkm_uoutp_mthd_acquire_dp(struct nvkm_outp *outp, u8 dpcd[16],
> > +nvkm_uoutp_mthd_acquire_dp(struct nvkm_outp *outp, u8 dpcd[DP_RECEIVER=
_CAP_SIZE],
> >                          u8 link_nr, u8 link_bw, bool hda, bool mst)
> >   {
> >       int ret;
>

