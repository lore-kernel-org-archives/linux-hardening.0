Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E8D2FD660;
	Fri, 28 Nov 2025 10:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764325931; cv=none; b=iznwUJsj60vX8vv3UHtSw6WHGb6cK6JrlAtWABJ4AQCqins/zPUlAS+7pPGtkUco7mQyjHmRbaawk58RUS3cPLH1FuC4aiQx4ltqzQJ5LCXDhFewrvsZyv9toKxKO4Jqp2o7vsFzPJsvWLuYdAcQ0XztzjEnuNKU0MflNkC9YAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764325931; c=relaxed/simple;
	bh=OawDqb4JtN6LsOoELsPux3yPu9eP/4QLpXhXfSwasDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CwA1fMEPSgeDQQ6NeTlM0FboUKgWblx+sSlwZNXLMFFdlxiRXCMlzjq6Y3653CAP83cNntkqe1uSCTM5mK+lBwWcLpYBgNvLJb7tf1lo3jf9cBhs7TwdYuj2xHEC5BREwBct0VrCOQTz6u6KzywTuTHkfcWfb8X580TfcAPiHsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5331D176A;
	Fri, 28 Nov 2025 02:31:58 -0800 (PST)
Received: from [10.57.87.167] (unknown [10.57.87.167])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0998B3F73B;
	Fri, 28 Nov 2025 02:32:03 -0800 (PST)
Message-ID: <177c5c01-82d7-461c-93c3-2c9f7bcb3403@arm.com>
Date: Fri, 28 Nov 2025 10:32:02 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/RFT PATCH 0/6] Improve get_random_u8() for use in randomize
 kstack
Content-Language: en-GB
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-hardening@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
 Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Jeremy Linton <jeremy.linton@arm.com>,
 Catalin Marinas <Catalin.Marinas@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, "Jason A. Donenfeld" <Jason@zx2c4.com>
References: <20251127092226.1439196-8-ardb+git@google.com>
 <b1dae5a7-27bd-42de-bcce-9fd3c2b1c178@arm.com>
 <CAMj1kXE-Qm4DQNAcg8Tg7YM4EMdLBu_UJm7M8Cpk3t5g7XqP5w@mail.gmail.com>
 <e996fdd5-7113-4327-a884-336dd5f77c4d@arm.com>
 <CAMj1kXGyYMy2xhcdNicHkMfWBnEjyhc+xg8ciuR-6WXDxDpZxg@mail.gmail.com>
 <f95593ac-d4cf-4e06-9a94-cc5133897c59@arm.com>
 <CAMj1kXE8msLjM83iKLQjRSQ+4cqj4iFS_CLxwfjj6adZ_AUBVg@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAMj1kXE8msLjM83iKLQjRSQ+4cqj4iFS_CLxwfjj6adZ_AUBVg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/11/2025 10:07, Ard Biesheuvel wrote:
> On Thu, 27 Nov 2025 at 16:57, Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> On 27/11/2025 15:03, Ard Biesheuvel wrote:
>>> On Thu, 27 Nov 2025 at 15:18, Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>
>>>> On 27/11/2025 12:28, Ard Biesheuvel wrote:
>>>>> On Thu, 27 Nov 2025 at 13:12, Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>>>
>>>>>> On 27/11/2025 09:22, Ard Biesheuvel wrote:
>>>>>>> From: Ard Biesheuvel <ardb@kernel.org>
>>>>>>>
>>>>>>> Ryan reports that get_random_u16() is dominant in the performance
>>>>>>> profiling of syscall entry when kstack randomization is enabled [0].
>>>>>>>
>>>>>>> This is the reason many architectures rely on a counter instead, and
>>>>>>> that, in turn, is the reason for the convoluted way the (pseudo-)entropy
>>>>>>> is gathered and recorded in a per-CPU variable.
>>>>>>>
>>>>>>> Let's try to make the get_random_uXX() fast path faster, and switch to
>>>>>>> get_random_u8() so that we'll hit the slow path 2x less often. Then,
>>>>>>> wire it up in the syscall entry path, replacing the per-CPU variable,
>>>>>>> making the logic at syscall exit redundant.
>>>>>>
>>>>>> I ran the same set of syscall benchmarks for this series as I've done for my
>>>>>> series.
>>>>>>
>>>>>
>>>>> Thanks!
>>>>>
>>>>>
>>>>>> The baseline is v6.18-rc5 with stack randomization turned *off*. So I'm showing
>>>>>> performance cost of turning it on without any changes to the implementation,
>>>>>> then the reduced performance cost of turning it on with my changes applied, and
>>>>>> finally cost of turning it on with Ard's changes applied:
>>>>>>
>>>>>> arm64 (AWS Graviton3):
>>>>>> +-----------------+--------------+-------------+---------------+-----------------+
>>>>>> | Benchmark       | Result Class |   v6.18-rc5 | per-task-prng | fast-get-random |
>>>>>> |                 |              | rndstack-on |               |                 |
>>>>>> +=================+==============+=============+===============+=================+
>>>>>> | syscall/getpid  | mean (ns)    |  (R) 15.62% |     (R) 3.43% |      (R) 11.93% |
>>>>>> |                 | p99 (ns)     | (R) 155.01% |     (R) 3.20% |      (R) 11.00% |
>>>>>> |                 | p99.9 (ns)   | (R) 156.71% |     (R) 2.93% |      (R) 11.39% |
>>>>>> +-----------------+--------------+-------------+---------------+-----------------+
>>>>>> | syscall/getppid | mean (ns)    |  (R) 14.09% |     (R) 2.12% |      (R) 10.44% |
>>>>>> |                 | p99 (ns)     | (R) 152.81% |         1.55% |       (R) 9.94% |
>>>>>> |                 | p99.9 (ns)   | (R) 153.67% |         1.77% |       (R) 9.83% |
>>>>>> +-----------------+--------------+-------------+---------------+-----------------+
>>>>>> | syscall/invalid | mean (ns)    |  (R) 13.89% |     (R) 3.32% |      (R) 10.39% |
>>>>>> |                 | p99 (ns)     | (R) 165.82% |     (R) 3.51% |      (R) 10.72% |
>>>>>> |                 | p99.9 (ns)   | (R) 168.83% |     (R) 3.77% |      (R) 11.03% |
>>>>>> +-----------------+--------------+-------------+---------------+-----------------+
>>>>>>
>>>>>
>>>>> What does the (R) mean?
>>>>>
>>>>>> So this fixes the tail problem. I guess get_random_u8() only takes the slow path
>>>>>> every 768 calls, whereas get_random_u16() took it every 384 calls. I'm not sure
>>>>>> that fully explains it though.
>>>>>>
>>>>>> But it's still a 10% cost on average.
>>>>>>
>>>>>> Personally I think 10% syscall cost is too much to pay for 6 bits of stack
>>>>>> randomisation. 3% is better, but still higher than we would all prefer, I'm sure.
>>>>>>
>>>>>
>>>>> Interesting!
>>>>>
>>>>> So the only thing that get_random_u8() does that could explain the
>>>>> delta is calling into the scheduler on preempt_enable(), given that it
>>>>> does very little beyond that.
>>>>>
>>>>> Would you mind repeating this experiment after changing the
>>>>> put_cpu_var() to preempt_enable_no_resched(), to test this theory?
>>>>
>>>> This has no impact on performance.
>>>>
>>>
>>> Thanks. But this is really rather surprising: what else could be
>>> taking up that time, given that on the fast path, there are only some
>>> loads and stores to the buffer, and a cmpxchg64_local(). Could it be
>>> the latter that is causing so much latency? I suppose the local
>>> cmpxchg() semantics don't really exist on arm64, and this uses the
>>> exact same LSE instruction that would be used for an ordinary
>>> cmpxchg(), unlike on x86 where it appears to omit the LOCK prefix.
>>>
>>> In any case, there is no debate that your code is faster on arm64.
>>
>> The results I have for x86 show it's faster than the rdtsc too, although that's
>> also somewhat surprising. I'll run your series on x86 to get the equivalent data.
>>
> 
> OK, brown paper bag time ...
> 
> I swapped the order of the 'old' and 'new' cmpxchg64_local()
> arguments, resulting in some very odd behavior. I think this explains
> why the tail latency was eliminated entirely, which is bizarre.
> 
> The speedup is also more modest now (~2x), which may still be
> worthwhile, but likely insufficient for the kstack randomization case.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git/log/?h=lockless-random-v2

Ahh, so we were never taking the slow path. That would definitely explain it.

I had a go at running this on x86 but couldn't even get the kernel to boot on my
AWS Sapphire Rapids instance. Unfortunately I don't have access to the serial
console so can't tell why it failed. But I used the exact same procedure and
baseline for other runs so the only difference is your change.

I wonder if this issue somehow breaks the boot on that platform?

Anyway, I'll chuck this update at the benchmarks, but probably won't be until
next week...

