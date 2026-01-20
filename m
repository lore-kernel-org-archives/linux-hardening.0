Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA8C3A35AE;
	Tue, 20 Jan 2026 20:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768942026; cv=none; b=ot5VuyxSDz3REfgLORNPw0dYrPTvY1PjZBqZ8l2mR9o/RUXjCOdJGczhgATA2inl6Ro1iu6PJuTpLKw0EVnSnoBO8v5Zt7TQznQT/jsBu1w0hFZiwHJBOvFjiGKud+G+cSXUxwJoXEukT4L80AZJVfhroiOeOBd2GGknqVvcrQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768942026; c=relaxed/simple;
	bh=LyspXueXW68AGO9V25LxvSI472ChvQTBK2CWNJt0Jcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kFlg7QTPDiVl5yTfh8BqqxhZswBTl7U/OAzR6cME63nNeMboaLJrVnQHqO+86jOv7UHgzRUixUsCWvgnhoU4nMB7h4dGrwU3QsUYsBN+HvpdI7Glri3loGm7J54MJ7OfMmvO+TIKxduwvWwgt9VzkDZGYVT8sB7YyajrzT1l01Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=eqV+OT2o; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="eqV+OT2o"
Received: from [IPV6:2601:646:8081:9483:12c5:bc8e:d949:3497] ([IPv6:2601:646:8081:9483:12c5:bc8e:d949:3497])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 60KKjMx63991457
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 20 Jan 2026 12:45:23 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 60KKjMx63991457
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025122301; t=1768941924;
	bh=uxi7aPtP+ZxwoZ8Xk6vH3We1uz0gYxMTSDROnW8WaQs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eqV+OT2oWOUXmm7uQu8O7qUME+1MYFWVKDJddplUiLKgJTofzB6U3VFHroyVs3Vf2
	 PZKokN2NbW8oCBQD7bIz96+02NEcjofwxpold0Z2SYbneKJAxQYOav67uXHcAvQOaL
	 VU+OwAP/GkoA8gYFF/26pTovLtQ1sOM8fJ+RMziNkkXvLgz4sl8YFcO8cupYbfFLHO
	 EqbvwZ+kIS/D24bPa6pRGR0vcYuEHbPHnM3z2Tp+/u8huUg/3G+Kyh7aruugBFCKUV
	 i9hFzhFrJfQ8LSRTLE1Kbj/cP9B/d4WDFn0Jb0C4FOxRhb03T5yPk3U7PQ/LiVoDD3
	 i7r4gAN/8uTFA==
Message-ID: <19f51dd5-c729-4977-880e-ff23ef01bca5@zytor.com>
Date: Tue, 20 Jan 2026 12:45:16 -0800
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/RFT PATCH 00/19] Link the relocatable x86 kernel as PIE
To: Kees Cook <kees@kernel.org>, Ard Biesheuvel <ardb@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Uros Bizjak <ubizjak@gmail.com>,
        Brian Gerst <brgerst@gmail.com>, linux-hardening@vger.kernel.org
References: <20260108092526.28586-21-ardb@kernel.org>
 <0658071f-0664-442d-b93c-6841f011454d@zytor.com>
 <CAMj1kXHTK2r5P6-vXp=JHVK7pfCvr=1jmR5dgDZTgvseG=8hPg@mail.gmail.com>
 <202601141003.852D0771D@keescook>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <202601141003.852D0771D@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026-01-14 10:16, Kees Cook wrote:
> On Fri, Jan 09, 2026 at 10:21:49AM +0100, Ard Biesheuvel wrote:
>> On Fri, 9 Jan 2026 at 01:37, H. Peter Anvin <hpa@zytor.com> wrote:
>>>
>>> On 2026-01-08 01:25, Ard Biesheuvel wrote:
>>>> This series is a follow-up to a series I sent a bit more than a year
>>>> ago, to switch to PIE linking of x86_64 vmlinux, which is a prerequisite
>>>> for further hardening measures, such as fg-kaslr [1], as well as further
>>>> harmonization of the boot protocols between architectures [2].
>>>
>>> Kristin Accardi had fg-kasrl running without that, didn't she?
> 
> I understand "such as fg-kaslr" to have been just a terse way of saying
> "such as a complete multi-architectural fg-kaslr"
> 
>> Yes, as a proof of concept. But it is tied to the x86 approach of
>> performing runtime relocations based on build time relocation data,
>> which is problematic now that linkers have started to perform
>> relaxations, as these cannot always be translated 1:1. For instance,
>> we already have a latent bug in the x86 relocs tool, which ignores
>> GOTPCREL relocations on the basis that the relocation is relative.
>> However, this is only true for Clang/lld, which does not update the
>> static relocation tables after performing relaxations. ld.bfd does
>> attempt to keep those tables in sync, and so a GOTPCREL relocation
>> should be flagged as a bug when encountered, because it means there is
>> a GOT slot somewhere with no relocation associated with it.
> 
> Another historical bit of context is that one of the main reasons
> Kristen's fg-kaslr got stuck was the linker support needed for (the 65k
> worth of) section pass-through. That never got resolved, and the solutions
> either required huge linker files (that tickled performance flaws in the
> linkers) that resulted in 10 minute linking times, or to disable all the
> orphan section handling, which was a regression in our sanity checking
> and bug-finding.
> 
> So, getting a well-behaved fg-kaslr still needs toolchain support,
> and getting there is going to need further design work. As far as PIE,
> this just makes the fg-kaslr toolchain work easier (fewer special cases),
> along with all the other benefits of moving to PIE.
> 

As I *explicitly* stated earlier, there isn't anything inherently wrong with
putting a small onus on x86 in order to make the general Linux code better --
but please, be honest about it *so we know what the actual tradeoffs are*.

For x86, we really do want to maintain the kernel memory model, which allows
us to directly reference symbols in complex address expressions and to
directly jump across modules. This means the "PIE" will need to be different
from the way PIE works in user space, which is in part designed to avoid
needing to dirty readonly pages, which would inhibit sharing -- which is
explicitly NOT a concern for the kernel.

So that is one thing that the toolchain needs to be able to do.

I fully expect that we will continue to need to have some kinds of overrides
for specific symbols, too, because there aren't any really sane ways to
express them to the toolchain; this especially applies to linker-script and
some assembly symbols. For example, the real-mode code (which uses the reloc
tool as well) has to support segment and segbase-relative relocations, which
are something that ELF simply has no concept of.

I have a lot more of an issue with trying to change the x86 boot protocol,
simply because the way booting works in x86 has been incredibly successful;
yes, the bzImage file format is ugly as ****, but that is a direct result of
34 years of continuous backwards compatibility. One of the reasons we have
been able to do that is that we have *explicitly* rejected other boot models,
such as Grub's self-declared Multiboot "standard" (which they have had to
revise multiple times by now) and the early Xen boot model of booting vmlinux
directly. We have added *many* capabilities to bzImage as needed, and it has
turned out to be quite flexible in the end.

That, in turn, has been possible exactly *because* the Linux kernel provides a
"prekernel". I don't even really like calling it the "decompressor" anymore;
it really has developed far beyond that.

Every time you introduce a new boot model you take a serious risk that a boot
loader author will say "hey, I'll just support this new model", and you *also*
take the serious risk that the boot model isn't adequate. When the Grub
authors says "we started using the 'modern' Linux entry point" -- meaning they
would bypass the entry stub and call the kernel entry point directly -- they
*reduced* the overall functionality, because history has shown that:

a. The kernel image is far easier for the end user to update than the
potentially many bootloaders, because the bootloader depends on the deployment
model (consider network booting, for example, or when the bootloader is in
firmware.)

b. The kernel image provides ONE CENTRAL PLACE to add features, fix bugs, and
develop workarounds for strange systems.

Thus, I will do anything I can to continue to veto changes to the x86 boot
model, unless they come with a VERY VERY good motivation.

We originally made the mistake with EFI to leave too much to the bootloader;
because of the downsides above we really needed to backpedal and take over
control much earlier in the flow, just as with BIOS -- apparently to the Grub
developers' utterly inexplicable chagrin.

	-hpa

