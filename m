Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74530303A18
	for <linux-hardening@vger.kernel.org>; Sun,  1 Mar 2026 02:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772333869; cv=none; b=LUXJtCaHceqBEm5ZEI0iuxpN6qp4U8ECddWJlxeazyRNst6Gqx6d0/wS1ho9JZ5NAS1mxa7SigW8dy1XnB7E0ge97oZYCcSXyTh0ucLr3MYDgUqlp0WylaG2EBej7W8/vtawCiK0Yfs21vYSEAxZ2OM/2myyxcF6n783GjSdYB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772333869; c=relaxed/simple;
	bh=v7j7u4Cgs/YgDdAJ7Cmwg6YLlgzhvBFEmlTEsg17hQE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=GgddxoZAmjzg0QRr8lPpDPmdaxgcram+cV+I6nKuWTckvHScbSNQqoByCew/B2qkGLoNUol6sZ4kHUdNWHrpetWO4EAm+odAUNa3jPNMlqOCWeBAgiI+tUrqvpZKljp460Doq5SKz7BQXU8I8JSWBf4M0pflDZWZUSXsjuGwpqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B8sykDSF; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B8sykDSF"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48371bb515eso49160725e9.1
        for <linux-hardening@vger.kernel.org>; Sat, 28 Feb 2026 18:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772333867; x=1772938667; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v7j7u4Cgs/YgDdAJ7Cmwg6YLlgzhvBFEmlTEsg17hQE=;
        b=B8sykDSFAyaC67iFyk4CYMeKS6Il9k1AUltUMttpfugW/RVix+yn1tROE+MVWY7597
         zPP6ejKH5rx+uu/rJhHP2wRfNcO31ZxO7+gG28k/E+M9wXr+JAO4ejq8uurzjF7yLOQj
         dAZadi3O9SihNq+f3RPFa4ynZ2UClR5y84C5bYhuvOzEa6q6kT9LJq5gfqnmI/TCu4rA
         N4ls9Sp5C4aY/9wAHeS6sK1c3znjZHgnBorPoqj4aMZ3dl5thqujzXWiGljCS+ksnjib
         yt1JowWzDvtuZLwQNP+lvWrT093WvZptGIgEB3pnQLIwQdyh90+DAOYkqvYy1pRsktoL
         7sWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772333867; x=1772938667;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v7j7u4Cgs/YgDdAJ7Cmwg6YLlgzhvBFEmlTEsg17hQE=;
        b=GzUj8Wa/GieTii7xS24tKoEpdUfi7uek4kjPdsEfybBX1N+aHNh7zmX8BKRNaRkWBc
         3hfGVm5z93fcJkAAHBqKDBa8Y5O89aSayot9J8QqNDL48i6MM1PEKEgweYhAXYldQ7G6
         BQWtDK+swnlADQs/2lqZQWNqvesFPb6hxPxhOtTn0DpNEtLuhdg+XbqiCAE9T61E6QNt
         9KgqHziucra54QOTl3aIrYdLClYXSG9itLEojB+740Jb/3b9CccHwmqcrpHhXpOMDo6k
         Qxf3RYnrOImD5CLIigPi5/W10nQCFdCzsMfIz4JR1gYqa6HwrGOniENiiVQpvl5JcP+t
         0IQg==
X-Forwarded-Encrypted: i=1; AJvYcCVRaQKF7NOKsRYO4eid69dGleQNm/a4bLIlOf+zqz6h1q/46y9+KFlpXD+I3nORLG9+jW9kF+lgr7xBwdp1XXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQL1U8tC9wrayzIEoQM1+qluX1DPKYmBv8v3wlJmXkDY3Qj3eO
	nMfPQlWA7lg3uy8g78R6LPFIbFGVLSc/nRZVBg+kQN8zsk8F/5CIkRrndLE9GWZwIow=
X-Gm-Gg: ATEYQzzFg2QUR+MNesD7jOV8xHztEq6DiF4EaicdYXOvDOBXcGaiAK/VZG61qnlU1er
	gxzJZfceLvUmQi0MWIes8qrGXHb3yIRNj92cSuLTbwCNJSPXEgsrzo224hMw4pY/V6ai35Dde6l
	YP0PZy0TWyS/lpekZwoWYBKTuMHNi/c1IxbsQKKO+zHPm/Dd8tAV3ZgPNxbdIutMX0QDtDubT7c
	PZzPRaM2y8ClywIaKWVmg/8cTqi+5o34jGeUGY9k98KSaRgyqXRad+OZO5l/9tPebds897Rah6n
	GDWL/ZbavrIiPKXjbDcpASY1WqrnCwvW4Vtyb/veN6TJ+j0zQkNQZTJVwRXOm0p8vJ1wXJARGl6
	RWotLRQlbtg5kFYFfioEozhpmXjgevsssnHxt1St6sgjbGF2mLXEsvUWVBJdsaQl52muDZpFLun
	6owVgiOqK3IYnYeYGt+Yp8z0scvNusXsQAO/Ydfdx4KHcGWAWHZI8qt4/1FQvrjeHWm/fO9vGzU
	OpkJ3wpm19OjnTnog==
X-Received: by 2002:a05:600c:8106:b0:483:afbb:a064 with SMTP id 5b1f17b1804b1-483c9bb7b7emr131516965e9.1.1772333866793;
        Sat, 28 Feb 2026 18:57:46 -0800 (PST)
Received: from localhost ([2a02:c7c:5e34:8000:6ece:b3d1:ab81:6eaf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c764a35sm19633263f8f.30.2026.02.28.18.57.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Feb 2026 18:57:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 01 Mar 2026 02:57:44 +0000
Message-Id: <DGR3X53FPO88.3C2UO0HGRVQGF@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Daniel Lezcano"
 <daniel.lezcano@linaro.org>, "Zhang Rui" <rui.zhang@intel.com>, "Lukasz
 Luba" <lukasz.luba@arm.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Krzysztof Kozlowski" <krzk@kernel.org>, "Alim Akhtar"
 <alim.akhtar@samsung.com>, "Bartlomiej Zolnierkiewicz"
 <bzolnier@gmail.com>, "Kees Cook" <kees@kernel.org>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, "Peter Griffin" <peter.griffin@linaro.org>,
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 <willmcvicker@google.com>, <jyescas@google.com>, <shin.son@samsung.com>,
 <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v2 0/7] thermal: samsung: Add support for Google GS101
 TMU
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Tudor Ambarus" <tudor.ambarus@linaro.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>
X-Mailer: aerc 0.20.0
References: <20260119-acpm-tmu-v2-0-e02a834f04c6@linaro.org>
In-Reply-To: <20260119-acpm-tmu-v2-0-e02a834f04c6@linaro.org>

On Mon Jan 19, 2026 at 12:08 PM GMT, Tudor Ambarus wrote:
> Add support for the Thermal Management Unit (TMU) on the Google GS101
> SoC.
>
> The GS101 TMU implementation utilizes a hybrid architecture where
> management is shared between the kernel and the Alive Clock and
> Power Manager (ACPM) firmware.

[..]

> Sensor Mapping (One-to-Many)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>
> The SoC contains multiple physical temperature sensors, but the ACPM
> firmware abstracts these into logical groups (Clusters) for reporting:
>
> - ACPM Sensor 0 (Big Cluster): Aggregates physical sensors 0, 6, 7, 8, 9.
> - ACPM Sensor 1 (Mid Cluster): Aggregates physical sensors 4, 5.
> - ACPM Sensor 2 (Little Cluster): Aggregates physical sensors 1, 2.

What about other non-CPU devices? Are there no sensors or implementation
currently doesn't support them?

Is this implementation and ACPM TMU support exclusive only to GS101 SoC?
IIRC, mapping could be different for other SoCs and, for instance, last
sensors could be non-CPU devices.

Best regards,
Alexey

[..]
