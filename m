Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E20B479877;
	Wed, 16 Sep 2026 23:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789600423; cv=none; b=hmINJUKoZuZ5yA00oCSKbLJwl7w6V3GrLFZbu/kDnxMyCbrdmqP2aCqpBpC3XZ9s1JlsqGCY8t4q+EyZTwTVVCZXkvoV62tzKWNTmECWXkGSFyq5q/K54DUMVhUdMxxJ0GaaQB07mCC6/NteMDu8ZEHaF/3Hgz3HLzBgA2qOf8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789600423; c=relaxed/simple;
	bh=yhEFEiKEmGgaq+9fp3+BC4jWp1bDYwlsupldy1BeHvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HNEf600ugKSX3dJnp9Hc3g/iYnNR/9c3TPYio47FjBGW46E90Ihk7YMYTIu0KbgbrBuPhhXr7zO5S1wbaOrdmQaN9/CnUDrWfRD/jR4HXLPS+UORq2p0yrrOAQG5jCQt4nUsmcsSkcZAD5d4olDUWU5tnOfCS6wUBUkJbSnV/DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GB0WqpY5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GB0WqpY5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC4A11F00893;
	Wed, 16 Sep 2026 23:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789600418;
	bh=tsfQcKYYzqD9FbWkpVVJVOyrhjtyKkDEvZ7QksEXMHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GB0WqpY5Rn/5NdNyZeMX/kRpoNek3RUFEsZt0dPo/3QjSsMB6kCJx/P/kf80FuwAn
	 D4wg3PlrqgJmMgg+suJE12iFk/4EtZE1aD7JFIxy5mBvKQfAt0ZiDH9K49wNoUXIhz
	 oTyULazznlnIxracNw2XiMxGdaZWoZkidgu7l/mxwXBwBFO5yWtE430yjoVu5qEavQ
	 5Z3TE1SvPnZOlc+4QZXgnfDHntnZSI3SoK1oNq3DhNlAEM7Ae1WmxgTriI2OWxpLTq
	 TFuWrqXNmCidS70Alff4akwwIKxp52N/KPdEgvYPuLunKoe0+C0d7HzyRdDqfsr774
	 VRBVM4G45/Z5Q==
Date: Wed, 16 Sep 2026 23:13:36 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonas Rebmann <jre@pengutronix.de>, Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>
Subject: Re: [PATCH 0/5] lib/string_helpers: fixes and test cases for
 string_unescape()
Message-ID: <20260916231336.GA2777429@google.com>
References: <20260916-string_unescape-v1-0-7f8bd986fa33@pengutronix.de>
 <20260916143623.3d144941ec17515f40c3561a@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916143623.3d144941ec17515f40c3561a@linux-foundation.org>

On Wed, Sep 16, 2026 at 02:36:23PM -0700, Andrew Morton wrote:
> On Wed, 16 Sep 2026 19:38:05 +0200 Jonas Rebmann <jre@pengutronix.de> wrote:
> 
> > This series fixes two bugs in string_unescape() regarding the
> > destination buffer length. Both fixes are accompanied with kunit tests
> > which would fail without the fixes.
> > 
> > To make this possible, preparatory patches 1 and 2 improve and clean up
> > testing helpers and 3 introduces test_unescape_one() which allows for
> > targeted testing of the string_unescape() function.
> 
> Sashiko complains about uncheched kunit_kzalloc() return val.
> 
> 	https://sashiko.dev/#/patchset/20260916-string_unescape-v1-0-7f8bd986fa33@pengutronix.de
> 
> I wonder whether we really need the usual allocation-failure semantics
> in kunit.  Can we just make the kunit memory allocation functions abort
> on error?

FWIW, having KUNIT_ASSERT_NOT_NULL built-in to kunit_kmalloc() et al
sounds good to me.  It's not clear to me why it wasn't done that way.
Maybe so that assertion failures show the correct file and line number?
But that can be solved by making them macros.

As-is, every test has to check for NULL, which is unnecessary
boilerplate.  It's also resulted in test-specific wrapper functions that
work around this, like alloc_buf() in lib/crypto/tests/test-utils.h.

If a fallible version is needed in rare cases, it could be underscored:
__kunit_kmalloc().  But I'm not sure any test needs that.

- Eric
