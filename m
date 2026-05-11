Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C454A3412;
	Mon, 11 May 2026 18:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778525140; cv=none; b=GcH+Op2ILKamkgtnVor50eIIxbkLFHt+sIvS7GFjE8lp0CpLse0hBTgzCB5tupgsVV8NiqktbwfnRB3tl9Eifm2Ked1woCPrho2ilaZJ3BLllIFds31tVzfOGowDTmaSjN8VdAy/P0zJaNCN69v/bk2BNOB//A3+J7j45F3/EY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778525140; c=relaxed/simple;
	bh=TwOfOoVHvAk5+BCmHU/0l16HBggiVxIlTk/wO3uefzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4++cgyMqn3L85m3VX/zq+7q6P66C9hzr3F0tJz0ygYHeCLegLOTcypiUv7m6XrFD0o0F74WwgAF9pNh0yRUAFusLCGd03Ewm9y8sslJkDI0tpsmYFSTKdR9nhq4H0zAnBRZgJr1xF1yV1f5eKLIlxCZbjZYof19Cu799Tr5fvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gD5uFrrl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gD5uFrrl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEFBEC2BCB0;
	Mon, 11 May 2026 18:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778525140;
	bh=TwOfOoVHvAk5+BCmHU/0l16HBggiVxIlTk/wO3uefzU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gD5uFrrlE+wG2vwML+Aua/biLzAAyLJ+t6tbI+rhZSnVTjogUz6PrsXYzBDuv04SE
	 5UossI/jUrt1BWF56+0ts/0MbUWbyhisN9TyfCmJ1yDkACDU33yNP81cnVfETNey5h
	 0P68FO0RXg4OZxf2Pt+hfo0cdCjBMwJbrdOEd3Pdl3PRLkTmcYaqHGBxXGM1vY4PSS
	 2qvPgHjG3FGAWF/6ZLxS2SoQBF9+nqr4cWLDQUhYH6dRDjnMxv/hnqfMec5S8pNKfa
	 4cWUtMHZ2B4dAzEHpMKQC27h9YzXrLWXzskKQEkFDNph7Ozt4lOUU0MxDlojcCKrDp
	 FduI08HJYAMQg==
Date: Mon, 11 May 2026 11:45:39 -0700
From: Kees Cook <kees@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Ard Biesheuvel <ardb+git@google.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
	Ard Biesheuvel <ardb@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Liz Prucka <lizprucka@google.com>,
	Seth Jenkins <sethjenkins@google.com>,
	Mike Rapoport <rppt@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4 02/15] mm: Make empty_zero_page __ro_after_init
Message-ID: <202605111144.349EF737E@keescook>
References: <20260427153416.2103979-17-ardb+git@google.com>
 <20260427153416.2103979-19-ardb+git@google.com>
 <CAG48ez1DJ88a0pBCE-Q0VXyDuJgng8zdunb38g4b4JPU88exww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez1DJ88a0pBCE-Q0VXyDuJgng8zdunb38g4b4JPU88exww@mail.gmail.com>

On Fri, May 08, 2026 at 07:02:51PM +0200, Jann Horn wrote:
> On Mon, Apr 27, 2026 at 5:44 PM Ard Biesheuvel <ardb+git@google.com> wrote:
> > The empty zero page is used to back any kernel or user space mapping
> > that is supposed to remain cleared, and so the page itself is never
> > supposed to be modified.
> >
> > So make it __ro_after_init rather than __page_aligned_bss: on most
> > architectures, this ensures that both the kernel's mapping of it and any
> > aliases that are accessible via the kernel direct (linear) map are
> > mapped read-only, and cannot be used (inadvertently or maliciously) to
> > corrupt the contents of the zero page.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> 
> Reviewed-by: Jann Horn <jannh@google.com>
> 
> Sorry, I should have looked at this properly earlier instead of ending
> up duplicating this patch with
> <https://lore.kernel.org/all/20260508-ro-zeropage-v1-1-9808abc20b49@google.com/>.

As you mention in your testing of the patch, could we add an LKDTM test
that does the same to catch any regressions?

-- 
Kees Cook
