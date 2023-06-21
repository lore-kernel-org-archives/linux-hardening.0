Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6758BEB64D7
	for <linux-hardening@archiver.kernel.org>; Wed, 21 Jun 2023 21:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjFUVjm (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 21 Jun 2023 17:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjFUVjm (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 21 Jun 2023 17:39:42 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E201B4
        for <linux-hardening@vger.kernel.org>; Wed, 21 Jun 2023 14:39:41 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-54fac329a71so3471473a12.1
        for <linux-hardening@vger.kernel.org>; Wed, 21 Jun 2023 14:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687383581; x=1689975581;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LMQGKrnwxJrYKagQrGNd4HzBWauMpUnU63pcxUio84Q=;
        b=RjsdU3Z7MemvIOsOm+J6epw1Da5oDqUFcQj7hPXtoM07I5aKCN1O/Ec61j/I+Bt/Jk
         iO/56fh+i5GjcvWZNRk0BPlV+rs2So+t6fS/USYtxV4JCEKZGpl5mqsnavtwqrFNhVf0
         SozDO4u4Xr7eFaEMsLVk+4LzP1IAL17XkogEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687383581; x=1689975581;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LMQGKrnwxJrYKagQrGNd4HzBWauMpUnU63pcxUio84Q=;
        b=clW63ZRHcHrWsLxohb4r+9WP3i4pHzNix/6lGNfBU/EdB1cDV9W+hIoPgzPtnpY9R3
         IjuxkFdTvglBFBNIuKJhlS21F9a2mHyMjWgLr908pl3OpvArFFTFnuUj6pCnLw3+dxcO
         T9t7Av4wBK2zR4C/ujKa4Wjad2wL1I3CeqbPy56d/zCIk5TRsVPemMNo0n7uesQIrTLT
         7BYRdrbBzFzeZAkPxm+6NfTkzgX859gUCPHE8RVCzKa9+RGMnmilHpMCkhqFtyftUmBR
         UVa6mg8c8skNtAsDyPgvZ6159jiKDLrVSX6ll3IPtH1dgzahOT1M1wXm3PKCkUhnuWa7
         p74w==
X-Gm-Message-State: AC+VfDynn1YRBOkF5Y3RLP2THhYMI1c+a6Anp0FOcv8w/Hx/hN+yula7
        sq0fcQvfrPDtt5MMkYyFks3qXw==
X-Google-Smtp-Source: ACHHUZ6ncMjo1q4HvqrqyxPoLFnGjEfqfAMeVa1q+LhlzHMxG2JfRgkZMMsKBe/2H+Zd9zkQ386CjA==
X-Received: by 2002:a17:90a:c905:b0:258:818a:fd65 with SMTP id v5-20020a17090ac90500b00258818afd65mr9890799pjt.30.1687383580740;
        Wed, 21 Jun 2023 14:39:40 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m3-20020a17090a7f8300b002563e8a0225sm3591485pjl.48.2023.06.21.14.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 14:39:40 -0700 (PDT)
Date:   Wed, 21 Jun 2023 14:39:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [linux-next:master 2819/11071] fs/ceph/addr.c:794:12: warning:
 stack frame size (2096) exceeds limit (2048) in 'ceph_writepages_start'
Message-ID: <202306211437.EDDEDA582@keescook>
References: <202306210637.TpfYq9gM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202306210637.TpfYq9gM-lkp@intel.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Jun 21, 2023 at 06:56:36AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> head:   9dbf40840551df336c95ce2a3adbdd25ed53c0ef
> commit: df8fc4e934c12b906d08050d7779f292b9c5c6b5 [2819/11071] kbuild: Enable -fstrict-flex-arrays=3

This looks very much like:
https://lore.kernel.org/all/202306100035.VTusNhm4-lkp@intel.com/

> config: riscv-randconfig-r004-20230620 (https://download.01.org/0day-ci/archive/20230621/202306210637.TpfYq9gM-lkp@intel.com/config)
> compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
> reproduce: (https://download.01.org/0day-ci/archive/20230621/202306210637.TpfYq9gM-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202306210637.TpfYq9gM-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> fs/ceph/addr.c:794:12: warning: stack frame size (2096) exceeds limit (2048) in 'ceph_writepages_start' [-Wframe-larger-than]
>    static int ceph_writepages_start(struct address_space *mapping,
>               ^
>    1820/2096 (86.83%) spills, 276/2096 (13.17%) variables
>    1 warning generated.

This appears to be a clang stack slot reuse issue. It continues to be
investigated.

-Kees

-- 
Kees Cook
