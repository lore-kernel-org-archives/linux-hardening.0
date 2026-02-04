Received: from forward502d.mail.yandex.net (forward502d.mail.yandex.net [178.154.239.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA0F1AA7A6
	for <linux-hardening@vger.kernel.org>; Wed,  4 Feb 2026 11:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770204158; cv=none; b=YN31j/c13Mn94dsIef9aEBuS5VFmXb2pduvxpuuCPk+KIJKHGPBx/mAiS0n8XQOrJhpTNbqeu0YuFXEr3AwROyJbc+IQOsr1ajcsE1V6h43M6Jhz+ZFcIzzxuAEPnJdTyP1JUfFt0AaBVGaH3qYbaPVKFYNCe5b8OQm6syC2BB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770204158; c=relaxed/simple;
	bh=ZCVg0E+9KAAFYT435l6YgX++osPfqYAdusnd9TKCTHc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Poj15H/vEJm7QbW7Q5fV0ovKL3qINQyWCzwuKNI+7gUTBM5hw0mWP63ow5onPvp3lAP0gS5J/HhivRYuqUQKK/1KybXgJtSwgpVOqkn4z+SNGR1M4Df307rVl97KygehZcK/gl+pWvSSjqYN7mdT8x3QcFddWTAbracRaCkAuZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=X98rkqu6; arc=none smtp.client-ip=178.154.239.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="X98rkqu6"
Received: from mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:3cca:0:640:f0e1:0])
	by forward502d.mail.yandex.net (Yandex) with ESMTPS id 56B30C1FF3;
	Wed, 04 Feb 2026 14:22:32 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id UMn6WWNGtGk0-9n2znNXU;
	Wed, 04 Feb 2026 14:22:32 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1770204152; bh=3KhrBmHCgd0mJoVgZqg/uoTdd5CUq2MmXb+xDP0sGwQ=;
	h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
	b=X98rkqu6m/vFxKw4CTsCDwQOmXA+YLAFFPEdnCJ+ZS6T7BHvm7htW3qaXfCWlHf79
	 TdYxL3PJToY/M1o72b4UdfHYB8mH+fMVCYbRPnqno9NKOJ+YOSpO7wcAZbW4LqmsUB
	 uuMaMcxbQKnyWB9YxMCWWLvrgJViseWQt9EmsvC8=
Authentication-Results: mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <2755955ff36c1283aba1c9a854d85de533bcd24a.camel@yandex.ru>
Subject: Re: [PATCH v4 1/4] lib: fix _parse_integer_limit() to handle
 overflow
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, 
 "Darrick J . Wong"
	 <djwong@kernel.org>, linux-hardening@vger.kernel.org
Date: Wed, 04 Feb 2026 14:22:30 +0300
In-Reply-To: <aYKJBZRwQe3llJlW@smile.fi.intel.com>
References: <20260202115451.290173-1-dmantipov@yandex.ru>
	 <20260202115451.290173-2-dmantipov@yandex.ru>
	 <aYKJBZRwQe3llJlW@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-02-04 at 01:47 +0200, Andy Shevchenko wrote:

> > +			} else
> > +				res =3D res * base + val;
>=20
> Formally this should be } else { ... }, but I'm not going to insist.

No problem since there will be v5 with one more overflow detection
quirk around memparse() :-).

Dmitry
