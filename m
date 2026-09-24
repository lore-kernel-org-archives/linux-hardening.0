Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CFF381E92;
	Thu, 24 Sep 2026 04:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790223103; cv=none; b=YQJH9xz17upeZr3x8On8pBrvqGB501dSP8OENQQtHHFCzcCJFjAR5QaQIAZU9LLrPDAa0AOMPh9I2JIfVeuvTi9mpQRHF1kZB+fw2o77ytT08gYJ8UoHWohJmzaIi4Q0Wxk7Cxl7ItMCYoFHEE18zKp8VKjKgmJ2qO7QzafX7P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790223103; c=relaxed/simple;
	bh=29U8SrS6AdO6lFFos4hTHxTPuzEqeGJOKIbIIOI38mc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KE62rUqYFna8I4lLMao06xMeNEDBKyGTzAH8PUP5SmrmHPjqK3pRZZVInCx/0g4DTpD/rC4A+KEXgAdZjJf3p50SyD4+JnbCb1mw/lt/sg8CxFkouFQawCP+rVS/lyRwkAyrF4AxO648eB8rMfbC8qlDlJ56xPgVng7oHybEP3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=OzxKUUwZ; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="OzxKUUwZ"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ZRQ0VxqpuNoSza6zOLG1gwykGEw7zwH/fbhRzlWY/Lc=;
	b=OzxKUUwZYTuTrykXXNDe9n63OFnXxUP++ZLONoERb3YuLUzDD9i/1X+acua3ZB0ygehiv+eB4
	Ca2QoSb4sbF6lfkJvaGgSUJp0QiJV+KR8CD9CGAMtq4xueFC11/v+HxiBlPz6WHm5vSky1Ra14s
	EL3oup3ikADUirUxoh+Z2pw=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4hr0TC39yJz12LFc;
	Thu, 24 Sep 2026 11:59:27 +0800 (CST)
Received: from kwepemk200008.china.huawei.com (unknown [7.202.194.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 238AB40561;
	Thu, 24 Sep 2026 12:11:33 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemk200008.china.huawei.com (7.202.194.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 24 Sep 2026 12:11:31 +0800
Message-ID: <bbd65e4d-8096-4939-8308-f0f54c5cb3bc@huawei.com>
Date: Thu, 24 Sep 2026 12:11:31 +0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/ptrace: Add PTRACE_SYSEMU_SINGLESTEP
 syscall-exit-stop test
To: Kees Cook <kees@kernel.org>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	<oleg@redhat.com>, <luto@amacapital.net>, <wad@chromium.org>,
	<peterz@infradead.org>, <ada.coupriediaz@arm.com>, <linusw@kernel.org>,
	<yeoreum.yun@arm.com>, <kevin.brodsky@arm.com>, <anshuman.khandual@arm.com>,
	<james.morse@arm.com>, <thuth@redhat.com>, <vladimir.murzin@arm.com>,
	<tglx@kernel.org>, <broonie@kernel.org>, <liqiang01@kylinos.cn>,
	<ryan.roberts@arm.com>, <pengcan@kylinos.cn>, <kmehltretter@gmail.com>,
	<linux-arm-kernel@lists.infradead.org>, Shuah Khan <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>
References: <20260922195719.i.211-kees@kernel.org>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20260922195719.i.211-kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk200008.china.huawei.com (7.202.194.74)



在 2026/9/23 3:57, Kees Cook 写道:
> ptrace(2) states that no syscall-exit-stop occurs when a tracee is
> continued with PTRACE_SYSEMU or PTRACE_SYSEMU_SINGLESTEP. arm64 gated
> its syscall-exit report on
> 
> 	flags & (_TIF_SYSCALL_TRACE | _TIF_SINGLESTEP)

Hi Kees,

The original fix description is a bit off: on arm64 there is no extra
syscall-exit-stop; instead, there's an additional pseudo single-step
injection.

As sashiko pointed out, as commit ac2081cdc4d9 ("arm64: ptrace:
Consistently use pseudo-singlestep exceptions") described, for
PTRACE_SYSEMU_SINGLESTEP, arm64 still needs the pseudo single-step
because its hardware single-step state machine is fast-forwarded over
the SVC instruction.

static void report_syscall_exit(struct pt_regs *regs)
{
   ...
   if (test_thread_flag(TIF_SINGLESTEP)) {
       /*
        * Signal a pseudo-step exception since we are stepping but
        * tracer modifications to the registers may have rewound the
        * state machine.
        */
       ptrace_report_syscall_exit(regs, 1);
          -> user_single_step_report(regs);
    }
}

https://sashiko.dev/#/patchset/20260922035510.1090299-1-ruanjinjie%40huawei.com

> 
> and ptrace_resume() clears SYSCALL_TRACE for both SYSEMU requests while
> PTRACE_SYSEMU_SINGLESTEP additionally sets TIF_SINGLESTEP, so the
> single-step bit alone produced a stop that must not exist. Nothing in
> tools/testing/selftests covered this.
> 
> Detecting the extra stop is less direct than it looks. The report is
> emitted with step=1, so ptrace_report_syscall_exit() dispatches to
> user_single_step_report() rather than ptrace_report_syscall(), and it
> arrives as a plain SIGTRAP indistinguishable by signal from the
> legitimate single-step trap: neither PTRACE_O_TRACESYSGOOD nor
> PTRACE_GET_SYSCALL_INFO separates the two. What does separate them is
> the PC. The redundant report fires before the tracee has moved past the
> syscall instruction, so it lands on the PC of the syscall-entry stop:
> 
> 	[0] sig=133 SYSCALL-STOP  pc=0x41ec28
> 	[1] sig=5   trap          pc=0x41ec28   <-- must not exist
> 	[2] sig=5   trap          pc=0x41ec2c
> 
> A fixed kernel reports pc=0x41ec2c already at stop [1]. The test
> therefore asserts that the first stop after the syscall-entry stop is at
> a different PC, which tests the consequence rather than the mechanism
> and does not depend on how many pseudo-step traps follow.
> 
> PTRACE_SYSEMU is used to reach the syscall-entry stop, as single-
> stepping there costs one stop per instruction and takes roughly 200000
> stops. Architectures without a PC accessor here, or without SYSEMU
> support, skip rather than fail.
> 
> Build tested ARCH=arm64 with GCC aarch64-linux-gnu 16.1.0, ARCH=arm
> with GCC arm-linux-gnueabihf 16.1.0, and ARCH=x86_64 with GCC 16.2.0.
> 
> Tests passing on ARCH=arm64 under qemu-system-aarch64, and the same
> test fails as expected on v7.3-rc2 without the fix[1]:
> 
> 	# entry stop pc=0x41ec28, next stop sig=5 pc=0x41ec28
> 	# Expected next_pc (4320296) != entry_pc (4320296)
> 	not ok 1 sysemu.no_syscall_exit_stop
> 
> An AArch32 build of the same test on an arm64 kernel reproduces the
> failure identically, covering the is_compat_task() path. It also passes
> on x86_64, which already uses generic entry, so the test does not report
> a false positive against a correct implementation.
> 
> Link: https://lore.kernel.org/all/20260922035510.1090299-2-ruanjinjie@huawei.com/ [1]
> Assisted-by: LLM
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
>  tools/testing/selftests/ptrace/Makefile       |   3 +-
>  .../selftests/ptrace/sysemu_singlestep.c      | 176 ++++++++++++++++++
>  tools/testing/selftests/ptrace/.gitignore     |   1 +
>  3 files changed, 179 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/ptrace/sysemu_singlestep.c

[...]

> +TEST_HARNESS_MAIN
> diff --git a/tools/testing/selftests/ptrace/.gitignore b/tools/testing/selftests/ptrace/.gitignore
> index f6be8efd57ea..792c81f804c0 100644
> --- a/tools/testing/selftests/ptrace/.gitignore
> +++ b/tools/testing/selftests/ptrace/.gitignore
> @@ -4,3 +4,4 @@ get_set_sud
>  peeksiginfo
>  vmaccess
>  set_syscall_info
> +sysemu_singlestep

-- 
Best regards,
Jinjie

