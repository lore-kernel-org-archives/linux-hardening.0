Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F06EB64D7
	for <linux-hardening@archiver.kernel.org>; Wed, 21 Jun 2023 21:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjFUVor (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 21 Jun 2023 17:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjFUVoq (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 21 Jun 2023 17:44:46 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FB39B
        for <linux-hardening@vger.kernel.org>; Wed, 21 Jun 2023 14:44:45 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b516978829so50654125ad.1
        for <linux-hardening@vger.kernel.org>; Wed, 21 Jun 2023 14:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687383885; x=1689975885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Rd40KBCWSsCbJWxPET1CFACuq5ZB3wmGFYxKgqNwkc=;
        b=Ooor9E92TNcAvld0FWJty92UhU5ZJe3cq0fLlktiQEeF8kC9BZ8YBc5s9JJlW3nLys
         PQ/53w9p3mTMyTjjZOraNa0q6bgpULJW1Jy1eC04LdGIkxWiCJ1s8AMAvZIP3c0yaa/F
         OHlT/5r/bi/p3cjMtS09w0n7zytLB9bgn5Luk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687383885; x=1689975885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Rd40KBCWSsCbJWxPET1CFACuq5ZB3wmGFYxKgqNwkc=;
        b=heIaD0sue3MDMqy3LVnNIulj8pdoYhZ4xg3Mw0vJ0Ly/rKptK3TonHQuuE40SBdkCZ
         Jn5dbx7Mpk6hixK3F1Uu5kCq6pmAwJK1z1ppYvC5x1F/JZoMU11VzSJ7TAi+grZ5UqMK
         YJva5+aAT+BTPnHGtdld2NJYzTWHZseCLlQQ0mGe7mejciTP8/6ZxaaQ7HRO7HhSqou3
         VCJZEHXJUfZ8Hjj+2uZNsQbM4ZDO2x//W+SEDQITuyJ6R7yfs8ySQrsRm/iaQpQm0WEb
         MtF1MYr9aMcZ8REGUIgWyq5fIMu0McofGlwOXsyQ6EL0G8n4zY1e64Zcevx9kCQcVUXL
         Gxqw==
X-Gm-Message-State: AC+VfDym+yLmYoYY6f4k53CEtMCqKe3svp3JVyLZaaW77xRzQHWDBJfr
        WlbgU8QcrAytK5g5tkJvdx7kgQ==
X-Google-Smtp-Source: ACHHUZ7gqJTbHl8WT+G1auX5bF8S63aJrNLzA2YHyy+W6rVFe4J3nRu/wOMaivJPPydajh1yPvu6aQ==
X-Received: by 2002:a17:903:280e:b0:1ac:5717:fd5 with SMTP id kp14-20020a170903280e00b001ac57170fd5mr16450144plb.60.1687383885047;
        Wed, 21 Jun 2023 14:44:45 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m12-20020a1709026bcc00b00186a2274382sm3941752plt.76.2023.06.21.14.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 14:44:44 -0700 (PDT)
Date:   Wed, 21 Jun 2023 14:44:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [linux-next:master 2819/11071] fs/ceph/addr.c:794:12: warning:
 stack frame size (2096) exceeds limit (2048) in 'ceph_writepages_start'
Message-ID: <202306211444.EEB1506@keescook>
References: <202306210637.TpfYq9gM-lkp@intel.com>
 <202306211437.EDDEDA582@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202306211437.EDDEDA582@keescook>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Jun 21, 2023 at 02:39:39PM -0700, Kees Cook wrote:
> On Wed, Jun 21, 2023 at 06:56:36AM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> > head:   9dbf40840551df336c95ce2a3adbdd25ed53c0ef
> > commit: df8fc4e934c12b906d08050d7779f292b9c5c6b5 [2819/11071] kbuild: Enable -fstrict-flex-arrays=3
> 
> This looks very much like:
> https://lore.kernel.org/all/202306100035.VTusNhm4-lkp@intel.com/
> 
> > config: riscv-randconfig-r004-20230620 (https://download.01.org/0day-ci/archive/20230621/202306210637.TpfYq9gM-lkp@intel.com/config)
> > compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
> > reproduce: (https://download.01.org/0day-ci/archive/20230621/202306210637.TpfYq9gM-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202306210637.TpfYq9gM-lkp@intel.com/
> > 
> > All warnings (new ones prefixed by >>):
> > 
> > >> fs/ceph/addr.c:794:12: warning: stack frame size (2096) exceeds limit (2048) in 'ceph_writepages_start' [-Wframe-larger-than]
> >    static int ceph_writepages_start(struct address_space *mapping,
> >               ^
> >    1820/2096 (86.83%) spills, 276/2096 (13.17%) variables
> >    1 warning generated.
> 
> This appears to be a clang stack slot reuse issue. It continues to be
> investigated.

We're currently tracking it here, though we may need to split the bug
up:
https://github.com/ClangBuiltLinux/linux/issues/39

-- 
Kees Cook
