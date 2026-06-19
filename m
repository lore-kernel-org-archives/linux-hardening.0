Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AC61E4AF;
	Fri, 19 Jun 2026 06:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781848887; cv=none; b=AuAIzYJGhUbp7Ldi03n6tTrsY2Gh3gFCnM0c46NdxQNMgmG1Un7yBW9XxGMpaCx4779hNOsfuuUqrPRGGlEwrwgCkiMW4mJbFPWIEahu9RJf89wgBQiTZas0w5xe4XZw/fd0ETlZwjVW3VBnCeopBq0MN4lAzRfBFH/tBg0La7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781848887; c=relaxed/simple;
	bh=klacdtRCjhWbo4xWFEw5CHfpQA6MIeqvmYkd0nFhCJ0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=spJ/UwyByp2mF+H5eDxTfNj/cTmtav7aTXRmr6hpGrBqZuTdpaxNKnMONM7uTEB8ETQm26PXH8qXSedZcEuL9htJLKq9fMKmEBo47UUr/iuwdrfK0lOnLa2WvEaDtnwR1fDZIRNiDgNtqMxQE0YTRoJXO39wnrN4qz/DBE2Ipq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=DyQrtgZg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gNpq9Dy/; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="DyQrtgZg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gNpq9Dy/"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 414561D000F7;
	Fri, 19 Jun 2026 02:01:24 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Fri, 19 Jun 2026 02:01:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1781848884;
	 x=1781935284; bh=Z0UjJpH83NrY1QtM/oR/I0ZRI5oKx+yriZPFjdMbXx0=; b=
	DyQrtgZgq4sY7BTJgr5VNroyVSyKZLZAjftNXtLSZoyuMwuPk2yxXW52NWgPNdmG
	6+ijkWIIyY+UuhpRpcAHk3VIXN7q9JzjD0Yqsd3dBq2WerM6h9HKhClJYIjWVOxs
	OYJ9zvMPAIcSgFgjcKitfztyhlqFt1iFOCJx3Vdknq9u/sZaZj3tXn7pUDoAdqm1
	fEByWG098iW+ka4wK4sTu84zrOsai32kPx99IB8VthTH7tt9E6Z0NYwbztHhVFpu
	7fZ9o+KPWVS91Pt10xZlkboMmvf0qmMsOTCVhRMrTGWE550aWf9i76JkWwFyR3Jb
	/H5cmh8PIBiKp5BdpASVgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781848884; x=
	1781935284; bh=Z0UjJpH83NrY1QtM/oR/I0ZRI5oKx+yriZPFjdMbXx0=; b=g
	Npq9Dy/GanBmB6c9LopnPetMOqoZd9AvxQrQuR+fOG2Wi3fX0oPezktiM/I8F9va
	0LErn2eUnEWSs/mu5mntJV9IW8CnNfzttvMv+LWsF6OP1GdKTncAZ/BQH/Ax6rd6
	WbBG0tEdyydOa/KmxV/y1C9JaKQlo5Q8TOa53IqD77+814C7piSIi/CxgQ9DStJh
	LQ1UNDbh9GDr2mKMPFNN7YNiv3Z658IQ3uOz+caD0wONa6dNh1qxuyYROpzjkjSv
	9uPZcguA1rl6MimpwNMqdWCe2qyVdtOwK9f8nr69siUbUyWf3PTdKQ3uhOfKd7tw
	iRT6jrTjcrv88vgH6/vMg==
X-ME-Sender: <xms:M9s0apyPqaW8kFfXQgsOJQAmmrooaXolCOPYOJOfukbLIq9Q9Lu3yQ>
    <xme:M9s0akEhl2fBrkhRU--xcoj1n1xf9HJ9xMqQ-nTSctZMoH6451WS7gevkUMJ27iS3
    DROS24NHbTw_AWCraK0sn2p2iYbVUn4K0PfkOLCMr4lRJclEqVHs7vb>
X-ME-Proxy-Cause: dmFkZTFdWyJY0ofCk3xgWPQnl2PHVfKy3+6kQZ0oa+dM1gmOm0Wblccux2F1HkGcKcywIi
    5qWdVNlTA/064VU4H/HUgKpalwVOSvCr2HrPTK6H6WRHvux3YN2IWe1KijMnvM1ZjSVFnw
    2UdHcGa5lKpzAsS7RSq630W6n+8THly/TOqc7S0KkpsvoG1neRfoVsuuAiHB0fsNXIjJXl
    SRm7S1c1oJnHasx+kDXo2eOY8OYJjAdiALTvs3jwuDKj9y5Hh+IVDK7SB2GBCp4zAKa3CX
    PKmmNt8y/fuVRyimSQUjxEU+85glPiwQ9Xrlc//+ZNoq2dRVK6eO/aWpBd7vyuagYF0/BY
    cBj/Iw4Pn4TrCYxv1RB9Kj85ui7dkFIrwCGk2Smysh/tYpMI1rqIC7L7BzXO2pazoYFJif
    HFUK65YE/+fN9ie69VyBfdWSWezLaqcY/MFDaTGE/w3voNwsq4f0R2+zLni1eLYFhqbRlq
    4mg1NQg3E8rk53+EjOe84pOvtoNBVnZK5YKTunfYewyoS36IMD2R5f6W55GqfzYOHo/Us7
    jNro02o66GTY3PgHqAcWotlqgM7jfn1soIseNa5TUtPnbRwObJQpp0ivE2xXGhRkhsrgbl
    iH0LzJrudDlQPbj2SYXfnANpRHHgxdHECkwLO6c9PdZQpt6AwC9CBf8NGPJg
X-ME-Proxy: <xmx:M9s0aozXekox8WWceOTTJQBFjqv-llg93fYJRluo741TQsKah6xBqA>
    <xmx:M9s0aoSMvRHOo9pUnKlpW7jb4i4ZZyetEWvBxcJk7PMrPJGWe-GizA>
    <xmx:M9s0asi8Zl5OyVdfVxOEtcs4ijdPo2woqWBbp5McJdxlVpoXzEhLBQ>
    <xmx:M9s0annxbSoacjWaYQQPOc6ZG4j2orEk4n0zH1kM1Ami6wU0I6LoXw>
    <xmx:NNs0akYCSRIxjeHExJbYQ_zo_lnz-M1Zir_UX-7n49c69yOIIZDS_dDw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B95CF1820082; Fri, 19 Jun 2026 02:01:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AWuee1yndYv3
Date: Fri, 19 Jun 2026 08:01:03 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Kees Cook" <kees@kernel.org>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Alexander Potapenko" <glider@google.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "David Laight" <david.laight.linux@gmail.com>,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <5d25357f-12a0-43d8-9299-7b5a92e04a68@app.fastmail.com>
In-Reply-To: <202606182054.A55B6CEE@keescook>
References: <20260618142951.1739694-1-arnd@kernel.org>
 <202606182054.A55B6CEE@keescook>
Subject: Re: [PATCH] KMSAN: fix memset() when using fortify-source, again
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Jun 19, 2026, at 05:55, Kees Cook wrote:
> On Thu, Jun 18, 2026 at 04:29:43PM +0200, Arnd Bergmann wrote:
>> Fixes: ff901d80fff6 ("x86: kmsan: use __msan_ string functions where possible.")
>> Fixes: 78a498c3a227 ("x86: fortify: kmsan: fix KMSAN fortify builds")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>> The patch passes randconfig builds on x86/arm/arm64/s390 for me,
>> but please double-check all the corner cases, as it's still
>> possible that the #ifndef is required to work around a runtime
>> issue that I did not test.
>
> How about I drop this into -next right after -rc2 and we can see what
> falls out of it?

Sounds good, thanks!

     Arnd
