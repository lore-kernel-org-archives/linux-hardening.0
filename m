Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B15CC6FA86
	for <linux-hardening@archiver.kernel.org>; Tue, 27 Sep 2022 03:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiI0DRK (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 26 Sep 2022 23:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiI0DQf (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 26 Sep 2022 23:16:35 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A40F80BED
        for <linux-hardening@vger.kernel.org>; Mon, 26 Sep 2022 20:16:18 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id s26so8244704pgv.7
        for <linux-hardening@vger.kernel.org>; Mon, 26 Sep 2022 20:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=cQ6zVkpqugLa9891w98RVMCjnbNxIhz4C6HrHMJZK8I=;
        b=Ys70lYwi0UuItAyKdztaa/QvN/zNeHvK+DYTxNBDjsJxCxH44M11cP9jPnxzHQPNjb
         igvguKL8YyFJNtFEBrZ5W6daU3oui1F9DXIVaw4aE/szAfv+15cUzVL5WS2GxWMW7Yt8
         IPCeEYWTOOuxdVg8giuH8nTC6Yhi4Ev8pRtpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=cQ6zVkpqugLa9891w98RVMCjnbNxIhz4C6HrHMJZK8I=;
        b=mNdDKD6wN4DbVN7CHelt0YwCXC2qTjwoAXGGlFr1qK3uQcA/wDDZMSbGRE2EBE2eRQ
         CPC2UqRf3lORFF2s/AofOh4wxMXOxJER1YuQb+jZQn4mWvsph6ADJKTK6YxM97DfwURK
         UMtRmk+vITiM3nnY+U3b/ftysqb4z+637rJpWDiZ9pfPAtLKTj4blP9Q7DdYG6begIzB
         +1r3bLIxoZ6/7C+Ly8H824xyeNUKG7vP2BLgGh1TgEG1EIX3/HIPjKxTn/71b8g6GJ9x
         3Jl8tzmGitccYdkww9gZw2uq/PIoXBpuS2uS3KDYGyzw/fAaISKPmrXLykuEDR12ztMT
         hNTg==
X-Gm-Message-State: ACrzQf0YbMEie9e5PuXZZzKhi9RtnAaL8tLtmszNV9+8wuX3HZporKBJ
        8V0Q6u2K7nyRqeltrD+2K3wCHg==
X-Google-Smtp-Source: AMsMyM4aPQZJmufIlgB90yFaVfoE50JmAVMSvaBvUb81fg56HsalOTyKUNoRqQO6/X3VOyQ7j9y52w==
X-Received: by 2002:a05:6a00:c89:b0:543:edb9:9dbc with SMTP id a9-20020a056a000c8900b00543edb99dbcmr27379913pfv.50.1664248577744;
        Mon, 26 Sep 2022 20:16:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 82-20020a621955000000b0053812f35a41sm269573pfz.194.2022.09.26.20.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 20:16:17 -0700 (PDT)
Date:   Mon, 26 Sep 2022 20:16:16 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ASoC: SOF: control.h: Replace zero-length array
 with DECLARE_FLEX_ARRAY() helper
Message-ID: <202209262009.D1377D0C3@keescook>
References: <YzIcZ11k8RiQtS2T@work>
 <YzIj6tdtDe9YrX+I@sirena.org.uk>
 <81af0106-a732-ce45-bb1c-c45db9e1aeb9@embeddedor.com>
 <YzIqNqhTIuaWZrOl@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzIqNqhTIuaWZrOl@sirena.org.uk>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Sep 26, 2022 at 11:39:50PM +0100, Mark Brown wrote:
> On Mon, Sep 26, 2022 at 05:27:41PM -0500, Gustavo A. R. Silva wrote:
> > On 9/26/22 17:12, Mark Brown wrote:
> > > On Mon, Sep 26, 2022 at 04:40:55PM -0500, Gustavo A. R. Silva wrote:
> 
> > > As documented in submitting-patches.rst please send patches to the
> > > maintainers for the code you would like to change.  The normal kernel
> > > workflow is that people apply patches from their inboxes, if they aren't
> > > copied they are likely to not see the patch at all and it is much more
> > > difficult to apply patches.
> 
> > That's exactly what I intended to do:
> > 
> > $ scripts/get_maintainer.pl --nokeywords --nogit --nogit-fallback include/sound/sof/control.h
> > Jaroslav Kysela <perex@perex.cz> (maintainer:SOUND)
> > Takashi Iwai <tiwai@suse.com> (maintainer:SOUND)
> > alsa-devel@alsa-project.org (moderated list:SOUND)
> > linux-kernel@vger.kernel.org (open list)
> > 
> > Did you see anything wrong with this or something...?
> 
> Yes, you should've also included me and the SOF maintainers.  It looks
> like the MAINTAINERS patterns aren't entirely up to date there
> unfortunately.  Though that said given that you'd picked up on the
> subject line I'd have expected the signoffs on the commits to also be
> pointing at the right tree as well.

Subject line heuristics look at X-many commits, but it looks like
get_maintainers stops looking at git history by default after 1 year,
which seems kind of odd. I had to work at it to get it to emit your
name. :)

scripts/get_maintainer.pl --git --git-since=3-years-ago

Seems like it's worth getting the MAINTAINERS regex updated? Is this
right?

diff --git a/MAINTAINERS b/MAINTAINERS
index a34ec41fbf7a..2560dded0e3e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19261,6 +19261,7 @@ F:	Documentation/devicetree/bindings/sound/
 F:	Documentation/sound/soc/
 F:	include/dt-bindings/sound/
 F:	include/sound/soc*
+F:	include/sound/sof/
 F:	sound/soc/
 
 SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS
@@ -19275,6 +19276,7 @@ L:	sound-open-firmware@alsa-project.org (moderated for non-subscribers)
 S:	Supported
 W:	https://github.com/thesofproject/linux/
 F:	sound/soc/sof/
+F:	include/sound/sof/
 
 SOUNDWIRE SUBSYSTEM
 M:	Vinod Koul <vkoul@kernel.org>

-- 
Kees Cook
