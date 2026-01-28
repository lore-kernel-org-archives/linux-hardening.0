Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B622DCF41
	for <linux-hardening@vger.kernel.org>; Wed, 28 Jan 2026 10:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769595269; cv=none; b=V2xWaPkqPcU7SNz0I60nHh83PF1LQS33zdPVlJoJME+QaB3N9VHulPH6gZNEBt+d9LsuQIDzMonR6KYe3rceZFcnh9+sypip5TpNsRWbNbS1LihPIhPZLtshIiWudnNPAj5/P7XnbR2OOhYVgFP65DNvL7hZUwgKRF+k/PLvgD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769595269; c=relaxed/simple;
	bh=oV8iSm8BWcJOZYezgVOeeocMcoEsadZBLrXLhvXRJQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KBtK4vnpXwQvi370mbgCCez01ptP8pCaY6C/ctHD1teXyNR0sYJ9F8uWtFfpEje+6uBxu0O15Z65DuVkWHcwnpvFrDJ5s2Y61sxGnE0WzwXn3rOUegOTSD0zRISQkDab+sA79IlqjpKd1+Y3GHDIquc8a6hoP3iQiVKehhhduqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=Q9pkdaI8; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="Q9pkdaI8"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48069a48629so16178895e9.0
        for <linux-hardening@vger.kernel.org>; Wed, 28 Jan 2026 02:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1769595267; x=1770200067; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/gpDAs4ZPhBjtHhMqCjkQ/XQcL21PGpv3nXXx+ufdJs=;
        b=Q9pkdaI8ebkblVWGdfVQiUZbQVF1VkwX8cPHRByRig+wj2QcNZa6+tBduAUWTgR3Y2
         JSsOwM9ofh/Lch2ciQp/ZTByVz8wTr0qP303hoq77KmlYj8ozq3ZrLACllNqeBMbPQic
         cdj8SUngp25inNe5kHru3rQY0itpbaB3EOHTbTQcuJQ3BV2ewBHXvx0IdxVHRC0NWtX/
         egFw+F/2CKY1HVUfmktI9sSQZ7i/+4Jpf5PqzmTn8ZjlGftlYX6k3aLnx7e4tqDNbm0T
         +arY2n7tYm1CGZRAvpwzfdjSWwalxF4uog6XSsj0kT2/8GwMBpQftMKjoC4tv0NafNUL
         PlaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769595267; x=1770200067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/gpDAs4ZPhBjtHhMqCjkQ/XQcL21PGpv3nXXx+ufdJs=;
        b=cUZKkMFs9xXd8saqFWA6lsSiKlDW9KVHfxX+bZx2AHYz6gR2skLl+cx7X2T2q7iwdo
         hFTr4cpJJLWanG/u2VlJc0CEwaZn+erjcHR9TePwGYvIcoVXAM2H5L1b+5RynjFiFik9
         qqY06hPWJcv6yDH9MkWBf2y9wgNO/JhGW4Fk3RJ+/4EA98yZeVliFocmP8TrHBbCE12F
         bG+pTP4lijvg6tiYncvwDTl6qbKK+Ssa5l0R8iSY0+bt3tolUudLQiS8CT2ZkcC8wycN
         9UnlSXbTNnDV7LSXPwVnh9kKUf8Uxe7yTyGCWawYAF3LbJB3rn6NQd6LFtC1YMnd/GtK
         r5Pw==
X-Forwarded-Encrypted: i=1; AJvYcCXEe8lpPU17JL50M4Lb1J0SwDST+tEJSIusEHDPA4281J2lJnfi8HbLwWwAQ59l7W8jYiOrXtzjMeH5FlrzxBU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0bAOi/RjT27CR62019zZo5uHNE5+u11Ki14yEYmwK+KW4i9VA
	GVrf1Ye/QSdikdw5Z9MK6C6ytEG5w3U6pI1hwJdvGi2NTokM3Resl1kux40wgay+RN0=
X-Gm-Gg: AZuq6aJaipapJW0tRC2IbDUbEU1O1idc7WakAC4j+vPCP45MQJPtShp4TbKds8IWYTh
	blDHmkfgcn5AwD1tzqyppFlZx9Q29Ap0HYKrVGILiHqfwobxFXKXlkz7Y+PdZwm9csUkcFXtxfY
	766LqZU5YAqi66jGcQA/z2Q4LoTyBEoz1xCvztK5FQfRDC9PSDsF8Ox6hU0iOYYbPZq2Rgul+Fl
	sAlK0NeBib6JJeZIsBiwkJsObeokiabMsXJPc2Xy0Xzx+8RVocnxBywZAYcsRrVKs2ENSKmxW3a
	j2d9tXN/pTIs7lF38Bj0j3HLCAYix5m6cJmA8ct4H3S7QvlIFKgdvet6V2qvFcJlQ8sMdIr1BKw
	YOoOag4UbCGyWB0p18zIbK5RbuYz+gcTyeD+vmUHc9U7G/EMqUUiTUGtySSLVnGVCRAmgpUJTT8
	xKQ2mhQtSiuBd6Rm7Xl9O7DLjfob8FVVilzsyKr3y7aZimNprPiv85NsbKIkw46+Xaf9e6ST9p2
	OvrCb5QW8reGsB0aE2+WeYBiMaXmsP1uW+ynMP2aUTR8vPwrK59BNS70ZYkk15yce9KPREA
X-Received: by 2002:a05:600c:524a:b0:479:1ac2:f9b8 with SMTP id 5b1f17b1804b1-48069c556b7mr54749985e9.21.1769595265936;
        Wed, 28 Jan 2026 02:14:25 -0800 (PST)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806d2585c6sm6410195e9.0.2026.01.28.02.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 02:14:25 -0800 (PST)
Date: Wed, 28 Jan 2026 10:14:23 +0000
From: Daniel Thompson <daniel@riscstar.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: Martin Uecker <uecker@tugraz.at>,
	Christopher Bazley <chris.bazley.wg14@gmail.com>,
	Alex Celeste <alexg.nvfp@gmail.com>,
	Joseph Myers <josmyers@redhat.com>,
	Aaron Ballman <aaron@aaronballman.com>,
	Douglas McIlroy <douglas.mcilroy@dartmouth.edu>,
	Bruno Haible <bruno@clisp.org>, Paul Eggert <eggert@cs.ucla.edu>,
	Florian Weimer <fweimer@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Kees Cook <kees@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Daniel Lundin <daniel.lundin.mail@gmail.com>,
	"Valentin V. Bartenev" <vbartenev@gmail.com>,
	Andrew Clayton <andrew@digital-domain.net>,
	"Brian W. Kernighan" <bwk@cs.princeton.edu>,
	"G. Branden Robinson" <branden@debian.org>,
	"Basil L. Contovounesios" <basil@contovou.net>,
	"Jason A. Donenfeld" <jason@zx2c4.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	onf <onf@disroot.org>, Rich Felker <dalias@libc.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [RFC v3 5/6] alx-0081r2 - array parameters of 0 elements
Message-ID: <aXnhf9uAvyJbQfcn@aspen.lan>
References: <aXdhh1r7ePA5SrIE@devuan>
 <aXdiyLn3vxV2P807@devuan>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXdiyLn3vxV2P807@devuan>

On Mon, Jan 26, 2026 at 01:49:16PM +0100, Alejandro Colomar wrote:
> Proposed wording
> 	Based on N3685.
>
>     6.7.7.3  Array declarators
> 	@@ Constraints, p1
> 	 In addition to optional type qualifiers and the keyword static,
> 	 the [ and ] can delimit an expression or *.
> 	 If they delimit an expression,
> 	 called the array length expression,
> 	 the expression shall have an integer type.
> 	 If the expression is a constant expression,
> 	-it shall have a value greater than zero.
> 	+it shall have a nonnegative value.
> 	+An array length expression
> 	+that is a constant expression with value zero
> 	+shall appear only in
> 	+a declaration of a function parameter with an array type,
> 	+and then only in the outermost array type derivation.

This change did not have any motivating example within the discussion.
Providing a motivational example showing why it is useful to allow array
parameters whose constant length is zero would be good.


Daniel.
