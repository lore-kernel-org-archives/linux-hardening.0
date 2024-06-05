Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EB6145341;
	Wed,  5 Jun 2024 11:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717587240; cv=none; b=cMMo4D8xcNApQl/CY9hwM1eBY/kM+w/i+a5D+Va+UMPKYhiDhuFH7DTZVXsa0J+3ygiB7WSyJuRFyE6FcBscrMBmmv3/02R3bTmOeOsaoefIXVpddXcG8qk/Oe339mTHlNIJO75kFGK6qGyRjU05zmc1HFkIjgsBh9elbCYI+lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717587240; c=relaxed/simple;
	bh=b1OcgW8wUSyivcgWbQC7y0JYwv52L9er4YfBuZGvmdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gtmoZ6Llg5kByiU3AwOjnCTz7F/lJD3YSSG351VdVAHjdIGLAVITeI2wDa4PXoJPhI5pcg2uHtXPQ+dR4fPp5f6kmO2A3JWpnlzvwdoy0CT9XpkpnZx2Yi/zwnQGIssHppA8fJFdz70qCxKQxaqVU6tmfFqB6VXFsRgPDiRsyYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Ycssa+al; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Ycssa+al"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9469540E0184;
	Wed,  5 Jun 2024 11:33:56 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ojFs060G7dlj; Wed,  5 Jun 2024 11:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717587232; bh=2L6sv+ET0LaoOrBxBmQEBSmnDbAmhN4YLVNcSuW3cSY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ycssa+al5Tr5ayCRsGg+jI2pTXGnrQT+p5jY6Z7tfICj7WvfAOdrvJkND7nl1l2JX
	 H+y+deL4856Vfu/SWHPW/ljLc5X4niQsNd4ypHWdc4RLcGT8O8HkjBjajzZv8VDX90
	 IlHwUOJYWpBmQJvTlKd3WwKknWCwtUXrHoTvkscfzRgDIV0W65G1c1Fn7HLJBmZglH
	 2EYIseq9dkJqzcttHsifN3VI8zTG9FscO4mpqbdwgIkIe3R6evVM6HTKyQ2AWct+c1
	 IHPLyf2tZoXb9kB8uN24gO2HIa2mAuybHfwYeomyyU6oMSa890H52HYDoNZgOyXgco
	 6LGKlyxkmBPoaq7XmO5BBz9D2SpndH9lioT/cjL5P0GAV5S/AvEnvtlCGBnodJPlxC
	 k0Eywo+3w9fVgZIm0xZhh9eHO9c0uwW8mevpbJDrRryqfEszrwJESllDd++mfMCvSG
	 rpv1OnvKGUpyneZhCpTQDGdGA8ie5HMS1wuMgX+PKl16qltMf8CXJRls+rzfUdl++R
	 TF0jG3+p8l1Vv6NZeL1ELFy2mkLd3O89MhPSPyF2s1/xQoFgj7qXDk0oxqYa6g5lMH
	 +K66+OP7JZKc5girvTyibrWdFSHg8U9BBSOToBl0L7F5OZSA6WPfvkrKNAfBCSNJiq
	 1NAqipZ8iJHdPqXKm4UQnJaM=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9DEF240E0177;
	Wed,  5 Jun 2024 11:33:29 +0000 (UTC)
Date: Wed, 5 Jun 2024 13:33:23 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Dave Hansen <dave.hansen@intel.com>, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
	mat.jonczyk@o2.pl, rdunlap@infradead.org,
	alexandre.belloni@bootlin.com, mario.limonciello@amd.com,
	yaolu@kylinos.cn, bhelgaas@google.com, justinstitt@google.com,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	CobeChen@zhaoxin.com, TimGuo@zhaoxin.com, LeoLiu-oc@zhaoxin.com
Subject: Re: [PATCH] x86/hpet: Read HPET directly if panic in progress
Message-ID: <20240605113323.GFZmBNA7ec2s191_2w@fat_crate.local>
References: <20240528063836.5248-1-TonyWWang-oc@zhaoxin.com>
 <50fc1bd3-909e-41c4-a991-9d81e32ef92c@intel.com>
 <87wmnda8mc.ffs@tglx>
 <CAHk-=wgMoeOTL1V3wTO=o=U1OXn7xF8OWv2hB9NF9Z=G4KotfQ@mail.gmail.com>
 <87le3t9i8c.ffs@tglx>
 <0aff3f62-a8a5-4358-ae3f-2ded339aface@zhaoxin.com>
 <20240605093609.GCZmAxidNIBP5bkDcX@fat_crate.local>
 <e4f307dd-3264-45f6-82eb-0102f7fb99d7@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e4f307dd-3264-45f6-82eb-0102f7fb99d7@zhaoxin.com>

On Wed, Jun 05, 2024 at 06:10:07PM +0800, Tony W Wang-oc wrote:
> It may also happen without setting fake_panic, such as an MCE error of the
> UCNA/SRAO type occurred?

Which types exactly do you mean when you're looking at the severities[]
array in severity.c?

And what scenario are you talking about?

To get an #MC exception and detect only UCNA/SRAO errors? Can that even
happen on any hardware?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
