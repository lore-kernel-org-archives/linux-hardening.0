Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE4DC433EF
	for <linux-hardening@archiver.kernel.org>; Mon, 31 Jan 2022 22:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233575AbiAaWat (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 31 Jan 2022 17:30:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbiAaWat (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 31 Jan 2022 17:30:49 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579A6C061714
        for <linux-hardening@vger.kernel.org>; Mon, 31 Jan 2022 14:30:49 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id k17so13864519plk.0
        for <linux-hardening@vger.kernel.org>; Mon, 31 Jan 2022 14:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=x0hUswGR/XVoEKkZMJv786HYuroqjOV4Xzoz88cK1Uk=;
        b=OYXJepQNOCqvgdd3Fq9VMDn+C0UV4o99poBGAYKeB19qtEicUSPDMLhUo7AgqSnjJc
         4UZhVvPs0zLZJXciTb3RlYcIJc2MQGVIuNcl4RopCunnxeArujE614mC+HyLqurulI1O
         mi70bn2BUJ2V2Ga0lZhWNVotQyHRmkfz9KXkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=x0hUswGR/XVoEKkZMJv786HYuroqjOV4Xzoz88cK1Uk=;
        b=Ud2aJjY2HpYNLqkF+HFF8MycNRw5sqnmXktRlhUkgt/I+lvfz45FMB4OPh+67Kj1oy
         diQ7ncK+wq2ev06QQtLq7TqiAl07zKb4zfxffV4cUoaMgG3lsoDRy6irSA2eGNE+Ii7T
         rEK0E1qFtFRvoEU7py2cmYFVSwAuTYj4ZknFb9urTiv+i25zK2qTqP79N/VXY+1/vGgS
         yltirjcXH5en6qzWGmkcYXFkp6M4nn4OHFMUmCfI1RzR7QnoaOYS2PmO2XEf6lgxKHYH
         lt9hTcUGH4ZH0z1yCwV7FsHfqjLdr5VpC5rIUzz+Gk1iQrbL9yXQ6yBS1wqTQ3DEuxnj
         WiqQ==
X-Gm-Message-State: AOAM532QJNVvB7r1ahhLOex2ws/uTiKM3tzR6djzkwMZKMsGK1GOn60W
        MvpJW4dm3dg40a+D+AdWtiXk35YGebeIaw==
X-Google-Smtp-Source: ABdhPJxzFY+CO4aJ/kK3+6cjDtA3vW2adjbpAGX4TrRwBbF4gSzc8F3hLJ0ZIeovN8MPB8tY7xJ/rg==
X-Received: by 2002:a17:90b:3810:: with SMTP id mq16mr35568804pjb.95.1643668248891;
        Mon, 31 Jan 2022 14:30:48 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c8sm12905815pfv.57.2022.01.31.14.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 14:30:48 -0800 (PST)
Date:   Mon, 31 Jan 2022 14:30:47 -0800
From:   Kees Cook <keescook@chromium.org>
To:     ci_notify@linaro.org
Cc:     linaro-kernel@lists.linaro.org, arnd@linaro.org,
        linux-hardening@vger.kernel.org
Subject: Re: [TCWG CI] Regression caused by linux: Makefile: Enable
 -Warray-bounds
Message-ID: <202201311410.EA1999F5@keescook>
References: <809699127.18214.1643504444637@jenkins.jenkins>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <809699127.18214.1643504444637@jenkins.jenkins>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sun, Jan 30, 2022 at 01:00:43AM +0000, ci_notify@linaro.org wrote:
> [TCWG CI] Regression caused by linux: Makefile: Enable -Warray-bounds:
> commit d4e0dad4a0cd00d1518f2105ccbfee17e2aa44a7
> Author: Kees Cook <keescook@chromium.org>
> 
>     Makefile: Enable -Warray-bounds
> [...]
> # 00:00:53 ./arch/arm/include/asm/io.h:113:9: error: array subscript 0 is outside array bounds of ‘const volatile void[0]’ [-Werror=array-bounds]

Thanks for the report!

Would it be possible to include the "inlined from" details in the email
summaries? Just getting a header file doesn't say where a header-defined
inline is being used.

For example, extracting from the build log, I can see more:

> 00:00:53 In file included from ./include/linux/io.h:13,
> 00:00:53                  from arch/arm/mach-cns3xxx/pm.c:8:
> 00:00:53 In function ‘__raw_readl’,
> 00:00:53     inlined from ‘cns3xxx_pwr_clk_en’ at arch/arm/mach-cns3xxx/pm.c:17:12:
> 00:00:53 ./arch/arm/include/asm/io.h:113:9: error: array subscript 0 is outside array bounds of ‘const volatile void[0]’ [-Werror=array-bounds]
> 00:00:53   113 |         asm volatile("ldr %0, %1"
> 00:00:53       |         ^~~

Looks like something sees a "void" type... this smells like a compiler
bug. I haven't been able to reproduce this warning yet.

> [...]
> git clone https://git.linaro.org/toolchain/jenkins-scripts
> 
> # Fetch manifests and test.sh script
> mkdir -p artifacts/manifests
> curl -o artifacts/manifests/build-baseline.sh https://ci.linaro.org/job/tcwg_kernel-gnu-bisect-gnu-master-arm-next-allmodconfig/45/artifact/artifacts/manifests/build-baseline.sh --fail
> curl -o artifacts/manifests/build-parameters.sh https://ci.linaro.org/job/tcwg_kernel-gnu-bisect-gnu-master-arm-next-allmodconfig/45/artifact/artifacts/manifests/build-parameters.sh --fail
> curl -o artifacts/test.sh https://ci.linaro.org/job/tcwg_kernel-gnu-bisect-gnu-master-arm-next-allmodconfig/45/artifact/artifacts/test.sh --fail
> chmod +x artifacts/test.sh
> 
> # Reproduce the baseline build (build all pre-requisites)
> ./jenkins-scripts/tcwg_kernel-build.sh @@ artifacts/manifests/build-baseline.sh

I couldn't find the compiler version anywhere in here. Could you include
the compiler and linker --version output in the build logs too?

Maybe something in tcwg_kernel-build.sh near here, to get either CC or
CROSS_COMPILE + HOSTCC and ld_opt's --version output:

    local opts
    opts="CC=$(pwd)/bin/${rr[target]}-cc $ld_opt SUBLEVEL=0 EXTRAVERSION=-bisect"
    if [ x"${rr[target]}" != x"$(uname -m)" ]; then
	opts="$opts ARCH=$(print_kernel_target ${rr[target]})"
	opts="$opts CROSS_COMPILE=$(print_gnu_target ${rr[target]})-"
	opts="$opts HOSTCC=gcc"
    fi

It looks like maybe this is built under Ubuntu bionic? Or maybe focal? I
don't see the warning with any GCC version I've tested with: 11.2.0
(impish), 10.3.0 (hirsute), 9.3.0 (focal), nor 7.5.0 (bionic).

Do you have some further hints about this?

Thanks!

-- 
Kees Cook
