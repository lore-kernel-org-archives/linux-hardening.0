Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A24221D92
	for <linux-hardening@vger.kernel.org>; Tue,  8 Jul 2025 06:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751957044; cv=none; b=IQsc012KpaOfZPGdS/lI2xYZ+kfvP2CUwbQIeCBZY/hd71edaCJh2GY5z4DtkZPxj6gcQDaeMvxAb3yoazGEQ4IOX7ALWPprxxN9vXZoahLEOKVfo5S7rk5dwuw4h0HDgUJVHEhCgSi4Eg4ATEmu43QB64/lPAilekSIeeWQFZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751957044; c=relaxed/simple;
	bh=VwcmJ/ZhvGTQZtfzPShfeClIbetsIVYAmTNQ+zOrI/Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z7sIQd07nYMTRjYHQBj0RPYHqnfxk+oI4JF0Vsbi4AsbFMsIp93CkK9F6upWj2vaKgeZDpTBFHCibrxTxAHNTz57Yh8B5dachUjH1ZV+hVUyu/i5T9CgySJwSpwpiNOu7xlp0Szj9+DUCMrnWfF5NWayFgcQQrLvhQo0v9xJlSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=W8RwA7Nl; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="W8RwA7Nl"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-553b3316160so4682465e87.2
        for <linux-hardening@vger.kernel.org>; Mon, 07 Jul 2025 23:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1751957040; x=1752561840; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VwcmJ/ZhvGTQZtfzPShfeClIbetsIVYAmTNQ+zOrI/Q=;
        b=W8RwA7NlpO7O2p6czkNsNu4slM6IhviQmFwW3pUq696RLuOQ2QKcIzQVFTgCLVFraG
         jAAsOO33Xr6aJUSmB+re1QPDnNH2TqzOaOuS57MbwKjooIU8iBNuQ7Dg5BmFQysA5+19
         Nn36YCwSqD06S3lMpvch8j/2sKf8+/K8rmbu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751957040; x=1752561840;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VwcmJ/ZhvGTQZtfzPShfeClIbetsIVYAmTNQ+zOrI/Q=;
        b=ixxQOfcTX366kN647qC8ty4vZ7KZDcUDqwlH85BGUcgOWOMGjokRXFQCiz8Qd161pp
         7RV1oDHVqON+377zaaE7f5PErm3nQKjGX8dyWwbX0vvwVfrA7WOG3k+H+6MaxH8b3gn3
         SChDV7XwveBTCH0M5YwGy7u2I7KXcz0kdSf2O0R+j/CPaGkB3ImVTFQWRuJs0ijFVYoQ
         jncwG4DqSizl2wBOSTSPweFvKvan64siWvs3QlNjCXhxFrlgbqH7gL1IYZ137KpDpKF0
         dImrmG2aL2Kjyh4KZGGnXOvFPsekPlkDXjIHbDCS4/IGCYMSPqinu+EvozDroyC5QXW7
         dgsg==
X-Forwarded-Encrypted: i=1; AJvYcCVKv7UnaYanC4oEwmEg6IB16CHpKBUVoRTpQaaYByGnPvi+Qn1+KJ3+ytbZGP8J1Yw6DRWVCYhae0pAGWG4ymg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmG+BgJQaZRytTqPKyOreRNMG/gYs+SwpE1rj8gYc9SWcm3EyQ
	rCtBMYJCK5iQurcjIvlWY6GAlzJR4uDeQA0EhbIgCrH7dcMVUusdS3igSyXJ9vJ9wvc=
X-Gm-Gg: ASbGncuKMhBdw02uickQntYRKjte/2dYxdDnTgV0m8dtz23FXOx63WsXUkSv6OOwSBc
	f4JLRVLaYd+KTEK1Po/BeVjDxhUX/g3XKuHWupQmtAvtMfHGqNSHBdVPYgt8dlXmBV9JraM3ixj
	10x5Agc0rj6mBO2v+QPkx65ofXso2kqE/VeQ7ft/caMzfp0Q4xZD+VFhIIXXIokgYUEA+MVCzUg
	MxOPBnXs35cp3iXje7TluKxJeY8peKBdg6nL4IgFfL6zBi6hl2emSHWOIPnWGFatHLhbcMa64hA
	/gwtC1Zi2srFh8QzzQBMq4vS7JBHBOVkPft4CG7D7UzZkH/zZmXKMXPM2pufvqB4
X-Google-Smtp-Source: AGHT+IGLpwW1oPOTvsZefKXTXlcktttg7ftS+Us6Recfkko3XFC9QR7DbsdqK2cC4ebFUT2MmTV7PQ==
X-Received: by 2002:a05:6512:230f:b0:553:388a:e794 with SMTP id 2adb3069b0e04-557a19df4f8mr5244040e87.17.1751957040069;
        Mon, 07 Jul 2025 23:44:00 -0700 (PDT)
Received: from localhost ([81.216.59.226])
        by smtp.gmail.com with UTF8SMTPSA id 38308e7fff4ca-32e1af83038sm14820851fa.14.2025.07.07.23.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 23:43:59 -0700 (PDT)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-mm@kvack.org,  linux-hardening@vger.kernel.org,  Kees Cook
 <kees@kernel.org>,  Christopher Bazley <chris.bazley.wg14@gmail.com>,
  shadow <~hallyn/shadow@lists.sr.ht>,  linux-kernel@vger.kernel.org,
  Andrew Morton <akpm@linux-foundation.org>,  kasan-dev@googlegroups.com,
  Dmitry Vyukov <dvyukov@google.com>,  Alexander Potapenko
 <glider@google.com>,  Marco Elver <elver@google.com>,  Christoph Lameter
 <cl@linux.com>,  David Rientjes <rientjes@google.com>,  Vlastimil Babka
 <vbabka@suse.cz>,  Roman Gushchin <roman.gushchin@linux.dev>,  Harry Yoo
 <harry.yoo@oracle.com>
Subject: Re: [RFC v1 0/3] Add and use seprintf() instead of less ergonomic APIs
In-Reply-To: <cover.1751747518.git.alx@kernel.org> (Alejandro Colomar's
	message of "Sat, 5 Jul 2025 22:33:47 +0200")
References: <cover.1751747518.git.alx@kernel.org>
Date: Tue, 08 Jul 2025 08:43:57 +0200
Message-ID: <87a55fw5aq.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Jul 05 2025, Alejandro Colomar <alx@kernel.org> wrote:

> On top of that, I have a question about the functions I'm adding,
> and the existing kernel snprintf(3): The standard snprintf(3)
> can fail (return -1), but the kernel one doesn't seem to return <0 ever.
> Should I assume that snprintf(3) doesn't fail here?

Yes. Just because the standard says it may return an error, as a QoI
thing the kernel's implementation never fails. That also means that we
do not ever do memory allocation or similar in the guts of vsnsprintf
(that would anyway be a mine field of locking bugs).

If we hit some invalid or unsupported format specifier (i.e. a bug in
the caller), we return early, but still report what we wrote until
hitting that.

Rasmus
