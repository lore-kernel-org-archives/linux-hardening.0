Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793781884;
	b=lNRGnhdA9DUGif8fs/O41mdb/XrPYX2sqhvrt8RA9RGrVilbMK0ORhkoI/gnOJyM9U5s
	 9wOYSduxzjoHmJ0d/8vFl29YQt8AGgtZyox2jty/nGoDb+nuXcyOV/fbcKyEzWLXAvyiv
	 SX+P2Z1GD45z5ZSnsux5BapUtUkLMV4+ZrW+8h7pa3HoYc3lZwbxYkFaIC6iYNXKZyzml
	 Q5PQ2GtAAxPYSAaOHEb+FBPoMmCkvgECdjzM7LwKE6W520bnZwi3P0z7ly0Vk0ROeR8If
	 5QKb6VNE+q9ro8sdJB0eFgShBAg9LEuPevEOll4lRQGkF+oNffum9JcRchyUM7MGijg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793781884;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=yUcMHykGBsdlMngLe5E8c5GRiAK228iYooBSZKs6auk=;
	b=v1WVhQ7j2tEMcKkZlSsdBh1qKq8QEIbK08StcHLAwt8jnRAuCYk0t/jgK/6urWkVUjkX
	 gXt515najhCskI4sh3X9KmTjtByME3B3xZ0e9vJ0Kv8i5/Sr9/qv4k929DPyAEavWS0PG
	 e6gFcZcxriULqsT1AXaFv70uZZKAUhIHbsKv+GNio4J1GrRoMoHtuFbPo5Xlw2cEJD9HG
	 Y4Yaottn4EUQJWEmZ1FRSJSHTV4b7nc7z2NJQ72QHV7i+mRtjKXIswQOBHWDaFMO7Fc51
	 jMvYXoHIw+CjwuqAm79vNAcJMatnPWjPdO2sh87kVH+FjJyacmArSj9efZhYQZ6jLiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=telaak.dev;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25C3606A32F
	for <linux-hardening@vger.kernel.org>; Wed,  4 Nov 2026 08:44:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B25C3606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telaak.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ae6b4c669fso1000196a91.0
        for <linux-hardening@vger.kernel.org>; Wed, 04 Nov 2026 00:44:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793781883; x=1794386683;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yUcMHykGBsdlMngLe5E8c5GRiAK228iYooBSZKs6auk=;
        b=sOmFVKnqEyDEmz8WikmfBCYeYLpgAz6Wb/0hCDDPVUAXQC9a0a6yeJStzf/NJaoWwq
         9+pQ2rS5EN/wVMgyW7layTeh340qZ6ZtMzDf61uacda1SDq8gujbhXxfuf65Qfw1kCKf
         1OKjE9T6r0mke3I7Sa8OIwwqSWBI4ZhkK1L3TAM5I4nTrcwEhkmC/FIh8jWnxBkvscLg
         AiAV3QzyUZTyUQGHYTh95sfJzXlfyP2fQzj/2EJEDMyJJab1wIRv5x/9rQCpV0L1L/yv
         TNqapM4qIKhGP4tZxjayI0mLbvetnCA2ZTRQnyC942y3Pm+Hl+pnVDyMVLnq/7DDQRw7
         t60Q==
X-Forwarded-Encrypted: i=1; AKwUvBzgD+9dsEeDCvnaDp6jTuGW80NZ0HWo3Ta4382TQK60csbRcOgLTGZfC8eQmcGh6IK9CISFzebDNmJcrWoM+3s=@vger.kernel.org
X-Gm-Message-State: APuU4Z8iS4NlZC8Ls2K+cZArypBqhlpQlpWm8QL1BAZLX/lWuDcyGntL
	w/wElC1OKI75X9LKxAm0P+ZoiL2rHS9BN1/mDkdMVDem/cN1NIhHyPLeb8z2jHmA
X-Gm-Gg: AYBFou3Pus3UK8c6y/jPwZTiz/jM/MpH6DbbBFyT0jogMrK1HYDU4R7LI+2ihe2DoeX
	qPkQDHTVFUzJYSEQ0TpYS9Wyi7+AVmkCMB+BGQE7WAl7gFhOHLSZfAFuGyZ4uy3mgrv5eSMkGGA
	pGPjjIvUPz9qwfvH7aOTd/giN+d8aA52ERZ4DlYNQt77jQ80vX1bDeEBZockPMuPvBbXN9/uSIO
	4EfX/o8/DHCaPDCevRuHt1N3s1v2JcMoWR3VMSM6NFZJKEvkcofbLrN2XJRVu2nOHyVsjdosDBW
	DKmI5etIGXpDrIdjKdJqVIAI1XNyqtz9+plXErxJxFPpBetSb/Vp9436+6s+3iSz0E6fKLVGUnF
	KfbEzO4pVedG0oTE1APFzlFUaG8VxLlyiSnnV0WPK9zTAph9uvSJLp3xZHSy6DtrUN2dg7mTnUO
	Pk/TQl+k7zoVO/HjfioJPpe3eMy4oL8kOwbv+SV1mHe590zmrEU2Mj5vr7JqhzsjwhAoHWykn6W
	+iWNZWifm8yQtJzusho40bzxc8QXYBjAGkOjtVD/unjg5FzSmMUgH1TFxb6m6RNcYYsCOlMD+UW
	DrAZmC0QKCAtckGKFZFs4lQupTn+1S3L5KE5gBPcHDxt7cOQiYcMHegwt4vDtkgJWZXUOPqKwXQ
	7qjJoledMQV+6Yk470DBwhgDVAjNUIKJaeFAZvxlRmu4=
X-Received: by 2002:a17:90b:1b0d:b0:3ac:36c7:c144 with SMTP id 98e67ed59e1d1-3ae89776936mr8643944a91.28.1793781882983;
        Wed, 04 Nov 2026 00:44:42 -0800 (PST)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com. [74.125.82.179])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c896cc6sm8143095a91.9.2026.11.04.00.44.42
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 00:44:42 -0800 (PST)
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-36c9a93a1abso360526eec.1
        for <linux-hardening@vger.kernel.org>; Wed, 04 Nov 2026 00:44:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBzKmyBYJ8DT+XNIMFTiHT31FX6j+/dlpO0lclGJF2QpIUdoMDQNL2P5YRlnlqEnaw6lJsFWRvZ6yyIPQh2BjOc=@vger.kernel.org
X-Received: by 2002:a05:7300:c5a7:b0:36c:a1bc:6102 with SMTP id
 5a478bee46e88-36ca1bc68a8mr2873501eec.0.1793781881630; Wed, 04 Nov 2026
 00:44:41 -0800 (PST)
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
In-Reply-To: <20261102-enthusiastic-flounder-of-domination-fb3a01@quoll>
From: Joseph Telaak <joseph@telaak.dev>
Date: Wed, 4 Nov 2026 03:44:30 -0500
X-Gmail-Original-Message-ID: <CAPY4CJ4cm117fjoZa302TKRmok_NnO62HhBWTSpNEzD8qAacdg@mail.gmail.com>
X-Gm-Features: AclHuK9nnsy6U4khk5cNnlQ4F7O21MbUU3fY_2pf7x3dkjkCudC-yc-EGP9flSY
Message-ID: <CAPY4CJ4cm117fjoZa302TKRmok_NnO62HhBWTSpNEzD8qAacdg@mail.gmail.com>
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

> Drop.
>
> Please run scripts/checkpatch.pl on the patches and fix reported
> warnings. After that, run also 'scripts/checkpatch.pl --strict' on the
> patches and (probably) fix more warnings.

Thanks, v2 drops it, and the series is clean with checkpatch and
checkpatch --strict.
