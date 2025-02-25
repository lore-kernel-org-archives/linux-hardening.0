Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6D526A0DD;
	Tue, 25 Feb 2025 14:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740492013; cv=none; b=msHN4pJgBHzejLN1EL4+oNmeinEnxtHLCZ+psu2UE5n8MIz3qVo9vNNvPcahkBIUQUjM3ek39B4GmP522M+7zXY0GQ7qZgys5+AvHQ9LtQoe7Qk0f93Jro3ZB2gvaFuLGRK8w8iiTCpunWlMstljrwglE9HZLsC6Ab3ODpnfj0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740492013; c=relaxed/simple;
	bh=BhCL6BrxT5nxXUnjaAAPt59Z+GHxn/wDdR1kkVg1Rm4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FWgcrdRfdWml/8eG9Vd7+NnbhvMH0lx9JL/TFhgpk9TRWwcngHBvWBQTEwyob2o1AxPRzptU+XGcV34t7ceoVnuTz9wSUzeM36tvHaRz7OCZwfAT8xVmoAU+I8dHxfwn52gljbHgcN5DpRrm+aSllhJXEIna/pN0Yrd+1PP3dso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=aM2+WPQg; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="aM2+WPQg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=BhCL6BrxT5nxXUnjaAAPt59Z+GHxn/wDdR1kkVg1Rm4=;
	t=1740492011; x=1741701611; b=aM2+WPQg6iPWjHrA5a9ox26oKSMNx99B6vHhRmoarPMdXev
	U8aUwZOCHJ8DEiN9y20cBqcwKhjYJXlnCz56kgeV/AF2EKYU9Ji+t2aa0OSC+xKQCXcgo4CmGusG8
	SdUMwYlzr3BG+lUV4/gkxmcDKuDa4mwPaNoiCLNCjm1qCYZQq+owAAFhfmdik2pb3JDj4whKR3Dvn
	L7Lr+444FWcKeIM0uEve8xyY+pkCXyrgeC/AQAY3XuBZNWG9E1p3PnNa9W8XIgUUBq2h0999MQLR7
	7eoryFxOFtAD02i+3lT5ZSB/+ObqKAJ1mGBb8ETWEkpZsMUPE7AIdMPwVOwS7dMg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tmvTB-00000009va0-3KcC;
	Tue, 25 Feb 2025 14:59:34 +0100
Message-ID: <47a3d0c82e716c1838d76d079c89d230d2d1fe19.camel@sipsolutions.net>
Subject: Re: [PATCH v7 5/7] mseal, system mappings: enable uml architecture
From: Johannes Berg <johannes@sipsolutions.net>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Benjamin Berg
	 <benjamin@sipsolutions.net>
Cc: "jeffxu@chromium.org" <jeffxu@chromium.org>, "Jason@zx2c4.com"	
 <Jason@zx2c4.com>, "adobriyan@gmail.com" <adobriyan@gmail.com>,
 "deller@gmx.de"	 <deller@gmx.de>, "gerg@kernel.org" <gerg@kernel.org>, 
 "anna-maria@linutronix.de"	 <anna-maria@linutronix.de>,
 "davem@davemloft.net" <davem@davemloft.net>,  "avagin@gmail.com"	
 <avagin@gmail.com>, "mhocko@suse.com" <mhocko@suse.com>, "enh@google.com"	
 <enh@google.com>, "thomas.weissschuh@linutronix.de"	
 <thomas.weissschuh@linutronix.de>, "hch@lst.de" <hch@lst.de>, 
 "hca@linux.ibm.com"	 <hca@linux.ibm.com>, "peterz@infradead.org"
 <peterz@infradead.org>,  "adhemerval.zanella@linaro.org"	
 <adhemerval.zanella@linaro.org>, "linux-kernel@vger.kernel.org"	
 <linux-kernel@vger.kernel.org>, "ojeda@kernel.org" <ojeda@kernel.org>, 
 "jannh@google.com"	 <jannh@google.com>, "f.fainelli@gmail.com"
 <f.fainelli@gmail.com>,  "sroettger@google.com"	 <sroettger@google.com>,
 "ardb@google.com" <ardb@google.com>,  "jorgelo@chromium.org"	
 <jorgelo@chromium.org>, "rdunlap@infradead.org" <rdunlap@infradead.org>, 
 "mark.rutland@arm.com"	 <mark.rutland@arm.com>, "Liam.Howlett@oracle.com"
 <Liam.Howlett@oracle.com>,  "vbabka@suse.cz"	 <vbabka@suse.cz>,
 "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "oleg@redhat.com"	
 <oleg@redhat.com>, "willy@infradead.org" <willy@infradead.org>, 
 "keescook@chromium.org"	 <keescook@chromium.org>, "peterx@redhat.com"
 <peterx@redhat.com>,  "mike.rapoport@gmail.com"	 <mike.rapoport@gmail.com>,
 "mingo@kernel.org" <mingo@kernel.org>,  "rientjes@google.com"	
 <rientjes@google.com>, "groeck@chromium.org" <groeck@chromium.org>, 
 "linus.walleij@linaro.org"	 <linus.walleij@linaro.org>,
 "pedro.falcato@gmail.com" <pedro.falcato@gmail.com>,  "ardb@kernel.org"	
 <ardb@kernel.org>, "42.hyeyoo@gmail.com" <42.hyeyoo@gmail.com>, 
 "linux-mm@kvack.org"	 <linux-mm@kvack.org>,
 "linux-hardening@vger.kernel.org"	 <linux-hardening@vger.kernel.org>,
 "torvalds@linux-foundation.org"	 <torvalds@linux-foundation.org>,
 "akpm@linux-foundation.org"	 <akpm@linux-foundation.org>,
 "dave.hansen@linux.intel.com"	 <dave.hansen@linux.intel.com>,
 "aleksandr.mikhalitsyn@canonical.com"	 <aleksandr.mikhalitsyn@canonical.com>
Date: Tue, 25 Feb 2025 14:59:32 +0100
In-Reply-To: <19e81e87-7430-4e23-ac67-dbb987496dd4@lucifer.local>
References: <20250224225246.3712295-1-jeffxu@google.com>
	 <20250224225246.3712295-6-jeffxu@google.com>
	 <c5d3927e-06e3-49e7-a1d6-f4c9e817def4@lucifer.local>
	 <96ebddf3fe31353c89f6a4680eaeb2793c25cd09.camel@intel.com>
	 <d2aeeb56-ba8c-49f3-957d-1ac790522233@lucifer.local>
	 <7e91bea34552472757a8eec425d1d10643ca584b.camel@sipsolutions.net>
	 <19e81e87-7430-4e23-ac67-dbb987496dd4@lucifer.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2025-02-25 at 13:41 +0000, Lorenzo Stoakes wrote:
> > I figured it is not a lot of churn and there isn't really any cost to
> > enabling the feature.
> >=20
> > That said, the only possible real-life use case I can see is doing MM
> > subsystem testing using UML. We certainly do not need the feature to
> > run our UML based wireless stack and driver tests.
>=20
> OK ack - my concern is users getting confused about this ironic host
> vs. client thing, must disable the security feature in the _actual kernel=
_
> to enable it in the client.

Well, s/to enable it in the client/to run the client/, I guess.

I'm still a bit disappointed in the whole thing anyway - if this does
get enabled in e.g. ChromeOS (as it looks like), then it'll mean that
gvisor/rr/UML will never run on chromebooks, which ... I mean yeah who's
going to do that, so it's more of a purist disappointment I guess. Can't
run kunit on a chromebook then, for example. This looks much different
for more general purpose distros too.

I also don't really want to reopen a discussion that was probably had
before, but I did wonder now what the security downsides of having an
opt-out, e.g. a new ELF property, for skipping the sealings would be.
Perhaps, depending on the impact, even making that mean "no system
mappings at all", at least for UML I believe they're not needed in the
first place.


> I'm not sure this is really worth it?
>=20
> I mean I agree this isn't a _huge_ amount added here and I don't want to =
be
> difficult - Jeff, Kees are you really keen on having this? Do you have
> specific use cases in mind or was this just a 'because we can':>)

There's always kunit that can run with UML, but I don't see tests being
added for this feature, in fact the only thing here is _disabling_ a
test. Maybe it should come with tests and then it'd be more interesting
;-)

The commit says "Testing passes on UML" but I'm not sure I see what
testing that might have been, per the cover letter Benjamin did that?

> I guess if intent is to slowly add architectures, it's not totally insane
> since we kinda know this one is ok so if that's what it is, probably won'=
t
> oppose it _too_ badly.

I think it still makes _some_ sense to have it for the testing aspect,
but perhaps might then make sense to split it out of the series to avoid
all the confusion and submit it to UML separately later? Or just leave
it since you can always test with qemu.

johannes
