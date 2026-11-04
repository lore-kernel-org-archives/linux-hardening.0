Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793782888;
	b=np0CBFdQt8lZezou5rlB20oFf1FbdxNxdNifYVQ/aXGqs6qGkIXjyrAyrQrPbeaKKdZl
	 F4DG074RE5kD90otTeO2dU9+IBNJsRVQkYrFbU48TJqP0Qc18xrBPpBnOugRC3uLEccbk
	 4iEKWnfiZpbs1coM/Sc+af1uqr6xR2/LyOl8PoFOx1FLjZv7M1BrPA8NKzrnj69mE8cx+
	 xJP31bcvTXBtVV6sSl0lOMMwV217HsFpjODdiE5/JMu0C7F+kO35qjeIlrt3f+s4UaZ0x
	 IH5YAAf+fyXv2M5elu8hXylMO9n1XTVqm5HyrjjHL9Y9bwnNTubKRq8Cn8y2HKlDoXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793782888;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=AaKiM9W+fdOJ7e3/KZVbbDmGDM/hjoRoSVQ8Q/hFZsc=;
	b=gMpHpwfqItkDbF0HHv600r1v9FgEz5DHR7OjHkyyPpvAKSUU3e9zN/rdOxDNC1Lacxto
	 lUQR0D2MH3fDWpe4Zob0DZKPjnFasbqScHzHA7O9geOIX+bW5EnNHAqECSn+Wi1DwPuDP
	 buCkEdaLnWUCJlc2s+AatL7EjPUgfvnxqqumtBS7Dsg1YidFK23Tsh46Kxn5u+aqh6kXm
	 +iwkeHE9nnMQGAaKtkPfw5Lc6T53fiia+ls9V71xfboR+CMU9Dw/eZqA5cDj/MD6A+yXp
	 Av8idDey1ROlrPYmgqWqhhPR7HgYV4wiiXW6tXPzhI+R3d/zvBPhrXiJ8KYoUCXhF0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=telaak.dev;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DBE606A333
	for <linux-hardening@vger.kernel.org>; Wed,  4 Nov 2026 09:01:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4DBE606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telaak.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8a058315c79so253025b3a.3
        for <linux-hardening@vger.kernel.org>; Wed, 04 Nov 2026 01:01:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793782887; x=1794387687;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AaKiM9W+fdOJ7e3/KZVbbDmGDM/hjoRoSVQ8Q/hFZsc=;
        b=QyKfyN2Go5EtO11Vs5lBjj5qqOVTGlOMNqQCG4O4yjQg6pCnNeEDGmyeZhHnSR8lTQ
         1c4jAD+GFUw68mqkBAbZLgK7MK55d8+QOzF987mnl9tlhkiDURMTpaM5GOS+NsffmJvo
         OQf9tEHw309netEUleWyPz9nCWF8aH/hITUwLmCb3Q0zsTYXQGf/wiBhcLO6Pa8+V79B
         WZh9PT/cUVU8afLp4BMpy9Jt2oGZSq6xk+axAO/M9kD/q76SZ622BFiXP3RZB82yn7o+
         v4PRKCfxxGnh6qUwRzBViSH+D3wDblFl0vpl81l/Rk5TPmV7Z5F4NZPOBFqvasdut4DR
         ldoQ==
X-Forwarded-Encrypted: i=1; AKwUvByceyL5p2+NdHp5KBV2UnojDjAfZsJxWEV5lrkufuBOivil6a1RPnkLmbjYPL0X7GL1Ne2pMCAxroo0RJkLfW0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Tm2CQtBmIkP2pBinxt4pL+pjbHXglU9JRCfHCCm788OpoMLgq
	GP53dS0LYlhOlM+4nCNV7FJRDQoPvCTEKRmIX2yEn8nKVGSTMlDInrC6eliikXu/
X-Gm-Gg: AYBFou2V6HM6BN9c21SkJQ+A7gHu6Xp9+DVbICbtrRrqz41vp/+mWokLNpSYndDnTbo
	STPhD1j7pG1trw/3jVxGurLHxDx2zOR+y3MC8JEMVdygloR++n4Xa4zXtv9dz/boYTVVMRJWavt
	q5domHAhsjVZ8N+BmLbGUFqmbxSZYRFZb+LcUWas8Y7dRDKWLel9pEdX9sHS2dDU10sqrODCJDh
	ThgeQon94c35j5GSu4+oS3tOqI5r7Fwy5qw+d9shFOy4FFIZSZjyzmqr3xdXZd5O/2rsyVoUYvo
	TK8c4mSInZioDptrXzIZ9e3Nnseai5hBQDxu7L4HggkEegJk5zC432NOubxBbayr7un8/3fuB4g
	RddjmMQhmLO9175VSHqumcALsXw0G10Jj/5ypGTDuqoSHOVY7Kzg9e8M3sgcXSmOgp3mNlGQqJn
	Q+oktg8WDtgbY4Rx5qynvfouZ4JpQJmHU0m+Cp/CAjPRArkXaAkuZV/vb122ZmzWl088j2Cb5CK
	Ybgn48ssnmRr1n33HCrROPbKl86kR/UoKL6WTQa1MeaaPEwp0HN03TSetwt40/20vUrZ3iJ07Zr
	Mt8/TzSktErUbE9iQ8lhkyGIJfLEBzocx1mZ9BGexPT+Cm9V7gCuXD73sLiaTlyBXOD5g13W7Op
	LqhnMdrGDQRuxfiI668qO/8wdf7/qg4j1PO79gKCGCXs=
X-Received: by 2002:a05:6a00:2d96:b0:874:705d:f65d with SMTP id d2e1a72fcca58-8a9be29dae5mr11359482b3a.43.1793782886880;
        Wed, 04 Nov 2026 01:01:26 -0800 (PST)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com. [74.125.82.179])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b09b569495sm649498b3a.37.2026.11.04.01.01.25
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 01:01:25 -0800 (PST)
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-36a18fc7a38so992537eec.1
        for <linux-hardening@vger.kernel.org>; Wed, 04 Nov 2026 01:01:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvByt06xsG0AU8G1VuKKtv4aaSMtlovwhgK87bMc9Y+Vk3IserSUeAVH49osuTmiMJlm1Y7mhz+R5g7+j4oTVOT4=@vger.kernel.org
X-Received: by 2002:a05:693c:4144:10b0:35d:4185:5395 with SMTP id
 5a478bee46e88-36a423a205fmr27260638eec.16.1793782884949; Wed, 04 Nov 2026
 01:01:24 -0800 (PST)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261101-ktd202x-et6326-v1-0-eb51eddad08c@telaak.dev>
 <20261101-ktd202x-et6326-v1-5-eb51eddad08c@telaak.dev> <20261102-enthusiastic-flounder-of-domination-fb3a01@quoll>
 <CAPY4CJ4cm117fjoZa302TKRmok_NnO62HhBWTSpNEzD8qAacdg@mail.gmail.com> <4fb6c428-85fd-4674-8480-919191db1277@kernel.org>
In-Reply-To: <4fb6c428-85fd-4674-8480-919191db1277@kernel.org>
From: Joseph Telaak <joseph@telaak.dev>
Date: Wed, 4 Nov 2026 04:01:13 -0500
X-Gmail-Original-Message-ID: <CAPY4CJ7CY6hitrp7xk6=r65EEQNYc74RYg-BjVSJo=6UBLq36g@mail.gmail.com>
X-Gm-Features: AclHuK9uQeJIR1NfXJqyf9nbtbfdJiELHYiw7wy3ZTo2enB8PX2i4vU_7m4oveI
Message-ID: <CAPY4CJ7CY6hitrp7xk6=r65EEQNYc74RYg-BjVSJo=6UBLq36g@mail.gmail.com>
Subject: Re: [PATCH 05/10] dt-bindings: leds: kinetic,ktd202x: Add Etek ET6326
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Griffin Kroah-Hartman <griffin@kroah.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	=?UTF-8?Q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, linux-leds@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> No, it is not. It has clear and obvious checkpatch warning.

Sorry, my wording was ambiguous. I meant that I've fixed it in v2,
which I haven't sent yet, and v2 passes checkpatch --strict; v1
doesn't.
