Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58496218592;
	Mon, 28 Sep 2026 08:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790584194; cv=none; b=d3d5605c4GxN/ooe/ufWFpowVm80vPc6QxDnpgvOLdXs0PPJRYMEXUYI3g532axrXcIFJ89fcwhYoIERZvojhBjD4F7GtjVD/CVTe8I5xO+iqrKVm4kIa5Ba62jT2+Z7tUY69N4qLYat3o1svuGDlpSO0BWRiBdokAVs/tqzgEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790584194; c=relaxed/simple;
	bh=lPgY0OX2361XcCtAX56rWcvG1KCkVjI4PrpEC+nDM3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7m3bCTOPa/urznPz0GRTJVEE5owYYgK9nnJR+WkghwWDFR1Ya8g75b6jAJHEEHL40a9pfzZ/1lYAMyadoW+HG16tnl7P6PpPjENS+aSZUROgEzkAj7WPlGfrfL8nC0++JkMU3okRW5WRoWfH/wIPKHMR3e98HsO3j/rKttGKkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fsVvxdTE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IGyhlSa+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fsVvxdTE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IGyhlSa+"
Date: Mon, 28 Sep 2026 10:29:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1790584191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lPgY0OX2361XcCtAX56rWcvG1KCkVjI4PrpEC+nDM3w=;
	b=fsVvxdTEB7rvAJoJAplF2ONYu+C4T1ZUVXgqcqQtPwk1tQJJiaFHJKogITDOpf5YWDeLr3
	xQudJRHRGuV36Uq3ALyluIOGeNy49aB7hg1Zif9Fy/3yDjx+mNns5uqXQnXBZrMZs6Wvsw
	GHIzHMPCvEeAlPReNMVDFRkxQBWre7tBI7EQ/IV9I1D7R7AswqCSoSdBQqQr/kGrdtZAuE
	26ejtT7tJ9GHecg9hEcPV9MRgo0CNQEHRe2tkOdqZ7/lC7v9zMsS5Gyhl4tnHnKq2hTv2d
	CC5azOpBcpza3VQal2ABjCkXwyWGp3BOg7j3MW1A142DePwrwa54TL7S7gzMdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1790584191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lPgY0OX2361XcCtAX56rWcvG1KCkVjI4PrpEC+nDM3w=;
	b=IGyhlSa+Ce/L0Up8OJsQFD06YDqiqM2IsqUVvRsKygzDSHOPKFA2QaNjSmWq5RO0HcNsz6
	6bmifjpyKghPd+BA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Bill Wendling <morbo@google.com>
Cc: linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>, 
	Ryota Sakamoto <sakamo.ryota@gmail.com>, Kuan-Wei Chiu <visitorckw@gmail.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Dmitry Antipov <dmantipov@yandex.ru>, 
	Petr Mladek <pmladek@suse.com>, Kir Chou <note351@hotmail.com>, 
	codemender-patching+linux@google.com, linux-hardening@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com
Subject: Re: [PATCH 2/2] lib/tests: Add KUnit test for struct stack_trace
 __counted_by_ptr attribute
Message-ID: <20260928101929-4f53f80d-7194-434e-bbd6-ee6f5838ac4f@linutronix.de>
References: <20260823123549.1120133-1-morbo@google.com>
 <20260823123549.1120133-3-morbo@google.com>
 <20260824083538-d0eff358-e1d4-4af6-9e61-d4d816783266@linutronix.de>
 <CAGG=3QXojhEsqvk-L5vT3w37z_VO+p1=8vrJCJ44sTz_V-YRGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGG=3QXojhEsqvk-L5vT3w37z_VO+p1=8vrJCJ44sTz_V-YRGg@mail.gmail.com>

Hi Bill,

sorry for the long delay.

On Thu, Sep 10, 2026 at 12:48:51PM -0700, Bill Wendling wrote:
> On Sun, Aug 23, 2026 at 11:41 PM Thomas Weißschuh
> <thomas.weissschuh@linutronix.de> wrote:
> >
> > On Sun, Aug 23, 2026 at 12:35:33PM +0000, Bill Wendling wrote:
> > > Add a custom KUnit test suite 'stacktrace_counted_by' to verify that the
> > > __counted_by_ptr annotation on the 'entries' field of 'struct stack_trace'
> > > behaves correctly.
> >
> > The implementation of __counted_by_ptr should be tested by a dedicated unittest
> > for that feature. And I am fairly sure that already exists. It should not be
> > tested in random subsystems.
> >
> I'm looking at `tools/unittests` and...what in the world is it
> supposed to be testing?

This seems to be testing the documentation generator.
An assumption which is corroborated by 'git log'.

> It looks like it's testing absolutely nothing of substance.

Debatable...

> I assume you want there to be a test that runs and
> produces a stack trace triggered by an invalid access, right?

Correct.

> I'm unable to find any tests in `tools/unittests` that do anything like
> that...maybe I'm missing something?

Look for KUnit tests instead. For example lib/tests/fortify_kunit.c.
Or non-KUnit tests in lib/test_fortify/.
Or LKDTM tests in drivers/misc/lkdtm/.

Also see Kees' recent message about testing traps with KUnit [0].
Apparently it is not so easy to test this from KUnit. But your proposed
stack_trace-specific test would have run into the same issues.


[0] https://lore.kernel.org/lkml/202609041620.81446C2A@keescook/

(...)


Thomas
