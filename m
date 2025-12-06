Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85962236FD
	for <linux-hardening@vger.kernel.org>; Sat,  6 Dec 2025 23:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765062977; cv=none; b=gjYXMpF0FnpHlEocWGGVrTr1Sskvs75UR2/jBKf6NQYyLqPK2fnMsjHYsq05GIY/V5q3WsdIAc6m97XAw/FuLF1sWxcBFIjoprwULeZvlZ8fRF/LQ9op+zgdyUGwdKhdBDXqmSvg/o3XWAYlN24jvksNn8jjTi0FSBZlc58bcQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765062977; c=relaxed/simple;
	bh=sHzfrNNc5TiZOJevop9wIz2ZjtFwVDhSUdmNHa4qp1A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oRDtzNgvN52yo6xepsxHXcIpvJqfrafzBfLX/OucTb3R6BPw0cv8wn8JZqG16SmCC+6YzePmkHV+hS1TnB5f2UJmI42SmZceIoVHaTM4Z0iEqar4sYYdt4MHowMc2v9Kg9X4O6KkeeS2beI4SAy4ymILozVbFhXGYrXy48HMLms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWROfoyf; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWROfoyf"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-640d0ec9651so5959212a12.3
        for <linux-hardening@vger.kernel.org>; Sat, 06 Dec 2025 15:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765062974; x=1765667774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sHzfrNNc5TiZOJevop9wIz2ZjtFwVDhSUdmNHa4qp1A=;
        b=QWROfoyfmqank1B+D60sDDmaEuEAVyHbQtxPsmnTIO7yt5Qm6yN/ofZ//wxV8MeAbQ
         f7vDFIupR7utaEgv6OGp099coRnwsIRUIQxU+SjTPlBddcuMpJCugLpV95PQIYwYpVvT
         zX9qxdM7kQOVpQtrEGnv5HWX606CAbwBBv1GWTK1eMbzl+HbtMy8oOJ/P12SBVwbm+8C
         8vwowt+Cn+tvRZgJdnZ1WTjCZr2grpVN8S0eG87IUkpTyFKW3rTE2n33jpIQ/5HNBDq7
         wyqv8sJ90BXokOsDJksJTxabCFagcvc7Tt21Y8cypQpVZvEJDR4ZAuEOgeFTgkkEzNRA
         bphA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765062974; x=1765667774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sHzfrNNc5TiZOJevop9wIz2ZjtFwVDhSUdmNHa4qp1A=;
        b=ka9lFksCVQhBPXZVHWks97+HftJq74GT7Kocax/tL11sp3FPYylo5UxJI7GmW59QcR
         LCEL9riY9pytEkaS8KhS0krB9HLdzOuxpZAvZRjQyOoxknqv4JOsD48Wlbbo+s6WE8+o
         1V6hi4c+HvW+Lhh6LWI48cO3Psu1k7etgRhhxEnekk7mwwyyPqkVGzI0VX8lSfc5VOYS
         43whxASUw2AeRvgvpMSrUsOq/WLC1269t6e1lEod1dD6zUygIA1GZfE7uHOIEL/0pCmy
         Fn5ZDPKsWiYKKBdmpOtN0UplqbkXMq5Ap2IbA34LfKebVG5AsqzYZlz1ygVkeHwFuDxR
         LfOw==
X-Forwarded-Encrypted: i=1; AJvYcCXllNNRGDkqsrEfnbEic58dphol3q0WkPyLj6mepktqlq4O47gnEtyFkjIWksxNrfBluc/ffCJuF/gkPiNS9S4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1QsRrN7im8xwIxcM7mqpRZqNW4gtVbJqa5e6ZrT328OJizcph
	qCK9NaidZnPdW4CPK2lL/or7TWHvPOvJ9areSIFvt7wd+34vm7XRSJNo
X-Gm-Gg: ASbGncvOc8ieCFTi6F1gHozFYp/IBQlA+Qh8S9U4zFwepQvhkuaj0awSjV8VyL6K7Jf
	F087ppMNb+DnC10Hm81KpZSSqwwzhxzsZQQ1u4iUxB8y7vYOv7pFwIovP0U7buFVjhCiKBBqmmZ
	kPRtoZYonH/DBDE2RhD+lSzFHbAQBCRo13ITrSpZXmCP+0dw0LJNsyZQm8tiZxERs9bFhravtX0
	kZXS65g3hTPugzwqXh+MPvGg1NZSmtDV/Tqxo594Ogl+HC5jXwuCknteQJNbRw1fi48hqZX1A+E
	3lIY+C4T1R03A3QEFKVVpnNClD3w4MTymM5Ne1tvgRwW3x0nfBnwFgIic84GL3WB9NBq8WOknVq
	xo9zoeoj08mFIAAsCDN13+K7gTg0gvQBQkVVggIkWqBM7r41B1R29jv8ctmRix+4cRtKexa3IS6
	3gyfAWkuFk/Hlwicef4xxWQBw=
X-Google-Smtp-Source: AGHT+IHtKFCmYVxjR1we6OXMVDfxzf8n+wwXaLbAzbV2+PkWV7ti0OR445B6RzpBr5bddwpvBpKOcw==
X-Received: by 2002:a17:907:6ea4:b0:b7a:101:f86c with SMTP id a640c23a62f3a-b7a242be758mr391922566b.10.1765062973847;
        Sat, 06 Dec 2025 15:16:13 -0800 (PST)
Received: from foxbook (bfg212.neoplus.adsl.tpnet.pl. [83.28.44.212])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b79f4459378sm754765966b.6.2025.12.06.15.16.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 06 Dec 2025 15:16:13 -0800 (PST)
Date: Sun, 7 Dec 2025 00:16:08 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Zenm Chen <zenmchen@gmail.com>,
 "gustavo@embeddedor.com" <gustavo@embeddedor.com>, "Jes.Sorensen@gmail.com"
 <Jes.Sorensen@gmail.com>, "gustavoars@kernel.org" <gustavoars@kernel.org>,
 "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 linux-usb@vger.kernel.org
Subject: Re: [PATCH][next] wifi: rtl8xxxu: Avoid
 -Wflex-array-member-not-at-end warnings
Message-ID: <20251207001608.1f6940bf.michal.pecio@gmail.com>
In-Reply-To: <44c9c325-14a8-4391-adce-4bbe8c68b446@gmail.com>
References: <ff184c0e-17f2-445f-9339-f4db9943db86@embeddedor.com>
	<20251121111132.4435-1-zenmchen@gmail.com>
	<475b4336-eed0-4fae-848f-aae26f109606@gmail.com>
	<c0d187d6fead4e5387db2a14129be96c@realtek.com>
	<44c9c325-14a8-4391-adce-4bbe8c68b446@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

> >> I got something. In my case everything seemed fine until I
> >> unplugged the wifi adapter. And then the system still worked for a
> >> few minutes before it froze.

Sounds like memory corruption.

> > Zenm and I tested below changes which can also reproduce the
> > symptom, so I wonder driver might assume urb is the first member of
> > struct, but unfortunately I can't find that.

That's what it seems to be doing, because it uses usb_init_urb()
on urbs embedded in some struct and then usb_free_urb().

If you look what usb_free_urb() does, it decrements refcount and
attempts to free urb. But here urb is a member of a larger struct,
so I guess the whole struct is freed (and this was either intentional
or a bug that didn't happen to blow up yet).

Now a bogus address is being passed to kfree() and things go boom.
Or at least that's my first guess after spending a few minutes.
But that's the direction I would be looking at.

Regards,
Michal
