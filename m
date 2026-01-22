Received: from forward500a.mail.yandex.net (forward500a.mail.yandex.net [178.154.239.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D866315D52
	for <linux-hardening@vger.kernel.org>; Thu, 22 Jan 2026 15:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769094449; cv=none; b=RW9rOMn0cQ/pdA+hKoSFdtLq3q6wPyz5O9X442S7hQifu/6g2OqvF4/l7kPwfz0Q8cRmiiqJ2F9L6lJm6rhNhOYGS/mmDt3pDA9mtizvgMqxENcrV+OmMw8vXUQF8GJeT+36RLJIgGaNTN5Zrv9pJUt9X0s5NaY9aJT3Ho0ZObU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769094449; c=relaxed/simple;
	bh=D9w24wPMtHrGLx4+zSY8RPUcdFId67Ud6KuDJrqaOkg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H/U48vkWpkMNEyFhSkfUp0CVXzTcqxXnZYYQZyRHlw9Lv0/4ygEhG8kSqdzv1jXXX6vkITu/fGxgVNJMtm3f69zDzeOrjWMc1Mhv4lCNuFjhqGmCJYflSbHk4h4J1FbAciOEw1ic7HrmGxr+dA8qKfEVxLqDruFuBtuc/Llh6QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=VwvdCeF6; arc=none smtp.client-ip=178.154.239.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="VwvdCeF6"
Received: from mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net [IPv6:2a02:6b8:c18:3e07:0:640:a874:0])
	by forward500a.mail.yandex.net (Yandex) with ESMTPS id CF6D4C1096;
	Thu, 22 Jan 2026 18:00:44 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id h0eh090GRW20-S08uk8ZA;
	Thu, 22 Jan 2026 18:00:44 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1769094044; bh=D9w24wPMtHrGLx4+zSY8RPUcdFId67Ud6KuDJrqaOkg=;
	h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
	b=VwvdCeF6t69jjzjPbkRod3vtz11/LIrnsF5pP0xCaxoZZ8K1g5mqKAwcR+YnS37zP
	 F4LJhNM1Q7YFs1Tu73k18rqLJaZUG5MqtreAbtoYjx7uImq/+3+9FXQJN2FKfn64B3
	 MJhjVvY3dH1xjKysIjzVac2WmOruGatze+UIGei8=
Authentication-Results: mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <533de75be777940d591ea23a41d595c212667baa.camel@yandex.ru>
Subject: Re: [PATCH 1/2] lib/cmdline_kunit: add test case for memparse()
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, 
 "Darrick J . Wong"
	 <djwong@kernel.org>, linux-hardening@vger.kernel.org
Date: Thu, 22 Jan 2026 18:00:43 +0300
In-Reply-To: <aXIOJEqV_ctVRrok@smile.fi.intel.com>
References: <20260122111254.1111811-1-dmantipov@yandex.ru>
	 <20260122111254.1111811-2-dmantipov@yandex.ru>
	 <aXIOJEqV_ctVRrok@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-01-22 at 13:46 +0200, Andy Shevchenko wrote:

> Can we also have one with more than 20 decimal digits?

Hmmm... running simple userspace test,

strtoull("569202370375329612767", ...)

returns ULLONG_MAX (and sets errno to -ERANGE), but

memparse("569202370375329612767", ...)

seems blindly overflows to -2646695909666487329.

I'm strongly suspecting that 'memparse()' should be carefully
tweaked to use 'kstrtoull()' instead of 'simple_strtoull()'.

Dmitry
