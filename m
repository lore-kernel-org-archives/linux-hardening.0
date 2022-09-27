Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F3CC32771
	for <linux-hardening@archiver.kernel.org>; Tue, 27 Sep 2022 02:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbiI0Cau (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 26 Sep 2022 22:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiI0Cat (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 26 Sep 2022 22:30:49 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E86CB2847
        for <linux-hardening@vger.kernel.org>; Mon, 26 Sep 2022 19:30:48 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id iw17so7915192plb.0
        for <linux-hardening@vger.kernel.org>; Mon, 26 Sep 2022 19:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=M6ZjbEpb/UdQZtA16p01zlM8hWd+9RIaPah6OiYEF9s=;
        b=JLnoASLUHeDPUf6dI39o1+5rs9AzhUtl9AApNwejURiKdFKySH7qwrWxoCD8281JdM
         s5VZBA3uCrzXB/vkhMOC5uX2WZ+020yhDkhV3nLWWe84wG1IrVbTXzd7loPubISbr7Lq
         REDFu0hTtFb8HmZWdQO+0sCSW2tjfT1AFwfcU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=M6ZjbEpb/UdQZtA16p01zlM8hWd+9RIaPah6OiYEF9s=;
        b=eX4GfeazU/94clePLqmd2HmX7K/pXLRobjkdZASmN2JtZZpSTBLG7Y5syQT7wfGn4t
         47NLTEdD6BEkzab5vKyv8igqhVExu2+9liSE83n6AYKDsDK764ZiWioyMjQD3EDgZrTJ
         af7b9TVQrJmew8y6NiPRHQMb4k1OjJdkqPY/Fp1vjawbWag/5V/rzlZT8rmC0Zf/CPNj
         00RG25gOBmyFJ2aq5OM0m8UEq9wjsBhRogxmqsjwQ7dYLuGvnM3oGs33OAbOqawZ1rpP
         8PuXVJFoZQzQVRP9psyp15NlfGmU28kM2GH01NqU0TXAfwWPBtM7lPm4y72NKgzM/Ow7
         +CmQ==
X-Gm-Message-State: ACrzQf0heWbMuLxeky9rC1L8zNXy8Bq7O9qWsRe9l67ald/c7/A1oybA
        ej87OgDSt65MkHtKyeR/Q7z4JA==
X-Google-Smtp-Source: AMsMyM4fVILya89l/buI/6YDmjZuGWn9S4tka+jx7icqv87/971kE+MPYocVhEp623vm5hAMuZB50Q==
X-Received: by 2002:a17:90b:4c8b:b0:203:5db5:8b71 with SMTP id my11-20020a17090b4c8b00b002035db58b71mr1933594pjb.51.1664245847736;
        Mon, 26 Sep 2022 19:30:47 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t6-20020a1709027fc600b00176dc72ad88sm117601plb.287.2022.09.26.19.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 19:30:46 -0700 (PDT)
Date:   Mon, 26 Sep 2022 19:30:46 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] ASoC: Intel: Skylake: Replace zero-length arrays
 with DECLARE_FLEX_ARRAY() helper
Message-ID: <202209261930.A40876B@keescook>
References: <YzIuiUul2CwPlkKh@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzIuiUul2CwPlkKh@work>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Sep 26, 2022 at 05:58:17PM -0500, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated and we are moving towards adopting
> C99 flexible-array members, instead. So, replace zero-length arrays
> declarations in anonymous union with the new DECLARE_FLEX_ARRAY()
> helper macro.
> 
> This helper allows for flexible-array members in unions.
> 
> Link: https://github.com/KSPP/linux/issues/193
> Link: https://github.com/KSPP/linux/issues/226
> Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
