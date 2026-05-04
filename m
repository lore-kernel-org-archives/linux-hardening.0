Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7783932E7
	for <linux-hardening@vger.kernel.org>; Mon,  4 May 2026 10:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777890077; cv=none; b=Mykb8xqJN1Nc7ccNHrPifoVodCC2GarRq+3IPvE/REazgYdPyoAYqkIayadoWeIBVgO3T6ey95Yb2HFFY2CyXsOaRT05iXd+snFQxL0UbjwurQeZltWdPHHCOEwTNmXayZplWcxm6AMNTJb6BY+EHN6WCeX5fgLo1H3yT7IE7zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777890077; c=relaxed/simple;
	bh=Qpc9cSZIQ6XgIpUBdj/WRMIntrqVQ+95EOrd1XUDUos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjYMlgVYLrrBTM9MDQ1ZETBfw8UT7Hej0GWTScmEvc6lAfmjF123CXcvUsRVAsy9wbENFfhrZO4xLiZolzlPShzul7hMLAAsZ3UXRscgq5Gz0r/flnAkuKqBCXRqNcLRLX7nKs/Cr8LhQUFlF8CiJPn8ZWI26UH5W9+uf6PoavM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n/lKxzyn; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n/lKxzyn"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-835b78c3797so402931b3a.2
        for <linux-hardening@vger.kernel.org>; Mon, 04 May 2026 03:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777890075; x=1778494875; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AzJI2062NMt5980YtQqfww16vShKlaQt7llmD/pl5fY=;
        b=n/lKxzynrqsju4/uRu0/UE3O9BTL8Qc86vBW8RZ1wVpISguA59QqBikod0VX//Pc5N
         aGYLIHrRqMcUDMgmAB+3KF4OIYFeHMQhg2sRaTa+VzwwORJdBpaqpCDJantZV6QFXR/2
         a00Pri31c71xTjpvapCilLzfB6LiF+HerS2Extfebw4YdOD8mPljr/mdtOdRRXrbHUUX
         3YgZAxr201a4KT9JWQPtAB1iK5rVf85+1lqykNkQVg/huXYexOoi/+Qu527A4Y2mFsDQ
         hfZNPQKVkNZeoBk2hGSsHYL65Q+tasIsoDj/Xy3ILNfrdUwmsnAgUog/T7ozYXS5e81h
         SH3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777890075; x=1778494875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AzJI2062NMt5980YtQqfww16vShKlaQt7llmD/pl5fY=;
        b=Q7P0TRi9rf3DLo5yZuNQwP0WFbW4+1RL7UhhOFUBRJtppqhaBabz61lThgYbA/tmob
         4Y1Z15jOgVgjUGEkaZ0DfxBuggnBLbnveZD3QctmH7j7Kg26YLHtNjRZXnCvEckFMgQC
         +/q6Woy9xNwUoq10/O+Z8vY4RkxATkfoXk3BWFVG+bdFdGMUxSP2/BhX7PxdNmyBZiAo
         YcnvxLmUsdOuhfvP32wL5+vTaj0yXUaKG4BVCZQYE2ry2asncl+mGaEzXamQw6yoHxtg
         v/Ysw1nTlwldrGcUD0aQXhkE42sz8upRrIVFoX+3/zC7Qczs9LraoQmcH4xGFTW9d+NZ
         05JQ==
X-Forwarded-Encrypted: i=1; AFNElJ9alBba67LMUi3N26xFfnGsz59MXdU+McXXC6HKgTvLvBlkXPVKyvfwc91Z5HQjklIjY9dIEbL8gNQKM3YVNEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiGvfoKbRh2lrfViEHxMARz7vp5v2amND4Hq0FWrfwLigJD/+4
	8LXUZAZFz4fraIO5KahRvC7FsD17hQtkxbuzRvxGO3FM/NuvrrX+g6sD
X-Gm-Gg: AeBDietZcHII9LaWjkox/XG6KbqPsKijEVCV4DHwWDhVORDdi4AyFVxRhkZ17yHPBsr
	//F8rkNKhTLddcmdo+5vhk/SUyFKJDiaX+gCjWs9s8CtjcKsmk6s6QaX6gw9JBoeW0Xx9dlWjh+
	cWwM/y+sW1ixhULzIf/9aENaNjxaABxLUJF/0hfSc22vDvS0nnhxXDiOuVlTQ+Hk8CT+8yXwnsQ
	EvtIDWCk24m3yIvUMFhi3E8Bb73ASg3TFAYAXXGR5Z0pEPtqj9H3vOqCEfsEDcQLrJWHaqXVhBa
	2eIHZXyqhYHfWJeqWsCUAHIspQo4n589b+tA1PaB5XCTToGGj86muhIcq/1xz3xuWpl8Qv8g64W
	0lar6r4JhzrYpvbFGqk4FTIFUiP4GuHLqYqGpPJcz9vt9EMVaTNuGs8EupqAWJQ/16kbIxXuPw0
	u/4tBYbhNL/iJnpoGnJiJIcdENUuZv6a7pTFc8AGXTGrg9
X-Received: by 2002:a05:6a00:340f:b0:835:4291:6975 with SMTP id d2e1a72fcca58-835429173d9mr5262314b3a.39.1777890075240;
        Mon, 04 May 2026 03:21:15 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8357c4f4530sm4335636b3a.9.2026.05.04.03.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 03:21:14 -0700 (PDT)
Date: Mon, 4 May 2026 18:20:59 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
	Inochi Amaoto <inochiama@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Ze Huang <huang.ze@linux.dev>, 
	Alex Elder <elder@riscstar.com>, linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: phy: Add Spacemit K3 USB3/PCIe comb phy
 support
Message-ID: <afhx6C2EvDbMJc92@inochi.infowork>
References: <20260430022843.1090138-1-inochiama@gmail.com>
 <20260430022843.1090138-2-inochiama@gmail.com>
 <20260504-logical-nice-python-1e1f43@quoll>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504-logical-nice-python-1e1f43@quoll>

On Mon, May 04, 2026 at 11:54:11AM +0200, Krzysztof Kozlowski wrote:
> On Thu, Apr 30, 2026 at 10:28:40AM +0800, Inochi Amaoto wrote:
> > +properties:
> > +  compatible:
> > +    const: spacemit,k3-comb-phy
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  "#phy-cells":
> > +    const: 2
> > +    description:
> > +      The first one is phy id, the second one is phy type.
> 
> You could mention here the defines representing supported phy types.
> 

OK.

> > +
> > +  spacemit,apb-spare:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description:
> > +      Phandle to APB SPARE system controller interface, used for
> > +      PHY calibration.
> > +
> > +  spacemit,apmu:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    items:
> > +      - items:
> > +          - description: phandle of APMU syscon
> > +          - description: configuration of the PHY lanes
> > +    description: |
> > +      Phandle to control PHY mux configuration. The configuration
> > +      is described as follows:
> > +      bit 4: 0 - PCIe A x8 mode, 1 - PCIe lane share mode
> > +      bit 3: 0 - PCIe A x4 mode, 1 - PCIe A x2 and PCIe B x2 mode
> > +      bit 2: 0 - PCIe C lane 0 is PCIe mode , 1 - USB mode
> > +      bit 1: 0 - PCIe C lane 1 is PCIe mode , 1 - USB mode
> > +      bit 0: 0 - PCIe D lane is PCIe mode , 1 - USB mode
> 
> I assume this device k3-comb-phy handles phys for PCIe A, B, C and D?
> 

In fact it handles phys for PCIe A-E. The mux for the phy of PCIe E 
(the id is 5) is controlled by bit 4. If the comb PHY is in shared
mode, the PCIe E always got one lane.

I think it is good to add a public link for this configuration, but
Spacemit has no opened any document for this publicly....

> > +
> > +      The bit[3:0] is only valid when bit 4 is 1.
> > +
> > +required:
> > +  - compatible
> 
> reg required.
> 

It is fine for me

> > +  - "#phy-cells"
> > +  - spacemit,apb-spare
> > +  - spacemit,apmu
> > +
> > +additionalProperties: false
> 
> Best regards,
> Krzysztof
> 

Regards,
Inochi
