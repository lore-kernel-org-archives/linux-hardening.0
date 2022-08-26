Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB8EECAAD4
	for <linux-hardening@archiver.kernel.org>; Fri, 26 Aug 2022 13:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240928AbiHZNEE (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 26 Aug 2022 09:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiHZNED (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 26 Aug 2022 09:04:03 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45940CCE0D
        for <linux-hardening@vger.kernel.org>; Fri, 26 Aug 2022 06:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661519042; x=1693055042;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=TKNYoX/RJCSPsPbxhKRDTfjKPP71dcfvWmqA6HAkbsU=;
  b=JzGIa0CV1K7mqT7DElnQqJeYW1Jz1/iZLKjggwa0SEkTnR++0WGdDQMu
   IQA2x6gSb1or7ng6DVEaD3XBxWzymA9BK6x5uCxgZ7ftaeWxtJdGuwIvw
   KOa6GIj7yZJDvhwZJaKu88b+pMbGagkSf90FnJKNBqbFcnDSBrovqYuY5
   pN0ieHU6mfxDxxVXWFiOSdPjQive3ador/AJg+GqYKq1XXQeXEQVuNd9e
   wIs/QKq3JbR7ixP9kvdqPpi5xg7GVwq7A4TfAvuCN8G3Jf3NsDKLOTBIR
   2MhDTObC1i2ubrL9ZbWl2ulRT7iEOgLhdtW5TOdtO91+oRFY4IU0rDpvo
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="293241542"
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="293241542"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 06:03:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="561431584"
Received: from lkp-server02.sh.intel.com (HELO 34e741d32628) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 26 Aug 2022 06:03:41 -0700
Received: from kbuild by 34e741d32628 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oRYzt-00048U-0H;
        Fri, 26 Aug 2022 13:03:41 +0000
Date:   Fri, 26 Aug 2022 21:02:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-hardening@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [linux-next:pending-fixes] BUILD SUCCESS WITH WARNING
 fe2c49524eb3863b526782620be347bcbecbd2d8
Message-ID: <6308c47f.6Aqe9XBuWYUM/2nd%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git pending-fixes
branch HEAD: fe2c49524eb3863b526782620be347bcbecbd2d8  Merge branch 'for-linux-next-fixes' of git://anongit.freedesktop.org/drm/drm-misc

Warning reports:

https://lore.kernel.org/linux-mm/202208110453.zEneXTnn-lkp@intel.com

Warning: (recently discovered and may have been fixed)

arch/m68k/include/asm/string.h:64:25: warning: '__builtin_memcmp' specified bound 6 exceeds source size 0 [-Wstringop-overread]
include/linux/fortify-string.h:44:33: warning: '__builtin_memcmp' specified bound 6 exceeds source size 0 [-Wstringop-overread]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- m68k-allmodconfig
|   `-- arch-m68k-include-asm-string.h:warning:__builtin_memcmp-specified-bound-exceeds-source-size
|-- m68k-allyesconfig
|   `-- arch-m68k-include-asm-string.h:warning:__builtin_memcmp-specified-bound-exceeds-source-size
`-- mips-allyesconfig
    `-- include-linux-fortify-string.h:warning:__builtin_memcmp-specified-bound-exceeds-source-size

elapsed time: 725m

configs tested: 66
configs skipped: 2

gcc tested configs:
arc                                 defconfig
loongarch                         allnoconfig
um                             i386_defconfig
um                           x86_64_defconfig
alpha                               defconfig
loongarch                           defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                        randconfig-a002
i386                                defconfig
s390                                defconfig
x86_64                        randconfig-a013
i386                          randconfig-a001
powerpc                          allmodconfig
x86_64                           allyesconfig
s390                             allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a011
i386                          randconfig-a003
arm                                 defconfig
s390                             allyesconfig
x86_64                        randconfig-a015
x86_64                        randconfig-a004
mips                             allyesconfig
i386                          randconfig-a005
powerpc                           allnoconfig
sh                               allmodconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
arc                  randconfig-r043-20220824
riscv                randconfig-r042-20220824
m68k                             allyesconfig
s390                 randconfig-r044-20220824
arc                  randconfig-r043-20220825
i386                          randconfig-a014
i386                          randconfig-a012
x86_64                    rhel-8.3-kselftests
i386                          randconfig-a016
x86_64                          rhel-8.3-func
i386                             allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
arm                              allyesconfig
arm64                            allyesconfig
ia64                             allmodconfig

clang tested configs:
x86_64                        randconfig-a014
x86_64                        randconfig-a001
x86_64                        randconfig-a016
x86_64                        randconfig-a012
x86_64                        randconfig-a003
i386                          randconfig-a002
x86_64                        randconfig-a005
i386                          randconfig-a006
i386                          randconfig-a004
hexagon              randconfig-r041-20220825
hexagon              randconfig-r045-20220825
hexagon              randconfig-r041-20220824
hexagon              randconfig-r045-20220824
riscv                randconfig-r042-20220825
s390                 randconfig-r044-20220825
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                          rhel-8.3-rust

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
