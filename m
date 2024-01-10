Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CE3D529
	for <linux-hardening@vger.kernel.org>; Wed, 10 Jan 2024 05:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ki+2ljAi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704864041; x=1736400041;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vLwfQtpajkFjBKmpcUOwPSdAT6v9p5LY3CLaLVQSDtQ=;
  b=ki+2ljAiHnZLGzjEM32CvozG7AcjtQyKtrCJnDR+beOdf2C3vnz7zRzO
   eKujzFD8c+xiNCJSjQVQUXlwPNMGmn726iSPYZzvT76Bn9pvzWkOSe0FA
   tCaSapbpcZ7TduI1lCULfxRIziGOMmlEYoOuok9bL6YZJf9kBDj/mNAdz
   z+a0aCmCYoYn1e31jwqB8AvIhu+ZxJEbRmp4PBI/EduhBO6ypG79NtWIp
   RI7Z55zYi4FevcsJDSUwyvZp3FdRZgdtomvIsl0AY0j6KpsZ0sjcbosdS
   UxWfhD0PbJHcJlgUH4+e8+ySHbD3Z22pOGq0V1IMbX9J2He6zNHZI3mbe
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="397264403"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="397264403"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 21:20:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="925511255"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="925511255"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 09 Jan 2024 21:20:33 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rNR0x-0006dU-0W;
	Wed, 10 Jan 2024 05:20:31 +0000
Date: Wed, 10 Jan 2024 13:18:22 +0800
From: kernel test robot <lkp@intel.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-hardening@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/4] arm64, powerpc, riscv, s390, x86: Refactor
 CONFIG_DEBUG_WX
Message-ID: <202401101318.RjNdYJu1-lkp@intel.com>
References: <b1e2171587806648500fd305918bc7e90abdeeb5.1704800524.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1e2171587806648500fd305918bc7e90abdeeb5.1704800524.git.christophe.leroy@csgroup.eu>

Hi Christophe,

kernel test robot noticed the following build errors:

[auto build test ERROR on powerpc/next]
[also build test ERROR on powerpc/fixes s390/features tip/x86/mm linus/master v6.7]
[cannot apply to next-20240109]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christophe-Leroy/arm-ptdump-Rename-CONFIG_DEBUG_WX-to-CONFIG_ARM_DEBUG_WX/20240109-201723
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
patch link:    https://lore.kernel.org/r/b1e2171587806648500fd305918bc7e90abdeeb5.1704800524.git.christophe.leroy%40csgroup.eu
patch subject: [PATCH 2/4] arm64, powerpc, riscv, s390, x86: Refactor CONFIG_DEBUG_WX
config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20240110/202401101318.RjNdYJu1-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240110/202401101318.RjNdYJu1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401101318.RjNdYJu1-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from init/main.c:102:
>> include/linux/ptdump.h:22:26: error: macro "ptdump_check_wx" passed 1 arguments, but takes just 0
      22 | void ptdump_check_wx(void);
         |                          ^
   In file included from arch/x86/include/asm/tlbflush.h:16,
                    from arch/x86/include/asm/uaccess.h:17,
                    from include/linux/uaccess.h:11,
                    from include/linux/sched/task.h:11,
                    from include/linux/sched/signal.h:9,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from include/linux/proc_fs.h:10,
                    from init/main.c:18:
   arch/x86/include/asm/pgtable.h:35: note: macro "ptdump_check_wx" defined here
      35 | #define ptdump_check_wx() ptdump_walk_pgd_level_checkwx()
         | 


vim +/ptdump_check_wx +22 include/linux/ptdump.h

    20	
    21	void ptdump_walk_pgd(struct ptdump_state *st, struct mm_struct *mm, pgd_t *pgd);
  > 22	void ptdump_check_wx(void);
    23	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
