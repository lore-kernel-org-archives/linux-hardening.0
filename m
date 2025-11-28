Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344E930FC12;
	Fri, 28 Nov 2025 11:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764330295; cv=none; b=ZXC2LSLeWRRhUazgz6wp3oMQvDTN46Iy/32yyayU8uMcl6eX/TAiu11qm9gRXsbfRJXAaNBj1DuyN0vBLt0oHYmP+ySBRTMSkNR6krtkNZnO1sujO9bTi0n4lLDbxIr/2DQ1MoQEfxPUqXOL9ADoxTpoRWk8ff8u+kztOSE8CjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764330295; c=relaxed/simple;
	bh=kqTNrob4O6cr5umGk0VSm47OpNtJ78m8qdnD4at18cE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFB43fMw7w7CFprxKcayjD6WETiArDTAqohMbT1KTFJU4O+ep2VyvNMwu0IoUrAVuCMRzHAojKvomxMi4kfPlwEyPoAhV6Q39gJVvW0MS5nrbtX5GOncIBHPzrWiUZwd2v2ad+IN9dyLbT3pXyqchQTuUW7J2rcXCn2MRZNQWVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9E59176A;
	Fri, 28 Nov 2025 03:44:44 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3EC263F66E;
	Fri, 28 Nov 2025 03:44:50 -0800 (PST)
Date: Fri, 28 Nov 2025 11:44:47 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Ard Biesheuvel <ardb+git@google.com>,
	linux-hardening@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Kees Cook <kees@kernel.org>, Will Deacon <will@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [RFC/RFT PATCH 0/6] Improve get_random_u8() for use in randomize
 kstack
Message-ID: <aSmLLz24stY_B9g0@J2N7QTR9R3>
References: <20251127092226.1439196-8-ardb+git@google.com>
 <b1dae5a7-27bd-42de-bcce-9fd3c2b1c178@arm.com>
 <CAMj1kXE-Qm4DQNAcg8Tg7YM4EMdLBu_UJm7M8Cpk3t5g7XqP5w@mail.gmail.com>
 <e996fdd5-7113-4327-a884-336dd5f77c4d@arm.com>
 <CAMj1kXGyYMy2xhcdNicHkMfWBnEjyhc+xg8ciuR-6WXDxDpZxg@mail.gmail.com>
 <f95593ac-d4cf-4e06-9a94-cc5133897c59@arm.com>
 <aSiDSp8NpqJkr1oD@J2N7QTR9R3>
 <CAMj1kXF9-tXVQS-_p8c058ssn80xaiDu+01SR98=yQ004xevng@mail.gmail.com>
 <6e4cfa83-3181-4988-a3d8-55e066b68947@arm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e4cfa83-3181-4988-a3d8-55e066b68947@arm.com>

On Fri, Nov 28, 2025 at 10:36:13AM +0000, Ryan Roberts wrote:
> On 27/11/2025 19:01, Ard Biesheuvel wrote:
> > On Thu, 27 Nov 2025 at 17:58, Mark Rutland <mark.rutland@arm.com> wrote:
> >>
> >> On Thu, Nov 27, 2025 at 03:56:59PM +0000, Ryan Roberts wrote:
> >>> On 27/11/2025 15:03, Ard Biesheuvel wrote:
> >>>> So the question is really whether we want to dedicate 16 bytes per
> >>>> task for this. I wouldn't mind personally, but it is something our
> >>>> internal QA engineers tend to obsess over.
> >>>
> >>> Yeah that's a good point.
> >>
> >> I think it's a fair point that some people will obsesses over this, but
> >> I think the concern is misplaced.
> >>
> >> I know that people were very happy for the kernel FPSIMD context to
> >> disappear from task_struct, but 16 bytes is a fair amount smaller, and
> >> I'm pretty sure we can offset that with a small/moderate amount of work.
> >>
> >> AFAICT there are extant holes in task_struct that could easily account
> >> for 16 bytes. I can also see a few ways to rework arm64's thread_info
> >> and thread_struct (which are both embedded within task_struct) to save
> >> some space.
> > 
> > Oh, I completely agree. But it is going to come up one way or the other.
> 
> I'm always terrified of changing the layout of those god structs for fear of
> accidentally breaking some cacheline clustering-based micro optimization.
> Putting new variables into existing holes is one thing, but rearranging existing
> data scares me - perhaps I'm being too cautious. I assumed there wouldn't be an
> existing hole big enough for 16 bytes.

FWIW, ignoring holes, the trailing padding is pretty big. In v6.18-rc1
defconfig task_struct appears to have ~40 bytes of padding due to
64-byte alignment. So (in that configuration) adding 16 bytes doesn't
actually increase the size of the structure.

I have a few specific changes in mind which could ammortize 16 bytes, so
even if this turns out to be an issue, we can make good.

For example, I'd like to change arm64's FPSIMD/SVE/SME context switch
to remove the opportunistic reuse of context after A->B->A migration.
That would remove the need for 'fpsimd_cpu' and 'kernel_fpsimd_cpu' in
thread struct (which is embedded within task struct, at the end), saving
8 bytes.

If we change the way we encod the 'vl' and 'vl_onexec' array elements,
we can shrink those from unsigned int down to u8, which would sve 12
bytes.

Mark.
