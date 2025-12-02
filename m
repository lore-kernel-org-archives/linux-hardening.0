Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4242D309F01;
	Tue,  2 Dec 2025 09:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764668150; cv=none; b=nPpTD5aoZ8D1+9UtUfxbeLvmp3uPv+08nBiSQmHsieUNeflb4XgdwSFUN+BN1ArsZUmB4a7srZv4RNBR7sIHvz3K72y3dNtGGBuJIHIyHWXinXImg2FSEOkGPtSAUM36kertx9Db+LB+uotUXBj+iCDAWZuGQUjALHEw2hsrge4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764668150; c=relaxed/simple;
	bh=N+bExpfMu6bpGudxgDyMM6k3hzFlD56+SYy+WJbnbDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jo63xg4GOvsMBqqR0Ls8TrffVTqWkBwRnDZuXjBSTgx9qUHQduejBE3O+7EbfeX2PFqyJw4Ktb48tLXMI5jMb/qZ6Qqf6dqP4X6TIXFSEVw0mLc593/xUtz1mE9ndsiWYLjFn+tjoXKGqPJeQCIObRWpamBa2mCQM39/6ghVE8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C4CB153B;
	Tue,  2 Dec 2025 01:35:40 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B96273F59E;
	Tue,  2 Dec 2025 01:35:45 -0800 (PST)
Date: Tue, 2 Dec 2025 09:35:40 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Kees Cook <kees@kernel.org>,
	Ard Biesheuvel <ardb+git@google.com>, Will Deacon <will@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	linux-hardening@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 2/2] randomize_kstack: Unify random source across
 arches
Message-ID: <aS6ylpLIyDZOvBDB@J2N7QTR9R3>
References: <20251127105958.2427758-1-ryan.roberts@arm.com>
 <20251127105958.2427758-3-ryan.roberts@arm.com>
 <CAMj1kXFY1RXk8T4f46bkm_sr0nJfBoO+ii68JK4+CsRiDwKdCg@mail.gmail.com>
 <9097505d-b18b-4f85-a02c-7f2865ad8bca@arm.com>
 <CAMj1kXHX1W2Kz5NJehtzDhOCKWEd6y1sp8+ViOMHGsq9e8=7Pw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHX1W2Kz5NJehtzDhOCKWEd6y1sp8+ViOMHGsq9e8=7Pw@mail.gmail.com>

On Tue, Dec 02, 2025 at 10:15:22AM +0100, Ard Biesheuvel wrote:
> On Mon, 1 Dec 2025 at 19:20, Ryan Roberts <ryan.roberts@arm.com> wrote:
> > On 28/11/2025 11:01, Ard Biesheuvel wrote:
> > > On Thu, 27 Nov 2025 at 12:00, Ryan Roberts <ryan.roberts@arm.com> wrote:
> > >> diff --git a/include/linux/randomize_kstack.h b/include/linux/randomize_kstack.h
> > >> index 089b1432f7e6..83c7e6710f6d 100644
> > >> --- a/include/linux/randomize_kstack.h
> > >> +++ b/include/linux/randomize_kstack.h
> > >> @@ -6,6 +6,7 @@
> > >>  #include <linux/kernel.h>
> > >>  #include <linux/jump_label.h>
> > >>  #include <linux/percpu-defs.h>
> > >> +#include <linux/prandom.h>
> > >>
> > >>  DECLARE_STATIC_KEY_MAYBE(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,
> > >>                          randomize_kstack_offset);
> > >> @@ -45,9 +46,13 @@ DECLARE_STATIC_KEY_MAYBE(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,
> > >>  #define KSTACK_OFFSET_MAX(x)   ((x) & 0b1111111100)
> > >>  #endif
> > >>
> > >> +static __always_inline u32 get_update_kstack_offset(void)
> > >> +{
> > >> +       return prandom_u32_state(&current->kstack_rnd_state);
> >
> > I've got bot warnings because this is being called from noinstr code. I guess
> > the best option is to just move add_random_kstack_offset() to after
> > instrumentation is enabled for the affected arches.
> 
> Just put instrumentation_begin()/instrumentation_end() around the call
> to prandom_u32_state() - that seems to be the common approach for
> punching holes into the 'noinstr' validation.

That silences the warning, but isn't necessarily safe, so please DO NOT
do that blindly. The instrumentation_{begin,end}() annotations are only
supposed to be used when we know by construction that instrumentation is
safe.

Generally, if you can move this to after instrumentation is already
enabled, that should be safe, and so that'd be the better approach.

Ryan, can you share those warnings (e.g. link to those reports)?

IIUC only x86 has noinstr validation, and from a quick scan, I expect
you see warnings from:

* do_syscall_64()
* do_int80_syscall_32()
* __do_fast_syscall_32()

For all of these, it is not safe to call instrumentable code before the
calls to {syscall_,}enter_from_user_mode{,_prepare}(). You'll need to
move the stack rnadomization after the existing instrumentation_begin()
calls.

We'll need to go check the other architectures similarly.

Mark.
