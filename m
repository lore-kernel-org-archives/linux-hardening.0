Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB83E476CCD;
	Thu, 27 Aug 2026 13:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787837134; cv=none; b=HhmOJR+vb/tNPHXscr+UApbTVtDAVAev6JVo3RmOrGbCM3EV8Hi5esDdIqkVKhrwOC+214qZp2CnSz6vBsHwURpVVo1hfObMEk8oef3PADfBJtr3sD3fGVamBHWdnlrcKRfajIHWRuRddYGbEE/dt/DMjjOPuRKjLoawn+CQ8WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787837134; c=relaxed/simple;
	bh=Bhg7JSisuGW0vSc6QK8z6aLaMXzSe/JxqXrV5j7guJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PJHqVDlsH+s9YKSQEyLN3oYrfqH76mn7fbrwPt8qKcPrzGrv7uk9QHGyK/cd9o+6ZraPeRzE8CnIXIB9vxT/+3gS1p2Zy5G8X/jst68k/iq7V5UHMv72SiujQO213Z3f9IVUfKSQtJudbOQUbXUOkWzo0KL717jISJv48Zpvaug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sITvsyFH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TqgolZg+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sITvsyFH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TqgolZg+"
Date: Thu, 27 Aug 2026 15:25:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787837118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vpxPpFcIUXLpr1YWo5DMhI8Cj0ygkTCS3zMybRqUN1I=;
	b=sITvsyFHEVYbjVig0X8wk6Zt5diIRvz0EMccuNLqTiEpQ9H9CuWL2IwgjeGTlSjd0MdNFK
	boUQ9MtyMZS0hVDDQDuZgEf9zNMEPeRnuIb5pj13G6+5iySUQY75wYyOryj6IPuC0vzJuJ
	6XPNWXxGiNuDur9iuCsPjGCLSuhtDtDfKoJJJjwJNMUDODgFOxyBmcnEZ4ZaEK4h60jNIs
	Mu+s0qQqE3YX244nUVsLCl/cnyHYFcjiLamK1CR3vKi6zuoZFn4ORbWL1jikUG3QFqU1vF
	r1+/0LoCYi9Ssg6e/Cko72HCqE+l136xiMkFvwGlJrNu4E9LnSNKF3DMgkqjRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787837118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vpxPpFcIUXLpr1YWo5DMhI8Cj0ygkTCS3zMybRqUN1I=;
	b=TqgolZg+C6B1DUSg4A6qBGqFJ5SlgvZxIEq8O7OOMx8SeiQ0SvcYNKgFGYevY9+wfLLVcC
	jeMOaNuztg2FDhCw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Bill Wendling <morbo@google.com>
Cc: linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Aleksa Sarai <cyphar@cyphar.com>, Jan Kara <jack@suse.cz>, Nathan Chancellor <nathan@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>, Gary Guo <gary@garyguo.net>, Alice Ryhl <aliceryhl@google.com>, 
	Douglas Anderson <dianders@chromium.org>, Anand Moon <linux.amoon@gmail.com>, 
	Oleg Nesterov <oleg@redhat.com>, codemender-patching+linux@google.com, 
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/2] userns: Add KUnit test suite for uid_gid_map
Message-ID: <20260827152113-4e14b134-4385-4e4c-b3ef-a45cb8b781e3@linutronix.de>
References: <20260823125155.1136740-1-morbo@google.com>
 <20260823125155.1136740-3-morbo@google.com>
 <20260824080214-8b12767a-8b04-4344-b48a-cd2966ad36de@linutronix.de>
 <CAGG=3QUCowcrBT-7ZUyOOrX5fjQtFSmRyqvnYkZX0tO9+MKp+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGG=3QUCowcrBT-7ZUyOOrX5fjQtFSmRyqvnYkZX0tO9+MKp+g@mail.gmail.com>

On Wed, Aug 26, 2026 at 01:40:03PM -0700, Bill Wendling wrote:
> On Sun, Aug 23, 2026 at 11:13 PM Thomas Weißschuh
> <thomas.weissschuh@linutronix.de> wrote:
> >
> > On Sun, Aug 23, 2026 at 12:51:48PM +0000, Bill Wendling wrote:
> > > Add a KUnit test suite to verify the insertion and sorting of mappings
> > > in struct uid_gid_map. This test suite validates both base extent
> > > insertion (<= 5 mappings) and extended extent insertion (> 5 mappings,
> > > which triggers the allocation of the forward and reverse pointers).
> > >
> > > This is especially useful for verifying that the __counted_by_ptr
> > > attribute added to 'forward' and 'reverse' pointers works correctly
> > > without causing any runtime bounds-checking panics or traps.
> >
> > AFAIU patch 1 is supposed to not change any behavior.
> > You could move the unit test to the front to make that clearer
> > and also validate it.
> >
> Patch 1 generates code to assert if a memory address outside of the
> bounds of a pointer is accessed. So it does change the behavior.

It should not change the behavior observed by a well-behaved caller.
And the test only simulates such a well-behaved caller.

> Should I still move the test case?

I think so. At least if you resend the series anyways.
Make sure to also run the test before your other patch is applied.

> 
> > > Assisted-by: Gemini Next
> > > Change-Id: If0c2c197a35cd7429cf0d2d6e3b33f0d9f0be66c
> >
> > Change-Id should not be used upstream.
> > See Documentation/dev-tools/checkpatch.rst.
> >
> I had removed it in v2. :-)

Thanks!

(...)
