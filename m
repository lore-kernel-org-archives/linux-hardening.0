Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1E6349AF6
	for <linux-hardening@vger.kernel.org>; Thu,  2 Jul 2026 17:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783013760; cv=none; b=doYAbm+373OIKiTJBvi5g8LgF9NwX7xhLSmFT0/8C6rOKEMrI51/PYtNoCU0rfAmzwEDCLKBgXEIVrgR5Dsb8SB2pJRpj0mIks/So/N3PZZZsNPh+3DuToHbalSBOo40LqwKjjsh/4k3OMnSKEWXshLVHQVhSuZqd/IXOMDm5Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783013760; c=relaxed/simple;
	bh=I1eeHpCHy2amylD5gAFQ/G5VWDnH0phiGEsKBXqG2BM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ki8pFK0up6P39CHXaJeKBYtdFFYeTfqsrF6z7Q5yybkZYyFd8BAE4ZfUMy4u+O9TPGW4LSaJQwBzwuSSAjSDZSPjiJrXRCTPDA3YygIlfaPnhj0d2angnRGsfAVgn1/uarY1xJXhqZYCEzDCUdwiOQzhAHK8vt9Hl4LjZaOsvUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UKFugqjV; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKFugqjV"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-37defb2f231so1424197a91.2
        for <linux-hardening@vger.kernel.org>; Thu, 02 Jul 2026 10:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783013759; x=1783618559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I1eeHpCHy2amylD5gAFQ/G5VWDnH0phiGEsKBXqG2BM=;
        b=UKFugqjV9r9iou6jyGWSsAIsdVsDSHxJqhgI8nnEp7LvnpLH48EHGKmoWGbufd3Og3
         SnENMdSdeZAYjwT1XcB+sHWoQJPWfP7s4Z7IcCCAIP4zAgARnej1gsuaYGTSLv2xzz2j
         5Ou/PBUDq3i1rdcKr6Dx0bRAouACcmxpz54BIZYiwPP/6pNGqMj+EoYKV+vTT9/5Dvas
         rUvqIkWu4/ZVx/JYar+BRD3uSkThci6FcmoM2JGYiElhZRLepO5lKGTknI7e7WsjRUci
         lGkIZBa6W6qx7kGLJdRldkA4KWhm1XobQkiD38cBDRC/MBv8sTZ8hkqoeaM5o0nFKkpm
         Ya5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783013759; x=1783618559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I1eeHpCHy2amylD5gAFQ/G5VWDnH0phiGEsKBXqG2BM=;
        b=DJFFoq6ZsQmJlpJGfuYYhlKn8Az3FbQblbP4+fd/p+4+8qyLlfappShZ49goelkJ22
         /f+7fBQ1kGLQ3AgVWEO3RYTOjU9GRSD1mETnXkPlJiObtpB15nQj8YI6OQlha7OF2dgS
         8wIehiQ+fucXC3LalsCQF1hNqqtvsTK5AcUpzmXOgt+n1W4wN+m0enwB2Cf+J8GF/oQG
         cUaxlBcBgUhDeZ2VzISoYQOUECKympjgxbDiNr00dUcKUgrJ56SEcTfvj8zVbZR4UJXA
         qmxTiSHV2LwKMbwlo91kBSHJe/WIXwzJMTY0Qk8mt50njLpNFOAmgO9uShKBnRjmnKeL
         pzTA==
X-Forwarded-Encrypted: i=1; AHgh+RpBv3/zsGNtcW3kKxLZv7qyxiaS7vcdrfLahT2gmC+Jl/wpfnZFpqCAJDnR29Z6WWzphzpyS06EyI9IEqSw9eQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YynDnPxxT+97tOlCxrrCRu5k+U3gaQGt7o2XAqn6yuLai92EE9g
	XKsVdVKGc4DqRPFcRPLR/orCAst21a5srs4aUAZHLdKYK+piEomylAm1
X-Gm-Gg: AfdE7ckvebUm7lVuTJHrBq1Anu0qHA6JGDbCKNreF+2Ll7LLx4vl0GFB5FSJ/uJ/QW0
	dwsEbR2YRaGrabIyz28MwaPqTcbDpQxzbgkQuYX75EK4uc3RwGWPjaCML74MbRACy4M4Ip6WFSz
	If7FqcEByQ/VOf52mpEc6OqWXvupXMm6R4MKncrTCu5gbfpFu5vYNA5WLjBe9CpbibrDaG9ijOc
	Nu+nEOJXgxR8CwXRfvOhWWgYYGpjEWKA4khcvsIhHExp50x2uBLh6rY/I5OQdLnUptyUTZCBbTo
	OPPk9lheW2AruGsvNTbvPkfZQl2FbmkD9T78JCO7bV5aprqBT/kzi9TyhF5Z7BzABisa6T0Kioa
	T0xtuZaQttNB0UyC4qqrFIDLCvaoEDbNPTHt595d8+vClanSc/93nMw7G4IkrkuMpNqHdMa1HsW
	Y0SvIwH1cVQMfDltuhjUkfCmrC/pelZ+7m70dAijHVLpoKVV8srHcA2UA=
X-Received: by 2002:a17:90b:41:b0:372:b4a1:21d8 with SMTP id 98e67ed59e1d1-380aa0f43d6mr7412581a91.13.1783013758621;
        Thu, 02 Jul 2026 10:35:58 -0700 (PDT)
Received: from LAPTOP-97G9G880.domain.name ([106.222.201.11])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b813cd9sm10870313eec.8.2026.07.02.10.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 10:35:58 -0700 (PDT)
From: Karthikeyan KS <karthiproffesional@gmail.com>
To: andrew@codeconstruct.com.au
Cc: joel@jms.id.au,
	andrew@aj.id.au,
	Kees Cook <kees@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v6] soc: aspeed: lpc-snoop: Fix usercopy overflow in snoop_file_read
Date: Thu,  2 Jul 2026 17:35:50 +0000
Message-ID: <20260702173550.10779-1-karthiproffesional@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <033f2657ae6a94ad13d22f717a2900afb75d892d.camel@codeconstruct.com.au>
References: <033f2657ae6a94ad13d22f717a2900afb75d892d.camel@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andrew,

Thanks for your consistent support and guidance.
I learned a lot from you.
Much Appreciated.

Thanks,
Karthikeyan
