Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1325C47080
	for <linux-hardening@archiver.kernel.org>; Wed,  2 Jun 2021 00:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCD25613B4
	for <linux-hardening@archiver.kernel.org>; Wed,  2 Jun 2021 00:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235481AbhFBAMd (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 1 Jun 2021 20:12:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20601 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235522AbhFBAMS (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 1 Jun 2021 20:12:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622592636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g6XERwupFZipcAmg6D1I1zxjEbLYz5zppsdgraxGF7Q=;
        b=Vmjd6jSIJVX2s/HDJRoh16GAW1DNk/KIl8EALpqoDlr4U1AKkkLL20q+MoGTHk8g6y2pkN
        BwJB6U2FbI21pMrne/dwuDvd23NOFHQ8kagj5/mKvLT+Bl++GG86jtZn4Hkh506d+GsJ4S
        Aad63XXkiOR5+P1TjzciLxxI8fm495k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-yi-c58mjPzuB9xbpHq-Vkg-1; Tue, 01 Jun 2021 20:10:31 -0400
X-MC-Unique: yi-c58mjPzuB9xbpHq-Vkg-1
Received: by mail-wr1-f69.google.com with SMTP id x9-20020a5d49090000b0290118d8746e06so210275wrq.10
        for <linux-hardening@vger.kernel.org>; Tue, 01 Jun 2021 17:10:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g6XERwupFZipcAmg6D1I1zxjEbLYz5zppsdgraxGF7Q=;
        b=NK/AQJR06BnNDXq4t6b780NnTahzzhyq7NmVzKxjbNdOH9K+v3d22QrJCjluBcDfnz
         gfQCUPW2+y25kLixjsW10RpZh4nHOb56HiS88WeFQAv8afbkm5vDXN5iCzzMi8OR5LPP
         dXMi4LkbG4njt3HxigSEECTciAhnok6PDEppehvIpQHFuY277Na5cC61HSi0Vj1Nn7un
         nSjAd4bKtYjfI3APW6aCWqXYj6X0URLz4af2StwYGfXuYpDfQrr/KdzuFFwGDNBt+V40
         oj+GB57a2dlaaM+AsefKl6+lXoyzYO7wULAHeGyR+FVbIRFKOfhqGDmyWbO2dgIuEMXX
         au6g==
X-Gm-Message-State: AOAM533u24ecLKpbV+tTKihmjFbg8AQip1svYyBbddT9tagf3fwdrOBH
        1NaCF15o0SM57J6mrgmtgqfHLitHjOmsZhjbCBTkR7lZwO7T09v7QocvIoFzTyToB7snQ2g/rYM
        rMqG79Wt2pB26+W88AKkoUXO6xKZdtl3GkFx9jRfTr1lD
X-Received: by 2002:adf:dcc3:: with SMTP id x3mr8763241wrm.177.1622592629495;
        Tue, 01 Jun 2021 17:10:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+7ytifh8Tq7X7nnucf7aYm2Vw3csWvxa0+c2QJbbdpuaVNF93Pvls4Lv1rmxm1PeJU5y+Ay/NirV8hdJrDSY=
X-Received: by 2002:adf:dcc3:: with SMTP id x3mr8763219wrm.177.1622592629297;
 Tue, 01 Jun 2021 17:10:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210305095657.GA142006@embeddedor> <79ff569a-5828-ef21-538b-12d07d34a4ff@embeddedor.com>
 <1ec627af-514e-b24a-da88-13eb561ccb15@embeddedor.com>
In-Reply-To: <1ec627af-514e-b24a-da88-13eb561ccb15@embeddedor.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Wed, 2 Jun 2021 02:10:18 +0200
Message-ID: <CACO55tv3o72GwG8ORcUYQ-nXFDi1Qo0uKG5T_4iVmuhdDxPdqg@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH RESEND][next] drm/nouveau: Fix fall-through
 warnings for Clang
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kees Cook <keescook@chromium.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-hardening@vger.kernel.org
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kherbst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

all three nouveau patches are

Reviewed-by: Karol Herbst <kherbst@redhat.com>

and I don't think anybody would mind if those get into through other
trees, but maybe drm-mist would be a good place for it if other
patches involve other drm drivers?

On Wed, Jun 2, 2021 at 1:16 AM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> Hi,
>
> Friendly second ping: who can take this?
>
> I can add this to my -next branch for 5.14 if you don't mind.
>
> JFYI: We had thousands of these sorts of warnings and now we are down
> to just 23 in linux-next. This is one of those last remaining warnings.
>
> Thanks
> --
> Gustavo
>
> On 4/20/21 15:13, Gustavo A. R. Silva wrote:
> > Hi all,
> >
> > Friendly ping: who can take this, please?
> >
> > Thanks
> > --
> > Gustavo
> >
> > On 3/5/21 03:56, Gustavo A. R. Silva wrote:
> >> In preparation to enable -Wimplicit-fallthrough for Clang, fix a couple
> >> of warnings by explicitly adding a couple of break statements instead
> >> of letting the code fall through to the next case.
> >>
> >> Link: https://github.com/KSPP/linux/issues/115
> >> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> >> ---
> >>  drivers/gpu/drm/nouveau/nouveau_bo.c        | 1 +
> >>  drivers/gpu/drm/nouveau/nouveau_connector.c | 1 +
> >>  2 files changed, 2 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouveau/nouveau_bo.c
> >> index 2375711877cf..62903c3b368d 100644
> >> --- a/drivers/gpu/drm/nouveau/nouveau_bo.c
> >> +++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
> >> @@ -443,6 +443,7 @@ nouveau_bo_pin(struct nouveau_bo *nvbo, uint32_t domain, bool contig)
> >>                      break;
> >>              case TTM_PL_TT:
> >>                      error |= !(domain & NOUVEAU_GEM_DOMAIN_GART);
> >> +                    break;
> >>              default:
> >>                      break;
> >>              }
> >> diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
> >> index 61e6d7412505..eb844cdcaec2 100644
> >> --- a/drivers/gpu/drm/nouveau/nouveau_connector.c
> >> +++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
> >> @@ -157,6 +157,7 @@ nouveau_conn_atomic_set_property(struct drm_connector *connector,
> >>                      default:
> >>                              break;
> >>                      }
> >> +                    break;
> >>              case DRM_MODE_SCALE_FULLSCREEN:
> >>              case DRM_MODE_SCALE_CENTER:
> >>              case DRM_MODE_SCALE_ASPECT:
> >>
> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau
>

