Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794525841;
	b=lrQrKN5MQFf5Wpq8NqcBaNEz0ikRCZHRZLAFFElUmGABDwau8nv5fTjvYWIUZ9X2qWiD
	 vQ1GOXAIY9IBR/9BAt1shUNswgaKTh8ff2Tgw2U0ZK2P7tm+/sN4Zcv+gv/2DuyMgo4u0
	 EtcRfF1w0FnCthKWKDi4Ll+eE7Lo+vpY/ubWRPOKc8AjPtclaEp8GIDZfIrS11DJ7CTBL
	 Zg/DKDjWpN9LUsgQ8CtwTQCbGt5Xeyl3IB8fq4d5z94q52NfpNWdrKRjiFDT7/2UJM1Qr
	 7gOYFnU+EGx8LFoZWhIzR/+hCRwnYuEWi0+wiMJado/8J27XN9OYxEMOPanZvX5WeQA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794525841;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=drls+PXlcGZoLfnoPObObwbc1/HPzgky5rGb/FCeY3w=;
	b=Zpxfb5fTIwGN2gu9Xy7m3LNf/sUkjdGtYpCFbrzzETMZ7ncda26ao2lrleyLjUAE2yYn
	 yrBq3MyMgdDjbGAfWQFYO3CG9eiZL+XNrU2CsB3zADFUncZM8VnjNJBYRWxYJkmDHg4u3
	 kVc4oQbgbP6+ycfDQE8gqjBqLzwbOZ43FvBMyyGWccbA0iILfv86MkWmj0m2UWZGXTeKt
	 xQZ4H/2QYZZm8nkUkuYb/kTo4+HPwzgWiyPz6LAxXxev0cnpT6TVJurxmkT8GuCYIfq+F
	 tytWAPXBfB9rcEQK0Pe4tbixtW1qv4nGtlCC25wCPanu7XCVaU4bAnjgiyKAitgXrZg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ausil.us;
	spf=pass smtp.mailfrom=gilmore.net.au;
	dkim=pass header.d=ausil.us header.i=@ausil.us header.a=rsa-sha256 header.s=google header.b=focqTQf7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.222.178
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C80606A32A
	for <linux-hardening@vger.kernel.org>; Thu, 12 Nov 2026 23:24:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41C80606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ausil.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gilmore.net.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ausil.us header.i=@ausil.us header.a=rsa-sha256 header.s=google header.b=focqTQf7
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-93e55db58cfso45760185a.1
        for <linux-hardening@vger.kernel.org>; Thu, 12 Nov 2026 15:24:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794525840; cv=none;
        d=google.com; s=arc-20260327;
        b=Ab8E72TJ8Zh96pV9Xq6welnnHwYQhKjmvEnGyVdqOCchxKMRBX0phC9TCICcjxJBRq
         FlZfzNum5PdfUyteKTKtnt/YC9Qmvq2ow+fNixMG83fZupZ8Icapnql1Z9gR0yaM4c1E
         92TB8wfvaGCFEVk35P0HZhwCE1y2gFiOybpVmKGY19IsB6z74CbH3ikt/EdRBTWVQpgm
         IKz1WO4w5J7/rjLU6Gz/pqQDXVSTEeIruR/Z9XK5zTSuBOG2cshtQbMpkeI32zUnwg5j
         4GNTmrmrGCg2NqaXFoJaY1thdnJRjpGzQy0I/11AnuTouMclExcPLF/9TFLZJFBq7vTI
         hwDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=drls+PXlcGZoLfnoPObObwbc1/HPzgky5rGb/FCeY3w=;
        fh=xYNP1+KBTNKBQ+SSVQUS4BMhi9DNQlAXYTV+2+vy5jw=;
        b=I3OCrB0P+9I5Y04A3a3SXK9BClymb61LK69brEYgnPteYUNrArp5xTQCjHDsSZMv1L
         nxWBGODPJKg5e3nNr81wGgOitKQi+KxDQY2S9jpTe7G6KDzlsQ9Gh4ZlUbd06+EsLIsM
         oa93XtGp1qK0aeshXkLncmtimEmYRjWvfhLsZC5uR2GyE7sUWFKQ1G83JbpG72QNAQRQ
         sEMAi1hLNSjOpwMYCng6Q6653rHE8FIM/TydPgAb6jfRd0tnohIGaJr3KAe3B0G6jXid
         cIvExY5uvMIaN03bwd6dFnvooG93CMAMCF7e08J4CyW9i3PNTXbQsUyb/LIKh8o+v9qA
         M9Yw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ausil.us; s=google; t=1794525840; x=1795130640; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=drls+PXlcGZoLfnoPObObwbc1/HPzgky5rGb/FCeY3w=;
        b=focqTQf7naFVCGV/My2d+xpcLS+yKtintmrypuRzht8YS8h99AlJDL/3AsFgqMzzSq
         LiYGDn8kpDU+Vupp3Eklu4tet98WA+Gg98hsss9HKVRYsSKcuOWLgCqfGsfC9WtJjhFv
         LVwgrg9eok9OlzpqlzH2V2tb6xEKnyNGK9EIbw7aYhPvoo9CRZELkbf0uLrIc2cGVhxU
         6S4QL30WvyiEW8bbRF9PJYgUnokd8ZbLUVvW9iSO395H8jdjvkvbCelBuukjOeNCOIvm
         Fgkyz48jdUU8emc2E0zd2TfHJq+ABdg8by9UYtuG/i481sA94eZ4XT8IFqFFLbKcla+Y
         4srQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794525840; x=1795130640;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=drls+PXlcGZoLfnoPObObwbc1/HPzgky5rGb/FCeY3w=;
        b=AlhMEPP9L8FUcpPyQrapuR+s2BDWtJxNvvKjJW/BPgKnibi+dfButQjoQX4mRS/Snq
         xDQ3JneWjuvu7H05ylmwtofx9Ho3PCs7oi++LS3cOqPyEnddSTNYXCw8uBmLIochJLVW
         AHVPTeCj7dWsvEXcAywtbHH0s72JwU/C2PiR/w8rkQQlvLvmUBSBfZxOPwHNqjnWXIN4
         UtXRMExRY2zaY210JUZy+VrtooH/CPscAeJK4YPJiKd8JhcljZZs80t6uFxqkY0WfAFA
         GY00cWFLMPlgD+Bhsr0uh7RngBtc/obsMhsuOwllOAxY2l4udxmSE7bgVgFpsR3UDy9q
         rBWQ==
X-Forwarded-Encrypted: i=1; AL+hErGrmiYutQZT2xPbMniIk5L6EP5D0EH7o7cslhN7RXgJj8MBgqtHDvbsOpQdg97JtjM9UVGMD7v2aIlSpBNJ2/4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9A0yYF7WcFVPUvNEJgi/dWMD4QZTJ8b8b/DafMOUTsbSof1fUg
	fCLPVMX61UmQCDOXc3AlZ/KfL0Zmv+Wps3NcZ4WbAYwYW7B670uukPqooC3Nw6iRyj4USl+llaI
	wf3lhHHXT5wHslkmpu2YZHffeO++kWoWA11f9bDL75g==
X-Gm-Gg: AYBFou141kjhTx5fSa0Di51Uv5Mu/+F5e/Mj2jplYuvZ/SP7cztbgSP8J4oKNmbHWjz
	P4RhmRRbAIVN3pKvV8MuM3M2Og2THumBt4ILuGNC4+PY/AU08rN5ZbrLmsqvljwAGQa+mToBx6D
	Krux/ITgCC0CNhXVB2cn8EF7VuPpfr/7fx3p7zP9NFA76p7amNy/XIocUEgMck7pRaG3NtkCvjM
	sGkiU1yHWlbygeEbsbbEbQGu0cNSWAn++ADb2L2XbAGt4MHtncUpUUU21Gyf2YhqFwRKtQsUwkG
	un7pnvWe9cm3c87/nIKZhW8Ar63BATKADjnIo+M4NPkx19p9RaInr/+ec3PlkBmC3gX9xuLrdmE
	eOt9B7YzbfvtuULJYBJNZPXt7ntUZ44+2jqwiEDGnGVjWWCTgS0o83Xgk/R0qLkCv6sRYZsKA/k
	EmWpu+6YmHPGp9TLgDUXAOpCPa
X-Received: by 2002:a05:620a:371b:b0:93f:43a4:a48c with SMTP id
 af79cd13be357-9494bc3a400mr175911185a.45.1794525840268; Thu, 12 Nov 2026
 15:24:00 -0800 (PST)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112025252.71375-1-dennis@ausil.us> <179448342405.66517.5463730214277229760.b4-review@b4>
In-Reply-To: <179448342405.66517.5463730214277229760.b4-review@b4>
From: Dennis Gilmore <dennis@ausil.us>
Date: Thu, 12 Nov 2026 17:23:47 -0600
X-Gm-Features: AclHuK84GnsbCUnbGFWAfzcRIsf9sLCdYOCcLTFaLBRnNzS4e4KBe3sc65us-XE
Message-ID: <CAABkxwsn9bkx37C1oEuMC1o+5Jtf+EnJgw5o7pso8hGxxJx34w@mail.gmail.com>
Subject: Re: [PATCH] ASoC: soc-core: start rtd->num_components at zero
To: Mark Brown <broonie@kernel.org>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, kees@kernel.org, 
	gustavoars@kernel.org, linux-sound@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	michael.hennerich@analog.com, nuno.sa@analog.com, dlechner@baylibre.com, 
	linux-spi@vger.kernel.org, miriam.rachel.korenblit@intel.com, 
	linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 5:37=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
>
> > Since the conversion to devm_kzalloc_flex(), the allocator sets the
> > __counted_by() counter num_components to the allocated length
> > (num_cpus + num_codecs + num_platforms). This only happens when the
> > compiler supports __builtin_counted_by_ref() (GCC 16 here). With
> > older compilers the counter stays zero, as before.
>
> This doesn't apply against current code, I think this is an issue that
> was already fixed.  Please check and resend if it's still needed.

Looks like it was already fixed in
https://lore.kernel.org/all/20261109102536.357134-1-ghidoliemanuele@gmail.c=
om/
I missed that when looking.

> --
> Mark Brown <broonie@kernel.org>
