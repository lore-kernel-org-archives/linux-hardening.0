Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7AAC27C7A
	for <linux-hardening@archiver.kernel.org>; Thu, 17 Aug 2023 08:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348849AbjHQI0y (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 17 Aug 2023 04:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348910AbjHQI0n (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 17 Aug 2023 04:26:43 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAE12D78
        for <linux-hardening@vger.kernel.org>; Thu, 17 Aug 2023 01:26:35 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qWYKg-00083x-D1; Thu, 17 Aug 2023 10:26:18 +0200
Date:   Thu, 17 Aug 2023 10:26:18 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Kees Cook <keescook@chromium.org>
Cc:     "GONG, Ruiqi" <gongruiqi1@huawei.com>,
        kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, Florian Westphal <fw@strlen.de>,
        linux-hardening@vger.kernel.org
Subject: Re: [netfilter-nf-next:testing 2/9]
 ./usr/include/linux/netfilter_bridge/ebtables.h:163:26: warning: field
 'target' with variable sized type 'struct ebt_entry_target' not at the end
 of a struct or class is a GNU extension
Message-ID: <20230817082618.GE4312@breakpoint.cc>
References: <202308171249.g1ywxhII-lkp@intel.com>
 <202308162257.F7876776C9@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202308162257.F7876776C9@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Kees Cook <keescook@chromium.org> wrote:
> On Thu, Aug 17, 2023 at 01:03:20PM +0800, kernel test robot wrote:
> > tree:   git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git testing
> > head:   015e2d9101d3713c7bee16dccad171df04a3bbd5
> > commit: 61b9e6bd48a6317c0a44ee4f3fecdec9de5baa9e [2/9] netfilter: ebtables: replace zero-length array members
> > config: i386-buildonly-randconfig-r004-20230817 (https://download.01.org/0day-ci/archive/20230817/202308171249.g1ywxhII-lkp@intel.com/config)
> > compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
> > reproduce: (https://download.01.org/0day-ci/archive/20230817/202308171249.g1ywxhII-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202308171249.g1ywxhII-lkp@intel.com/
> > 
> > All warnings (new ones prefixed by >>):
> > 
> >    In file included from <built-in>:1:
> > >> ./usr/include/linux/netfilter_bridge/ebtables.h:163:26: warning: field 'target' with variable sized type 'struct ebt_entry_target' not at the end of a struct or class is a GNU extension [-Wgnu-variable-sized-type-not-at-end]
> >            struct ebt_entry_target target;
> >                                    ^
> >    1 warning generated.
> 
> Eww, it looks like "struct ebt_entry_target" is used _within_ another
> struct:
> 
> struct ebt_standard_target {
>         struct ebt_entry_target target;
>         int verdict;
> };

Yes, same as xt_standard_target.

> These have been fixed in the past in a variety of ways -- it all depends
> on how userspace is using them. In looking at Debian Code Search:
> https://codesearch.debian.net/search?q=struct+ebt_standard_target&literal=1
> 
> It is exclusively doing casts and looking at the "verdict" member. So
> the easiest conversion might be this:
> 
>  struct ebt_standard_target {
> -       struct ebt_entry_target target;
> +       unsigned char hdr[sizeof(struct ebt_entry_target)];
>         int verdict;

I don't think its worth doing all of this.

Can't we just keep it as-is and drop the relevant hunk from the patch?
