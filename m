Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2BF18027;
	Sat, 22 Nov 2025 22:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763849776; cv=none; b=in1UxZ5OuHrRUgq6YpoQPv+U7vJfLgofW5220GBvgtMWzzpwJFWe1r8zs39Qc/vUE88LSq50mQXmyZ8Osd5jFWsaos4wl+R8cfe7k6+CS+rPCv2rKCBtoHPBLIADFg9Qiz8VixUkNzhIgU9o+qm/CrORxyqqBudbrGipgubegsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763849776; c=relaxed/simple;
	bh=oJdmGsiGca/DIx/SjiqaVDSIgtR8inCTav2QsrGYsnI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=u/NrmRDGAkvCL6PKSbEL/jbMIlynIR7zEPKzHc9Pw4v4lQjsHaSDRvoY1MNmNukpEu4kWJ4FUF38OOlGTTygXLpbAYzUqZFJJbaYhitQr+/wnRTUmnKFBPD1dJh4tDJlbOplX9r4s83eklMYzA7z8Tj/6VZo7otWJMdHp7r2wNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aP/XIbRp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aP/XIbRp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC8BC4CEF5;
	Sat, 22 Nov 2025 22:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1763849775;
	bh=oJdmGsiGca/DIx/SjiqaVDSIgtR8inCTav2QsrGYsnI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aP/XIbRpSAXDDN74W5EaeT79d59eTeWrpONNYbuJxY47A6IOURTJuJDS/lcOqDMFJ
	 kLmg01OK1IHPznETCSTp6gTrZCInPoI9U3cnZCndSAEGo9eB/CuHQmvOeNt67yrPrZ
	 ty04hbqr2KmmVv3VlLRbNS6ArXo29SI61ReubVpA=
Date: Sat, 22 Nov 2025 14:16:14 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Kees Cook <kees@kernel.org>
Cc: Bill Wendling <morbo@google.com>, linux-kernel@vger.kernel.org,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Justin Stitt <justinstitt@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Heiko Carstens <hca@linux.ibm.com>,
 Marc Herbert <Marc.Herbert@linux.intel.com>, Uros Bizjak
 <ubizjak@gmail.com>, Tejun Heo <tj@kernel.org>, Jeff Xu
 <jeffxu@chromium.org>, Michal =?ISO-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Thomas =?ISO-8859-1?Q?Wei=DFschuh?=
 <thomas.weissschuh@linutronix.de>, John Stultz <jstultz@google.com>,
 Christian Brauner <brauner@kernel.org>, Randy Dunlap
 <rdunlap@infradead.org>, Brian Gerst <brgerst@gmail.com>, Masahiro Yamada
 <masahiroy@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 linux-mm@kvack.org, linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 2/2] memblock: annotate struct memblock_type with
 __counted_by_ptr
Message-Id: <20251122141614.80f1a845cd694b1b470107ca@linux-foundation.org>
In-Reply-To: <202511211525.05CB7E1AEC@keescook>
References: <20251121193957.1655580-1-morbo@google.com>
	<20251121193957.1655580-3-morbo@google.com>
	<202511211525.05CB7E1AEC@keescook>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Nov 2025 16:30:43 -0800 Kees Cook <kees@kernel.org> wrote:

> On Fri, Nov 21, 2025 at 07:39:44PM +0000, Bill Wendling wrote:
> > Add the '__counted_by_ptr' attribute to the 'regions' field of 'struct
> > memblock_type'. The 'regions' field is an array of 'struct
> > memblock_region' and its size is tracked by the 'max' field, which
> > represents the total number of allocated regions.
> 
> As part of any counted_by annotation patch, there needs to be discussion
> in the commit log about how it's been shown to be a safe annotation
> to make. e.g. in this case, if all allocations of "regions" have a
> corresponding "max" assignment, etc. If just "git grep" can't find them
> all, using something like Coccinelle or CodeQL to search for struct
> memblock_type::regions assignments can work.

How is anyone to know these things?  I can't find anything about this
in include/ or Documentation/ or in the relevant commits.

There should be a comment at the __counted_by() definition site, please.

And possibly write a Documentation/ file then change checkpatch to
direct people to that file if they add a counted_by?


