Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F17C05027
	for <linux-hardening@archiver.kernel.org>; Fri,  3 Feb 2023 19:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbjBCT6r (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 3 Feb 2023 14:58:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbjBCT6q (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 3 Feb 2023 14:58:46 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F303EA6C07;
        Fri,  3 Feb 2023 11:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675454326; x=1706990326;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EW5HLUVaym+yW2nbWH1WVFDR2aB9Cns0EuLP35Yjpyw=;
  b=mMOtBYltpPEINMEbNoGLDMuEFBVAnXEOC4s8KlDPaG3gYuhj5NXRKu4z
   KVVf/ZWkO1G77gNBuGneswFO1KA4aUQdXUI57UAyp4Repd1HSth7wTMNU
   CKMBjGEoI0/kI77p59IWrqPb1GvhQhsLe5iDIjrWp5K5J40LM+I1/8GEx
   aBuCtqcsJMo998wl1ewZGJirxAyD/FZwEOTFGol3fvmsmtFN5QpM60GyU
   9NaDatvBbI7eeGCSVsifVQIgjzrDO3Y441ExLQ7a69397Zv5fl7NEf8hy
   xsyJWnkSawjN2JhJS1wLqM/2pdXyJR71pHqL93lW2d4k2iJDEJ4PWPWUx
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="326536884"
X-IronPort-AV: E=Sophos;i="5.97,271,1669104000"; 
   d="scan'208";a="326536884"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 11:58:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10610"; a="643361761"
X-IronPort-AV: E=Sophos;i="5.97,271,1669104000"; 
   d="scan'208";a="643361761"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 03 Feb 2023 11:58:14 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pO2CL-0000jV-1n;
        Fri, 03 Feb 2023 19:58:13 +0000
Date:   Sat, 4 Feb 2023 03:57:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Victor Hassan <victor@allwinnertech.com>, keescook@chromium.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        tony.luck@intel.com, gpiccoli@igalia.com,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pstore/blk: Export a method to implemente panic_write()
Message-ID: <202302040337.IyKFZgIk-lkp@intel.com>
References: <20230203113515.93540-1-victor@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203113515.93540-1-victor@allwinnertech.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi Victor,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on kees/for-next/pstore]
[also build test ERROR on kees/for-next/kspp linus/master v6.2-rc6 next-20230203]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Victor-Hassan/pstore-blk-Export-a-method-to-implemente-panic_write/20230203-193548
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/pstore
patch link:    https://lore.kernel.org/r/20230203113515.93540-1-victor%40allwinnertech.com
patch subject: [PATCH] pstore/blk: Export a method to implemente panic_write()
config: x86_64-randconfig-a012 (https://download.01.org/0day-ci/archive/20230204/202302040337.IyKFZgIk-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/368e42ba015da6c7bdd201b8fdb669e936307cbb
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Victor-Hassan/pstore-blk-Export-a-method-to-implemente-panic_write/20230203-193548
        git checkout 368e42ba015da6c7bdd201b8fdb669e936307cbb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/pstore/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from fs/pstore/blk.c:16:
>> include/linux/pstore_blk.h:32:41: error: must use 'enum' tag to refer to type 'pstore_blk_notifier_type'
   typedef int (*pstore_blk_notifier_fn_t)(pstore_blk_notifier_type type,
                                           ^
                                           enum 
   1 error generated.


vim +32 include/linux/pstore_blk.h

    31	
  > 32	typedef	int (*pstore_blk_notifier_fn_t)(pstore_blk_notifier_type type,
    33			struct pstore_device_info *dev);
    34	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
