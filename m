Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69E1353A82
	for <linux-hardening@vger.kernel.org>; Tue,  8 Sep 2026 06:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788850347; cv=none; b=c4oeUH1Bw/GSWbnH17asBbUPczHtoSJJAAUK5R8+AQU9t+X4FNJW3mv0bGcAyje6BB2f3zJVgtua9IDpr6pCD/mMOCqkvZ5D8KN94AjW5HKZgp6lGEVwa8C27eP5j4LyqnnbdjkB2FxEI68AJMMNeVFurTeC3dXbt4LCuUx1fpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788850347; c=relaxed/simple;
	bh=AtNAb9NyWSu8YZkbqHBAoZSwv6rTxZiHiOZfX/IRwgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/XDXgq5Ra1Hy77LYBoirM4s2T34ZnMroTRLoPz/Jw0zplu8J4/Yag1qjGehwOizEbh8jntf25MfNVDqte41gWPQ+Kd4T4kVP0M+DiPf21b+l9p7I9cZ4vF17aG7V5lvwqeozI+5IrJ0Kr4nMPenC/9I1ai0+6N09oKhGDxoXbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MxGHPr/o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MxGHPr/o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D9921F00A3A;
	Tue,  8 Sep 2026 06:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788850346;
	bh=tQCExSqn1W0rL2KHHjcgog6hZgpy3PJqmFXUPMAfp8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MxGHPr/o7Egzf7/M8R8Ao6xgWW828L9KjV5g84sSn7wi9vQ7ZcW0u0yYAkaDvectd
	 mR4UMWwASyruj3B4tXUeARgiJB6uF8PJhd7Vk5pHsWytx6JL63jN1/RAI90iaZDj5v
	 BSMATV5Tjnay2NldoJaKCaxkJf+B14z9AyDmY+MVafeEWhRzFRldWfi0CqcNr52USK
	 953kOdfoLHavZRSp42M83cfpJ14CsK0C7vG3yQyKNcguUsP8lAJpH7cavlJCQtN9Gc
	 1lsmIJCiWgIzHl6QoyQVlGhaNA5yh2Rs7v8dUZbABjex8SUJroXjJK4pnfLnMSZmk4
	 hpWo7/SVN/Y7Q==
Date: Tue, 8 Sep 2026 09:52:12 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-hardening@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@chromium.org>,
	Joey Gouly <joey.gouly@arm.com>, Kees Cook <kees@kernel.org>,
	Linu Cherian <linu.cherian@arm.com>,
	Linus Walleij <linusw@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Maxwell Bland <mbland@motorola.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Pierre Langlois <pierre.langlois@arm.com>,
	=?iso-8859-1?Q?Pierre-Cl=E9ment?= Tosi <ptosi@google.com>,
	Quentin Perret <qperret@google.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Vlastimil Babka <vbabka@kernel.org>, Will Deacon <will@kernel.org>,
	Yang Shi <yang@os.amperecomputing.com>,
	Yeoreum Yun <yeoreum.yun@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	x86@kernel.org, Ira Weiny <iweiny@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>, Thomas Gleixner <tglx@kernel.org>
Subject: Re: [PATCH RFC v9 01/25] mm: Introduce kpkeys
Message-ID: <ap-wnHAwfdX_b39o@kernel.org>
References: <20260818-kpkeys-v9-0-743ad31b2c8f@arm.com>
 <20260818-kpkeys-v9-1-743ad31b2c8f@arm.com>
 <178877845406.3691569.6930315020588094755.b4-review@b4>
 <3f6e7678-0784-4ac1-acb4-b128887803c5@arm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f6e7678-0784-4ac1-acb4-b128887803c5@arm.com>

On Mon, Sep 07, 2026 at 05:49:42PM +0200, Kevin Brodsky wrote:
> On 07/09/2026 12:54, Mike Rapoport wrote:
> >> +
> >> +#include <linux/bug.h>
> >> +#include <linux/cleanup.h>
> >> +#include <linux/kpkeys_types.h>
> >> +
> >> +/**
> >> + * KPKEYS_GUARD_NOOP() - define a guard type that does nothing
> > Nit: I'd suggest to drop "define" from all the descriptions, they would
> > read better without it IMHO.
> 
> Fair enough, but if we say just "a guard type that does nothing" is it
> clear that this is a macro defining a type, and not a type itself?

Then maybe "helper to define", like cleanup.h does?
 
> - Kevin

-- 
Sincerely yours,
Mike.
