Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D00239934C
	for <linux-hardening@vger.kernel.org>; Mon,  8 Jun 2026 20:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780951944; cv=pass; b=R8tI98VToUbZBYo57TJaho+D9G+40dp82ItumjEhtcUHkwuusEFTV5y0BUG6bIqnX7XY3z7Q/1TDu7WuYMkaU8WgiaqzmWMUJ5agkVWQaBv9ZIAcCd9QtwC+LZJ3UtgDmXE6r3p908+hrYjadagfwXmsFuawWkrAc1tqD97mQzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780951944; c=relaxed/simple;
	bh=W25ew7OtPq3XBskzl76qlbOu0FGmIC+E26EOjAY+RgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S4G/3tfM4RnxXrX5BrZ1PlPl5EoIHTBHx64sRDC+K+gpsDLrsHvr+K9fZZdUE/EK1tMl02qf6wvYTNAV9hUzPiqVgeisz0dk74ZQyT0cRpFCTWYy36vAYvmXfSkkOGav341lwPXIvR/zDJG80rMirLIs5W/1Pv8CviAva6iCDmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b7oo6Kx3; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7oo6Kx3"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-68c19f1f3ceso7476415a12.2
        for <linux-hardening@vger.kernel.org>; Mon, 08 Jun 2026 13:52:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780951942; cv=none;
        d=google.com; s=arc-20240605;
        b=CG2cXjAn3ON13joiHaLL8Km/tuNyzQmuDYV/Nf0SP/doNXF4wlhm8SWMXWzXF+aEuw
         63ytobE/X1tzy9aGKtgUF/Uiz+vOeFlXp5LxvDjHH7aY6uwLjycYvVJvfR/CyC2ziCAS
         inKfsxB8SX2UrnzXqL79ZvHzUM8ofIdtapCsmdr68tuIYPEPw2wePjFORT7zKy4+BcF1
         rzvC1JoWODIUmljDBAxj63NpNzBafuNwttE20KMcwMdcZdgD1WQ1dWrXQumx/domvc5T
         1ic7yAkZExssVR8B8OOd6ZFGYva0dL/nPLpkCrxsMZFa3dRBbN7aus1ssZQDNIEQV5XZ
         Y4CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W25ew7OtPq3XBskzl76qlbOu0FGmIC+E26EOjAY+RgA=;
        fh=BXG7vDb3Y6vc8Vs8X9zdVzUx9A8TbyZ4y5MrTwKnyMM=;
        b=UzBAIWXDxoCNelIcbHQGdGSnyh5NNaUnQ+OzyIIP8kIsUSZNMECbLUvw1mv0IvXRFM
         tczzDr1xuKK6rtmiSq/A2HWszbLBARGBZX1DxXQN8oo31aoDRFaMjY8L0DnK6HSbMTBR
         VVP9tscWr3VdrfIrWb2tQXtjYRjmu6N0GAVpR5Cz3RMsJWXEx51OtBDjQfzxQEFLh24k
         VYQ0FB2BGovQxNVdYJEL+5diiYRrrfsZ0vMdLw6qRo1AbMFAykSR5XDRwRGfHEW1i2Ba
         Mdz2dyIULCNjR0YlbJMr1eYuWEW7LWG2DE8fYqrTVGq5cbAkOyLWJrQ3iRMvcPe2ulF0
         btTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780951942; x=1781556742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W25ew7OtPq3XBskzl76qlbOu0FGmIC+E26EOjAY+RgA=;
        b=b7oo6Kx35AK2fDsqwMsG5GhiC8FXarvgIL8+uCLYMd1qx8zryfoWzDn9CitvF3ARQq
         S949vs5wU98fckjVLd8qiczeXiSbKh4yJB2f8CDwMuH0it8vrmAppCYtGIq88u950FJO
         n6inM5WDrwjaeSPtPMsNT7GXOvIRjDGrLQZ6/fHgp0j8F9dXLZrqcqt6YD0HsJcMFTTM
         GF1OTHudMU4ryBA46UfK/X7tbKPR1URQClaiNg5D1OwjQDijzLePGvQoS/qMlzVAESY7
         DBXvzirBA3nmY6q+L61z6ID9JKJt7HQBDLP/SHuvyvHSKW43h8X7swMbvcRp42d3rcuV
         3Aqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780951942; x=1781556742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W25ew7OtPq3XBskzl76qlbOu0FGmIC+E26EOjAY+RgA=;
        b=tQU0eiFzU8JYeO21hkRCab//cCEoVcQ1MJAlCrzlIJ7eoU7oRjzevT2Cr0q/rhXlDQ
         hRSKaeK6FrRhzJXKUkzLcu7DQkDCQ8faPGHEhDxVLHOHiSvcHCUdiW6e9fcREJdSqQvI
         N2/yjQZiXoXoxWgvItLHkjN1rO0tP5Q55XSd3LLBfuQekn1ni6YqdQuzMdgkSvrFYI1Q
         o2SbFK5sTU2Yv7GPLCCzeITYWOyNS2jTN49osdv6pQ4+c7fI1rSY3+JtdhNbjflFPiK1
         MRvFErIVkaYJocvMZn8rzx2CN+mFaWzohfnF1JeYRFvN+E5pZZDGSnLWTUSj2twO1cc2
         jbOg==
X-Forwarded-Encrypted: i=1; AFNElJ8JzOaimZA3Su9PgkgUs/nqwL+5Uhhx5MXc3YAToCPITJnp6FEJ/SgcNv2N47LKf/91J7bcuTXXY6Eob/IWXKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjWNPOb+6q0inJf1lrSLcjDt/xJPAqvyTstUFXBHukW1SMAeEc
	kOIDQcyKT3XLRPbe5+O/EXM0rGMwkiERWFTbiyzjezOPjFfmjUMtyN+4gbDiMKJKzuqcbHZFm6m
	dFsOWB0bNQ9pnVWwxfs21SSYg0KysPBs=
X-Gm-Gg: Acq92OFCMQZr46z/RpnRFp+25f3nS27O2a7ABA55jgrBdTDVNE8kjVSLlu8JGBhcM79
	81co+AEu5WnR2hTsJe+5Wzb4TDqlY3GEZG0zapAQOSzJeW7alXbTIedPyFlaciY0bHp05mUuFhJ
	Munh9/c4fzRdwDYv+KELxAvkpF4RAicO67rXXAq0d9AiXy3eMkp851442MKTQYJCmkMS30ytDvj
	nVRq7SQ0hS9h2NhEs6Qg8M7xgM7Uv/sBRF6el/RJKT8Dcf9M5IUnUp9fiY90E25y/FPVZolt+Kw
	iTE8mCKLxAw/RuOMbN9MNGZVjy+wzv6/CuCuHzIj+Z4iIOuolqRVjd3zuxrc0V/JiXjfHcxOz06
	wAt+0V0DjUrQOt9H1dF7HayCvKJi6fAEzLnHyIDcUz2v1OfcpsT3wRyRihJ0oJGB3LYQu
X-Received: by 2002:a17:907:989:b0:bed:25a6:1c89 with SMTP id
 a640c23a62f3a-bf373407e0amr899008466b.25.1780951941373; Mon, 08 Jun 2026
 13:52:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608051829.7390-1-rosenp@gmail.com> <aibs9gb5M4-gbCFY@SMW015318>
In-Reply-To: <aibs9gb5M4-gbCFY@SMW015318>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 8 Jun 2026 13:52:09 -0700
X-Gm-Features: AVVi8CfU092ys9IKRz0NL8aHFjs8GUJHMrxAGBkw8vKo0ocK4JDhwLaodGN_EAA
Message-ID: <CAKxU2N9cTuhj4WAu98+6m3qb4Yy5NwZQHcnKUa4ra86+M-S-cg@mail.gmail.com>
Subject: Re: [PATCHv2] dmaengine: st_fdma: simplify allocation
To: Frank Li <Frank.li@oss.nxp.com>
Cc: dmaengine@vger.kernel.org, Patrice Chotard <patrice.chotard@foss.st.com>, 
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	"moderated list:ARM/STI ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be|_ptr)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 9:25=E2=80=AFAM Frank Li <Frank.li@oss.nxp.com> wrot=
e:
>
> On Sun, Jun 07, 2026 at 10:18:29PM -0700, Rosen Penev wrote:
>
> Nit: dmaengine: st_fdma: simplify allocation by using flexible array
that's in the description. Did it that was to not have it as long,

flexible array member is the proper terminology.
>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
>
> > Use a flexible array member to combine kzalloc and kcalloc to a single
> > allocation.
> >
> > Add __counted_by for extra runtime analysis. Assign counting variable
> > after allocation before any array accesses.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >
