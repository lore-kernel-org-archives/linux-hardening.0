Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4DA27FB35
	for <linux-hardening@vger.kernel.org>; Sat, 22 Nov 2025 21:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763845240; cv=none; b=G60qK8+YqNgDbWm9w5KQT4SCEZbRDM7Kxvb63eFygZq3Swq7cScBg4juSWo/Qeh+vgo8erfnKv7z2xUwsn6Ciu5nf25pol3u5kygu+cv+lN6kNJIKAaqvtOuy9QaWQsfZjg57J2vFxfKHd4Ld3S/4L2TtKHp5175WvEcdk7EiyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763845240; c=relaxed/simple;
	bh=RdjaX2niye+QaA7f4+vmh/qanvjRwf5mmtfnOsMH620=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u0bhdOCjbbG7Jlt0r6IXeBkFb3TVAwDwKZqxdGcCPkdJvDujJMPEuEHft6CZ7ZJTbdvRqfQooQFtcInfuarV+AjHJ2sTpaxKGIQ1cQWWBd6ShuO27q+3LMxAtcvn7omEqQcUi38WcTp3wNLTCkhc15UEIQ6K02hW25Z/Xr9mBCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=GjMaq5wi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="GjMaq5wi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67899C4CEF5
	for <linux-hardening@vger.kernel.org>; Sat, 22 Nov 2025 21:00:39 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="GjMaq5wi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1763845237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RdjaX2niye+QaA7f4+vmh/qanvjRwf5mmtfnOsMH620=;
	b=GjMaq5wiBepTPSo2V7eiqJ1a+twqoy2vnltVSiQa89DMa0lBxuPASwDt58RY775LUN7syG
	RLeeEh+vUEuxYqxP0gNNVpqdKlZkqSYF9dxMCIjvPinnPSpqXpHm7R1VQhBvrLJ36b8Et9
	rS3Cv5d1Y0hbVae84MiqSX5Uat6JTug=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d43436d4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <linux-hardening@vger.kernel.org>;
	Sat, 22 Nov 2025 21:00:37 +0000 (UTC)
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-657509d761dso1648449eaf.0
        for <linux-hardening@vger.kernel.org>; Sat, 22 Nov 2025 13:00:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVCHowbcuV62kpkx8CcgYugu/KzO5in3yCazmSn43fVZm2+7L9ExKk8R75rmIn4A/ikFdFtBp5O4Ne5xsPv9UE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNh7ISOlBkVBiFBvtQjSNEUD7lYO8gZ+tO6maI2zLjzXotxAst
	dP1EWQ+k4z3k7aAEc2L0dcZITrF1cxDj6Ofztt5CCpgVk+yiv0W9hnJj8dNrh1D1Mw9yfUXRa4y
	aTLWbAt3sV6dzSCP/UpgODbaBFYlu6ks=
X-Google-Smtp-Source: AGHT+IHhLYoQTOXsYDzBvDrhx/MSvI4agDaTEI5z0taFiCl8rX+zo7epzxpxtq3QIvy50SGXsWOw5WH5qgGfyHvcPLg=
X-Received: by 2002:a05:6808:178b:b0:450:c648:4aeb with SMTP id
 5614622812f47-45115b25a78mr2323855b6e.44.1763845235532; Sat, 22 Nov 2025
 13:00:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251122194206.31822-1-ebiggers@kernel.org>
In-Reply-To: <20251122194206.31822-1-ebiggers@kernel.org>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Sat, 22 Nov 2025 22:00:27 +0100
X-Gmail-Original-Message-ID: <CAHmME9pvZLPKK=_Wa9+kCNejZ88grDnb5JS9=QvMrTQ0WeVsOw@mail.gmail.com>
X-Gm-Features: AWmQ_bn1ZzeLHuRMqZ6nj3AH1LlwOlRr1TPSTeXuVGzgci7cSh4vrKZVIUr8xEc
Message-ID: <CAHmME9pvZLPKK=_Wa9+kCNejZ88grDnb5JS9=QvMrTQ0WeVsOw@mail.gmail.com>
Subject: Re: [PATCH 0/6] lib/crypto: More at_least decorations
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Acked-by: Jason A. Donenfeld <Jason@zx2c4.com>
