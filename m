Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE43253B52
	for <linux-hardening@vger.kernel.org>; Wed, 19 Mar 2025 10:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742380025; cv=none; b=jsvUKfenBrF/heWR2Eq52zWejG582xFYccT0IZvamH1j0Zpm/MQV7/Yb0M0LyMqV6KejPBrRQbm8FpT6m2C0+7m6yGuiruRjY+vZ3d0787hgm/1cHt02rubzKggrxw155IY+kAss8yYSftWHKqhWd9fsJgCOgIrtoe3yvG0Z4+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742380025; c=relaxed/simple;
	bh=70xPgndhBbN1Zl06WxGoggYZcvKMdREQYLlrzYYvJUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FgePfwNXjNVMS9W9oF/8mBSLcKrhOMbvGNl7pfS3NoCgf8fW7FYAY1MqukhbH6KsKCLSk2scEhahmM9utMJbqV9CYcCHWMt7mSqTjaoIAvfDRNxi3u0hhEIAegIUfrdc4o+0SHiLlO9Dj3E1y+j3JoOWxEXuYWWMneeiZM8R+dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=gfANeS/u; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="gfANeS/u"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22622ddcc35so17065295ad.2
        for <linux-hardening@vger.kernel.org>; Wed, 19 Mar 2025 03:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742380022; x=1742984822; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=npBphVZ8VLlrZ8y917ZIpDNY3wIDZS8LemBb5dLjPNo=;
        b=gfANeS/uCfk2A1VQq/1dEqqftz2EeGaErHXmuUs7BclJEp2RTqlgHkS8uxRNVM9LR8
         RLOhgfJeJ/YMfig3XhP1E96eaVFxGt62H4/Snpj6VxSH+FH/dgr+Z7+VmfYOQGSc7t4T
         yxwHSa/tVc0lq0GYXviOQa0I6Hhwjy7olIWXau0scn0btBZ7Mw8Pbu8+BYxr49CB2+XP
         fNwiDKYrf3Oj9AOGWzOlQRXbs2z5V8aHA92l7+m7JIe9sg58sTL2XoFbi0F6QS8gUjIP
         U4DTOeeUn1k89L8W4uhFn9sf2G9lHaElDHEjbfRdNspvGfEM8agxoSS1ka6oxctcGoac
         V91g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742380022; x=1742984822;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=npBphVZ8VLlrZ8y917ZIpDNY3wIDZS8LemBb5dLjPNo=;
        b=a8EUGLa1kcsGu2S2J43Zg7atJ0TVa23qiFzg1jDILooG6UxI8647pPGhRBvE8eh6s9
         AYItPgDuoKpJ1AZFA5mYZLMRv2QKQxq/XEKHMhuP9BarC0l1C/2mF+p7bFlV/p1p1wdV
         9OVejQWA5dX3Ashk2TyxFxfl8U3eBvk/DVZQ18Ty9NB13wsUeXu9PNB0Z7Bsue9RuSsy
         Ky2m+WcF5czL/MKFfqCFb+jAEcY5iYOrq20qmLTfmBv8KB5aP3rUa5XMtUsVSxOGNq/R
         3zbPFR3rsQ6Rd+HaRUB3M1bzBOQxSaI+KQO3/44RgR2kvEpvHP4vXoFAycu5WU1KhxOS
         IaGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVf408zM9jg2c4aTph12FWx94aoHGNA9MHyhLgVFL9w+tU2uXIdcNa0BBpc15OlZLey9fIxLMBFBDJWN3FiPNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKWs2oAPY9P6MYndzyrxQ1vr93skry+GqUASnVuHdQwXJDJZYk
	rkDD+QFLdFDo8cP6YzcF9PI8/cmQ8pnv31MmbZTdKtj7cUJKNbO9NtN8MxOdur6AlbZOPRaxni1
	kEqI=
X-Gm-Gg: ASbGncvVig3haGg3x47TEfCGkL7qJFexpMPD3Hnz63qug6U4zox3DVsy5fqtTQ+g63q
	3sfHXcUodwE+T+ipY+hWDIgVe3PeSReHjpiMktzjHG2J00PSrg0hn80JS7a+/MqYBYjsOShbDJ7
	ulD0bUD6GIRxjqDmJcDVKORiKeSxqlxK1GrO49dI/t9zjwpgqmIsrIRF2M2iXAuB8GJGn4wnl8w
	eNX/TwegDPBK4crzPuME/jeRft1m6Fbv/1mVdZhAlpsRBx5ZUgcK7sNnHsp+O4sGH0z9e6KLg3X
	PB9hwclLTLWNHz+l3uMOTEI8EWw+y5l793Qz6uTvEcbKs+1WSCLFxl7luA==
X-Google-Smtp-Source: AGHT+IHgJa32EViQ9FgGt9X3i0ytHBwBESrxRu8v5xDPPM9kC6u1kldI+paOKRwUQkJJvg9ufU4lfw==
X-Received: by 2002:a17:902:e892:b0:224:1294:1d24 with SMTP id d9443c01a7336-22649828102mr31984225ad.3.1742380022332;
        Wed, 19 Mar 2025 03:27:02 -0700 (PDT)
Received: from [157.82.207.107] ([157.82.207.107])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd547asm109878845ad.248.2025.03.19.03.26.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 03:27:01 -0700 (PDT)
Message-ID: <bd681ec6-0b4c-47d9-8a4a-b7324c0883a6@daynix.com>
Date: Wed, 19 Mar 2025 19:26:57 +0900
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] KVM: arm64: PMU: Use multiple host PMUs
To: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>, Joey Gouly <joey.gouly@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu
 <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 devel@daynix.com
References: <20250319-hybrid-v1-1-4d1ada10e705@daynix.com>
 <Z9pze3J2_zrTk_yC@linux.dev>
 <e8324d9d-3756-41cf-a102-28572e302368@daynix.com>
 <86plidmjwh.wl-maz@kernel.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <86plidmjwh.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/03/19 18:47, Marc Zyngier wrote:
> On Wed, 19 Mar 2025 08:37:29 +0000,
> Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2025/03/19 16:34, Oliver Upton wrote:
>>> Hi Akihiko,
>>>
>>> On Wed, Mar 19, 2025 at 03:33:46PM +0900, Akihiko Odaki wrote:
>>>> Problem
>>>> -------
>>>>
>>>> arch/arm64/kvm/pmu-emul.c used to have a comment saying the follows:
>>>>> The observant among you will notice that the supported_cpus
>>>>> mask does not get updated for the default PMU even though it
>>>>> is quite possible the selected instance supports only a
>>>>> subset of cores in the system. This is intentional, and
>>>>> upholds the preexisting behavior on heterogeneous systems
>>>>> where vCPUs can be scheduled on any core but the guest
>>>>> counters could stop working.
>>>>
>>>> Despite the reference manual says counters may not continuously
>>>> incrementing, Windows is not robust enough to handle stopped PMCCNTR_EL0
>>>> and crashes with a division-by-zero error and it also crashes when the
>>>> PMU is not present.
>>>>
>>>> To avoid such a problem, the userspace should pin the vCPU threads to
>>>> pCPUs supported by one host PMU when initializing the vCPUs or specify
>>>> the host PMU to use with KVM_ARM_VCPU_PMU_V3_SET_PMU after the
>>>> initialization. However, QEMU/libvirt can pin vCPU threads only after the
>>>> vCPUs are initialized. It also limits the pCPUs the guest can use even
>>>> for VMMs that support proper pinning.
>>>>
>>>> Solution
>>>> --------
>>>>
>>>> Ideally, Windows should fix the division-by-zero error and QEMU/libvirt
>>>> should support pinning better, but neither of them are going to happen
>>>> anytime soon.
>>>>
>>>> To allow running Windows on QEMU/libvirt or with heterogeneous cores,
>>>> combine all host PMUs necessary to cover the cores vCPUs can run and
>>>> keep PMCCNTR_EL0 working.
>>>> I'm extremely uneasy about making this a generalized solution. PMUs are
>>> deeply tied to the microarchitecture of a particular implementation, and
>>> that isn't something we can abstract away from the guest in KVM.
>>>
>>> For example, you could have an event ID that counts on only a subset of
>>> cores, or better yet an event that counts something completely different
>>> depending on where a vCPU lands.> > I do appreciate the issue that you're trying to solve.
>>>
>>> The good news though is that the fixed PMU cycle counter is the only
>>> thing guaranteed to be present in any PMUv3 implementation. Since
>>> that's the only counter Windows actually needs, perhaps we could
>>> special-case this in KVM.
>>>
>>> I have the following (completely untested) patch, do you want to give it
>>> a try? There's still going to be observable differences between PMUs
>>> (e.g. CPU frequency) but at least it should get things booting.
>>
>> I don't think it will work, unfortunately. perf_init_event() binds a
>> perf event to a particular PMU so the event will stop working when the
>> thread migrates away.
>>
>> It should also be the reason why the perf program creates an event for
>> each PMU. tools/perf/Documentation/intel-hybrid.txt has more
>> descriptions.
> 
> But perf on non-Intel behaves pretty differently. ARM PMUs behaves
> pretty differently, because there is no guarantee of homogeneous
> events.

It works in the same manner in this particular aspect (i.e., "perf stat 
-e cycles -a" creates events for all PMUs).

> 
>>
>> Allowing to enable more than one counter and/or an event type other
>> than the cycle counter is not the goal. Enabling another event type
>> may result in a garbage value, but I don't think it's worse than the
>> current situation where the count stays zero; please tell me if I miss
>> something.
>>
>> There is still room for improvement. Returning a garbage value may not
>> be worse than returning zero, but counters and event types not
>> supported by some cores shouldn't be advertised as available in the
>> first place. More concretely:
>>
>> - The vCPU should be limited to run only on cores covered by PMUs when
>> KVM_ARM_VCPU_PMU_V3 is set.
> 
> That's userspace's job. Bind to the desired PMU, and run. KVM will
> actively prevent you from running on the wrong CPU.
> 
>> - PMCR_EL0.N advertised to the guest should be the minimum of ones of
>> host PMUs.
> 
> How do you find out? CPUs can be hot-plugged on long after a VM has
> started, bringing in a new PMU, with a different number of counters.
> 
>> - PMCEID0_EL0 and PMCEID1_EL0 advertised to the guest should be the
>> result of the AND operations of ones of host PMUs.
> 
> Same problem.

I guess special-casing the cycle counter is the only option if the 
kernel is going to deal with this.

> 
>>
>> Special-casing the cycle counter may make sense if we are going to fix
>> the advertised values of PMCR_EL0.N, PMCEID0_EL0, and
>> PMCEID1_EL0. PMCR_EL0.N as we can simply return zero for these
>> registers. We can also prevent enabling a counter that returns zero or
>> a garbage value.
>>
>> Do you think it's worth fixing these registers? If so, I'll do that by
>> special-casing the cycle counter.
> 
> I think this is really going in the wrong direction.
> 
> The whole design of the PMU emulation is that we expose a single,
> architecturally correct PMU implementation. This is clearly
> documented.
> 
> Furthermore, userspace is being given all the relevant information to
> place vcpus on the correct physical CPUs. Why should we add this sort
> of hack in the kernel, creating a new userspace ABI that we will have
> to support forever, when usespace can do the correct thing right now?
> 
> Worse case, this is just a 'taskset' away, and everything will work.

It's surprisingly difficult to do that with libvirt; of course it is a 
userspace problem though.

> 
> Frankly, I'm not prepared to add more hacks to KVM for the sake of the
> combination of broken userspace and broken guest.

The only counter argument I have in this regard is that some change is 
also needed to expose all CPUs to Windows guest even when the userspace 
does its best. It may result in odd scheduling, but still gives the best 
throughput.

Regards,
Akihiko Odaki

> 
> 	M.
> 

