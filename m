Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FE31E5B8A;
	Thu,  6 Feb 2025 21:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738877305; cv=none; b=ZTU10g2VsdbqG6k5JQyHwjabftlluaKFJRG3+YWCd02myK0pr8Wdbn9YvY/QqetIHbrl4UU8IO6Ii2QAYcVKewIZeJXXdh23Sudf7kJ/vg4Q7OD1PtZqgCdkpxIVfpxfBHESSNDQC62rDGleu7p/8rtBMyWfM8nrFYGWo5W7+3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738877305; c=relaxed/simple;
	bh=uVh8uGRAZBQ0vpXQbrTzd5Jj4gN9gwG+MNzgNH/Rtx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MTGP4dI4qMgugxEZwz65k/7wbW+XaTBPi0b+ROf/9IZNRWjEaRgPGQb2qLFFSvVu95hPW8x+OsjvtWCfw8yjeBytth8q2z960hCB1DgFRWWT4xaBnPNOesiLl32fumsYX7zeyv8hi29zoRckB2Md1NWaQ1nsgIqEz5KHlKxuY2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pZgVGfvm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZgVGfvm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB53EC4CEDD;
	Thu,  6 Feb 2025 21:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738877304;
	bh=uVh8uGRAZBQ0vpXQbrTzd5Jj4gN9gwG+MNzgNH/Rtx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pZgVGfvmkCwTzjnrIGnGSpyqE0NGdENwsrMBvIHer49PNBzjSHHOw44M65YDfroEb
	 cgpDTc8Mc69rbRP/u6WC0ccQaYFbRUkjQqcZVdai5JDuOfKt4yGEHX1+AjJDBYRt8c
	 Rpg3bemhkVcKCMgd4o5CeZM51RWcUdOQeqm8F0ZbxjiI8EtaoEHYVC4QJ11H41GZ1Z
	 8SMIQGUJh3ledOuS5CjYe76hjpy0nhP8gkdviCNtAiqnn5KS1wgQj1gsZE9DaJDRJ4
	 zHLKqwAgLbMHtcQPlw8RbfkUxldKQVEzXH8eWjaxM4o0NGuI44y1/MVASU8CsOIx4o
	 M6oKXxMFq7ZvA==
Date: Thu, 6 Feb 2025 13:28:24 -0800
From: Kees Cook <kees@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Andy Shevchenko <andy@kernel.org>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 1/3] compiler.h: Move C string helpers into C-only kernel
 section
Message-ID: <202502061327.C82D5D8B0@keescook>
References: <20250206175216.work.225-kees@kernel.org>
 <20250206181133.3450635-1-kees@kernel.org>
 <CANiq72nmAKa4rHsk0s1iqY77T-0MEyA8UJv1y=w9vFQ79FBxSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72nmAKa4rHsk0s1iqY77T-0MEyA8UJv1y=w9vFQ79FBxSw@mail.gmail.com>

On Thu, Feb 06, 2025 at 09:07:05PM +0100, Miguel Ojeda wrote:
> On Thu, Feb 6, 2025 at 7:11 PM Kees Cook <kees@kernel.org> wrote:
> >
> > The C kernel helpers for evaluating C Strings were placed outside of the
> > assembly ifdef. Move them to the correct place so future changes won't
> > confuse the assembler.
> 
> This moves it also into the kernel ifdef too -- I assume that is
> intentional. (Perhaps mention ifndef instead of ifdef?)

Right, yeah. I guess I only mentioned that in the Subject. I'll clarify.

> 
> I checked that this is indeed a pure move, so:
> 
> Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

-Kees

-- 
Kees Cook
