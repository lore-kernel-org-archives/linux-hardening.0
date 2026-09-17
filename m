Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB335478D;
	Thu, 17 Sep 2026 00:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789603490; cv=none; b=mwb3C0xCjRYJvZWLuqE6cmfDH7RUfznkrOQJl8wPHL0LdVM+tceA8RUpChDEnTPsmmqXo62TBo3m/0Mx/B+ySWOP9w7i9VDwWuQx8It6rD0+dnfCMWpGbkZyYaSZ873SFs3f35d3BE6AJ2KwyEgp+EIcuC4Z1gGshZmGEXuEDII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789603490; c=relaxed/simple;
	bh=0fYYtWZhEQ4A9EAW1416gUkQQFlbp4qX5PFsgcCK6PI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=QOASGPvajuv702eDn95ZEFBOYozSQqT9MfGVU51VfRQI97AObYpaOMJ+2xvPZm/tLplKHudMrg9ggZuXVsfSZ43XzolDn44Fz0CBBULrXqqT7hUz/EfkLt5yVx7hLHSOCalpChHJvKYJcYn11vM6+LYZQwXhgrjj/VGfZyPs5DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IUid807a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IUid807a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6660E1F000FF;
	Thu, 17 Sep 2026 00:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1789603488;
	bh=uCIjUjRLaVGP2XDD0J/r9CF8gUlKb8vWept+gWkz/3c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IUid807akAMj9giYI1VNN3jUlf90o8rH/bxv72li0B7+YudMoo6G/gPacmoAWLIqU
	 sSsTFnpN/9cVgBHeLuZnWzSaVHTq4Qc8LvJNXeWHBnYgMbAqKySSgafoNhU1T6j+IM
	 E7PCtQ7cEL7KOHvqCJ/dFib9AwAj/LlMNs/LEALc=
Date: Wed, 16 Sep 2026 17:04:47 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Jonas Rebmann <jre@pengutronix.de>, Kees Cook <kees@kernel.org>, Andy
 Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@pengutronix.de, Brendan Higgins
 <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, Rae Moar
 <raemoar63@gmail.com>
Subject: Re: [PATCH 0/5] lib/string_helpers: fixes and test cases for
 string_unescape()
Message-Id: <20260916170447.f8b7df928c7f8b6841adec0f@linux-foundation.org>
In-Reply-To: <20260916231336.GA2777429@google.com>
References: <20260916-string_unescape-v1-0-7f8bd986fa33@pengutronix.de>
	<20260916143623.3d144941ec17515f40c3561a@linux-foundation.org>
	<20260916231336.GA2777429@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Sep 2026 23:13:36 +0000 Eric Biggers <ebiggers@kernel.org> wrote:

> On Wed, Sep 16, 2026 at 02:36:23PM -0700, Andrew Morton wrote:
> > On Wed, 16 Sep 2026 19:38:05 +0200 Jonas Rebmann <jre@pengutronix.de> wrote:
> > 
> > > This series fixes two bugs in string_unescape() regarding the
> > > destination buffer length. Both fixes are accompanied with kunit tests
> > > which would fail without the fixes.
> > > 
> > > To make this possible, preparatory patches 1 and 2 improve and clean up
> > > testing helpers and 3 introduces test_unescape_one() which allows for
> > > targeted testing of the string_unescape() function.
> > 
> > Sashiko complains about uncheched kunit_kzalloc() return val.
> > 
> > 	https://sashiko.dev/#/patchset/20260916-string_unescape-v1-0-7f8bd986fa33@pengutronix.de
> > 
> > I wonder whether we really need the usual allocation-failure semantics
> > in kunit.  Can we just make the kunit memory allocation functions abort
> > on error?
> 
> FWIW, having KUNIT_ASSERT_NOT_NULL built-in to kunit_kmalloc() et al
> sounds good to me.  It's not clear to me why it wasn't done that way.
> Maybe so that assertion failures show the correct file and line number?
> But that can be solved by making them macros.
> 
> As-is, every test has to check for NULL, which is unnecessary
> boilerplate.  It's also resulted in test-specific wrapper functions that
> work around this, like alloc_buf() in lib/crypto/tests/test-utils.h.
> 
> If a fallible version is needed in rare cases, it could be underscored:
> __kunit_kmalloc().  But I'm not sure any test needs that.

Sure.  

Simply doing kthread_exit() when we're in the middle of something is
rather rude - it'll leak things.  I doubt if anyone cares about that much
if they're engaged in poking around with kunit tests.  otoh, small GFP_KERNEL
allocation failures are close to can't-happen.

One thought is to create a fake struct device in kunit, use
devm_kzalloc everywhere then get kunit_try_catch_throw() to release the
device.  Reuse the devm_ code's tracking and garbage-collecting
infrastructure.  But it just isn't worthwhile.  Make the kunit layer
say "ha ha, you lost some memory" and leave it at that...

