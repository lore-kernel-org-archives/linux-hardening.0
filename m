Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4437FBC4;
	Wed, 21 Feb 2024 16:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708534509; cv=none; b=TP19tpH6hozl45z1lL0ZSQYzyw4KHPBGdHLn5/TYqEZ4qlTGZpJt7ODCxble/4fSac2yyuDhUgq3EEf6jnaF9tIs+GbH2N7/aERh3AYQeFK41NLFCQCbSHdZx7W7i9x3Q86cglOQrq2mqHr0JA1+0YOLzD3XDZZqFHK6syHsXzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708534509; c=relaxed/simple;
	bh=07lkd9NoppxxiEpP29PS7z0+eMrgeWwUwan7L7s+lZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EkcFzvmKN0TGsdtQUBZNapr7Z2CsXn/zdpaDzhKekosed8hcwdSC4/bSVSj4fChBDBx4HU2vrA1o2waq98w9VtlLreMucP6FFYRy6c02yVDCFl/J2fkEydire2eFtlcyXw9kmNanOTo71Ig1qmgGNrDeVgkCEV2oPTu49JmNdas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D0611007;
	Wed, 21 Feb 2024 08:55:43 -0800 (PST)
Received: from [192.168.20.13] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B5F143F73F;
	Wed, 21 Feb 2024 08:55:00 -0800 (PST)
Message-ID: <305d26ba-8738-4244-801f-939e1a9730a1@arm.com>
Date: Wed, 21 Feb 2024 10:54:58 -0600
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] arm64: syscall: Direct PRNG kstack randomization
Content-Language: en-US
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, Kees Cook <keescook@chromium.org>
Cc: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
 will@kernel.org, gustavoars@kernel.org, mark.rutland@arm.com,
 rostedt@goodmis.org, arnd@arndb.de, broonie@kernel.org,
 guohui@uniontech.com, Manoj.Iyer@arm.com, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, James Yang <james.yang@arm.com>,
 Shiyou Huang <shiyou.huang@arm.com>
References: <20240221020258.1210148-1-jeremy.linton@arm.com>
 <202402202226.A6817927@keescook>
 <CAHmME9pYS=YZM1b0ftrjj_qjz_U4V8PsiLzB15JmBRr39Av2Ng@mail.gmail.com>
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <CAHmME9pYS=YZM1b0ftrjj_qjz_U4V8PsiLzB15JmBRr39Av2Ng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Thanks for looking at this.

On 2/21/24 06:44, Jason A. Donenfeld wrote:
> Hi,
> 
> On Wed, Feb 21, 2024 at 7:33 AM Kees Cook <keescook@chromium.org> wrote:
>>> +#ifdef CONFIG_RANDOMIZE_KSTACK_OFFSET
>>> +DEFINE_PER_CPU(u32, kstackrng);
>>> +static u32 xorshift32(u32 state)
>>> +{
>>> +     /*
>>> +      * From top of page 4 of Marsaglia, "Xorshift RNGs"
>>> +      * This algorithm is intended to have a period 2^32 -1
>>> +      * And should not be used anywhere else outside of this
>>> +      * code path.
>>> +      */
>>> +     state ^= state << 13;
>>> +     state ^= state >> 17;
>>> +     state ^= state << 5;
>>> +     return state;
>>> +}
> 
> Can we please *not* introduce yet another RNG? You can't just sprinkle
> this stuff all over the place with no rhyme or reason.
> 
> If you need repeatable randomness, use prandom_u32_state() or similar.
> If you need non-repeatable randomness, use get_random_bytes() or
> similar.

Sure prandom_u32_state() should have a similar effect being a bit 
slower, and a bit better due to the extra hidden state.

> 
> If you think prandom_u32_state() is insufficient for some reason or
> doesn't have some property or performance that you want, submit a
> patch to make it better.
> 
> Looking at the actual intention here, of using repeatable randomness,
> I find the intent pretty weird. Isn't the whole point of kstack
> randomization that you can't predict it? If so, get_random_u*() is
> what you want. If performance isn't sufficient, let's figure out some

There isn't anything wrong with get_random_u16 from a kstack 
randomization standpoint, except for the latency spikes of course.

> way to improve performance. And as Kees said, if the point of this is
> to have some repeatable benchmarks, maybe just don't enable the
> security-intended code whose purpose is non-determinism? Both exploits
> and now apparently benchmarks like determinism.

As I mentioned in the other email, benchmark is probably the wrong word. 
Its a better QoS response time distributions for a given workload. And 
its not strictly in RT kernel latency test types of things, but normal 
memcached style workloads on !RT kernels as well.


