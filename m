Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D16C77B7A
	for <linux-hardening@archiver.kernel.org>; Wed, 17 May 2023 18:25:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjEQSZN (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 17 May 2023 14:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjEQSZL (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 17 May 2023 14:25:11 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1D883D8
        for <linux-hardening@vger.kernel.org>; Wed, 17 May 2023 11:25:10 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-517bdc9e81dso577743a12.1
        for <linux-hardening@vger.kernel.org>; Wed, 17 May 2023 11:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684347909; x=1686939909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=45x6aIah125jOfw5DAw6akq7zYqDXWAyHyu9qSo7fA0=;
        b=H4099AwsRNj44sSGT6ogy8ufHfUuk1mCMpajqaFZm2RTsiOdTWnzN9o7fIL1fi+EN/
         DpMuUzPEUrTkIZFJWr7HT+5pu/aGMFZ9bFyqkVh4QGn8PH6i3QHtZBcMqwbgsN1Q26F9
         IaNgpyu3EyiCRbB+GFhmdhMe3m9A6KuTRo4ag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684347909; x=1686939909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=45x6aIah125jOfw5DAw6akq7zYqDXWAyHyu9qSo7fA0=;
        b=P8Ych5kUG6Luwx7yDg2mvVE+gw9H/iEFn34ilPhfLeOCn7OgAYFOyDzPvIutELfVoE
         QI1hfLrqVDRcktglsfEwdkJntcPtFH8LsIitssLCdobKrlZAwk/OeWs/VY2zF53LXRCQ
         beJKAhve0uPj7h0+Ujj7rD5IAWWS3BepTQzhdeTg+Mw9YiyuRcTDqNs+1KQUWQEr26Ik
         WEhRBLIHQBLsbU1nlJoDTrkBM8u9PLmcBb36IUW8jUxSmWm1r6Xb9DmS+SH8NcPK6UOp
         M5GNAgVXWdW14a7JFfdvLABSihUnA+1AoEmq4lepXwE6qXVEaX+OZksTcYM2hb2X5vM+
         Bw/A==
X-Gm-Message-State: AC+VfDwyUoObznNmgjRZnO5jIRQNHQplZofB+okLbjHIfg75AdodriOr
        tEKz8fsQgFb+bDHLLV9mGdpf0g==
X-Google-Smtp-Source: ACHHUZ7HRV57oX9mtBvMxH/rRkgfAocqgjQoyV0w1AqbEJxyB1hldkewGUNpqsBE+e10ortGtNQ0Lw==
X-Received: by 2002:a05:6a20:1590:b0:105:5086:fd42 with SMTP id h16-20020a056a20159000b001055086fd42mr20303935pzj.45.1684347909705;
        Wed, 17 May 2023 11:25:09 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y24-20020aa78558000000b00634a96493f7sm13122932pfn.128.2023.05.17.11.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 11:25:09 -0700 (PDT)
Date:   Wed, 17 May 2023 11:25:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH] firmware: meson_sm: Fix memcpy vs iomem type warnings
Message-ID: <202305171124.4EB0D65@keescook>
References: <20221012185234.never.936-kees@kernel.org>
 <166602031304.3572695.12870664862275915316.b4-ty@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166602031304.3572695.12870664862275915316.b4-ty@linaro.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

*thread necromancy*

On Mon, Oct 17, 2022 at 05:25:13PM +0200, Neil Armstrong wrote:
> Hi,
> 
> On Wed, 12 Oct 2022 11:53:16 -0700, Kees Cook wrote:
> > Use memcpy_{toio,fromio}() instead of memcpy(). Silences warnings from
> > Sparse:
> > 
> > drivers/firmware/meson/meson_sm.c:170:17: warning: incorrect type in argument 1 (different address spaces)
> > drivers/firmware/meson/meson_sm.c:170:17:    expected void const *
> > drivers/firmware/meson/meson_sm.c:170:17:    got void [noderef] __iomem *sm_shmem_out_base
> > drivers/firmware/meson/meson_sm.c:170:17: warning: incorrect type in argument 2 (different address spaces)
> > drivers/firmware/meson/meson_sm.c:170:17:    expected void const *
> > drivers/firmware/meson/meson_sm.c:170:17:    got void [noderef] __iomem *sm_shmem_out_base
> > drivers/firmware/meson/meson_sm.c:206:9: warning: incorrect type in argument 1 (different address spaces)
> > drivers/firmware/meson/meson_sm.c:206:9:    expected void const *
> > drivers/firmware/meson/meson_sm.c:206:9:    got void [noderef] __iomem *sm_shmem_in_base
> > drivers/firmware/meson/meson_sm.c:206:9: warning: incorrect type in argument 1 (different address spaces)
> > drivers/firmware/meson/meson_sm.c:206:9:    expected void const *
> > drivers/firmware/meson/meson_sm.c:206:9:    got void [noderef] __iomem *sm_shmem_in_base
> > drivers/firmware/meson/meson_sm.c:206:9: warning: incorrect type in argument 1 (different address spaces)
> > drivers/firmware/meson/meson_sm.c:206:9:    expected void const *
> > drivers/firmware/meson/meson_sm.c:206:9:    got void [noderef] __iomem *sm_shmem_in_base
> > drivers/firmware/meson/meson_sm.c:206:9: warning: incorrect type in argument 1 (different address spaces)
> > drivers/firmware/meson/meson_sm.c:206:9:    expected void *
> > drivers/firmware/meson/meson_sm.c:206:9:    got void [noderef] __iomem *sm_shmem_in_base
> > 
> > [...]
> 
> Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.2/drivers)
> 
> [1/1] firmware: meson_sm: Fix memcpy vs iomem type warnings
>       https://git.kernel.org/amlogic/c/7dc69c7d073e6004a281db8f7f15cf6ebf702ea0
> 
> These changes has been applied on the intermediate git tree [1].
> 
> The v6.2/drivers branch will then be sent via a formal Pull Request to the Linux SoC maintainers
> for inclusion in their intermediate git branches in order to be sent to Linus during
> the next merge window, or sooner if it's a set of fixes.
> 
> In the cases of fixes, those will be merged in the current release candidate
> kernel and as soon they appear on the Linux master branch they will be
> backported to the previous Stable and Long-Stable kernels [2].
> 
> The intermediate git branches are merged daily in the linux-next tree [3],
> people are encouraged testing these pre-release kernels and report issues on the
> relevant mailing-lists.
> 
> If problems are discovered on those changes, please submit a signed-off-by revert
> patch followed by a corrective changeset.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

Hi! This change seems to have never been mainlined and seems to have
disappeared from linux-next.

-- 
Kees Cook
