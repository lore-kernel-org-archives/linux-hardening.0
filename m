Received: from forward500a.mail.yandex.net (forward500a.mail.yandex.net [178.154.239.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70F8198A17;
	Thu,  5 Feb 2026 09:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770283517; cv=none; b=LxHD+Fv/MCbHx7nTkRuqcrwpI7fmaXw2FfaF8bAInzHZ74cz76ZPZNM2klb6ex7YLWednSyp5CpPQXjI3pNDOB3a05oRat+yWf2FWtcw45FL2bhiTeWJoDNchgejmfv9jUAnlMtBrAN7mXf8dsLCiNwDasKFEggihQxePi8Wp98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770283517; c=relaxed/simple;
	bh=ju2wstuYIJqo+Q8x+eeHR5r7AVTa0IykUAC1G57tM9w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MNkkocAt3PxxoM0Ia9hWl4O7JTj4XgLXHVQ6X6c/3u9v02mGNiR+HH2zwntfqdwCsNdTzWa3QicTYuJWlFuKbLPBXgEi2EEH82fbOQ4zPhLIW5TUTa2GbveRk35ezupbBuNrC+IJmskj9pRmqCrO9uG6BFOASkWwTV88nk4tQCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=SxHqp4uB; arc=none smtp.client-ip=178.154.239.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="SxHqp4uB"
Received: from mail-nwsmtp-smtp-production-main-97.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-97.vla.yp-c.yandex.net [IPv6:2a02:6b8:c15:2804:0:640:a3ea:0])
	by forward500a.mail.yandex.net (Yandex) with ESMTPS id EC350C0F98;
	Thu, 05 Feb 2026 12:17:18 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-97.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id GHmH0o0GFqM0-fsA9Nxun;
	Thu, 05 Feb 2026 12:17:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1770283038; bh=LkxviVhcV60DhQiy80KOn2bfwDYHzucr7Gms/qqMo6s=;
	h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
	b=SxHqp4uBWJ1Y9LlKOedYfRGTtTuyStvmHIU4nSYqMnr9AA2Syo3rmWwNuqHv54nvF
	 OjlGTwTY6TnrRzQC+EcJJRQcaFUdFZT6zdFT0lC3xmVFPrk5tk2T1tfdqeepdi2rv7
	 qZdbm7Q6mnd3rLfNiw0hm6v9N9oxT4a3kUdOYWEc=
Authentication-Results: mail-nwsmtp-smtp-production-main-97.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <bd627279346a8eb8096371c899325ccfc6fd07d7.camel@yandex.ru>
Subject: Re: [PATCH v5 2/5] lib: fix memparse() to handle overflow
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, 
 "Darrick J . Wong"
	 <djwong@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 05 Feb 2026 12:17:16 +0300
In-Reply-To: <aYNa5ZBcA_pJqS7Y@smile.fi.intel.com>
References: <20260204135717.941256-1-dmantipov@yandex.ru>
	 <20260204135717.941256-3-dmantipov@yandex.ru>
	 <aYNa5ZBcA_pJqS7Y@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-02-04 at 16:42 +0200, Andy Shevchenko wrote:

> On Wed, Feb 04, 2026 at 04:57:14PM +0300, Dmitry Antipov wrote:
> > Since '_parse_integer_limit()' (and so 'simple_strtoull()') is now
> > capable to handle overflow, adjust 'memparse()' to handle overflow
> > (denoted by ULLONG_MAX) returned from 'simple_strtoull()'. Also
> > use 'check_shl_overflow()' to catch an overflow possibly caused
> > by processing size suffix and denote it with ULLONG_MAX as well.
>=20
> Do we have already test cases to cover this?

In

static const struct cmdline_test_memparse_entry testdata[] =3D {
        ...
        { "1111111111111111111T",       "",     ULLONG_MAX },
        ...
};

the whole string is valid and so should be recognized by memparse(). Next,
1111111111111111111 fits unsigned long long but 1111111111111111111 << 40
is too large and should be catched by check_shl_overflow().

Dmitry
