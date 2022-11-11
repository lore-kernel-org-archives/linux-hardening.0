Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE2FC4332F
	for <linux-hardening@archiver.kernel.org>; Fri, 11 Nov 2022 19:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbiKKTVx (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 11 Nov 2022 14:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiKKTVx (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 11 Nov 2022 14:21:53 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAB310FF9
        for <linux-hardening@vger.kernel.org>; Fri, 11 Nov 2022 11:21:51 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id p21so4946412plr.7
        for <linux-hardening@vger.kernel.org>; Fri, 11 Nov 2022 11:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IHk/WyAgMPc33IOyOTaPaWGnmZhp17CsZbK+KP95Wh8=;
        b=O6YivlkQdE2NV4Z4tLE02IOQ7YQgIRJrWM80tdZkt5k+XIQtZz7cxKpCMaB7rrfPq7
         G3XacIpYr2nn6HNsDJtbm6DA3HrV4P+qQd/qmV5UhkMSi3baY1lPJVMFkAstEJzuHUeN
         DgKOEOliQUckGTg21sefxcOucamEjp7kTw/Qs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IHk/WyAgMPc33IOyOTaPaWGnmZhp17CsZbK+KP95Wh8=;
        b=3oL7NtDmudXVpkR+PX+yKmh3JvEDfS1zOEHyJjnPyynT4yoCVDh3XfSLRw/YGWgbuI
         o5m/WddxMhfvebbmcwiP2z37YreWHPgXArTWgDudqWZqew9UAXaMZRpsGN8dNvABqDjF
         fcBe8BY5o4QD7B13/6/WVhgL5/ZKYxB250NKJKlLKn10eONxYGjs0MD61UpDJcuQL+lN
         oq1kqG8vWt6sqjXOBrHsJmxCCJyvioA9WePhgu6Z19ri3QVHCltDxXd513HHWz04CajP
         2Fswlv8O6orv7zFSYgwjoum8/Y1PxRLBxI/rt4zciXYplhKwDPFtOs+132bGyGpYYZRY
         KrXw==
X-Gm-Message-State: ANoB5pl8i0Miy+nvgsg5hiJmS7Jx1WdKSvBCdGHZKt52IM5LlrR0t5IA
        nCJTLpHiIXgY6n8t5RMN2+xnXA==
X-Google-Smtp-Source: AA0mqf4i77VIhs5qpNyBlVvhpR2s9r/2VBj54xZbpPIy/ryD5gcsls//pP1BrhZB4gM/fwDn5Bz05Q==
X-Received: by 2002:a17:902:e052:b0:172:f5b1:e73b with SMTP id x18-20020a170902e05200b00172f5b1e73bmr3962831plx.58.1668194510942;
        Fri, 11 Nov 2022 11:21:50 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c14-20020a62f84e000000b0052d4cb47339sm1907746pfm.151.2022.11.11.11.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 11:21:50 -0800 (PST)
Date:   Fri, 11 Nov 2022 11:21:49 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     Lyude Paul <lyude@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, Ilia Mirkin <imirkin@alum.mit.edu>,
        Daniel Vetter <daniel@ffwll.ch>,
        Karol Herbst <kherbst@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@gmail.com>,
        "Nathan E. Egge" <unlord@xiph.org>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        Dave Airlie <airlied@redhat.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: Coverity: nouveau_dp_irq(): Null pointer dereferences
Message-ID: <202211111110.11B554B@keescook>
References: <202211100850.7A8DD75@keescook>
 <87iljl6ehe.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87iljl6ehe.fsf@intel.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Nov 11, 2022 at 11:13:17AM +0200, Jani Nikula wrote:
> On Thu, 10 Nov 2022, coverity-bot <keescook@chromium.org> wrote:
> > Hello!
> >
> > This is an experimental semi-automated report about issues detected by
> > Coverity from a scan of next-20221110 as part of the linux-next scan project:
> > https://scan.coverity.com/projects/linux-next-weekly-scan
> >
> > You're getting this email because you were associated with the identified
> > lines of code (noted below) that were touched by commits:
> >
> >   Mon Aug 31 19:10:08 2020 -0400
> >     a0922278f83e ("drm/nouveau/kms/nv50-: Refactor and cleanup DP HPD handling")
> 
> Hi Kees, this looks like a good idea, but maybe double check the Cc list
> generation? I was Cc'd on four mails today that I thought were
> irrelevant to me.

Hi!

Heh, I was recently asked to _expand_ the CC list. :)

For these last pass of reports, I added a get_maintainers.pl run to the
identified commit. In this instance, the commit touched:

 drivers/gpu/drm/nouveau/dispnv04/disp.c     |    6 +
 drivers/gpu/drm/nouveau/dispnv50/disp.c     |  192 ++++++++++++++++++++++--------------------------
 drivers/gpu/drm/nouveau/nouveau_connector.c |   14 ---
 drivers/gpu/drm/nouveau/nouveau_display.c   |    2 
 drivers/gpu/drm/nouveau/nouveau_display.h   |    2 
 drivers/gpu/drm/nouveau/nouveau_dp.c        |  132 ++++++++++++++++++++++++++++-----
 drivers/gpu/drm/nouveau/nouveau_encoder.h   |   33 +++++++-
 7 files changed, 244 insertions(+), 137 deletions(-)

And the get_maintainers.pl rationale was:

Ben Skeggs <bskeggs@redhat.com> (supporter:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS,commit_signer:1/1=100%,commit_signer:6/16=38%,authored:4/16=25%,added_lines:23/124=19%,removed_lines:36/152=24%)
Karol Herbst <kherbst@redhat.com> (supporter:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS,commit_signer:2/1=100%)
Lyude Paul <lyude@redhat.com> (supporter:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS,commit_signer:9/16=56%,authored:6/16=38%,added_lines:92/124=74%,removed_lines:107/152=70%)
David Airlie <airlied@gmail.com> (maintainer:DRM DRIVERS)
Daniel Vetter <daniel@ffwll.ch> (maintainer:DRM DRIVERS)
Ilia Mirkin <imirkin@alum.mit.edu> (commit_signer:1/1=100%,authored:1/1=100%,added_lines:2/2=100%,removed_lines:2/2=100%)
"Nathan E. Egge" <unlord@xiph.org> (commit_signer:1/1=100%)
Jani Nikula <jani.nikula@intel.com> (commit_signer:6/16=38%)
Dave Airlie <airlied@redhat.com> (commit_signer:5/16=31%)
Thomas Zimmermann <tzimmermann@suse.de> (commit_signer:4/16=25%,authored:4/16=25%)
dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS)
nouveau@lists.freedesktop.org (open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS)


-- 
Kees Cook
