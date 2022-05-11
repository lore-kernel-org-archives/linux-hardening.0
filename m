Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BAEC433F5
	for <linux-hardening@archiver.kernel.org>; Wed, 11 May 2022 07:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237592AbiEKHbl (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 11 May 2022 03:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234832AbiEKHbg (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 11 May 2022 03:31:36 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AD96543D;
        Wed, 11 May 2022 00:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652254295; x=1683790295;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TzmIUvS+MtG9JtLBVwtHktGy8iBnVLxd6nF8f6yLGKQ=;
  b=XJ3vsOgspazxtyGGnKyHhqQsBKXYqMnA4CYEFnXfCBHXTfF0dT6mIe9Y
   sAuELM8LuukLWyG+0bESq/Knh9R0gX4PV2UsLs0rIMzaa+V/OzDvjKQRw
   VO5uVtsCgwmAUw6I1iC1AbiLNqYevoqeDq8pudfvq5reu5o2j7AGNMigP
   sWpWG8RGE/6pLaw1A6Q8oKqFOWpY2k+fz0GJ1zSzI9sAHMDjPbYw4u/0c
   xfeAG58ZsxEkR7Ir+tYLPmnl3HPTNDWzdZ6urYyqMQLXoh55zJEUj3ULM
   Cchd7qdy4NFrvkp1nzVwFlyCgnvXlkY3sx00uIyeWe9oHjpBHiPV1Lka8
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="356041187"
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; 
   d="scan'208";a="356041187"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 00:31:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; 
   d="scan'208";a="520405839"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 11 May 2022 00:31:32 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nogom-000IqI-8Y;
        Wed, 11 May 2022 07:31:32 +0000
Date:   Wed, 11 May 2022 15:31:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>,
        Alexander Popov <alex.popov@linux.com>
Cc:     kbuild-all@lists.01.org, Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gcc-plugins: Change all version strings match kernel
Message-ID: <202205111547.BDAL0Z0h-lkp@intel.com>
References: <20220510235412.3627034-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510235412.3627034-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi Kees,

I love your patch! Yet something to improve:

[auto build test ERROR on kees/for-next/pstore]
[also build test ERROR on linux/master linus/master v5.18-rc6 next-20220510]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Kees-Cook/gcc-plugins-Change-all-version-strings-match-kernel/20220511-075434
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/pstore
config: i386-randconfig-m021-20220509 (https://download.01.org/0day-ci/archive/20220511/202205111547.BDAL0Z0h-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/020fffc667a0f0414fc7f807e6a5f565444eb5e4
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kees-Cook/gcc-plugins-Change-all-version-strings-match-kernel/20220511-075434
        git checkout 020fffc667a0f0414fc7f807e6a5f565444eb5e4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> <command-line>: fatal error: ./include/generated/utsrelease.h: No such file or directory
   compilation terminated.
   make[3]: *** [scripts/gcc-plugins/Makefile:49: scripts/gcc-plugins/latent_entropy_plugin.so] Error 1
>> <command-line>: fatal error: ./include/generated/utsrelease.h: No such file or directory
   compilation terminated.
   make[3]: *** [scripts/gcc-plugins/Makefile:49: scripts/gcc-plugins/structleak_plugin.so] Error 1
   make[3]: Target '__build' not remade because of errors.
   make[2]: *** [scripts/Makefile.build:550: scripts/gcc-plugins] Error 2
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1175: scripts] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
