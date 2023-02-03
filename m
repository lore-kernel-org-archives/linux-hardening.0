Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD1FC61DA4
	for <linux-hardening@archiver.kernel.org>; Fri,  3 Feb 2023 16:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbjBCQ3p (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 3 Feb 2023 11:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbjBCQ3o (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 3 Feb 2023 11:29:44 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FED8A7ED3
        for <linux-hardening@vger.kernel.org>; Fri,  3 Feb 2023 08:29:43 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id be8so5746452plb.7
        for <linux-hardening@vger.kernel.org>; Fri, 03 Feb 2023 08:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EGj5KCWeluHnuZthHjKS/p0W/Q63My14ajFgn/N7qhE=;
        b=VnPfY6G7WLkodXEsJkzaXZAEnTsENaxYzDFISjb6PNoaycBXUugUZezZK1sL6bZ2d5
         CIABhclo6LVO8xyysXi6VjdhLtrl2TjHQqTKNhN/kNLaroMQ7b5CnnhZ6/XL+aqL2sN0
         kgbGj04aiIaBJig1rV44FxUURpCdpvCBDE0EU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EGj5KCWeluHnuZthHjKS/p0W/Q63My14ajFgn/N7qhE=;
        b=4pzU/4/0YdtoH2KudNdNm0YU4F7scxLoPys3D5ks79vSYDvsVlKr+ZvEfbZprhUx5O
         foZljohnS7SKfSoZtJ5lyWYCH9jXwBeBxHz/VbpCMiz58uUZCgMAX3p1sUQnolY339DW
         ML+DvGx1QHEKviON4+bdu2JejZ95LUI1Z47QBT8haDxFuv/i1ETGa5+C5HMRKDScbTb8
         J+bTYIWia7ioQXiWZ62UBXwDocoViwPISw0n2jsH9FomB3kqYgTqSvVTPLf3zDy0YPN5
         akhjPP+3L3xs89GaKgMAyJnXYbuHG97rFY0x1PTFJpDk/8IdsesPbDYv04hKBLYyOXjO
         KZQQ==
X-Gm-Message-State: AO0yUKVjLan9NNcHIldC2MEwu8olWH3J39hZOFTjPoVaFBkktRPFvpCF
        cjFEy2n5PoM5AMDnCKfqXgFSrg==
X-Google-Smtp-Source: AK7set+bY+B15yGzpYLybxs7pdiMEx2TrMbimOis4YoDfiySO3n8L/uGAam2EAZZNsS8vm3OkApl1g==
X-Received: by 2002:a17:903:22cf:b0:192:4f85:b91d with SMTP id y15-20020a17090322cf00b001924f85b91dmr12771941plg.46.1675441782953;
        Fri, 03 Feb 2023 08:29:42 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d7-20020a170902b70700b001869b988d93sm1800377pls.187.2023.02.03.08.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 08:29:42 -0800 (PST)
Message-ID: <63dd3676.170a0220.1f1b2.3244@mx.google.com>
X-Google-Original-Message-ID: <202302031629.@keescook>
Date:   Fri, 3 Feb 2023 16:29:41 +0000
From:   Kees Cook <keescook@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ASoC: uapi: Replace zero-length arrays with
 __DECLARE_FLEX_ARRAY() helper
References: <YzIzUjUuJKf0mkKg@work>
 <fcd83e77-a3fb-9061-771a-8509ea6f5950@embeddedor.com>
 <Y9wmnfTi/p4FuRmd@sirena.org.uk>
 <bb43c410-bd8c-66fe-19a1-0f41442838eb@embeddedor.com>
 <Y90ExljX2qCsowhu@sirena.org.uk>
 <652684af-bd10-99da-1ed8-104407493428@embeddedor.com>
 <Y90P3kik6ONZg3U4@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y90P3kik6ONZg3U4@sirena.org.uk>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Fri, Feb 03, 2023 at 01:45:02PM +0000, Mark Brown wrote:
> On Fri, Feb 03, 2023 at 07:27:03AM -0600, Gustavo A. R. Silva wrote:
> 
> > I think we have run into this same issue (you not being listed in the
> > MAINTAINERS file) at least once in the past, right? (thinkingface)
> 
> > IMHO, the sensible solution for this is to keep the MAINTAINERS file
> > up-to-date. So, get_maintainer.pl can continue to be useful for people.
> 
> Sure, feel free to send an update...

Is this accurate?


diff --git a/MAINTAINERS b/MAINTAINERS
index 7f86d02cb427..e21a3412a546 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19564,6 +19564,8 @@ F:	Documentation/devicetree/bindings/sound/
 F:	Documentation/sound/soc/
 F:	include/dt-bindings/sound/
 F:	include/sound/soc*
+F:	include/sound/sof/
+F:	include/uapi/sound/asoc.h
 F:	sound/soc/
 
 SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS


-- 
Kees Cook
