Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5D5171CE;
	Sun,  1 Oct 2023 15:27:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A124EC433C7;
	Sun,  1 Oct 2023 15:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696174021;
	bh=OP680lsN8lk0ineFcZVgu79J8KnTHUp5BT9RfTao+vk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=aUZj+oZx53xM+0Adszz/WePNjpsIy9M65UpjURU/NxSen1aEW+VD0g4cNi4O582tX
	 UdrVpyJrd0PnH8FSU4/PEfoCjVJLUwFMm83B7Ua7uaewX4UNOsO5EngyqnK8FLGyuk
	 Y+RdmiJPNpfVEh0V4Mg4EzU6j+5te3R8+zzqWLXFrswKW0yEntKN2nzWYc2vwW+88x
	 GDzfgx4kadbk+mgqoFA4GsZnG7h1JZdeHKVFv74F1iodxlTaCv1Y1p/P4vIpb4jNGN
	 mSJsW0vdj3syiTjlkdFdIHXGHSYrFPEnkXRLFQteTbYwaaettWQvWoAYA+q4gHrOXc
	 HibQudUhLOPHA==
Date: Sun, 01 Oct 2023 08:26:56 -0700
From: Kees Cook <kees@kernel.org>
To: Julia Lawall <julia.lawall@inria.fr>, Kees Cook <keescook@chromium.org>
CC: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Ian Abbott <abbotti@mev.co.uk>,
 H Hartley Sweeten <hsweeten@visionengravers.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] comedi: Annotate struct comedi_lrange with __counted_by
User-Agent: K-9 Mail for Android
In-Reply-To: <alpine.DEB.2.22.394.2310010945130.3166@hadrien>
References: <5c3b7459b820e22e2ac6ce892d4aadcc119cc919.1696065263.git.christophe.jaillet@wanadoo.fr> <202309301342.5B5BED40A1@keescook> <alpine.DEB.2.22.394.2310010945130.3166@hadrien>
Message-ID: <90E2BBA5-8A2D-42DE-B36A-CD37BABBB433@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 1, 2023 12:45:41 AM PDT, Julia Lawall <julia=2Elawall@inria=2Efr=
> wrote:
>
>
>On Sat, 30 Sep 2023, Kees Cook wrote:
>
>> On Sat, Sep 30, 2023 at 11:14:47AM +0200, Christophe JAILLET wrote:
>> > Prepare for the coming implementation by GCC and Clang of the __count=
ed_by
>> > attribute=2E Flexible array members annotated with __counted_by can h=
ave
>> > their accesses bounds-checked at run-time checking via CONFIG_UBSAN_B=
OUNDS
>> > (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-fam=
ily
>> > functions)=2E
>> >
>> > Signed-off-by: Christophe JAILLET <christophe=2Ejaillet@wanadoo=2Efr>
>> > ---
>> > This patch is part of a work done in parallel of what is currently wo=
rked
>> > on by Kees Cook=2E
>> >
>> > My patches are only related to corner cases that do NOT match the
>> > semantic of his Coccinelle script[1]=2E
>>
>> Nice!
>>
>> struct comedi_lrange {
>>         int length;
>>         struct comedi_krange range[];
>> };
>> =2E=2E=2E
>> static const struct comedi_lrange range_rti800_ai_10_bipolar =3D {
>>         4, {
>>                 BIP_RANGE(10),
>>                 BIP_RANGE(1),
>>                 BIP_RANGE(0=2E1),
>>                 BIP_RANGE(0=2E02)
>>         }
>> };
>>
>> I'm struggling to come up with a way for Coccinelle to find this kind o=
f
>> thing in other places=2E=2E=2E
>
>Kees, what exactly are you trying to match?  Static allocations?

I need to count the number of initialized elements in the flexible array t=
hat is the last member and see if it matches a value set in another member=
=2E

E=2Eg=2E the above sets 4 values for the last array member and then sets a=
nother member to 4=2E

-Kees


--=20
Kees Cook
