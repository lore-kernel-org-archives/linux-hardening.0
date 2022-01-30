Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4099C433F5
	for <linux-hardening@archiver.kernel.org>; Sun, 30 Jan 2022 20:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356142AbiA3UfS (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sun, 30 Jan 2022 15:35:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244727AbiA3UfP (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sun, 30 Jan 2022 15:35:15 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A082C06173B
        for <linux-hardening@vger.kernel.org>; Sun, 30 Jan 2022 12:35:15 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id z5so10721976plg.8
        for <linux-hardening@vger.kernel.org>; Sun, 30 Jan 2022 12:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HhCfzXrJfpfzHpYFIeIiF4SObfvNlEvOkXD0dTt9Bes=;
        b=aI9B7t7nlxry+lWbS6lAs3mP/ob2ZO0xOgR5o3hf6lQhcxUVW2AI2w8Rw/O1FYynpm
         5Wy4OfR++fmAkF2jXLUfiV0nv5PFrdc2wfTBZ7QplaqtH/CKfgT6DdZRGusktwVOIItR
         9RmnWVnD0EyNXCq+BL+y3ASpxxKtKcmqgBPOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HhCfzXrJfpfzHpYFIeIiF4SObfvNlEvOkXD0dTt9Bes=;
        b=U8Ds83qOD7lLiTvHWTBZ4gGTX9ugneY0Sv0Hs3xzPZpg0RdlaTtCyNumwTs0rP0Wz4
         YKme2O55xnbLBTfql3uOVOAKtVxnnfnHXa4xgx6Rh3mYNwowOXxU9CVIBhr6rgN6kbbQ
         zeqhwNy9fl8JHZZIfSHydUC3gtbQs8GMJPac4yBDPUxu76l4lFIRuMSVEICLL5ByA6nv
         uEFeUnpVwYTsv2AZIRUDW0TAgUxFbHlu65ZcTv9limKKWe7jED5CgiHbBKfZJ6o1+x7p
         CRgxiQnWLhDNItpKU7ARJGEB/OzzTA7q10FU9T+V1rXsg5OFmpLUuWaRpW9NtnvuMdQx
         Endw==
X-Gm-Message-State: AOAM533hKlp7tQgmJDgkm4txJMtoLPMkplr9FBA2g3eZLkNHghsum6Gn
        rgU3HaOn36ugxy3snqcKj+YUCg==
X-Google-Smtp-Source: ABdhPJxcxIPFWYWKzE1XOlatp1pBNOxZIXCv9oIzp/3JWkb5ov8UyOIpHcJBVM75drURUF2dFlNWYQ==
X-Received: by 2002:a17:902:dcc9:: with SMTP id t9mr17491178pll.15.1643574914677;
        Sun, 30 Jan 2022 12:35:14 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l2sm16080704pfc.183.2022.01.30.12.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 12:35:14 -0800 (PST)
Date:   Sun, 30 Jan 2022 12:35:13 -0800
From:   Kees Cook <keescook@chromium.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, Geert Uytterhoeven <geert@linux-m68k.org>,
        Peter Rosin <peda@axentia.se>,
        Andy Shevchenko <andy@kernel.org>,
        Matteo Croce <mcroce@microsoft.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] lib/test_string.c: Add test for strlen()
Message-ID: <202201301234.D62394C08@keescook>
References: <20220130183653.491292-1-keescook@chromium.org>
 <202201310303.HQlCsvvd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202201310303.HQlCsvvd-lkp@intel.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Mon, Jan 31, 2022 at 04:13:30AM +0800, kernel test robot wrote:
> Hi Kees,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on linux/master]
> [also build test ERROR on linus/master kees/for-next/pstore v5.17-rc2 next-20220128]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Kees-Cook/lib-test_string-c-Add-test-for-strlen/20220131-023726
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 2c271fe77d52a0555161926c232cd5bc07178b39
> config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20220131/202201310303.HQlCsvvd-lkp@intel.com/config)
> compiler: sh4-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/d22fe883339c5141953dbca980b51466ac3e2329
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Kees-Cook/lib-test_string-c-Add-test-for-strlen/20220131-023726
>         git checkout d22fe883339c5141953dbca980b51466ac3e2329
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sh SHELL=/bin/bash M=lib/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> lib/test_string.c:188:30: error: initializer element is not constant
>      188 | static const int strlen_ce = strlen("tada, a constant expression");
>          |                              ^~~~~~

Thanks; this is expected -- the strlen() in -next is currently broken
(and will be fixed in the next -next).

-Kees

> 
> 
> vim +188 lib/test_string.c
> 
>    181	
>    182	/*
>    183	 * Unlike many other string functions, strlen() can be used in
>    184	 * static initializers when string lengths are known at compile
>    185	 * time. (i.e. Under these conditions, strlen() is a constant
>    186	 * expression.) Make sure it can be used this way.
>    187	 */
>  > 188	static const int strlen_ce = strlen("tada, a constant expression");
>    189	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

-- 
Kees Cook
