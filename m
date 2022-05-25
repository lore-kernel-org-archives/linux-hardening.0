Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515D1C433F5
	for <linux-hardening@archiver.kernel.org>; Wed, 25 May 2022 22:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245552AbiEYWnH (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 25 May 2022 18:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245336AbiEYWnF (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 25 May 2022 18:43:05 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144E8A3389
        for <linux-hardening@vger.kernel.org>; Wed, 25 May 2022 15:43:04 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id t25so38204367lfg.7
        for <linux-hardening@vger.kernel.org>; Wed, 25 May 2022 15:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oz2gVkV0rfGCK+wdnxIRVq+wPrFjy2J+zLB3pC3weio=;
        b=wCoRfmCbsxPE19Zmdw6DveiRBya3gLcbPlkCQYJ7N/7yJQLRx8NAwqara8WXe8tq/P
         7ASVnP6pM7uRxH/yKf6GevmzNtwNP9eOTBanOIHO7McHyYS6UQc4498QARj3NhkhyQi4
         DWO8di2RJlvJrwGP7g3eQA6l8yJsxaozcbWBVe/+NpD0KSwgUGxPK11xgV7ztKWN0G57
         pcuZNQ/p0OOspIeOC1NR3n15KY9Yfv+WKI3DOFZlPd5UmrjSy2cSr0MpRucPCxYUwV60
         z0c4jH+te97AyRx4G1tpAuhALhlcwjmo1KWiRXaeyyxZFRjZaPEOKd8D7mz95QY4c7Ti
         Om3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oz2gVkV0rfGCK+wdnxIRVq+wPrFjy2J+zLB3pC3weio=;
        b=b/z/DAFxGX15me8HI3z/9whHxlThUBCRRMRagecH0q69gGsIOtoN7UvAIfHV+tnXwH
         9S8EI3PztFZs0ZLmTfAFEEYEkIfNESWJ2hirf86iUnALCERtJeXrdHL9bvpu0Cbt+dPu
         dvL9bmQmMDk7rZaU+CTSo+V9k/kZ3WmbemiCB1aPKA7WIjmzuoZ9IAfjXGp7VSLfuanZ
         1V5bdSptu1ZnOolL1XPO/FRIgO3i0Bq0ioHozThGt0ja0BvkuQUWMR/8mzzfBk0dv3a8
         uKjmY95S5NoUIygOWc2k8q6GwVbRejUO+JhuQNuj8zZvCIr7wRd91Syk7R8hdW2znOQq
         wROw==
X-Gm-Message-State: AOAM530iGSmWNMONeFkXtxWNLjIsUY/y3hPmNklX5LKvfb33fkSB0LGx
        QQYISeX1x0JAkzF8Y2jHrhNPeQ==
X-Google-Smtp-Source: ABdhPJzfyvl7lu0FBluAxH1xjtbTDlyzPZN0U5W97+zTH7VP0T31OYEE4wxbKw4XNU8aF9swQ9ktgw==
X-Received: by 2002:a05:6512:12c9:b0:477:c583:ed10 with SMTP id p9-20020a05651212c900b00477c583ed10mr4278948lfg.20.1653518581956;
        Wed, 25 May 2022 15:43:01 -0700 (PDT)
Received: from mutt (c-7303e555.07-21-73746f28.bbcust.telenor.se. [85.229.3.115])
        by smtp.gmail.com with ESMTPSA id g7-20020a056512118700b0047255d21104sm3286144lfr.51.2022.05.25.15.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 15:43:01 -0700 (PDT)
Date:   Thu, 26 May 2022 00:42:59 +0200
From:   Anders Roxell <anders.roxell@linaro.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Alexander Popov <alex.popov@linux.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Subject: Re: [PATCH] gcc-plugins: Change all version strings match kernel
Message-ID: <20220525224259.GA16698@mutt>
References: <20220510235412.3627034-1-keescook@chromium.org>
 <20220523143054.GA3164771@roeck-us.net>
 <202205231251.39D012E@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202205231251.39D012E@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On 2022-05-23 12:54, Kees Cook wrote:
> On Mon, May 23, 2022 at 07:30:54AM -0700, Guenter Roeck wrote:
> > On Tue, May 10, 2022 at 04:54:12PM -0700, Kees Cook wrote:
> > > It's not meaningful for the GCC plugins to track their versions separately
> > > from the rest of the kernel. Switch all versions to the kernel version.
> > > 
> > > Fix mismatched indenting while we're at it.
> > > 
> > > Cc: linux-hardening@vger.kernel.org
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > 
> > I see random build failures with this patch in linux-next.
> > 
> > Error log:
> > cc1plus: fatal error: ./include/generated/utsrelease.h: No such file or directory
> > 
> > The problem doesn't happen all the time. Is there some missing dependency ?
> 
> Here's a prior report I hadn't been able to repro:
> https://lore.kernel.org/linux-mm/202205230239.EZxeZ3Fv-lkp@intel.com
> 
> But now I can: I see it with a -j1 build. This fixes it for me:

I could see this issue when I built an arm64 allmodconfig mainline [1]
kernel, on sha
7e062cda7d90 ("Merge tag 'net-next-5.19' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next")

To reproduce what I built tuxmake [2] can be used:
$ tuxmake --runtime podman --target-arch arm64 --toolchain gcc-11 --kconfig http://ix.io/3YBi kernel

> 
> diff --git a/Makefile b/Makefile
> index 91c91fcf3c24..c04420d5aa3d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1175,7 +1175,7 @@ include/config/kernel.release: FORCE
>  # Carefully list dependencies so we do not try to build scripts twice
>  # in parallel
>  PHONY += scripts
> -scripts: scripts_basic scripts_dtc
> +scripts: include/generated/utsrelease.h scripts_basic scripts_dtc
>  	$(Q)$(MAKE) $(build)=$(@)
>  
>  # Things we need to do before we recursively start building the kernel
> diff --git a/scripts/gcc-plugins/Makefile b/scripts/gcc-plugins/Makefile
> index 6f0aecad5d67..c29334669a16 100644
> --- a/scripts/gcc-plugins/Makefile
> +++ b/scripts/gcc-plugins/Makefile
> @@ -64,5 +64,5 @@ $(foreach m, $(notdir $(plugin-multi)), $(eval $(obj)/$m: $(addprefix $(obj)/, $
>  quiet_cmd_plugin_cxx_o_c = HOSTCXX $@
>        cmd_plugin_cxx_o_c = $(HOSTCXX) $(plugin_cxxflags) -c -o $@ $<
>  
> -$(plugin-objs): $(obj)/%.o: $(src)/%.c FORCE
> +$(plugin-objs): $(obj)/%.o: $(src)/%.c $(objdir)/include/generated/utsrelease.h FORCE
>  	$(call if_changed_dep,plugin_cxx_o_c)
> 
> Both "include/generated/utsrelease.h" and "scripts" were same-level
> deps, so they were racing. 

This patch patch solved the build error.

Cheers,
Anders
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
[2] https://tuxmake.org/install-pypi/
