Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6542DA74C;
	Wed, 16 Sep 2026 21:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789594588; cv=none; b=mXiqcQe541ww+D5a+3dvhxGxNdLe/8QeYtw0c9Xgk3PUu9+QExU+kl7LYYsj6Lch3zhtVUwkTvoMtes603LpowW3dRcXR78xLaz2h3jWOAApUF0ZAkJiZN/1vANvEem0hgcQsy6tw8qOu6pDyOo7HfAPrloyE6qdIciC/zGeLcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789594588; c=relaxed/simple;
	bh=7qNl+fT2/HL6DeHHvaOji4sNENw9rD34MvYmX1mnpI0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ibJhgRF1DtZ7hvbb6yBGKKWR1ZK4/xjRVZxPKvg38PNjKopWyx65GKXHPj1DmROfIOSSGQ8sX1fqFC2l4Zp6zAcp1hsREqaMLRdHScHt5rEtUnp/yMYukH77yNxq5IbkZdxL4znnhDmK0wGhLdSOkilGzGDFaOnWwreQ9sGyGIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=z8qt1Ati; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="z8qt1Ati"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B09971F00893;
	Wed, 16 Sep 2026 21:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1789594584;
	bh=AioWpP6nPDrIeQmM9fcqoDPKslgpy1K+wzeFDFFB6N0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=z8qt1Ati+PeUehcg0IVG2CvGHEwgKZOEOeVdcbGDeVlLqhd8UBGtsrALI5yN1PLdy
	 iKGkv+71tqLAfCaNRsT9ZIfVx7T7pjNehk3UWrFULcfLnBrh0WtAK6XWhnWCaryEvN
	 eLbhivcB6CIGxhKEr8kOFUVGyXwiZ3VgPox8dsH8=
Date: Wed, 16 Sep 2026 14:36:23 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jonas Rebmann <jre@pengutronix.de>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@pengutronix.de, Brendan Higgins <brendan.higgins@linux.dev>, David
 Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>
Subject: Re: [PATCH 0/5] lib/string_helpers: fixes and test cases for
 string_unescape()
Message-Id: <20260916143623.3d144941ec17515f40c3561a@linux-foundation.org>
In-Reply-To: <20260916-string_unescape-v1-0-7f8bd986fa33@pengutronix.de>
References: <20260916-string_unescape-v1-0-7f8bd986fa33@pengutronix.de>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Sep 2026 19:38:05 +0200 Jonas Rebmann <jre@pengutronix.de> wrote:

> This series fixes two bugs in string_unescape() regarding the
> destination buffer length. Both fixes are accompanied with kunit tests
> which would fail without the fixes.
> 
> To make this possible, preparatory patches 1 and 2 improve and clean up
> testing helpers and 3 introduces test_unescape_one() which allows for
> targeted testing of the string_unescape() function.

Sashiko complains about uncheched kunit_kzalloc() return val.

	https://sashiko.dev/#/patchset/20260916-string_unescape-v1-0-7f8bd986fa33@pengutronix.de

I wonder whether we really need the usual allocation-failure semantics
in kunit.  Can we just make the kunit memory allocation functions abort
on error?


