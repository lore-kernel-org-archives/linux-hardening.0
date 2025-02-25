Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE18268692;
	Tue, 25 Feb 2025 15:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740495977; cv=none; b=MhGLR7XQMUmKuesjtj+WD2lkfOIJx7h2L1qFrutxDbPI7bA7OTtM1na8EtSNVhnLgk6yiI/vjioTQf+xx1A4/HF+S5KF/d/wcYtdY6iE+2UuySFWP97FJYTOfl85i7owZ/43O0oE4JcDyg0GLE4EvO5z4wraFAmm55KCmvvtIoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740495977; c=relaxed/simple;
	bh=ulSlGShANn0qabJ6PwZZ9yBHZeUtO9LZVEnKl8528tc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=aNsBs8tvsk7xps94/MeQ3Fo17kZK5lBxKPD0qNXhEsG5DqUzcw2Zv6ktYMHE9LA83+hyDRNkkr6FHB6PPbA+N0x/x8QjvvKOg7bLe5GTydiX/J6PdwtMc3K+ajgV4isQsvErfrAENIk3z/duZ/0mtjrON6nV6TTlM7yMzhKb0zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZjmHLl4s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZjmHLl4s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E570AC4CEDD;
	Tue, 25 Feb 2025 15:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740495977;
	bh=ulSlGShANn0qabJ6PwZZ9yBHZeUtO9LZVEnKl8528tc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=ZjmHLl4sZAOy1F8GiI8E8GAiKPa5p7MSwqaQtXxYzGw1lXbbMPoC1vIM1vTXHDE1C
	 c4lWCmbEi/mIYjG1s4rOtAhvqeyyd4jEDGnnNnVa5dB/fp/Khy1h5TlavXOdDIHJiw
	 oHx4XaWEPVB0jlViX7Qc3tpS87j0ppDz3TW7gEKsJB0zTzwIGkCbXftF7ysnFKwGs/
	 hurOr1uaJZ1iNMf8vzSXGfLRCZHAZrYRIrmX4uhh7pr4zKPTfmOrOoSaDw7jhMBx6G
	 tYSI1/1WAzzP4TEugmX0mOEYpTLVWOfCvWoOzvnpEDsMDKp/nZyTIv5/is/Sn9nMgy
	 jrwQZeOmBeQmw==
Date: Tue, 25 Feb 2025 07:06:13 -0800
From: Kees Cook <kees@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Berg, Benjamin" <benjamin.berg@intel.com>
CC: "jeffxu@chromium.org" <jeffxu@chromium.org>,
 "Jason@zx2c4.com" <Jason@zx2c4.com>,
 "adobriyan@gmail.com" <adobriyan@gmail.com>, "deller@gmx.de" <deller@gmx.de>,
 "gerg@kernel.org" <gerg@kernel.org>,
 "anna-maria@linutronix.de" <anna-maria@linutronix.de>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "avagin@gmail.com" <avagin@gmail.com>, "mhocko@suse.com" <mhocko@suse.com>,
 "enh@google.com" <enh@google.com>,
 "thomas.weissschuh@linutronix.de" <thomas.weissschuh@linutronix.de>,
 "hch@lst.de" <hch@lst.de>, "hca@linux.ibm.com" <hca@linux.ibm.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "adhemerval.zanella@linaro.org" <adhemerval.zanella@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "ojeda@kernel.org" <ojeda@kernel.org>, "jannh@google.com" <jannh@google.com>,
 "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
 "sroettger@google.com" <sroettger@google.com>,
 "ardb@google.com" <ardb@google.com>,
 "jorgelo@chromium.org" <jorgelo@chromium.org>,
 "rdunlap@infradead.org" <rdunlap@infradead.org>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
 "vbabka@suse.cz" <vbabka@suse.cz>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
 "oleg@redhat.com" <oleg@redhat.com>,
 "willy@infradead.org" <willy@infradead.org>,
 "keescook@chromium.org" <keescook@chromium.org>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "mike.rapoport@gmail.com" <mike.rapoport@gmail.com>,
 "mingo@kernel.org" <mingo@kernel.org>,
 "rientjes@google.com" <rientjes@google.com>,
 "groeck@chromium.org" <groeck@chromium.org>,
 "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
 "pedro.falcato@gmail.com" <pedro.falcato@gmail.com>,
 "ardb@kernel.org" <ardb@kernel.org>,
 "42.hyeyoo@gmail.com" <42.hyeyoo@gmail.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
 "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
 "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "aleksandr.mikhalitsyn@canonical.com" <aleksandr.mikhalitsyn@canonical.com>
Subject: Re: [PATCH v7 5/7] mseal, system mappings: enable uml architecture
User-Agent: K-9 Mail for Android
In-Reply-To: <d2aeeb56-ba8c-49f3-957d-1ac790522233@lucifer.local>
References: <20250224225246.3712295-1-jeffxu@google.com> <20250224225246.3712295-6-jeffxu@google.com> <c5d3927e-06e3-49e7-a1d6-f4c9e817def4@lucifer.local> <96ebddf3fe31353c89f6a4680eaeb2793c25cd09.camel@intel.com> <d2aeeb56-ba8c-49f3-957d-1ac790522233@lucifer.local>
Message-ID: <DC169C8C-BF10-4125-AA91-29E48BB1AD6A@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On February 25, 2025 2:37:11 AM PST, Lorenzo Stoakes <lorenzo=2Estoakes@or=
acle=2Ecom> wrote:
>On Tue, Feb 25, 2025 at 08:45:21AM +0000, Berg, Benjamin wrote:
>> Hi,
>>
>> On Tue, 2025-02-25 at 06:22 +0000, Lorenzo Stoakes wrote:
>> > On Mon, Feb 24, 2025 at 10:52:44PM +0000, jeffxu@chromium=2Eorg=C2=A0=
wrote:
>> > > From: Jeff Xu <jeffxu@chromium=2Eorg>
>> > >
>> > > Provide support for CONFIG_MSEAL_SYSTEM_MAPPINGS on UML, covering
>> > > the vdso=2E
>> > >
>> > > Testing passes on UML=2E
>> >
>> > Maybe expand on this by stating that it has been confirmed by Benjami=
n (I
>> > _believe_) that UML has no need for problematic relocation so this is=
 known to
>> > be good=2E
>>
>> I may well be misreading this message, but this sounds to me that this
>> is a misinterpretation=2E So, just to clarify in case that is needed=2E
>>
>> CONFIG_MSEAL_SYSTEM_MAPPINGS does work fine for the UML kernel=2E
>> However, the UML kernel is a normal userspace application itself and
>> for this application to run, the host kernel must have the feature
>> disabled=2E
>>
>> So, UML supports the feature=2E But it still *cannot* run on a host
>> machine that has the feature enabled=2E
>
>Sigh ok=2E Apologies if I misunderstood=2E
>
>Is there any point having this for the 'guest' system? I mean security wi=
se are
>we concerned about sealing of system mappings?

UML guests are used for testing=2E For example, it's the default target fo=
r KUnit's scripts=2E Having sealing working in the guest seems generally us=
eful to me=2E

>
>I feel like having this here might just add confusion and churn if it's n=
ot
>useful=2E
>
>If this is useless for UML guest, let's just drop this patch=2E

But on the flip side, it's certainly not critical to have UML supported=2E=
 I guess I just don't see a down side to keeping the patch=2E

-Kees


--=20
Kees Cook
