Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C5EC433FE
	for <linux-hardening@archiver.kernel.org>; Fri, 11 Nov 2022 20:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbiKKUjn (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 11 Nov 2022 15:39:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234113AbiKKUjl (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 11 Nov 2022 15:39:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD73667F5A
        for <linux-hardening@vger.kernel.org>; Fri, 11 Nov 2022 12:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668199121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iOc02DiC+CaIVCkcAVw6EXV28570qCIpUk2+es1FDOA=;
        b=drQID7XaTAX3aswo40tSMFD1LWAu1r91cQUZoIIhFywYUSVtveQXrASiTKsBauMz+xm550
        xXVfFN/oCJ2e7nlMrOuHpjHORtlbD7PJ/geZabtr4Tpr7TXTGLQR4WIXA0JwSBzQmaxl+0
        OqiJhUorUdsJnWfJCbZM2PxBzw+d2Pg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-46-DyATBpccPyK3dZgXjWXYIQ-1; Fri, 11 Nov 2022 15:38:40 -0500
X-MC-Unique: DyATBpccPyK3dZgXjWXYIQ-1
Received: by mail-qv1-f69.google.com with SMTP id ob9-20020a0562142f8900b004bba5363ad9so4307731qvb.8
        for <linux-hardening@vger.kernel.org>; Fri, 11 Nov 2022 12:38:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iOc02DiC+CaIVCkcAVw6EXV28570qCIpUk2+es1FDOA=;
        b=jyR/huBuE8hdC5AgmyfJen0TUez/GwaSMGVIpTXcC3u6DTeuFG9OAuPEmwk3wRgIbQ
         JrSkp2sWUrLsclP69w0Lx4P1ce4JpcPgePZMvM+1BRchyXs9QS2BY68ni5rT21Hxjrtn
         2RqVsHAI6io9qp21koMwkMYirqTC0OuOutxF6dJ2PuQfH9ixOyPuDbIe3cu1y9mgaIbb
         x/43SQeiPJdoiKR2IiS5LqGDBoqKF2LhymEZsN9iNBpJQbL74H6bCJNlEl15A1700d+m
         wgUCXLU1jhwvvwlMnFBnGlaR5/hjtpgMVMWZoRZgXTF4aKXBthDQIhWzrTil7VcSMNL1
         7zIw==
X-Gm-Message-State: ANoB5plLnQdattAOEhzIz+v7Sa1AEE0O4qRxgpmFHB41LgP2K4UvR2oZ
        49P9U5XeoReoXbzYsMs0Za8XAoJBJjKXMjoew8h6wqJgJZHK4cFK3cF+rD+USO8+A5AjUVLl0H9
        tU/PLJS5LElTNUgGA6oMFwDJi2QeE1FAr80bRPjOeuaub
X-Received: by 2002:ac8:140e:0:b0:398:5f25:649 with SMTP id k14-20020ac8140e000000b003985f250649mr3006121qtj.673.1668199120417;
        Fri, 11 Nov 2022 12:38:40 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5LOmUpWj0zC/+L7Y7H4Tvue8JzxcncnqkZQZYbqztBBpUxGN2/AlKbzfkTgtWEPvFTFIdqi6rdOfPhtKrf+k8=
X-Received: by 2002:ac8:140e:0:b0:398:5f25:649 with SMTP id
 k14-20020ac8140e000000b003985f250649mr3006098qtj.673.1668199120192; Fri, 11
 Nov 2022 12:38:40 -0800 (PST)
MIME-Version: 1.0
References: <202211100850.7A8DD75@keescook> <87iljl6ehe.fsf@intel.com>
 <202211111110.11B554B@keescook> <CACO55tt5KOgDYMEw=spDeoMaYuj2GQOuHU+BEgadr1nQiFOGhw@mail.gmail.com>
 <202211111215.1F421B7E@keescook>
In-Reply-To: <202211111215.1F421B7E@keescook>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Fri, 11 Nov 2022 21:38:28 +0100
Message-ID: <CACO55tvaXFyAMiAYmx2DKNj9fNtapThejHkRsvZd_5StYXTy+w@mail.gmail.com>
Subject: Re: Coverity: nouveau_dp_irq(): Null pointer dereferences
To:     Kees Cook <keescook@chromium.org>
Cc:     Jani Nikula <jani.nikula@intel.com>, Lyude Paul <lyude@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, Ilia Mirkin <imirkin@alum.mit.edu>,
        Daniel Vetter <daniel@ffwll.ch>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@gmail.com>,
        "Nathan E. Egge" <unlord@xiph.org>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        Dave Airlie <airlied@redhat.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Nov 11, 2022 at 9:16 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Fri, Nov 11, 2022 at 09:06:54PM +0100, Karol Herbst wrote:
> > On Fri, Nov 11, 2022 at 8:21 PM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > On Fri, Nov 11, 2022 at 11:13:17AM +0200, Jani Nikula wrote:
> > > > On Thu, 10 Nov 2022, coverity-bot <keescook@chromium.org> wrote:
> > > > > Hello!
> > > > >
> > > > > This is an experimental semi-automated report about issues detected by
> > > > > Coverity from a scan of next-20221110 as part of the linux-next scan project:
> > > > > https://scan.coverity.com/projects/linux-next-weekly-scan
> > > > >
> > > > > You're getting this email because you were associated with the identified
> > > > > lines of code (noted below) that were touched by commits:
> > > > >
> > > > >   Mon Aug 31 19:10:08 2020 -0400
> > > > >     a0922278f83e ("drm/nouveau/kms/nv50-: Refactor and cleanup DP HPD handling")
> > > >
> > > > Hi Kees, this looks like a good idea, but maybe double check the Cc list
> > > > generation? I was Cc'd on four mails today that I thought were
> > > > irrelevant to me.
> > >
> > > Hi!
> > >
> > > Heh, I was recently asked to _expand_ the CC list. :)
> > >
> > > For these last pass of reports, I added a get_maintainers.pl run to the
> > > identified commit. In this instance, the commit touched:
> > >
> > >  drivers/gpu/drm/nouveau/dispnv04/disp.c     |    6 +
> > >  drivers/gpu/drm/nouveau/dispnv50/disp.c     |  192 ++++++++++++++++++++++--------------------------
> > >  drivers/gpu/drm/nouveau/nouveau_connector.c |   14 ---
> > >  drivers/gpu/drm/nouveau/nouveau_display.c   |    2
> > >  drivers/gpu/drm/nouveau/nouveau_display.h   |    2
> > >  drivers/gpu/drm/nouveau/nouveau_dp.c        |  132 ++++++++++++++++++++++++++++-----
> > >  drivers/gpu/drm/nouveau/nouveau_encoder.h   |   33 +++++++-
> > >  7 files changed, 244 insertions(+), 137 deletions(-)
> > >
> > > And the get_maintainers.pl rationale was:
> > >
> > > Ben Skeggs <bskeggs@redhat.com> (supporter:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS,commit_signer:1/1=100%,commit_signer:6/16=38%,authored:4/16=25%,added_lines:23/124=19%,removed_lines:36/152=24%)
> > > Karol Herbst <kherbst@redhat.com> (supporter:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS,commit_signer:2/1=100%)
> > > Lyude Paul <lyude@redhat.com> (supporter:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS,commit_signer:9/16=56%,authored:6/16=38%,added_lines:92/124=74%,removed_lines:107/152=70%)
> > > David Airlie <airlied@gmail.com> (maintainer:DRM DRIVERS)
> > > Daniel Vetter <daniel@ffwll.ch> (maintainer:DRM DRIVERS)
> > > Ilia Mirkin <imirkin@alum.mit.edu> (commit_signer:1/1=100%,authored:1/1=100%,added_lines:2/2=100%,removed_lines:2/2=100%)
> > > "Nathan E. Egge" <unlord@xiph.org> (commit_signer:1/1=100%)
> > > Jani Nikula <jani.nikula@intel.com> (commit_signer:6/16=38%)
> > > Dave Airlie <airlied@redhat.com> (commit_signer:5/16=31%)
> > > Thomas Zimmermann <tzimmermann@suse.de> (commit_signer:4/16=25%,authored:4/16=25%)
> > > dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS)
> > > nouveau@lists.freedesktop.org (open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS)
> > >
> >
> > I'd say it's good enough to message supporters and the mailing lists
> > for at least Nouveau code, maybe even all drm drivers.
>
> i.e. leave out the commit_signer hits?
>

yes.

> > Not sure what to do about actual maintainers, but I doubt Dave and
> > Daniel want to be CCed on every Coverity report here either.
>
> I updated the CC logic based on this feedback:
> https://lore.kernel.org/linux-hardening/87h6zgfub4.fsf@kernel.org/
>
> So maybe just mailing lists?
>

That should be good enough, but maybe the DRM subsystem is big enough
so it's reasonable to add special rules. For Nouveau either way is
fine.

> --
> Kees Cook
>

