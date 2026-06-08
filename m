Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD08390223
	for <linux-hardening@vger.kernel.org>; Mon,  8 Jun 2026 21:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780952834; cv=none; b=q4mOjh6Yiuddv8uZuobEFm3X4+JLSvkD3q0ofG5iB9S7gR6Td9fpf1PFC5Q0bbFypomQWC7XMJAKhdEpWBaVh+vVgvvYPxciak12u1zdd4pMk+GeuVI7u8O+okaffcD59qP77oknLmPglcfnZJLeHxDD5LtM5iJS+2YW7NarF2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780952834; c=relaxed/simple;
	bh=AkJ4Onjq6hRT+x3T2G96bEDlFlW6AzfGwTZ56r0g0r4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WF8kOORQVcBRr21bctOiC2nUqkzJJ7rb8ABEuaXLKDKzcmjhORr2pTHP+VcFWn6bkI7W5SqMXx8Tllt1JGoEUK3WKsxfSlLFlIv73jhxdKLATkk7rXi53bNef+3NaPz+16pR333TssiL7xNGDmWFuUSxTxHRvuG4s61mdvIApz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ggieVirV; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggieVirV"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-45eedc94d37so2404106f8f.3
        for <linux-hardening@vger.kernel.org>; Mon, 08 Jun 2026 14:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780952832; x=1781557632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3sHjwoJ5ZnUIbl6Kzmw0eDuutU3fVA4THUQ3Mz9TeEk=;
        b=ggieVirVWHqyof8Uy+u8MkDm3EBe+KpUNRopO7IO34rJ4n5BO8M7EhNCOuDcPz+3LC
         h3uR8nkACCtY0ray2Mio528zObd6swx5fpUOzJcwxzwvwDwDavfp4wvqpEeD39hsjY75
         lywV6qES1wTsUDhbQPYcPa/OUczaRgWKEsZwKreayX9xsisq2g7OtanE5VqW+/lbucLN
         3osluvkuWdUUPWYCCAPRHOMBIMuV2Y5ZeQggfcqC/OmC4yYE0iGu8DiInzb47tqjXlW4
         ZUEy0H0N1yZvprLqoeM57lEZaTqyxistYyJDwg9yPpSMbhw4eQ5XbpPKXodn06gAmNtV
         U+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780952832; x=1781557632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3sHjwoJ5ZnUIbl6Kzmw0eDuutU3fVA4THUQ3Mz9TeEk=;
        b=qFdS9otlrquRCLaceOjExLWIt1DRRw6/j4Y9bwCoAeIGRTCcws2LJW4r/QQTAIebhd
         V9CCQyZozZ1IZLiGmJz2vwAOqUHSPI038YUxE0zyoOGSKPZQKMxrJoJwsuBnh2Ax+6aU
         XP0foCaKYSnUvBzWdcDFB+PEqS5wmmGZOYJM5h3R54ZKdt94Pj7E/lU/9L/Ky4BaLQ2g
         CCPf57tTJ4gjSpXWFpZ7HmCY63U2egqKOJes65VmQD05eUmRiSsMoldIl/Cp8yqv/pxY
         C02Vpqe4O7cQxYi4tWaJER81dwUT8d3g4ogu7f08bwDlRqItKEjvgySBaCyvu5RujpiM
         k0uQ==
X-Forwarded-Encrypted: i=1; AFNElJ/M6jXmy8DJeqxTlSGsGYszEn926YMARMHZ9wn5NQyasOgpr1yj/H7Qaw/4Ujd/UAwXKahOiy3htuhFckmLXXc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8rdHxHcDXqSn2LQ4R05uQslXNfZdehHMLge1/IdpIYQ40UQLr
	2/mMTjI6n/XZzxwsh4vIkfhMCe0l253oUgkwW3+DeCzIWQw3EPzgbcsh
X-Gm-Gg: Acq92OH9vSsn8uOlDMQShz0ertRqeevdMXqqOmNrSPzhoPzQNt3ZWVlZYyxapWUJ2+j
	RNg3X9V+Jt9lLPIou5qX4WOXbQHE2YmeeLAfC6vyN1aOnFSASY4V3eZ0zyEuYYWZCxAJVnKD9uv
	dfDBHso/vKAqUNDtC00zhlnNxdv4Lpyt3HB+xdX5Ju5m+IzEUojeMCVo2W/USNhvHspmEpqYR17
	x/o81Cm+pp2tXOXWABCZqDS9o6C1WIqj5wgzoJVu0VC0ikqc0jyD9QWgBtCcOub7wZRrzOQwGkb
	SEQ6LVPOPORqbd3MObyvJBg1QXBdIoweLewJhcB7Pbe2jTv6TjOvSCDrEjZ2QBEAGI/Y37F6G0w
	IFDNoNtJwxUUw3RTMEqUFmDtJreB607c/NEii1DCYSGD9u7e5kI0kXVdYF1WhTLQFtRvISnKIfS
	M40TA4urBqPo/PqTUhyPItE3qy5WJXHizPwUp+mgvkmeNjpcMnU8rDzGJJ9ZOHy/oDg15qklo=
X-Received: by 2002:adf:f847:0:b0:45e:779a:302c with SMTP id ffacd0b85a97d-4603065b681mr18894313f8f.29.1780952831514;
        Mon, 08 Jun 2026 14:07:11 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4602cda363bsm43293865f8f.31.2026.06.08.14.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 14:07:11 -0700 (PDT)
Date: Mon, 8 Jun 2026 22:07:10 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org, Arnd
 Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jay
 Vosburgh <jv@jvosburgh.net>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] drivers/net/bonding: User strscpy() to copy
 device name
Message-ID: <20260608220710.7499931d@pumpkin>
In-Reply-To: <20260608132311.0fb69fed@kernel.org>
References: <20260606202633.5018-13-david.laight.linux@gmail.com>
	<20260608132311.0fb69fed@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Jun 2026 13:23:11 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Sat,  6 Jun 2026 21:26:07 +0100 david.laight.linux@gmail.com wrote:
> > From: David Laight <david.laight.linux@gmail.com>  
> 
> Could you be so very kind to read the automated message you received
> when you posted this?

Looks like I managed to send two patches for files in the same directory
that contained equivalent fixes.

I think I should be able to merge the patch emails into one and send
as a single V2 patch that contains both changes.

	David
