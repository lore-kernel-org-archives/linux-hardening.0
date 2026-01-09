Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A315D1F95C;
	Fri,  9 Jan 2026 00:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767919059; cv=none; b=GejX1pmVMyilaKhQ3GMafyQpVHyFQeuLaQOwG0cipo1JgH64l8H07DVXKyviReSKjtWW7ZWFGg4qUxhR/v9YLVsOpb6JtWuuIbXvN/Pm9ZzhUynWX4/cFZcDq6frgtKyjmJpM5wr6beO7oGiv2TUqxcGc8LS+d0jl09U+rKEGWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767919059; c=relaxed/simple;
	bh=hclOahF0a7HxPthLzFJ+58DJukrIVIhcuu0DY9kBmXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eHzdHyuEkp45Vxo1efq3ZQMBtemEdCoevJxCc/5VAcNqdgIavBmYkG1/xL9xBHLDDNK1DJrhSOA+qEOssiTVN3O0Is0jjbNwFKKX5kRKpMAOKkkL5WsUoe0BR1e63LJ/C+q7oWa/uUIbaf3RbQlHpnGjrkQ9NIDKLDTJmvEhlkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=h2o7j6DH; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="h2o7j6DH"
Received: from [172.27.2.41] (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 6090a44a2711877
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 8 Jan 2026 16:36:25 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 6090a44a2711877
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025122301; t=1767918986;
	bh=BFfFAwJAy7ijpDZN7KkK3xe0NjVXlkZUy/s/4NjXQSw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=h2o7j6DHpkjf8jgi3/eFhxStw4AJKe/hV+dRsaoH3QHhpAkq3VS02vjeL+GUH+vTL
	 oIV8RODisE07CjJnMQUwBGE67bF91eFgGTYzSI8tM4eP8loxpjmolhGuIh6iXxrlUK
	 tbJuoVe6PC/b6BkEL47uQAaW3SDzAMf0BD8PWP0Ovm+zzs7ZiAnVxAgYcc+MIHyii/
	 n0IrUiXfoTi3nykrZ28Iud3BEF9pZ/q6vEuvtQv3HskfwWgGwVwxqmPIXy3d8rzFdp
	 0KVI8IncrGVeiEgLS0BVLGUk8PoyktjCKdAmazbPu/Qoobmute6I1uYASjcqHSgekN
	 cdxc2VEOhirSg==
Message-ID: <0658071f-0664-442d-b93c-6841f011454d@zytor.com>
Date: Thu, 8 Jan 2026 16:36:03 -0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/RFT PATCH 00/19] Link the relocatable x86 kernel as PIE
To: Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Kees Cook <kees@kernel.org>,
        Uros Bizjak <ubizjak@gmail.com>, Brian Gerst <brgerst@gmail.com>,
        linux-hardening@vger.kernel.org
References: <20260108092526.28586-21-ardb@kernel.org>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20260108092526.28586-21-ardb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026-01-08 01:25, Ard Biesheuvel wrote:
> This series is a follow-up to a series I sent a bit more than a year
> ago, to switch to PIE linking of x86_64 vmlinux, which is a prerequisite
> for further hardening measures, such as fg-kaslr [1], as well as further
> harmonization of the boot protocols between architectures [2].

Kristin Accardi had fg-kasrl running without that, didn't she?

From your footnotes, it looks like what you are *really* asking for is to
pessimize x86 code to benefit other architectures. That isn't inherently
wrong, but stating it as you have above is dishonest.

> The main sticking point is the fact that PIE linking on x86_64 requires
> PIE codegen, and that was shot down before on the basis that
> a) GOTs in fully linked binaries are stupid
> b) the code size increase would be prohibitive
> c) the performance would suffer.
> 
> This series implements PIE codegen without permitting the use of GOT
> slots. The code size increase is between 0.2% (clang) and 0.5% (gcc),
> and I could not identify any performance regressions (using hackbench)
> on various different micro-architectures that I tried it on.
> (Suggestions for other benchmarks/test cases are welcome)

Could you show some examples of how the code changes?

	-hpa
> 
> [1] There have been a few attempts at landing fine grained KASLR for
> x86, but the main problem is that it was tied to the x86 relocation
> format, which deviates from how fully linked relocatable ELF binaries
> are generally constructed (using PIE). Implementing fgkaslr in the ELF
> domain would make it suitable for other architectures too, as well as
> other use cases (bare metal or hosted) where no dynamic linking is
> performed (firmware, hypervisors). In order to implement this properly,
> i.e., with debugging support etc, it needs support from the tooling
> side. (Fine grained KASLR in combination with execute-only code mappings
> makes it extremely difficult for an attacker to subvert the control flow
> in the kernel in a way that can be meaningfully exploited).
> 
> [2] EFI zboot is already used by various architectures that have no
> decompressor stage at all (arm64, RISC-V, LoongArch), and this format
> can be combined with an ELF payload too. EFI zboot accommodates non-EFI
> boot chains by describing the size, offset, payload type and compression
> type in its header, so that it can be extracted and booted by other
> means.

The bzImage format already have that for all practical purposes. We *really*
don't want to introduce a new binary format for the x86 kernel. A bunch of
such attempts have been done in the past, and it is nothing but a mess that
breaks things, because now you are encouraging different bootloaders to
support a non-overlapping set of binary formats.

STRONG NAK on that one.

	-hpa


