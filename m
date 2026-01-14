Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B30B30BF60;
	Wed, 14 Jan 2026 18:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768414602; cv=none; b=bzxaro8uzHzEZJV1773wmjYhQXWZDjefiwpA1pIDWGtGG0OOtpgGarR3LcqmG2Hu6+zI8KxhyvVsn6oLQCzCJKFHg8OuMsqCfwaBhLMZHDNT3ZBw9mBcQe3mJ8ix7qs1uxPNIOkp6eDtfo6Qo6BL0/5OxAjJHTNi5351SZmbMgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768414602; c=relaxed/simple;
	bh=0mzSBvp8hwTzdPabF4zKwRQev5n67P/cemC0YYwK/TI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dh5DIWId2aDH1cG/U73eZ2aVejgH/6FFA6+zMVa86UmORpgNSCBn/xy86oo/9Fsugs/sa+jJGLq1bO55YVqGk2vYM/LvbhG4Y9JNLt/0rOr2Z+x5ozU+nO1ws/+31ryOKVyX0HM25VGBc1VHZ6yqPjVUMCBkoMEFn5b+CQUyxfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYSTXT5S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYSTXT5S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14B64C4CEF7;
	Wed, 14 Jan 2026 18:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768414602;
	bh=0mzSBvp8hwTzdPabF4zKwRQev5n67P/cemC0YYwK/TI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eYSTXT5ScX5n9Bo55NbJe9GzCa2qN9yfBq0D2bvDgDDK4dvVnNkA8iPvodjeaW7k1
	 dd67ITPoT90gkg27OBgk/acKnXougCK9mREQfz/xq/B3x4ouv0+KaGVXbG12ASKT9J
	 /HCwoRdJHpOFXbnRD6Kluz/vcCrlo7O40Dhen6ODnqWHUS/VBo7bGRmh/ur5pBMCfk
	 kxSWm3QDeiM4zaJByqrr4ZFGdZ986V8fwXSDxWdqD1ATUK93YpogtEquUdazkNjYAb
	 crdRXEG+CkqiXxNtYybhZqsGldW2yk2qsaNipR6aBgPLxl3mVSGdqGFOADwaQWD4Ly
	 B0Q9AnrMVYIVQ==
Date: Wed, 14 Jan 2026 10:16:41 -0800
From: Kees Cook <kees@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Uros Bizjak <ubizjak@gmail.com>, Brian Gerst <brgerst@gmail.com>,
	linux-hardening@vger.kernel.org
Subject: Re: [RFC/RFT PATCH 00/19] Link the relocatable x86 kernel as PIE
Message-ID: <202601141003.852D0771D@keescook>
References: <20260108092526.28586-21-ardb@kernel.org>
 <0658071f-0664-442d-b93c-6841f011454d@zytor.com>
 <CAMj1kXHTK2r5P6-vXp=JHVK7pfCvr=1jmR5dgDZTgvseG=8hPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHTK2r5P6-vXp=JHVK7pfCvr=1jmR5dgDZTgvseG=8hPg@mail.gmail.com>

On Fri, Jan 09, 2026 at 10:21:49AM +0100, Ard Biesheuvel wrote:
> On Fri, 9 Jan 2026 at 01:37, H. Peter Anvin <hpa@zytor.com> wrote:
> >
> > On 2026-01-08 01:25, Ard Biesheuvel wrote:
> > > This series is a follow-up to a series I sent a bit more than a year
> > > ago, to switch to PIE linking of x86_64 vmlinux, which is a prerequisite
> > > for further hardening measures, such as fg-kaslr [1], as well as further
> > > harmonization of the boot protocols between architectures [2].
> >
> > Kristin Accardi had fg-kasrl running without that, didn't she?

I understand "such as fg-kaslr" to have been just a terse way of saying
"such as a complete multi-architectural fg-kaslr"

> Yes, as a proof of concept. But it is tied to the x86 approach of
> performing runtime relocations based on build time relocation data,
> which is problematic now that linkers have started to perform
> relaxations, as these cannot always be translated 1:1. For instance,
> we already have a latent bug in the x86 relocs tool, which ignores
> GOTPCREL relocations on the basis that the relocation is relative.
> However, this is only true for Clang/lld, which does not update the
> static relocation tables after performing relaxations. ld.bfd does
> attempt to keep those tables in sync, and so a GOTPCREL relocation
> should be flagged as a bug when encountered, because it means there is
> a GOT slot somewhere with no relocation associated with it.

Another historical bit of context is that one of the main reasons
Kristen's fg-kaslr got stuck was the linker support needed for (the 65k
worth of) section pass-through. That never got resolved, and the solutions
either required huge linker files (that tickled performance flaws in the
linkers) that resulted in 10 minute linking times, or to disable all the
orphan section handling, which was a regression in our sanity checking
and bug-finding.

So, getting a well-behaved fg-kaslr still needs toolchain support,
and getting there is going to need further design work. As far as PIE,
this just makes the fg-kaslr toolchain work easier (fewer special cases),
along with all the other benefits of moving to PIE.

-Kees

-- 
Kees Cook
