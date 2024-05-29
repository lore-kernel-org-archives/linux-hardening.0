Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8881D68F;
	Wed, 29 May 2024 07:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716968726; cv=none; b=XVPMXhP/t9Np90VYKp2l8CjKaMGSePii5sKZmCxKa1x6/bjDbDmCDPNJvIfTYEIXrkxS8szQEpTZS0+I+oGbu4uqn9sq4zZFYBi5MJH/He+D0O2EA7i1l9UHdqGFtmTX0xIq5xztK6sNYHIp5jHKR+e5ja6L+LILSTmWz7Y4D6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716968726; c=relaxed/simple;
	bh=v6FAbaz9f1j/G5lLHBL8K04Ed2sbYL7jFU9Ly0m88VY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qrr0SaJhXwSfkgOowIh5m3ZjFvlFRg90ROVDsmdRDVw/NEg7z0/yFlcfzTaoRKSQ61cuN3ihaLQJ0unvJcIBUMHnWzK39YlkVTbufqJBCqSX/b0xque++SXKhOcPxABglhFgoajzmprea8TcspuGlFIXm0maTDg1mEmnh3/6FrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vhYz3Jsa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mrfnR8kQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vhYz3Jsa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mrfnR8kQ"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716968723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v6FAbaz9f1j/G5lLHBL8K04Ed2sbYL7jFU9Ly0m88VY=;
	b=vhYz3JsaR/FB9g4OsE74iv1r8AOGlE5G/PnLfuBYkHpEM8Su30LIhMkyb7JoEyeqMByGcs
	uZ9ZXSqr47nUn3jTxz2If6xwnMA72TyDDtTHB65HiEMaDPES9HlsjvcqwFzFYSP/H0FPOD
	6RfZeZ+mffFOclBBw7R43p2Mg0rXXwF6muOYsJDdivvSePrEKFHFTnYMXLg56RpBWUVOw8
	IIxKccCQvwFSt/YoQLt/q20zcXLNrjpHGmxHJIw0ZfBt5+pjuCEQZ+/W+rGOun9q1LNfrI
	RdWHo9vvLqrTfr86jin5r/V4maM1OdvU5Hj74hHOHRpM5SSEwFS2DIKxLYIYJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716968723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v6FAbaz9f1j/G5lLHBL8K04Ed2sbYL7jFU9Ly0m88VY=;
	b=mrfnR8kQlISi1x6fh4gKv2+CgjE7t8wsGPsovZ31Xa1OWO4Ex+B27zAaN8AzdUsSqGiIX4
	b1Rc1HNnB0jICjDw==
To: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>, Dave Hansen
 <dave.hansen@intel.com>, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
 mat.jonczyk@o2.pl, rdunlap@infradead.org, alexandre.belloni@bootlin.com,
 mario.limonciello@amd.com, yaolu@kylinos.cn, bhelgaas@google.com,
 justinstitt@google.com, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Cc: CobeChen@zhaoxin.com, TimGuo@zhaoxin.com, LeoLiu-oc@zhaoxin.com, Linus
 Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] x86/hpet: Read HPET directly if panic in progress
In-Reply-To: <199ba55d-8eb8-47df-9f42-55a865b51ab7@zhaoxin.com>
References: <20240528063836.5248-1-TonyWWang-oc@zhaoxin.com>
 <50fc1bd3-909e-41c4-a991-9d81e32ef92c@intel.com> <87wmnda8mc.ffs@tglx>
 <2553dd17-f763-4894-89b7-5f76c03d3a37@zhaoxin.com>
 <199ba55d-8eb8-47df-9f42-55a865b51ab7@zhaoxin.com>
Date: Wed, 29 May 2024 09:45:22 +0200
Message-ID: <87fru19i3x.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, May 29 2024 at 14:44, Tony W Wang-oc wrote:
> Actually, this scenario is what this patch is trying to solve.
>
> We encountered hpet_lock deadlock from the call path of the MCE handler,
> and this hpet_lock deadlock scenario may happen when others exceptions'
> handler like #PF/#GP... to call the panic. So read_hpet should avoid
> deadlock if panic in progress.

That's not what your changelog says.
