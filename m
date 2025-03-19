Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33101EB5F0
	for <linux-hardening@vger.kernel.org>; Wed, 19 Mar 2025 08:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742373458; cv=none; b=OX/4wtko+kj1m/AIacCjSVQo2JDFrOGS/IUFh8VnKIJvQkCqyTaF2aXGbVZs1h7x/YBkR7wTe3zheK7GrQfFXF1UunMMuXM1rXT1DOkf8X4d+JOCltup9A9KDfFLRrOntNf/qXXZKqM/SfbXRoVktXHzCxqSo011dvO3D51X1Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742373458; c=relaxed/simple;
	bh=S/DM8uwy6fHgCeqcLxRM67H1uInAJIyuQCI5xKD/Sws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HUR/grGdBK5SLet5+QXX7KUAdSpFvsYFueFcOKkyl3kGKRzQTsS2MfsDu+fEwN7gpqP4mZJtWWmNSNzw3dADaUrHe6oERYpxxP/ClpTRw19gsBQX3MFSqu5+wNTh9fCzYY7fk/EJMkCrZwTFKoG7IJvpXFg+4FaBxiQlTF1uRkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=mYwEH/8M; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="mYwEH/8M"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-225e3002dffso74152665ad.1
        for <linux-hardening@vger.kernel.org>; Wed, 19 Mar 2025 01:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742373455; x=1742978255; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=raeSZ2hiIddXsOAs17+aEypVNCamlDqV6zC8M8stgwI=;
        b=mYwEH/8MN0Jd5jf1iANyhnnjPuPsYeLSlMRawjxckyqtejszJCTAP3TJaw5/zFEntH
         Ldl/bLSdc+O+sOFGsA/VolfGCjVjynWsZs4ph87bSxG+UmUGVhc9UDNsYsbJwmSvdgYp
         TdyjrRfLt01Ja7Oa76CpY6ENMvcvif/AfpR9HuaX5T24puMTEt6yUBrX7sLE+bMpQbEg
         ifu2k8NCAjArohIYo6+DMonna6b7PoLR13VpqCMk1J+WGfBSbmK4LSdWbb8PDNa/IzEh
         lGeOMfThptPTcBIOMQ3A13KMogltBaUvxI619Gy6orOSSaU3PYabYlMQv//1iQ3Z+wJj
         GXBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742373455; x=1742978255;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=raeSZ2hiIddXsOAs17+aEypVNCamlDqV6zC8M8stgwI=;
        b=Fmp/WoQT/CNQZEKGrnsTiSt+FoemMzSIrMH8MFHTjyo6YrINiUQZhkxqG7FCsamd3C
         cY6kRidKTlxWr8DZohihCJZujuaztnHchLpqPDOkr9aUW7V18Puhd/0pAcsqkfjiTNnb
         EujDc39/H6rLST6DMRrXOpkwtawI6eZ2Ieij8x8BKY2OeGCY6Y4z1oZ+BLsX4+U0dS+P
         RB3hDu+ftzHrh4FJVaRyEGqQ6HLXkBSO5KN1VqNLfBAbzzY4d0yRbBv9clbssCY4zAR/
         4uvviOyTJ6ABQb4kI6etdxiHUF490ezP58nz1YghHUxmF8QNXoN0mFj4LF5koBFL2Go2
         Fcyg==
X-Forwarded-Encrypted: i=1; AJvYcCX9BXJRw3oZqsUrQ0T42ESN13UqkMUKHFbZscNwKpp56oClhC4yTY1dN0jYrlZLPUMBlDj65eZ0QycniOclVag=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxEIXTxq9zz/djMJgSovE/O1Lh3x2HXfhtYFQ0b//W4O6v48OF
	mgpvBqfhndMlhJQKIKoz99UmguueGC2MvS53bOjXLPvruDfQY0qMiZ6Yod2rRtM=
X-Gm-Gg: ASbGncuxqc+sZmeMsZxas+8b0dA6+sJ+kB5YdFi1V2gJqCU068SOYNDlmgfLO/X3O2I
	3jb2yo6EusZGBdkSsjFC+vAqxcm2XGpeFod1shCxheUGFSlP5cBmnAwvnzpUDduqtD/xIlEEuhS
	qDv+W6zsMq+FXuW3cvmTGFQEyWscdOBmYkG8rKvypizPtIRct5AyTWtVH93uba8piomYwL+5Wlk
	mcif2a5Q034bskKhLs1ue2yxoJSB1DUHLB1YDg7BcColYieiWn5F0Vl5aYpOLs18opoAqW82+/r
	PRHRW8lz8nJHZtNHI6S3UqD7dElrn7O/8MxY4rqaayjUU+qihnVhJ+BMhg==
X-Google-Smtp-Source: AGHT+IH+6dxptjQXlSRUDSGGL2iyvluJRGz6CBIsQSY3dGou7+NO/3MdKJprSYoKWQkhnn/vTt9hvQ==
X-Received: by 2002:a05:6a00:1701:b0:736:5dae:6b0d with SMTP id d2e1a72fcca58-7376d5fedddmr2863987b3a.10.1742373455094;
        Wed, 19 Mar 2025 01:37:35 -0700 (PDT)
Received: from [157.82.207.107] ([157.82.207.107])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737116b114asm11031715b3a.164.2025.03.19.01.37.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 01:37:33 -0700 (PDT)
Message-ID: <e8324d9d-3756-41cf-a102-28572e302368@daynix.com>
Date: Wed, 19 Mar 2025 17:37:29 +0900
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] KVM: arm64: PMU: Use multiple host PMUs
To: Oliver Upton <oliver.upton@linux.dev>
Cc: Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu
 <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 devel@daynix.com
References: <20250319-hybrid-v1-1-4d1ada10e705@daynix.com>
 <Z9pze3J2_zrTk_yC@linux.dev>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <Z9pze3J2_zrTk_yC@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/03/19 16:34, Oliver Upton wrote:
> Hi Akihiko,
> 
> On Wed, Mar 19, 2025 at 03:33:46PM +0900, Akihiko Odaki wrote:
>> Problem
>> -------
>>
>> arch/arm64/kvm/pmu-emul.c used to have a comment saying the follows:
>>> The observant among you will notice that the supported_cpus
>>> mask does not get updated for the default PMU even though it
>>> is quite possible the selected instance supports only a
>>> subset of cores in the system. This is intentional, and
>>> upholds the preexisting behavior on heterogeneous systems
>>> where vCPUs can be scheduled on any core but the guest
>>> counters could stop working.
>>
>> Despite the reference manual says counters may not continuously
>> incrementing, Windows is not robust enough to handle stopped PMCCNTR_EL0
>> and crashes with a division-by-zero error and it also crashes when the
>> PMU is not present.
>>
>> To avoid such a problem, the userspace should pin the vCPU threads to
>> pCPUs supported by one host PMU when initializing the vCPUs or specify
>> the host PMU to use with KVM_ARM_VCPU_PMU_V3_SET_PMU after the
>> initialization. However, QEMU/libvirt can pin vCPU threads only after the
>> vCPUs are initialized. It also limits the pCPUs the guest can use even
>> for VMMs that support proper pinning.
>>
>> Solution
>> --------
>>
>> Ideally, Windows should fix the division-by-zero error and QEMU/libvirt
>> should support pinning better, but neither of them are going to happen
>> anytime soon.
>>
>> To allow running Windows on QEMU/libvirt or with heterogeneous cores,
>> combine all host PMUs necessary to cover the cores vCPUs can run and
>> keep PMCCNTR_EL0 working.
 > > I'm extremely uneasy about making this a generalized solution. PMUs are
> deeply tied to the microarchitecture of a particular implementation, and
> that isn't something we can abstract away from the guest in KVM.
> 
> For example, you could have an event ID that counts on only a subset of
> cores, or better yet an event that counts something completely different
> depending on where a vCPU lands.> > I do appreciate the issue that you're trying to solve.
> 
> The good news though is that the fixed PMU cycle counter is the only
> thing guaranteed to be present in any PMUv3 implementation. Since
> that's the only counter Windows actually needs, perhaps we could
> special-case this in KVM.
> 
> I have the following (completely untested) patch, do you want to give it
> a try? There's still going to be observable differences between PMUs
> (e.g. CPU frequency) but at least it should get things booting.

I don't think it will work, unfortunately. perf_init_event() binds a 
perf event to a particular PMU so the event will stop working when the 
thread migrates away.

It should also be the reason why the perf program creates an event for 
each PMU. tools/perf/Documentation/intel-hybrid.txt has more descriptions.

Allowing to enable more than one counter and/or an event type other than 
the cycle counter is not the goal. Enabling another event type may 
result in a garbage value, but I don't think it's worse than the current 
situation where the count stays zero; please tell me if I miss something.

There is still room for improvement. Returning a garbage value may not 
be worse than returning zero, but counters and event types not supported 
by some cores shouldn't be advertised as available in the first place. 
More concretely:

- The vCPU should be limited to run only on cores covered by PMUs when 
KVM_ARM_VCPU_PMU_V3 is set.
- PMCR_EL0.N advertised to the guest should be the minimum of ones of 
host PMUs.
- PMCEID0_EL0 and PMCEID1_EL0 advertised to the guest should be the 
result of the AND operations of ones of host PMUs.

Special-casing the cycle counter may make sense if we are going to fix 
the advertised values of PMCR_EL0.N, PMCEID0_EL0, and PMCEID1_EL0. 
PMCR_EL0.N as we can simply return zero for these registers. We can also 
prevent enabling a counter that returns zero or a garbage value.

Do you think it's worth fixing these registers? If so, I'll do that by 
special-casing the cycle counter.

Regards,
Akihiko Odaki

> 
> Thanks,
> Oliver
> 
> ---
> diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
> index a1bc10d7116a..913a7bab50b5 100644
> --- a/arch/arm64/kvm/pmu-emul.c
> +++ b/arch/arm64/kvm/pmu-emul.c
> @@ -724,14 +724,21 @@ static void kvm_pmu_create_perf_event(struct kvm_pmc *pmc)
>   		return;
>   
>   	memset(&attr, 0, sizeof(struct perf_event_attr));
> -	attr.type = arm_pmu->pmu.type;
> +
> +	if (pmc->idx == ARMV8_PMU_CYCLE_IDX) {
> +		attr.type = PERF_TYPE_HARDWARE;
> +		attr.config = PERF_COUNT_HW_CPU_CYCLES;
> +	} else {
> +		attr.type = arm_pmu->pmu.type;
> +		attr.config = eventsel;
> +	}
> +
>   	attr.size = sizeof(attr);
>   	attr.pinned = 1;
>   	attr.disabled = !kvm_pmu_counter_is_enabled(pmc);
>   	attr.exclude_user = !kvm_pmc_counts_at_el0(pmc);
>   	attr.exclude_hv = 1; /* Don't count EL2 events */
>   	attr.exclude_host = 1; /* Don't count host events */
> -	attr.config = eventsel;
>   
>   	/*
>   	 * Filter events at EL1 (i.e. vEL2) when in a hyp context based on the

