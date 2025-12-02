Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F9D1FD4;
	Tue,  2 Dec 2025 10:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764669747; cv=none; b=XYfLfo07bLGMVy3Fv2SbeJ+xgK+5+n6GAgDDpbNIj9UZ91kH/IszCsDVOLeCO3dh++z6jkpL9Ms8lEGcBfPsU7y2KL0VN27SOdW+dXuSiPMGkWUtSQK3nakhDtR5IOs6ndoLnc9/BS3ccLJ79oyw7eXOKAF7pLSjDdclh7UfatY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764669747; c=relaxed/simple;
	bh=l+9FM79ssj+H3+h/cosVpSP22Pg7HARn2juZ0zSmfgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=edPL6TWeeOgoDnqHYw8MAVXJ76a/dQJYGJevuj9/71dxeFkoVqnw3Zcn6qKFoi9TeXA3PEhC6RFWlTzXKQL3dYxwcZuIy2K0yGUJfuOZ8rMdbgFnzXJ6UmPjYjRNzJoEFQ4rTOm0DS8yjIGyxG3E1EqAHwpxgnSHCMvrm7pTiio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8345A153B;
	Tue,  2 Dec 2025 02:02:17 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 321853F73B;
	Tue,  2 Dec 2025 02:02:23 -0800 (PST)
Date: Tue, 2 Dec 2025 10:02:20 +0000
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
Message-ID: <aS65LFUfdgRPKv1l@J2N7QTR9R3>
References: <20251127105958.2427758-1-ryan.roberts@arm.com>
 <20251127105958.2427758-3-ryan.roberts@arm.com>
 <CAMj1kXFY1RXk8T4f46bkm_sr0nJfBoO+ii68JK4+CsRiDwKdCg@mail.gmail.com>
 <9097505d-b18b-4f85-a02c-7f2865ad8bca@arm.com>
 <CAMj1kXHX1W2Kz5NJehtzDhOCKWEd6y1sp8+ViOMHGsq9e8=7Pw@mail.gmail.com>
 <aS6ylpLIyDZOvBDB@J2N7QTR9R3>
 <CAMj1kXG=HDVso1xc6TGgSrBpV3Sq2YQLdPKg2dw5z9qdrbdWBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXG=HDVso1xc6TGgSrBpV3Sq2YQLdPKg2dw5z9qdrbdWBw@mail.gmail.com>

On Tue, Dec 02, 2025 at 10:47:04AM +0100, Ard Biesheuvel wrote:
> On Tue, 2 Dec 2025 at 10:35, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Tue, Dec 02, 2025 at 10:15:22AM +0100, Ard Biesheuvel wrote:
> > > On Mon, 1 Dec 2025 at 19:20, Ryan Roberts <ryan.roberts@arm.com> wrote:
> > > > I've got bot warnings because this is being called from noinstr code. I guess
> > > > the best option is to just move add_random_kstack_offset() to after
> > > > instrumentation is enabled for the affected arches.
> > >
> > > Just put instrumentation_begin()/instrumentation_end() around the call
> > > to prandom_u32_state() - that seems to be the common approach for
> > > punching holes into the 'noinstr' validation.
> >
> > That silences the warning, but isn't necessarily safe, so please DO NOT
> > do that blindly.
> 
> Oops - sorry about that.

No problem! I just wanted to make sure we didn't start to gain broken
usage that'd need an audit and cleanup.

[...]

> Given that prandom_u32_state() does a fairly straight-forward mangle
> of 4 32-bit words, might it be better to make that __always_inline
> itself?

Possibly! I don't know whether it's better to have prandom_u32_state()
inline or out-of-line.

So long as prandom_u32_state() doesn't call out to instrumented code,
making it an __always_inline function will be safe.

Mark.
