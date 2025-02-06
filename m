Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441A01A256E;
	Thu,  6 Feb 2025 18:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738867940; cv=none; b=aQ09dAMZa0yD0L+I11CW7xZJkDGqESbkr0zK/p0+ux/R3kQ3ijk4Gmg3zW3Lylucr7id+j4YiSAvJx5tnW/oKmjdLDccXQ3sbeSdRgDLdOcVGYefMuw9Q/Ngbu8HTDB6ba47APtwJVJUIk0mPnQoHeALzaRiHdVEJ6vrIQyxugA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738867940; c=relaxed/simple;
	bh=PYqpdjb3pm4kXVwX/G7U2wilgc0uN1LJbAA0nKyUDbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=noFRSV4Yrg61oQoe3QV1hpMjHPSZTPgK9KnTla8qatmdznxIVIxQeDyG2+x4RItVm50cFvTKwdaUYlbAwhI73bb8YOpICl6ommK3okyZx59xW3FpehXOZz9gF/I1hl0ShHZ92KoJSPXGOuBiu3qfsT5qWMfGwZ9EBVOxsv1f2Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TlGPb+U+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TlGPb+U+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9695FC4CEDF;
	Thu,  6 Feb 2025 18:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738867938;
	bh=PYqpdjb3pm4kXVwX/G7U2wilgc0uN1LJbAA0nKyUDbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TlGPb+U+r3kCa87x7+sMSHeMSICA4IQJzF0t8VY6fE1gP+KFQwahsrQzZA20aM7nG
	 bbqjwdlw1YhsjPZKNqhFPtSlSYtGO+qgI6+OLstGdgwxCgDAxBTejI6aGuva0TeJFR
	 yW/rYBhl93dq7E6orZ/tHc/vg9ynIlgnhzATCs4xeE1bL0ZIbVqG0DtxgXRDFZtN4j
	 Umz0dKBcKGetbO6yTWUivH7dTcDK9p4w1B7OGIe++JZtFOeuKUP6zLZAzc9wwrQEms
	 BdAhp0F6mKdcY478chy3NjV9sVtCjbvnJQa+iFPz6mKIkfWimYUKBi5SV01paExQOE
	 JJaQT1I0eQ8GA==
Date: Thu, 6 Feb 2025 10:52:18 -0800
From: Kees Cook <kees@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Suren Baghdasaryan <surenb@google.com>,
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
Subject: Re: [PATCH 0/3] string.h: Use ARRAY_SIZE() for
 memtostr*()/strtomem*()
Message-ID: <202502061050.EC48F506B1@keescook>
References: <20250206175216.work.225-kees@kernel.org>
 <CAHp75Vf=84tWvv57Kj5A5bLenQSkC5yDHTHy-u0iK1_U87nvBw@mail.gmail.com>
 <CANiq72kGUOgP60SaEwiBcgsDJnjdvJZ1VJtyf3a_+sQJjiffng@mail.gmail.com>
 <CAHp75Veo-C3A+XVr1RuFumoULWNOugN+CFE65d1T5o+TZSmw-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Veo-C3A+XVr1RuFumoULWNOugN+CFE65d1T5o+TZSmw-g@mail.gmail.com>

On Thu, Feb 06, 2025 at 08:45:41PM +0200, Andy Shevchenko wrote:
> On Thu, Feb 6, 2025 at 8:44 PM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > On Thu, Feb 6, 2025 at 7:42 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > >
> > > What's the minimum Clang version we build kernel with? 12?
> >
> > 13.0.1 for most architectures according to `scripts/min-tool-version.sh`.
> 
> Okay, does it mean 13 has no such a bug?

It probably did, but Clang 13 didn't support compile-time error messages
(added in 14). Regardless, this fixes it there and makes the API more
robust.

> Otherwise the commit message and other comments might be clearer...

How should I rephrase things? I mention the bug and when it was fixed
in patch 3:

  ...
  benefit of working around a bug in Clang (fixed[1] in 15+) that got
  ...

-Kees

-- 
Kees Cook
