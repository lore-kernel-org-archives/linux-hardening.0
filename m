Received: from forward501b.mail.yandex.net (forward501b.mail.yandex.net [178.154.239.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07382FD698;
	Wed, 18 Feb 2026 13:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771422041; cv=none; b=O+iVUVW1T1tJ9z1Kkz3rbsXEUc7W6IsMGaDOHlC4vdzAcKFhQ7DWhPPZ3ou4/b5d5RjcY7dznIJ1TBsoAmnLJFL78jpYTXABN0rMZDlOYenjpqxfgKuKGonhz0M1UhJFij8MuRRQV8K+IbvOSttR+lS2kJGTLJpjblueM+b/El0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771422041; c=relaxed/simple;
	bh=JzXeul7hrLHJEyXVuNdFfdj6AUqmHyErDXCENhN9W1g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YvhEdVtL8LFdeBN+l0PI5slzlmJwBDEBS5O6RIL9GMkjnQQgo9tCXVcidRR7ujhbP1PVgT5zNWj1dsGs6ACWorasUFxfAoEPyQcsKaddNoH6yHGaGP0LOnXcamciYubX87pXxEBorVIgxrSMas2gj+uDPWxlvqRwikZGewisFoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=ZjVcGL3R; arc=none smtp.client-ip=178.154.239.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="ZjVcGL3R"
Received: from mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net [IPv6:2a02:6b8:c11:e97:0:640:f294:0])
	by forward501b.mail.yandex.net (Yandex) with ESMTPS id 872BE89C47;
	Wed, 18 Feb 2026 16:40:30 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id Sea3lbMGFa60-YCPLBxWD;
	Wed, 18 Feb 2026 16:40:29 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1771422030; bh=JzXeul7hrLHJEyXVuNdFfdj6AUqmHyErDXCENhN9W1g=;
	h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
	b=ZjVcGL3R7bx2RRPMRmuw1vTAzDSUCjONX00aMnML2AQGLBdThqK6U8m4NQu3TDoRL
	 N3vF6VkPmpBtr9/b75ZN3VfPskv5HZtsw5QgpwocfoRYhKE/KD+JM0hooH2H1/r1+C
	 rQx7Vy5ZtyJ1oVqFvFEStiGqrCVjFR36pB3YVWwk=
Authentication-Results: mail-nwsmtp-smtp-production-main-70.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <87799485ed44bf023f0e1a7ed67f2e5268763c73.camel@yandex.ru>
Subject: Re: [PATCH v8 0/5] lib and lib/cmdline enhancements
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Andy Shevchenko <andriy.shevchenko@intel.com>, Andrew Morton
	 <akpm@linux-foundation.org>
Cc: David Laight <david.laight.linux@gmail.com>, Kees Cook
 <kees@kernel.org>,  "Darrick J . Wong"	 <djwong@kernel.org>,
 linux-hardening@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Wed, 18 Feb 2026 16:40:28 +0300
In-Reply-To: <20260212164413.889625-1-dmantipov@yandex.ru>
References: <20260212164413.889625-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-02-12 at 19:44 +0300, Dmitry Antipov wrote:

> Adjust '_parse_integer_limit()' and 'memparse()' to not ignore
> overflows, extend string to 64-bit integer conversion tests, add
> KUnit-based test for 'memparse()' and fix kernel-doc glitches
> found in lib/cmdline.c.
>=20
> Dmitry Antipov (5):
> =C2=A0 lib: fix _parse_integer_limit() to handle overflow
> =C2=A0 lib: fix memparse() to handle overflow
> =C2=A0 lib: add more string to 64-bit integer conversion overflow tests
> =C2=A0 lib/cmdline_kunit: add test case for memparse()
> =C2=A0 lib/cmdline: adjust a few comments to fix kernel-doc -Wreturn warn=
ings

Any chance to move forward with this?

Dmitry
