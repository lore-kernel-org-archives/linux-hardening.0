Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D98303CB4;
	Thu,  6 Nov 2025 14:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762437746; cv=none; b=ZNJvLWqFwtSYGlzDy/04PWPwY1CdteN1qkFGQvYe6U1iPKuiQ1mDPVyd1yz40SDchMVgLAVX6Z9PcelC6sAi9OMjNTFK4alc8/yDpa5MiePet2m1ufBDmcENk/cCKCU/E72mRuxUJPddfiECBSNcMx8kPQmKHSbyjp3Qii3Noeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762437746; c=relaxed/simple;
	bh=hiQQw6k86ZVHtOXveAjwjSs/SFXI36atd+KcmN4uR6U=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=KxgZ5lGsoyN+nB7hhywql+KzioSxK+/FTOs96sniVpo10DyPdbXP/yPdd6DuVya5UcfD+PyQHhBzi30kETk/VoDggVQhRrOT8A9pEPSKSERsHH8XUjDL4uHf6+VxYEyhjsVJQQYfeuDZWeFBvgMoECc3QnrNnT9NlPw2wkDNbtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SKJOV6V8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKJOV6V8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE6B1C4CEFB;
	Thu,  6 Nov 2025 14:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762437745;
	bh=hiQQw6k86ZVHtOXveAjwjSs/SFXI36atd+KcmN4uR6U=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=SKJOV6V8NNXUmOgJUCVDxPTxCRUG3LhVH2hz17HmwIjUL1VOET0PiuylvL2SNqvEX
	 iVUbC5eumzOQrcsBCPramUlOdj4PswFkDO7xSzdW+KOE0YLYna1sOw8yonXiq59R+h
	 K1sEiPkHqyUGoOzsnfMX8UwJ/JsqL23kruSnhMWWxsq5An2Yca5SRQTUsI13CBbWRv
	 3GnIzJyDDLu0ZeBqvAeVxVRJfJhUTkheJTiSx74WC5HnWhwII3ZRMcYs3l8nUm2LcF
	 KpjfG96FvbJnWdIpG2eqFTTOG0wTdV0kk8HrFmkXA6R3y5iR5ZgxAToVMnwiJJwiED
	 aAKIrGYjx1KXw==
Date: Thu, 06 Nov 2025 06:02:23 -0800
From: Kees Cook <kees@kernel.org>
To: =?UTF-8?Q?Valdis_Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
 Amit Dhingra <mechanicalamit@gmail.com>
CC: =?ISO-8859-1?Q?Timur_Krist=F3f?= <timur.kristof@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>, Leo Li <sunpeng.li@amd.com>,
 David Airlie <airlied@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: linux-next-20251029 - build error in amdgpu
User-Agent: K-9 Mail for Android
In-Reply-To: <105884.1762399131@turing-police>
References: <1043551.1761844832@turing-police> <32ed124e9d603cad950c4836c7a14a3ba8bc2068.camel@gmail.com> <1296761.1762045181@turing-police> <CAFF-SiU3XL5pZAzsB=eXi7e1LKzx5XwiNOyfGpPXOnnc6uo2cw@mail.gmail.com> <CAO=gReF+sWpKZFa+wbtGxa3+wSjAQG1UMG3iJaDt2EOPmH-7mQ@mail.gmail.com> <105884.1762399131@turing-police>
Message-ID: <A9C2FED1-EFBF-48AD-A3C8-41DDD16F8AA1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On November 5, 2025 7:18:51 PM PST, "Valdis Kl=C4=93tnieks" <valdis=2Eklet=
nieks@vt=2Eedu> wrote:
>On Wed, 05 Nov 2025 18:34:05 -0800, Amit Dhingra said:
>
>> I have the same problem=2E
>>  =2E=2E=2E
>
>> Setting RANDSTRUCT_NONE=3Dy seems to stop the error=2E
>>
>> [1] https://lore=2Ekernel=2Eorg/all/2025062439-tamer-diner-68e9@gregkh/
>
>Wow=2E  I wouldn't have guessed that RANDSTRUCT would be the cause=2E=2E=
=2E
>However, RANDSTRUCT_NONE=3Dy does make dce_stream_encoder=2Ec compile cle=
anly=2E
>
><insert Twilight Zone theme music here>
>
>Adding Kees Cook and the linux-hardening list to the cc:, hope somebody h=
as an
>idea what's going on=2E

I'm surprised the stable team didn't find the associated fix in your linke=
d thread=2E It had the right Fixes tag:
https://lore=2Ekernel=2Eorg/all/20250502224156=2Ework=2E617-kees@kernel=2E=
org/

Regardless, just remove the "0" from the dce110_an_str_enc_funcs initializ=
er; that's an older code pattern that isn't needed any more=2E

Randstruct requires designated initializers, though I thought the macro tu=
rned that on universally, so the fact that the error is only present with r=
andstruct seems like a separate bug=2E

-Kees

--=20
Kees Cook
