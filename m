Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F75C3DA58
	for <linux-hardening@archiver.kernel.org>; Thu, 17 Aug 2023 17:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353237AbjHQRDB (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 17 Aug 2023 13:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353805AbjHQRCi (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 17 Aug 2023 13:02:38 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1EA2D75
        for <linux-hardening@vger.kernel.org>; Thu, 17 Aug 2023 10:02:36 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bf1935f6c2so280155ad.1
        for <linux-hardening@vger.kernel.org>; Thu, 17 Aug 2023 10:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692291756; x=1692896556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Of6VU25h9o3MQFapeYfF0CWZ6iyOJM3AV0c4Y0pZ9cU=;
        b=SFYhf7Oz8UygdI5YwpKRoNs+ZXAjO5sfO6ikcV/OhTNMscCt40x0lD0mjI1W9025YN
         A0bkeVTf0o5KpnbkeZDJOHyk2POgEKEmARdNxasavIOmfnfOz0TyzBm9fo1VCD3JwPiB
         OS3XEwNdNlmJBQ+pjG1wh8ag9tz/SIwbh4GBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692291756; x=1692896556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Of6VU25h9o3MQFapeYfF0CWZ6iyOJM3AV0c4Y0pZ9cU=;
        b=Ab3h8Wd9KX7WVep+zJ2JVE5lyAcHiLTIlE0p/bfl4FKRxNGvGibQ99gtQyyeyPKLgv
         1Mjd98jhJEQuYdnU8LKsbt0kWb19iBw/raji50wD1NcX5bZS0jiV/6MGPaaCfxwtyJCL
         YDC1x+LBpsPZmHBBDn9eyD3y20up8meyWnCKAcZK+AH5S4ctNbwulf2W1mefXLP0n7mF
         AtAgxca7epOyDKwAEj6viTmvRqaK4pw4hDc7PMivmEHjcaEfdznPrXIMu3aCDBeqzUoU
         QTS2nL+ItKI+antwBzbXoU27/904ythR4Nci/GafosSDn3os0mY87l7KEaAhsB/Yaw6j
         9KZg==
X-Gm-Message-State: AOJu0YyfQkabYe749FleiQBhdbra3Zl11XTUWn/MB9l2IlZEskK8xSxC
        77lk8DvdWEF3sN5G0uP3rxAYkg==
X-Google-Smtp-Source: AGHT+IGI+a/TGyaY9qq/8RhsQ7+ZyIRNHF9G7HFpGWCoFP17tKGyxWmLNtgQ1mqMX5B+KZCAWgxUvA==
X-Received: by 2002:a17:902:dace:b0:1bc:4b77:c74 with SMTP id q14-20020a170902dace00b001bc4b770c74mr4865416plx.0.1692291756228;
        Thu, 17 Aug 2023 10:02:36 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ju17-20020a170903429100b001bdb0483e65sm13952918plb.265.2023.08.17.10.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 10:02:35 -0700 (PDT)
Date:   Thu, 17 Aug 2023 10:02:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     "GONG, Ruiqi" <gongruiqi1@huawei.com>,
        kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [netfilter-nf-next:testing 2/9]
 ./usr/include/linux/netfilter_bridge/ebtables.h:163:26: warning: field
 'target' with variable sized type 'struct ebt_entry_target' not at the end
 of a struct or class is a GNU extension
Message-ID: <202308171000.C97EEC7@keescook>
References: <202308171249.g1ywxhII-lkp@intel.com>
 <202308162257.F7876776C9@keescook>
 <20230817082618.GE4312@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817082618.GE4312@breakpoint.cc>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Thu, Aug 17, 2023 at 10:26:18AM +0200, Florian Westphal wrote:
> Kees Cook <keescook@chromium.org> wrote:
> > On Thu, Aug 17, 2023 at 01:03:20PM +0800, kernel test robot wrote:
> > > tree:   git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git testing
> > > head:   015e2d9101d3713c7bee16dccad171df04a3bbd5
> > > commit: 61b9e6bd48a6317c0a44ee4f3fecdec9de5baa9e [2/9] netfilter: ebtables: replace zero-length array members
> > > config: i386-buildonly-randconfig-r004-20230817 (https://download.01.org/0day-ci/archive/20230817/202308171249.g1ywxhII-lkp@intel.com/config)
> > > compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
> > > reproduce: (https://download.01.org/0day-ci/archive/20230817/202308171249.g1ywxhII-lkp@intel.com/reproduce)
> > > 
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Closes: https://lore.kernel.org/oe-kbuild-all/202308171249.g1ywxhII-lkp@intel.com/
> > > 
> > > All warnings (new ones prefixed by >>):
> > > 
> > >    In file included from <built-in>:1:
> > > >> ./usr/include/linux/netfilter_bridge/ebtables.h:163:26: warning: field 'target' with variable sized type 'struct ebt_entry_target' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
> > >            struct ebt_entry_target target;
> > >                                    ^
> > >    1 warning generated.
> > 
> > Eww, it looks like "struct ebt_entry_target" is used _within_ another
> > struct:
> > 
> > struct ebt_standard_target {
> >         struct ebt_entry_target target;
> >         int verdict;
> > };
> 
> Yes, same as xt_standard_target.
> 
> > These have been fixed in the past in a variety of ways -- it all depends
> > on how userspace is using them. In looking at Debian Code Search:
> > https://codesearch.debian.net/search?q=struct+ebt_standard_target&literal=1
> > 
> > It is exclusively doing casts and looking at the "verdict" member. So
> > the easiest conversion might be this:
> > 
> >  struct ebt_standard_target {
> > -       struct ebt_entry_target target;
> > +       unsigned char hdr[sizeof(struct ebt_entry_target)];
> >         int verdict;
> 
> I don't think its worth doing all of this.
> 
> Can't we just keep it as-is and drop the relevant hunk from the patch?

For now, yeah. But we'll need to find a solution as flex-array
structures overlapping variables is considered deprecated (it can lead
to ambiguous sizing results). But as long as the kernel itself doesn't
use struct ebt_standard_target, we can kick the can down the road a bit
more. :)

-- 
Kees Cook
