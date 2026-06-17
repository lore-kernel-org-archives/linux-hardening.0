Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C426F3783B0
	for <linux-hardening@vger.kernel.org>; Wed, 17 Jun 2026 21:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781731861; cv=none; b=prXaz3sLMfuRJt7ZoFDh69vLlfu+Pm3B8lXV8CRLkSIX+Y04pp3E1Y+XaEQhhK2LORnuPapcfi2dVDM19wd0QCmW4I36HjtjZb79ifXEjYEykQTSgHvjwPq84ikJeK88vxbBMu0va2AGkuGya+qGkcnQb3+ptPWvc8M891tvj9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781731861; c=relaxed/simple;
	bh=VKPsWynGDM9pys60QuVcwARe1tdFU7Czo0xoqGYlLAo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i7yoGfUafd+04BmVsItNv6dTcTrtD7rPoB6R28NJlRdlWpkexHX10w23YSb1YO2Qp06GYxzcwruGzIpRg+SdHMYd/Y838XKGf/ZZCyvBbDNW6TvaAk1BuBbJ0IwQtK3euOqfSpfixIeMctUs8tUwpAGVRp2EozdCrHerFheu+Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZ3fenMF; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZ3fenMF"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-45eeea039ebso153760f8f.1
        for <linux-hardening@vger.kernel.org>; Wed, 17 Jun 2026 14:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781731858; x=1782336658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qeHK9f7qxiC+a+aM8unHOfffPeCuNSMjZHypTzZC9QE=;
        b=GZ3fenMF+Ea8FGHAhsl7ZsvaYtVff0Nyzw2jccXIO9pgZNGLQ4lKQLfE2JT2yQnGba
         qxBQrvw8ODKfuYyHkoG7DT+lrs/dziZLTJTIAjkRrI7zaYpWqV+MMbn9yQibp9Apo4qd
         S7F/4uEje0Vz5bib2jcz1gJ8E5C5TZYG0lFnFcKMNSy1EKL2CVXFvGsvDtri0QvhWHKU
         Ji34NQPFtq8ll+vkHyofOzCQSo72ataJOGP1EezZwSG/uNSz7AWcxVk3LE2GA9g3RN+Y
         SNfT5GgvS2ttS2x4ypLZUHpqaxfFtW3PINyDw9rcyAYT6NxdkiyFYA75hR0bqLhL2Kst
         WlfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781731858; x=1782336658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qeHK9f7qxiC+a+aM8unHOfffPeCuNSMjZHypTzZC9QE=;
        b=swP9iBAUYcHXc1Jt9/8mn8KcHYPhPrtHVRwQtYAIrU5zr0wQk8eKYyE7K5gilWwDzx
         BXtlh2hi6pG+CirQtla3uaXEpoxOAFPux0hXA+ED7nSJCqFgP1oGwSehXZ37ivbnBcwT
         xkPoqfmSwwpao7PGI4amOsf9gTx8uuG559MU2U1oO67gJR/J/vrgXEvVs3avnurpIeV0
         y+wrUNeZBJCuzbM8kjYu9vUdlSBbyKVsJNj5WKpvtio7fybzD3hvwUnDtAuHLtBB0I83
         JGAZ72mCzHxuNAI7llFTzvGD0F2c9oh2aLobXY3ZldpoaP8NCGISXf/WGfwLAux4I5rM
         M8kQ==
X-Forwarded-Encrypted: i=1; AFNElJ++lIC8H4cQM4KruUo62LWOz3JWaelKH/aSkVPCmee14lxzjJ1b2tJnDFSdcyZ1NfMZlPS0T6eme2F9lIIDrf4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx35lGDqERZ0UfT84R+8XNH37pEI2aED517teVKUDhs6My2P3Zi
	+AcDa6XmN7OFq8xIGiKrtuq35aYmSkciD+yRRbHH3Lg1MewZrOgDEhlD
X-Gm-Gg: AfdE7cnGyb6Y2eyu862S5frWDlqY82s3+RnLLalpR9REGrvVbmrwB5KAUeG6UFrszfe
	uN/HHQIki99q9weaycMiTc9zpASjiaL2bVDFx8zAkylayoDxPCm5s4uSlXkUSMwXw3wfxowBwDY
	3gkIdNv3Kp6TQwYpCd1GKXnEtcydezOjLb9l04IzJpX2hvP137IgokpWVZAQlvmKf5NunJyJymJ
	4sGg/MiTkk/Ssftey9UOmUNJGMBDmdRRqspeNlueHpceQnakLfuCmyw5bhi+8p1VPDBhtptyd5i
	8+6x30M8JfNSrGW4hH4ZvtTySaxr7IPrmWAj7NAb5Ne/GDVOCSmGkJ1b+dNy82BpGiUJP3NoVQo
	+e01G5W0i5vYZ+bOv8SaJJ0q3gCC7p/O+3jWIsRjYIHj1iZ+lPlvoWsm+MpCfc6LGbk+xpfUxgJ
	KLEVb95Nj9WMp0WbUPreheZn7i2oQYn5pG6Ru9NDa5hvktSrLuA93+rNxC6yBy
X-Received: by 2002:a05:6000:288c:b0:460:3233:f994 with SMTP id ffacd0b85a97d-463adc9232fmr1301938f8f.43.1781731857875;
        Wed, 17 Jun 2026 14:30:57 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4620b3ed0d2sm18936916f8f.22.2026.06.17.14.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 14:30:57 -0700 (PDT)
Date: Wed, 17 Jun 2026 22:30:56 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, Kees Cook <kees@kernel.org>, "Gustavo A. R.
 Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v1 1/2] overflow: Allow to sum a few arguments at once
Message-ID: <20260617223056.754bfcb8@pumpkin>
In-Reply-To: <1e656f5798a9f2f36daa00aba60d2196b2456335.camel@sipsolutions.net>
References: <20260617112250.2791461-1-andriy.shevchenko@linux.intel.com>
	<20260617112250.2791461-2-andriy.shevchenko@linux.intel.com>
	<1e656f5798a9f2f36daa00aba60d2196b2456335.camel@sipsolutions.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Jun 2026 14:56:09 +0200
Johannes Berg <johannes@sipsolutions.net> wrote:

> On Wed, 2026-06-17 at 13:12 +0200, Andy Shevchenko wrote:
> > Convert size_add() to take variadic argument, so we can simplify users
> > with using a macro only once.  
> 
> > +#define __size_add3(addend1, addend2, addend3, addend4, ...)			\
> > +	__size_add(__size_add2(addend1,  addend2, addend3), addend4)
> > +#define __size_add4(addend1, addend2, addend3, addend4, addend5, ...)		\
> > +	__size_add(__size_add3(addend1,  addend2, addend3, addend4), addend5)  
> 
> I guess it's not going to really matter, but it would generate fewer
> calls to have something more like
> 
> #define __size_add3(a1, a2, a3, a4) \
> 	size_add(size_add(a1, a2), size_add(a3, a4))
> #define __size_add4(a1, a2, a3, a4, a5) \
> 	size_add(size_add(a1, a2), size_add(a3, a4, a5))
> 
> as a binary tree, rather than only cutting one off every time. Not sure
> that results in hugely different code though - maybe fewer overflow
> checks?

The binary tree stands a chance of executing less slowly because the leaf
adds can be executed in parallel.
Excluding the saturation checks (wtf is it called size_add() not
saturating_add() ?) (a + b) + (c + d) will usually execute faster than
((a + b) + c) + d because the (a + b) and (c + d) can execute at the
same time; unfortunately gcc will always generate the latter.

	David

> 
> Although your version make it really completely equivalent to the
> nl80211.c code, clearly it doesn't matter if all the values are "good",
> and I believe the overflow behaviour means it doesn't matter for the
> overflow case either?
> 
> johannes
> 

