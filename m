Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F306C1EB25;
	Fri, 17 May 2024 08:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715935783; cv=none; b=usHSHjtP/gxKXlFr65LbPHSS319fpdjxQfn+NtoQn9jr4l9WsKc2LPjCQwIDfeUPv2GksnX7UNxl4XdP4NZlAIXmnnYiqfjeY3qpjhJzeYN/Pflweg9CBUGjVwZdFCyW6WEEeiumxncJWXC2NTxrXCKi/YAEmh+gPXwzIjsJmlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715935783; c=relaxed/simple;
	bh=bHB9Jyod00NwPI/ne8odhL2AXmhmNsER6T4TKlS22BE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rUhNZ+wpTj2Du0o5wNLN1OCyuPJ3Uhj8NhrGs813gcO/UapHlYBMoHBuqgLlsiP/qVTwIjUjq/EGq0vnZaJb2ygNA0AQZZrh+I10eFMr5Cw7gwH+WGDGTpXZXBIRFoJGm42JWOx6zgo1zDsZUzKaPlLJLLNQ+pE86br5c319FTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4aNoSl0x; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=87ZEWj6b; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4aNoSl0x";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="87ZEWj6b"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715935780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Deoi2GZ+KDWE4R9eV3dkdUKvxWuoHOIQHWloV/mCKL4=;
	b=4aNoSl0xm0exphB7zLPX4O07pTlF7cp+mBPwN/zAxbZqJIbC8lckN9/vs4IsFyD6ldzLUw
	B64g3UhkXU6++iwIRip4SIjXYXfCs1tfb79f/rYZ/Fq+86OjpcKn9ZeBYsrejidJO65BvK
	ruNAVnKvaRVQ6K6Usqq8hZcknyXlWPpV6E3zMQ+gTdMl8LrIIlrikycUB3RePTyy6nIF8I
	kLkBqA3mM5tDWWCPzvj2CEBFr+KecCpbH9giWbljmgZMDazagn7l8VNN77q8bBcAPrrdHN
	hDX5pqzl29PQEwBkZGoS3BENzfz2K/xZxVQUZUT4y4uBpD8savGmdFX41l6oKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715935780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Deoi2GZ+KDWE4R9eV3dkdUKvxWuoHOIQHWloV/mCKL4=;
	b=87ZEWj6b2Wq4yvgsK9yoA17pwUSQUTuSHPGEib5DWhmlaRGQG+Gm6gWqR+2hCtuVF+0TZZ
	UYNvqs88L5fWLKBw==
To: Justin Stitt <justinstitt@google.com>
Cc: John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ntp: remove accidental integer wrap-around
In-Reply-To: <CAFhGd8p94sHpDc8MApZK7q9iEQ_C8c5frwZx9v_bTnhwtAM=HQ@mail.gmail.com>
References: <20240507-b4-sio-ntp-usec-v1-1-15003fc9c2b4@google.com>
 <87v83gllv8.ffs@tglx>
 <CAFhGd8p94sHpDc8MApZK7q9iEQ_C8c5frwZx9v_bTnhwtAM=HQ@mail.gmail.com>
Date: Fri, 17 May 2024 10:49:39 +0200
Message-ID: <87ttiwkel8.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, May 16 2024 at 16:40, Justin Stitt wrote:
> On Tue, May 14, 2024 at 3:38=E2=80=AFAM Thomas Gleixner <tglx@linutronix.=
de> wrote:
>> So how can 0xf42400 + 500000/1000 overflow in the first place?
>>
>> It can't unless time_maxerror is somehow initialized to a bogus
>> value and indeed it is:
>>
>> process_adjtimex_modes()
>>         ....
>>         if (txc->modes & ADJ_MAXERROR)
>>                 time_maxerror =3D txc->maxerror;
>>
>> So that wants to be fixed and not the symptom.
>
> Isn't this usually supplied from the user and can be some pretty
> random stuff?

Sure it comes from user space and can contain random nonsense as
syzkaller demonstrated.

> Are you suggesting we update timekeeping_validate_timex() to include a
> check to limit the maxerror field to (NTP_PHASE_LIMIT-(MAXFREQ /
> NSEC_PER_USEC))? It seems like we should handle the overflow case
> where it happens: in second_overflow().
>
> The clear intent of the existing code was to saturate at
> NTP_PHASE_LIMIT, they just did it in a way where the check itself
> triggers overflow sanitizers.

The clear intent of the code is to do saturation of a bound value.

Clearly the user space interface fails to validate the input to be in a
sane range and that makes you go and prevent the resulting overflow at
the usage site. Seriously?

Obviously the sanitizer detects the stupid in second_overflow(), but
that does not mean that the proper solution is to add overflow
protection to that code.

Tools are good to pin-point symptoms, but they are by definition
patently bad in root cause analysis. Otherwise we could just let the
tool write the "fix".

The obvious first question in such a case is to ask _WHY_ does
time_maxerror have a bogus value, which clearly cannot be achieved from
regular operation.

Once you figured out that the only way to set time_maxerror to a bogus
value is the user space interface the obvious follow up question is
whether such a value has to be considered as valid or not.

As it is obviously invalid the logical consequence is to add a sanity
check and reject that nonsense at that boundary, no?

Thanks,

        tglx
