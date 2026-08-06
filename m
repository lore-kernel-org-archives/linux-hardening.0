Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A74486654;
	Thu,  6 Aug 2026 17:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786038770; cv=none; b=PQTcSrXJd55lW9UOWQKrx9fqaUwdZvvqQ7ClqgjxlEAAAxi80pjKGXqE8w+PYb8vD9GzPnszSGQYLTH1GGRSRvsePZldhFaOTLb7Ri9zQXDcdEqrw2C1GDvLC703bIr3eDZEeigL300yUYncaVLNfpv7W36YcgbpiM99l6RMxb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786038770; c=relaxed/simple;
	bh=dTFc5KVSOyyRLaUvxjyy4gjSMx63nUB5dXvPdJoK6QE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=uPaYTCONfPuHQpkDP6VDsKKaE3ApCndDlXBVlTky2z8GSn+fJoJyT6W9GJF/cv1XagEST68c1Tm0OERhDW/0yenOYMttNTADH3/+KcSg74TfHpuTYzh5JHqV3Q2ec84BaUrneHubbjKVGF30tklsl3e+EYXONN4EdvwEFPYAiWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n87K100v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n87K100v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 109761F000E9;
	Thu,  6 Aug 2026 17:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786038768;
	bh=amu0jMXpH/msysld31tqkZsT5du+PiFJPn/DYBO7gZI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=n87K100vrR0/fb4HD2jydkBkg7Ou2tZfdMM+IOEW5jy211ESoPjvEmPAgyxBVzMx5
	 DWP/9e+URFvvRzJvjY9b88GyeMfDAs60De5lTrGVnVcCgOsfZgCVPHl0KM2le0aDYE
	 VXB2MemoKRQMw35Vo0oyTEMvhat2PankAAuL3Keck9O85xsrqjMFMSSqBOyPXL707A
	 ddGLPmgNjSX8MLO7fCCNWBs4D7DS2VuA4l2IkUF1IiY+UC4Eqmsof14XiaAI5A8AlH
	 qtUSAf23XHbYH2B99REt+iZd+4kwV2Q/Bh4sC8RHG+MPf5mIbEER3lev/cLTxNjRzt
	 oEqO3gpyZFGkg==
Date: Thu, 6 Aug 2026 11:52:47 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Milan Tripkovic <milant2002@gmail.com>
cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
    Albert Ou <aou@eecs.berkeley.edu>, Kees Cook <kees@kernel.org>, 
    Alexandre Ghiti <alex@ghiti.fr>, Andy Shevchenko <andy@kernel.org>, 
    linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
    linux-hardening@vger.kernel.org, 
    Dusan Stojkovic <Dusan.Stojkovic@rt-rk.com>, 
    Milan Tripkovic <Milan.Tripkovic@rt-rk.com>
Subject: Re: [PATCH 2/2] lib/string_kunit: extend benchmarks and unit test
 to memchr()
In-Reply-To: <20260520155532.1139471-3-milant2002@gmail.com>
Message-ID: <81c7c1b0-2906-96f6-6f7e-c859a7578c8c@kernel.org>
References: <20260520155532.1139471-1-milant2002@gmail.com> <20260520155532.1139471-3-milant2002@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hi,

On Wed, 20 May 2026, Milan Tripkovic wrote:

> From: Milan Tripkovic <Milan.Tripkovic@rt-rk.com>
> 
> Extend the string benchmarking suite to include memchr().
> Extend the string unit test to include memchr()
> 
> Signed-off-by: Milan Tripkovic <Milan.Tripkovic@rt-rk.com>

This one either needs an ack from the appropriate maintainers of 
lib/tests/string_kunit.c, or should be posted separately so those 
maintainers can take it upstream.

thanks

- Paul
