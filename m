Received: from forward502d.mail.yandex.net (forward502d.mail.yandex.net [178.154.239.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8020838F257;
	Thu,  5 Feb 2026 09:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770282267; cv=none; b=cQPW0BDXWQMCbNh+GOvfmRFMToMmWnw1bVePJbmIpaI08UraIazUOsePJnjjAkih1eUJRHdM95pKMVZ0yKVn+IyoFZCXWmOy23nBEr1UVMF4IB1LT/uj1SMKzIVsFoS8wk5QZlfKwUvbyKfYNsQB+E6PCAJvxD27ycYE8FTYRd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770282267; c=relaxed/simple;
	bh=u2u1hmtp4i+IFuIf7RAtOB68qlWZ1GapEORoeGFMTwQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NVaf7oNV70+oP/g3Ife+zRrdzDZ7K/wWDkLG6yx1uXBFzA6/GF6AqdVeQpPYgt87dQEJlWEzEjVEjxhZNFzJxzpPXUnXcjzMK9rpi3aX192+NUhDVYzdBaRHjSOoYYkdMwsQ11d6pvKQyW4VIyZvkKA9rIvr0KkUC9jOD6ZgOiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=RvGuVXEF; arc=none smtp.client-ip=178.154.239.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="RvGuVXEF"
Received: from mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:3cca:0:640:f0e1:0])
	by forward502d.mail.yandex.net (Yandex) with ESMTPS id C9F9AC20B9;
	Thu, 05 Feb 2026 12:04:16 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id E4mtEm0GqKo0-KeiOziCb;
	Thu, 05 Feb 2026 12:04:16 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1770282256; bh=KBWeTthQA7tNjsoiGVOrPOVLjKWDwoVhUWSgVKGXVm0=;
	h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
	b=RvGuVXEFFx45CG4kkcl525JKMuuN9kteVEOCZmEs3PHr43QQnSnKxlFxaDti2Ct7v
	 x5OQh4JMq6iamk13R4wrUnj+nMcoE3/nMwkpx93ZLtg5F3FKRj61KfmSzJgbLtVIDs
	 tayKhUD1/lF+uXkVomqIUlUpBgIzMhWG2kdDE/Ng=
Authentication-Results: mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <c49751e8971a77c9847baad442ea7800e9d6e03f.camel@yandex.ru>
Subject: Re: [PATCH v5 1/5] lib: fix _parse_integer_limit() to handle
 overflow
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, 
 "Darrick J . Wong"
	 <djwong@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 05 Feb 2026 12:04:14 +0300
In-Reply-To: <aYNYOaiSfXFFe6Jc@smile.fi.intel.com>
References: <20260204135717.941256-1-dmantipov@yandex.ru>
	 <20260204135717.941256-2-dmantipov@yandex.ru>
	 <aYNYOaiSfXFFe6Jc@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-02-04 at 16:31 +0200, Andy Shevchenko wrote:

> In case you would need a v6, we can leave some of the lines untouched if =
we
> switch to for-loop instead of while, but it might make the for-loop quite=
 long.

Hmm...the for-loop might be:

for (res =3D 0, rv =3D 0; max_chars--; rv++, s++) {
        ...
}

and it makes _parse_integer_limit() a few lines shorter.

Dmitry
