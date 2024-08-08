Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EF615EFB6;
	Thu,  8 Aug 2024 23:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723158666; cv=none; b=M43j5LeW2pEwUorb6hf64U+h2FlJlTMHZrKMou1ZKsdS3QerfJlr77IXsh03iqQJlzkrtHaC1mRtugbLM8ytBrKOA3s+1jG4pMs2Vhgk07xoyQXbLoNbk3Vebh7uV29dBnjPRidSJEPjNsJp64e5xBJCBJeH8S6IJjEYBQFQpIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723158666; c=relaxed/simple;
	bh=aOHb6LusMMRPMXEAanHSL5GIU+4+KgqN2z0DDHzY6kQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUdL8EEqR7Qyaj7/QfZa7JGkC7eWNWRBmwXUeaRWTGHAzZ74dn/v+ssIWij4QJGO8iuXd49LBXOauxhmwUjTExo05TU4wO7mfGGIVU0Bd1hM6I5NoWdrRsYHX+lo2p5kO0li04I68kuHCty7j7SdlquPMNdeD8sHoCC/Bg5Rbzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3g45c55; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3g45c55"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C01F1C32782;
	Thu,  8 Aug 2024 23:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723158665;
	bh=aOHb6LusMMRPMXEAanHSL5GIU+4+KgqN2z0DDHzY6kQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k3g45c55KqphM23ZBIu4vHRFLkGOEdjFuX3yl0rgAKVGLlUM1xC6Q29Djcze9Desm
	 f5TavoiCTXNJXwZj4j5pGYzAPbBf3tNk0q66ZyT6bCa+vFOgzDC2LrvPG6s+uEhSiD
	 4wSgskoLNU8AV9eIg1vc1Fk0/UaeDry8p8mnqbweo80XJmnMzMY/3/YUc3OWO+LZH6
	 7NLPL71hPFfapIrNJeT2vTiPKpD8TOTUlUXmRNUpWuwTHad4sY5LoouhQuUlJK7pDN
	 uj2xyUJZYZ3l8W5n4mcBc+PVJ2EG5e0h/Snk7MWETo0xbB2k/KIv2LYhZtG1CREos3
	 6L/9W0EKn1pug==
Date: Thu, 8 Aug 2024 16:11:05 -0700
From: Kees Cook <kees@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Justin Stitt <justinstitt@google.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] lib/string_helpers: rework overflow-dependent code
Message-ID: <202408081609.D08D11C@keescook>
References: <20240808-b4-string_helpers_caa133-v1-1-686a455167c4@google.com>
 <CAHp75VfBjKLf3LqDXvAehW5sxGzYnU4sS3fr=JoaM-6p_gR34w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VfBjKLf3LqDXvAehW5sxGzYnU4sS3fr=JoaM-6p_gR34w@mail.gmail.com>

On Fri, Aug 09, 2024 at 01:07:21AM +0300, Andy Shevchenko wrote:
> On Fri, Aug 9, 2024 at 12:44 AM Justin Stitt <justinstitt@google.com> wrote:
> >
> > When @size is 0, the desired behavior is to allow unlimited bytes to be
> > parsed. Currently, this relies on some intentional arithmetic overflow
> > where --size gives us SIZE_MAX when size is 0.
> >
> > Explicitly spell out the desired behavior without relying on intentional
> > overflow/underflow.
> 
> Hmm... but why? Overflow for the _unsigned_ types is okay. No?

Yes, it's well defined, but in trying to find a place to start making a
meaningful impact on unexpected wrap-around, after discussions with
Linus and Peter Zijlstra, we're going taking a stab at defining size_t
as not expecting to wrap. Justin has been collecting false positive
fixes while working on the compiler side of this, and I had asked him to
send this one now since I think it additionally helps with readability.

-- 
Kees Cook
