Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5ED41A84;
	Sun, 27 Oct 2024 15:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730042763; cv=none; b=g54eWJI5kwYi5gVObpMm8sR8F0iArauBlZhEnqiS9Yk9GXNo0Lb9ack8PpSo+tqNQ1hu9ksqODTNhg5hR1qgqLtHEnoHvTUj+x3ooIv3K9VwldCWf/rW4+uno67xVtmG8QMcBV8VDfUKSOYDZMOkNWadk7J1UgkG8p402y7mxLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730042763; c=relaxed/simple;
	bh=XCORri4WBwjvLuKlwT7V0EXFrfvKIRVkPyWhoVupm/4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=W4oGbtUXlWvtLAetvgcV8NYAucrQugmn91K4Au26II3uv9RFG8mrx8/8PgbVXhOiYR1tIZNY1X/u7TOKKciL+vN1qFkOnSGy2Usw3RUbWKcCpJzAGFOpgx697Fdz26QwRJ62Byxq3/1pql62UBbWj3jdnDNzPtn03zDibzlT82w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=LXSLba8r; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="LXSLba8r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=SoDbtuSX0QLzcHEEAoUdaVp4YZgMG/yHNRZjxeiDS1g=;
  b=LXSLba8rYwX/OY/IATcQ3k0RAUIT+fv8mIwN/3YI+rf1YtZs9BJUBAYc
   OUu5NaDczwGuA2rEqf64eUFIrheaRVUWzuLttPUiKur04LGimoQzEJ29/
   /S4dj4t3AJb5IRQ/HL75GqAB7TMYrTa8JDR8FcieXhq10RaKjoYA+eC0e
   E=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.11,237,1725314400"; 
   d="scan'208";a="100137520"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2024 16:25:52 +0100
Date: Sun, 27 Oct 2024 16:25:51 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Andy Shevchenko <andy.shevchenko@gmail.com>
cc: Thorsten Blum <thorsten.blum@linux.dev>, Kees Cook <kees@kernel.org>, 
    Andy Shevchenko <andy@kernel.org>, Nicolas Palix <nicolas.palix@imag.fr>, 
    linux-hardening@vger.kernel.org, cocci@inria.fr, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coccinelle: Add str_off_on() and str_no_yes() rules
In-Reply-To: <CAHp75VeeUKWakOWW7ft8BB9Gg=29_z93fCjDk_VGsqd8py878A@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2410271624210.3498@hadrien>
References: <20241027125858.1804-2-thorsten.blum@linux.dev> <CAHp75VeeUKWakOWW7ft8BB9Gg=29_z93fCjDk_VGsqd8py878A@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1609715228-1730042751=:3498"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1609715228-1730042751=:3498
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 27 Oct 2024, Andy Shevchenko wrote:

> On Sun, Oct 27, 2024 at 2:59 PM Thorsten Blum <thorsten.blum@linux.dev> wrote:
> >
> > In addition to str_on_off() and str_yes_no(), add rules to search for
> > str_off_on() and str_no_yes() replacements.
>
> I don't know cocci well enough, but this does simply not scale. We
> also have cases where "Yes"/"No", "YES"/"NO" and all possible
> variations of that.

Andy, are you concerned about the number of such functions in the kernel
or the number of rules in the semantic patch.  There are indeed more
concise ways to write the semantic patch.

julia

>
>
> --
> With Best Regards,
> Andy Shevchenko
>
--8323329-1609715228-1730042751=:3498--
