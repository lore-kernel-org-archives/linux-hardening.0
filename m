Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AACC25B08
	for <linux-hardening@archiver.kernel.org>; Wed, 17 Aug 2022 06:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiHQGPc (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 17 Aug 2022 02:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238904AbiHQGP1 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 17 Aug 2022 02:15:27 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8AEE6C77D
        for <linux-hardening@vger.kernel.org>; Tue, 16 Aug 2022 23:15:25 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 202so11170670pgc.8
        for <linux-hardening@vger.kernel.org>; Tue, 16 Aug 2022 23:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc;
        bh=V/WWAglTMLKqDnCjeLq46a4fbo9tCoelyGe1SAfOR/k=;
        b=YlYJWJE/PCNViHtIOZW4O1+R2iJAm9NkOWcITR7ggRW5tiqhBwZNDcRjEcx3ChBhSD
         kPn3/A04CfrTNbDj2GJjMNOWFoXwD/lyUhkrhOf6Tt/J0t+SwFognBlHV+xVwzF4Nyd9
         ItO+V0T1neUEzD4FcveLrcPLfzl+ZJJQmdP6RQDDMYcivbuXVIvdmHZSWgNTZYGVOScP
         7gX/DXkKpGBJ85OqXK+XVReXwNDW0FOHR4uHKjfJP/qJxB40w3B5fOY0ozloCmIRdLwz
         0IjqD25m22r9mEcCypIHh88WmktzVXQwnBh7r5mC/GwwC8wItNaurUwejBqHekH3pVhk
         MxMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc;
        bh=V/WWAglTMLKqDnCjeLq46a4fbo9tCoelyGe1SAfOR/k=;
        b=b3+ZRCA5xFyUYEYee4yHNvztNS/6hKF7H8yQbclgII1rfmgoHDbGlz9po1TNnrV/9j
         Q9iTmCcLvO7jtGLPgD3IeaUWJwVXFKLyx2qT1axRAWxXgqlJiVoexzZLZ3m43LsJ6F+h
         3ctg3E125lNwKTyPa2N/M/AOkbLlR7QL6tn2krm5ehWVuZRUG3i8G8KxIL/c3w9Q+Wd6
         aJRepWZD4hr8pRJKwx+s2HxAJU573y3rK7s1apVsBHZskZN5vFCjfs9WIOQrLTVmhgNy
         63Jo14C3JCLgg/qezu/Gp40kBnk50AxgZtKaPiQ96iElQjYxo69sHDroprSzofwRyDGY
         fpsg==
X-Gm-Message-State: ACgBeo3nGMrwAzrHbF6FNtak2E4yyO2/bBcE4y+A/O1gdhS5CQIcsO+W
        NyLBozWdY7YcgruoByeDq/fYJaIaShk=
X-Google-Smtp-Source: AA6agR4fnFRb2kKnWaHcGEdnVjMuoIdfuJUH/ni4C3A7/FlJUUXsv0mCe2GW1oXaSmt3y8wyLliXNQ==
X-Received: by 2002:a63:f14c:0:b0:41a:b83d:a636 with SMTP id o12-20020a63f14c000000b0041ab83da636mr20445300pgk.361.1660716925100;
        Tue, 16 Aug 2022 23:15:25 -0700 (PDT)
Received: from tee480.ozlabs.ibm.com (110-175-254-242.static.tpgi.com.au. [110.175.254.242])
        by smtp.googlemail.com with ESMTPSA id d20-20020aa797b4000000b00517c84fd24asm9842553pfq.172.2022.08.16.23.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 23:15:24 -0700 (PDT)
Message-ID: <faa82449f058e4d57372dc4e7b5ca2dc091cb454.camel@gmail.com>
Subject: Re: [PATCH v4 2/2] selftests/powerpc: Add a test for execute-only
 memory
From:   Jordan Niethe <jniethe5@gmail.com>
To:     Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
Cc:     ajd@linux.ibm.com, anshuman.khandual@arm.com,
        nicholas@linux.ibm.com, npiggin@gmail.com,
        aneesh.kumar@linux.ibm.com, linux-hardening@vger.kernel.org
Date:   Wed, 17 Aug 2022 16:15:19 +1000
In-Reply-To: <20220817050640.406017-2-ruscur@russell.cc>
References: <20220817050640.406017-1-ruscur@russell.cc>
         <20220817050640.406017-2-ruscur@russell.cc>
Content-Type: text/plain; charset="UTF-7"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, 2022-08-17 at 15:06 +-1000, Russell Currey wrote:
+AD4 From: Nicholas Miehlbradt +ADw-nicholas+AEA-linux.ibm.com+AD4
+AD4 
+AD4 This selftest is designed to cover execute-only protections
+AD4 on the Radix MMU but will also work with Hash.
+AD4 
+AD4 The tests are based on those found in pkey+AF8-exec+AF8-test with modifications
+AD4 to use the generic mprotect() instead of the pkey variants.

Would it make sense to rename pkey+AF8-exec+AF8-test to exec+AF8-test and have this test be apart of that?

+AD4 
+AD4 Signed-off-by: Nicholas Miehlbradt +ADw-nicholas+AEA-linux.ibm.com+AD4
+AD4 Signed-off-by: Russell Currey +ADw-ruscur+AEA-russell.cc+AD4
+AD4 ---
+AD4 v4: new
+AD4 
+AD4  tools/testing/selftests/powerpc/mm/Makefile   +AHw   3 +--
+AD4  .../testing/selftests/powerpc/mm/exec+AF8-prot.c  +AHw 231 +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-
+AD4  2 files changed, 233 insertions(+-), 1 deletion(-)
+AD4  create mode 100644 tools/testing/selftests/powerpc/mm/exec+AF8-prot.c
+AD4 
+AD4 diff --git a/tools/testing/selftests/powerpc/mm/Makefile b/tools/testing/selftests/powerpc/mm/Makefile
+AD4 index 27dc09d0bfee..19dd0b2ea397 100644
+AD4 --- a/tools/testing/selftests/powerpc/mm/Makefile
+AD4 +-+-+- b/tools/testing/selftests/powerpc/mm/Makefile
+AD4 +AEAAQA -3,7 +-3,7 +AEAAQA noarg:
+AD4  	+ACQ(MAKE) -C ../
+AD4  
+AD4  TEST+AF8-GEN+AF8-PROGS :+AD0 hugetlb+AF8-vs+AF8-thp+AF8-test subpage+AF8-prot prot+AF8-sao segv+AF8-errors wild+AF8-bctr +AFw
+AD4 -		  large+AF8-vm+AF8-fork+AF8-separation bad+AF8-accesses pkey+AF8-exec+AF8-prot +AFw
+AD4 +-		  large+AF8-vm+AF8-fork+AF8-separation bad+AF8-accesses exec+AF8-prot pkey+AF8-exec+AF8-prot +AFw
+AD4  		  pkey+AF8-siginfo stack+AF8-expansion+AF8-signal stack+AF8-expansion+AF8-ldst +AFw
+AD4  		  large+AF8-vm+AF8-gpr+AF8-corruption
+AD4  TEST+AF8-PROGS :+AD0 stress+AF8-code+AF8-patching.sh
+AD4 +AEAAQA -22,6 +-22,7 +AEAAQA +ACQ(OUTPUT)/wild+AF8-bctr: CFLAGS +-+AD0 -m64
+AD4  +ACQ(OUTPUT)/large+AF8-vm+AF8-fork+AF8-separation: CFLAGS +-+AD0 -m64
+AD4  +ACQ(OUTPUT)/large+AF8-vm+AF8-gpr+AF8-corruption: CFLAGS +-+AD0 -m64
+AD4  +ACQ(OUTPUT)/bad+AF8-accesses: CFLAGS +-+AD0 -m64
+AD4 +-+ACQ(OUTPUT)/exec+AF8-prot: CFLAGS +-+AD0 -m64
+AD4  +ACQ(OUTPUT)/pkey+AF8-exec+AF8-prot: CFLAGS +-+AD0 -m64
+AD4  +ACQ(OUTPUT)/pkey+AF8-siginfo: CFLAGS +-+AD0 -m64
+AD4  
+AD4 diff --git a/tools/testing/selftests/powerpc/mm/exec+AF8-prot.c b/tools/testing/selftests/powerpc/mm/exec+AF8-prot.c
+AD4 new file mode 100644
+AD4 index 000000000000..db75b2225de1
+AD4 --- /dev/null
+AD4 +-+-+- b/tools/testing/selftests/powerpc/mm/exec+AF8-prot.c
+AD4 +AEAAQA -0,0 +-1,231 +AEAAQA
+AD4 +-// SPDX-License-Identifier: GPL-2.0
+AD4 +-
+AD4 +-/+ACo
+AD4 +- +ACo Copyright 2022, Nicholas Miehlbradt, IBM Corporation
+AD4 +- +ACo based on pkey+AF8-exec+AF8-prot.c
+AD4 +- +ACo
+AD4 +- +ACo Test if applying execute protection on pages works as expected.
+AD4 +- +ACo-/
+AD4 +-
+AD4 +-+ACM-define +AF8-GNU+AF8-SOURCE
+AD4 +-+ACM-include +ADw-stdio.h+AD4
+AD4 +-+ACM-include +ADw-stdlib.h+AD4
+AD4 +-+ACM-include +ADw-string.h+AD4
+AD4 +-+ACM-include +ADw-signal.h+AD4
+AD4 +-
+AD4 +-+ACM-include +ADw-unistd.h+AD4
+AD4 +-+ACM-include +ADw-sys/mman.h+AD4
+AD4 +-
+AD4 +-+ACM-include +ACI-pkeys.h+ACI
+AD4 +-
+AD4 +-
+AD4 +-+ACM-define PPC+AF8-INST+AF8-NOP	0x60000000
+AD4 +-+ACM-define PPC+AF8-INST+AF8-TRAP	0x7fe00008
+AD4 +-+ACM-define PPC+AF8-INST+AF8-BLR	0x4e800020
+AD4 +-
+AD4 +-static volatile sig+AF8-atomic+AF8-t fault+AF8-code+ADs
+AD4 +-static volatile sig+AF8-atomic+AF8-t remaining+AF8-faults+ADs
+AD4 +-static volatile unsigned int +ACo-fault+AF8-addr+ADs
+AD4 +-static unsigned long pgsize, numinsns+ADs
+AD4 +-static unsigned int +ACo-insns+ADs
+AD4 +-static bool pkeys+AF8-supported+ADs
+AD4 +-
+AD4 +-static bool is+AF8-fault+AF8-expected(int fault+AF8-code)
+AD4 +-+AHs
+AD4 +-	if (fault+AF8-code +AD0APQ SEGV+AF8-ACCERR)
+AD4 +-		return true+ADs
+AD4 +-
+AD4 +-	/+ACo Assume any pkey error is fine since pkey+AF8-exec+AF8-prot test covers them +ACo-/
+AD4 +-	if (fault+AF8-code +AD0APQ SEGV+AF8-PKUERR +ACYAJg pkeys+AF8-supported)
+AD4 +-		return true+ADs
+AD4 +-
+AD4 +-	return false+ADs
+AD4 +-+AH0
+AD4 +-
+AD4 +-static void trap+AF8-handler(int signum, siginfo+AF8-t +ACo-sinfo, void +ACo-ctx)
+AD4 +-+AHs
+AD4 +-	/+ACo Check if this fault originated from the expected address +ACo-/
+AD4 +-	if (sinfo-+AD4-si+AF8-addr +ACEAPQ (void +ACo)fault+AF8-addr)
+AD4 +-		sigsafe+AF8-err(+ACI-got a fault for an unexpected address+AFw-n+ACI)+ADs
+AD4 +-
+AD4 +-	+AF8-exit(1)+ADs
+AD4 +-+AH0
+AD4 +-
+AD4 +-static void segv+AF8-handler(int signum, siginfo+AF8-t +ACo-sinfo, void +ACo-ctx)
+AD4 +-+AHs
+AD4 +-	fault+AF8-code +AD0 sinfo-+AD4-si+AF8-code+ADs
+AD4 +-
+AD4 +-	/+ACo Check if this fault originated from the expected address +ACo-/
+AD4 +-	if (sinfo-+AD4-si+AF8-addr +ACEAPQ (void +ACo)fault+AF8-addr) +AHs
+AD4 +-		sigsafe+AF8-err(+ACI-got a fault for an unexpected address+AFw-n+ACI)+ADs
+AD4 +-		+AF8-exit(1)+ADs
+AD4 +-	+AH0
+AD4 +-
+AD4 +-	/+ACo Check if too many faults have occurred for a single test case +ACo-/
+AD4 +-	if (+ACE-remaining+AF8-faults) +AHs
+AD4 +-		sigsafe+AF8-err(+ACI-got too many faults for the same address+AFw-n+ACI)+ADs
+AD4 +-		+AF8-exit(1)+ADs
+AD4 +-	+AH0
+AD4 +-
+AD4 +-
+AD4 +-	/+ACo Restore permissions in order to continue +ACo-/
+AD4 +-	if (is+AF8-fault+AF8-expected(fault+AF8-code)) +AHs
+AD4 +-		if (mprotect(insns, pgsize, PROT+AF8-READ +AHw PROT+AF8-WRITE +AHw PROT+AF8-EXEC)) +AHs
+AD4 +-			sigsafe+AF8-err(+ACI-failed to set access permissions+AFw-n+ACI)+ADs
+AD4 +-			+AF8-exit(1)+ADs
+AD4 +-		+AH0
+AD4 +-	+AH0 else +AHs
+AD4 +-		sigsafe+AF8-err(+ACI-got a fault with an unexpected code+AFw-n+ACI)+ADs
+AD4 +-		+AF8-exit(1)+ADs
+AD4 +-	+AH0
+AD4 +-
+AD4 +-	remaining+AF8-faults--+ADs
+AD4 +-+AH0
+AD4 +-
+AD4 +-static int check+AF8-exec+AF8-fault(int rights)
+AD4 +-+AHs
+AD4 +-	/+ACo
+AD4 +-	 +ACo Jump to the executable region.
+AD4 +-	 +ACo
+AD4 +-	 +ACo The first iteration also checks if the overwrite of the
+AD4 +-	 +ACo first instruction word from a trap to a no-op succeeded.
+AD4 +-	 +ACo-/
+AD4 +-	fault+AF8-code +AD0 -1+ADs
+AD4 +-	remaining+AF8-faults +AD0 0+ADs
+AD4 +-	if (+ACE(rights +ACY PROT+AF8-EXEC))
+AD4 +-		remaining+AF8-faults +AD0 1+ADs
+AD4 +-
+AD4 +-	FAIL+AF8-IF(mprotect(insns, pgsize, rights) +ACEAPQ 0)+ADs
+AD4 +-	asm volatile(+ACI-mtctr	+ACU-0+ADs bctrl+ACI : : +ACI-r+ACI(insns))+ADs
+AD4 +-
+AD4 +-	FAIL+AF8-IF(remaining+AF8-faults +ACEAPQ 0)+ADs
+AD4 +-	if (+ACE(rights +ACY PROT+AF8-EXEC))
+AD4 +-		FAIL+AF8-IF(+ACE-is+AF8-fault+AF8-expected(fault+AF8-code))+ADs
+AD4 +-
+AD4 +-	return 0+ADs
+AD4 +-+AH0
+AD4 +-
+AD4 +-static int test(void)
+AD4 +-+AHs
+AD4 +-	struct sigaction segv+AF8-act, trap+AF8-act+ADs
+AD4 +-	int i+ADs
+AD4 +-
+AD4 +-	/+ACo Skip the test if the CPU doesn't support Radix +ACo-/
+AD4 +-	SKIP+AF8-IF(+ACE-have+AF8-hwcap2(PPC+AF8-FEATURE2+AF8-ARCH+AF8-3+AF8-00))+ADs
+AD4 +-
+AD4 +-	/+ACo Check if pkeys are supported +ACo-/
+AD4 +-	pkeys+AF8-supported +AD0 pkeys+AF8-unsupported() +AD0APQ 0+ADs
+AD4 +-
+AD4 +-	/+ACo Setup SIGSEGV handler +ACo-/
+AD4 +-	segv+AF8-act.sa+AF8-handler +AD0 0+ADs
+AD4 +-	segv+AF8-act.sa+AF8-sigaction +AD0 segv+AF8-handler+ADs
+AD4 +-	FAIL+AF8-IF(sigprocmask(SIG+AF8-SETMASK, 0, +ACY-segv+AF8-act.sa+AF8-mask) +ACEAPQ 0)+ADs
+AD4 +-	segv+AF8-act.sa+AF8-flags +AD0 SA+AF8-SIGINFO+ADs
+AD4 +-	segv+AF8-act.sa+AF8-restorer +AD0 0+ADs
+AD4 +-	FAIL+AF8-IF(sigaction(SIGSEGV, +ACY-segv+AF8-act, NULL) +ACEAPQ 0)+ADs
+AD4 +-
+AD4 +-	/+ACo Setup SIGTRAP handler +ACo-/
+AD4 +-	trap+AF8-act.sa+AF8-handler +AD0 0+ADs
+AD4 +-	trap+AF8-act.sa+AF8-sigaction +AD0 trap+AF8-handler+ADs
+AD4 +-	FAIL+AF8-IF(sigprocmask(SIG+AF8-SETMASK, 0, +ACY-trap+AF8-act.sa+AF8-mask) +ACEAPQ 0)+ADs
+AD4 +-	trap+AF8-act.sa+AF8-flags +AD0 SA+AF8-SIGINFO+ADs
+AD4 +-	trap+AF8-act.sa+AF8-restorer +AD0 0+ADs
+AD4 +-	FAIL+AF8-IF(sigaction(SIGTRAP, +ACY-trap+AF8-act, NULL) +ACEAPQ 0)+ADs
+AD4 +-
+AD4 +-	/+ACo Setup executable region +ACo-/
+AD4 +-	pgsize +AD0 getpagesize()+ADs
+AD4 +-	numinsns +AD0 pgsize / sizeof(unsigned int)+ADs
+AD4 +-	insns +AD0 (unsigned int +ACo)mmap(NULL, pgsize, PROT+AF8-READ +AHw PROT+AF8-WRITE,
+AD4 +-				      MAP+AF8-PRIVATE +AHw MAP+AF8-ANONYMOUS, -1, 0)+ADs
+AD4 +-	FAIL+AF8-IF(insns +AD0APQ MAP+AF8-FAILED)+ADs
+AD4 +-
+AD4 +-	/+ACo Write the instruction words +ACo-/
+AD4 +-	for (i +AD0 1+ADs i +ADw numinsns - 1+ADs i+-+-)
+AD4 +-		insns+AFs-i+AF0 +AD0 PPC+AF8-INST+AF8-NOP+ADs
+AD4 +-
+AD4 +-	/+ACo
+AD4 +-	 +ACo Set the first instruction as an unconditional trap. If
+AD4 +-	 +ACo the last write to this address succeeds, this should
+AD4 +-	 +ACo get overwritten by a no-op.
+AD4 +-	 +ACo-/
+AD4 +-	insns+AFs-0+AF0 +AD0 PPC+AF8-INST+AF8-TRAP+ADs
+AD4 +-
+AD4 +-	/+ACo
+AD4 +-	 +ACo Later, to jump to the executable region, we use a branch
+AD4 +-	 +ACo and link instruction (bctrl) which sets the return address
+AD4 +-	 +ACo automatically in LR. Use that to return back.
+AD4 +-	 +ACo-/
+AD4 +-	insns+AFs-numinsns - 1+AF0 +AD0 PPC+AF8-INST+AF8-BLR+ADs
+AD4 +-
+AD4 +-	/+ACo
+AD4 +-	 +ACo Pick the first instruction's address from the executable
+AD4 +-	 +ACo region.
+AD4 +-	 +ACo-/
+AD4 +-	fault+AF8-addr +AD0 insns+ADs
+AD4 +-
+AD4 +-	/+ACo
+AD4 +-	 +ACo Read an instruction word from the address when the page
+AD4 +-	 +ACo is execute only. This should generate an access fault.
+AD4 +-	 +ACo-/
+AD4 +-	fault+AF8-code +AD0 -1+ADs
+AD4 +-	remaining+AF8-faults +AD0 1+ADs
+AD4 +-	printf(+ACI-Testing read on --x, should fault...+ACI)+ADs
+AD4 +-	FAIL+AF8-IF(mprotect(insns, pgsize, PROT+AF8-EXEC) +ACEAPQ 0)+ADs
+AD4 +-	i +AD0 +ACo-fault+AF8-addr+ADs
+AD4 +-	FAIL+AF8-IF(remaining+AF8-faults +ACEAPQ 0 +AHwAfA +ACE-is+AF8-fault+AF8-expected(fault+AF8-code))+ADs
+AD4 +-	printf(+ACI-ok+ACEAXA-n+ACI)+ADs
+AD4 +-
+AD4 +-	/+ACo
+AD4 +-	 +ACo Write an instruction word to the address when the page
+AD4 +-	 +ACo execute only. This should also generate an access fault.
+AD4 +-	 +ACo-/
+AD4 +-	fault+AF8-code +AD0 -1+ADs
+AD4 +-	remaining+AF8-faults +AD0 1+ADs
+AD4 +-	printf(+ACI-Testing write on --x, should fault...+ACI)+ADs
+AD4 +-	FAIL+AF8-IF(mprotect(insns, pgsize, PROT+AF8-EXEC) +ACEAPQ 0)+ADs
+AD4 +-	+ACo-fault+AF8-addr +AD0 PPC+AF8-INST+AF8-NOP+ADs
+AD4 +-	FAIL+AF8-IF(remaining+AF8-faults +ACEAPQ 0 +AHwAfA +ACE-is+AF8-fault+AF8-expected(fault+AF8-code))+ADs
+AD4 +-	printf(+ACI-ok+ACEAXA-n+ACI)+ADs
+AD4 +-
+AD4 +-	printf(+ACI-Testing exec on ---, should fault...+ACI)+ADs
+AD4 +-	FAIL+AF8-IF(check+AF8-exec+AF8-fault(PROT+AF8-NONE))+ADs
+AD4 +-	printf(+ACI-ok+ACEAXA-n+ACI)+ADs
+AD4 +-
+AD4 +-	printf(+ACI-Testing exec on r--, should fault...+ACI)+ADs
+AD4 +-	FAIL+AF8-IF(check+AF8-exec+AF8-fault(PROT+AF8-READ))+ADs
+AD4 +-	printf(+ACI-ok+ACEAXA-n+ACI)+ADs
+AD4 +-
+AD4 +-	printf(+ACI-Testing exec on -w-, should fault...+ACI)+ADs
+AD4 +-	FAIL+AF8-IF(check+AF8-exec+AF8-fault(PROT+AF8-WRITE))+ADs
+AD4 +-	printf(+ACI-ok+ACEAXA-n+ACI)+ADs
+AD4 +-
+AD4 +-	printf(+ACI-Testing exec on rw-, should fault...+ACI)+ADs
+AD4 +-	FAIL+AF8-IF(check+AF8-exec+AF8-fault(PROT+AF8-READ +AHw PROT+AF8-WRITE))+ADs
+AD4 +-	printf(+ACI-ok+ACEAXA-n+ACI)+ADs
+AD4 +-
+AD4 +-	printf(+ACI-Testing exec on --x, should succeed...+ACI)+ADs
+AD4 +-	FAIL+AF8-IF(check+AF8-exec+AF8-fault(PROT+AF8-EXEC))+ADs
+AD4 +-	printf(+ACI-ok+ACEAXA-n+ACI)+ADs
+AD4 +-
+AD4 +-	printf(+ACI-Testing exec on r-x, should succeed...+ACI)+ADs
+AD4 +-	FAIL+AF8-IF(check+AF8-exec+AF8-fault(PROT+AF8-READ +AHw PROT+AF8-EXEC))+ADs
+AD4 +-	printf(+ACI-ok+ACEAXA-n+ACI)+ADs
+AD4 +-
+AD4 +-	printf(+ACI-Testing exec on -wx, should succeed...+ACI)+ADs
+AD4 +-	FAIL+AF8-IF(check+AF8-exec+AF8-fault(PROT+AF8-WRITE +AHw PROT+AF8-EXEC))+ADs
+AD4 +-	printf(+ACI-ok+ACEAXA-n+ACI)+ADs
+AD4 +-
+AD4 +-	printf(+ACI-Testing exec on rwx, should succeed...+ACI)+ADs
+AD4 +-	FAIL+AF8-IF(check+AF8-exec+AF8-fault(PROT+AF8-READ +AHw PROT+AF8-WRITE +AHw PROT+AF8-EXEC))+ADs
+AD4 +-	printf(+ACI-ok+ACEAXA-n+ACI)+ADs
+AD4 +-
+AD4 +-	/+ACo Cleanup +ACo-/
+AD4 +-	FAIL+AF8-IF(munmap((void +ACo)insns, pgsize))+ADs
+AD4 +-
+AD4 +-	return 0+ADs
+AD4 +-+AH0
+AD4 +-
+AD4 +-int main(void)
+AD4 +-+AHs
+AD4 +-	return test+AF8-harness(test, +ACI-exec+AF8-prot+ACI)+ADs
+AD4 +-+AH0

