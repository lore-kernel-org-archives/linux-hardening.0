Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96562148851
	for <linux-hardening@vger.kernel.org>; Mon, 29 Jul 2024 12:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722256511; cv=none; b=f9d5GxySZ3GQg8AUlr1fAqG8F+I5GLvbCn11S589npf0JORipd0M4SbOiDOxBgOLOVHxQQAqgv7URRG9e821eQON/kJsxjzNXUVjO5WK9HVuQ7ShX6aHYa35q8IbHzu8TUN2QMGPus5gaXj51+zHnZD8Homb0BMPRpfWIp4FmIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722256511; c=relaxed/simple;
	bh=ro7/+HNT4eCDCDbZAtGztKrHoS6STVSDGamrNBFa4IM=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=m3oFJJdvg4ACnor73GfR09cZRimGFRHvY+lVLV/DwfR0EZBCBnSdClLmc5CKo5+aaVE32DUJ2N8dSzC2zI+UBBm43hbvXvmlkrcNTr/BHsYNjJZYmmix0wS9pk+j3ocJdE3KE+w4aFTKc2YUQ4a/lJO0D+Ny5tqOQYykSwlB86U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dustri.org; spf=pass smtp.mailfrom=dustri.org; dkim=pass (2048-bit key) header.d=dustri.org header.i=@dustri.org header.b=hPaDC3Y8; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dustri.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dustri.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dustri.org header.i=@dustri.org header.b="hPaDC3Y8"
Message-ID: <c875722b-0434-41fe-b375-cc685498c444@dustri.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dustri.org; s=key1;
	t=1722256506;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ro7/+HNT4eCDCDbZAtGztKrHoS6STVSDGamrNBFa4IM=;
	b=hPaDC3Y8wcOJVV6cXuCeqY2cA/wPQSLIB0VhJC3cByJAD9qvqtACDQtH89FlytHupFCoe8
	jEWXijGJm3QPBKKD11x+TgQPGooVGx3B0sPYks4+8ArRRHJ7WCcwJfY/EOTvaEjAfjrmcd
	pyG9dLt5F91iCGWy0oQp0oTKdMtgYicLs9Yw8pZ/J9e66IiXFKBksrZjKLY1qerI6f7qoD
	pi/DITGEZcOjHGKeGl8S6TlHiO/aV0fA08k0wH4udTuMwAnkt73QF9jikRPSG9tuuQCzpw
	izRPiv3C7yjw/Pe01NEnnVvGWl9iJzPfd6W9Xk+mRk12IRdD7aexFVVpdadyHA==
Date: Mon, 29 Jul 2024 14:35:02 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: keescook@chromium.org
Cc: ast@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 jgross@suse.com, jpoimboe@kernel.org, leitao@debian.org,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 mingo@redhat.com, nathan@kernel.org, peterz@infradead.org,
 samitolvanen@google.com, tglx@linutronix.de, x86@kernel.org
References: <20240501000218.work.998-kees@kernel.org>
Subject: Re: [PATCH] x86/alternatives: Make FineIBT mode Kconfig selectable
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: jvoisin <julien.voisin@dustri.org>
Autocrypt: addr=julien.voisin@dustri.org; keydata=
 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
 766VTOg4l2PTPCnIdNFy1Os=
In-Reply-To: <20240501000218.work.998-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

> Since FineIBT performs checking at the destination, it is weaker against
> attacks that can construct arbitrary executable memory contents. As such,
> some system builders want to run with FineIBT disabled by default. Allow
> the "cfi=kcfi" boot param mode to be selectable through Kconfig via the
> newly introduced CONFIG_CFI_AUTO_DEFAULT.

I'm confused as why you think that KCFI is stronger/better than FineIBT.
The latter is compatible with execute-only memory, makes use of hardware
support, doesn't need LTO, is faster, … moreover, I don't see why an
attacker able to "construct arbitrary executable memory contents"
wouldn't be able to bypass KCFI as well, since its threat model
(https://github.com/kcfi/docs/blob/master/kCFI_whitepaper.pdf)
explicitly says "We assume an OS that fully implements the W^X policy
[56,58,106] preventing direct code injection in kernel space."
