Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7161F3B3890
	for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 21:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779226957; cv=pass; b=bYxQXAavNRsDuz1VeNce/NAt9qDAxDpDriVVhNglEWdqX+6PeOoAu+Go4/AeoGB53eKHI6PWT/HyoOC+HFMvkVfXSRvdQjCPFVOPcmrZnUV2ChnqwQcDvcRqPa2cRt7eDu/gQnn0leldV8yC93cDfhPEpj35Dox7cltUlsZpoyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779226957; c=relaxed/simple;
	bh=agpQDPE0e0tDa6PFtfyC+WslCRjLfXBgwgqDsBVIG9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uuFOtf6bFbZ/1BxZpZO3f9PL3IDpUvSM7enV4S5zDfkpakJEIh/pvaGq6YpfjsDfb76TjxO2BhJLOJ0G+lSHJNm/haL5bp3BvC5ouLTkqWZlg3Supeil6ELucgiZhb3dmuQLnCxq7ikorHdQuVXVd39GB7N4foP2H+EaweX/Gy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cBBOp9lP; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cBBOp9lP"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-67bf769704eso116a12.0
        for <linux-hardening@vger.kernel.org>; Tue, 19 May 2026 14:42:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779226954; cv=none;
        d=google.com; s=arc-20240605;
        b=UdAmrO7cyIIpaWXGdZbICc64IJYAhsRpZjAbBfTOeqD4bc3CkyCarL8nxdQaAgmY0X
         /mKbhvMpqw4tzziyrM3d5gMlbc4Ek4/9PDPhOFbuQkDTFIBkaG9uebJHIMfy0sjFu63+
         RP/5lMyo4rqYw4veXcPP93jvZ1rTZOgtn6RMoN8GAGl85H0cUOeD3Y+9/5XNhveZyShM
         VTZJjnW9i7+hTiPASvxOfLgbahSsfbKF/OoQ1pAi11hvkxmVXeMgJq/gL7bMkQ3BuMUx
         EDe1YunkCO9ItFcrjsC5e2/6RwA37ahERxYAUDxJJNOYgtNAY88FrjV+dvKtrySXDTqQ
         uYHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=agpQDPE0e0tDa6PFtfyC+WslCRjLfXBgwgqDsBVIG9k=;
        fh=/yZTa/qW3e1fX4FbmORlvF+bd4bkK+NbFVfqgAeVKmE=;
        b=R3Mn0Bw86iBEkmIkh4Vvw3rwzp6r5zVT3gu3VJEiK/lE0NIey2dcbVgqeuvloiDCTk
         XZmvFZH9GllZCNyHp3eErGTPaAAZveSuL/xpV9qYAc88gxusqDaA1GZJrHOLJc0CH/b6
         V2W8PA1K3nJHy26bduCLscS9dJj8NoQvovW5kN8gfxeNtvz54pooHYl677GS0GhUR4PA
         BnJB5Ce0noRcTiX1qLdfQh0hswQB3PxINN7Xn+FC13IingvXsh6B47FnqLA/TKiPy10V
         QUfP6D21d12/CzbCsBFbkw/Atrif4Bu4sOLie2C3eKD7UrvzYKrdtLVcHCHtFlLmiaQu
         rSbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779226954; x=1779831754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=agpQDPE0e0tDa6PFtfyC+WslCRjLfXBgwgqDsBVIG9k=;
        b=cBBOp9lPxsBqzp5DiVVxXZDcRjTE3euWHcLy8b7vbCVmNAJKacI97hsJ3Vh0KDFaXt
         NXU/Zw17XqHcSHLDvSXAwaJJyllAMtOnzA54IEMDi5toSkc1FhEXHqZzqiln7NYZ4wvW
         lfDw4ZrKlWmzFMu6D/n8ftMX8TONAUMPAsEN31ppZN2D373vE0vjsNy/4phHOsAWuYNI
         nF/qzfTTzsfvL29YjAa8hB1+SvxRY6O7eKRjW3auOF834Bo2J3b1uCxJC4HpkvPM5oIs
         V7wciD7Ct1uavsVVCtQKUXyo51LalxiQasEvoLneaUrOkZFwJnRtJwnYl4KuZY4B5BFn
         MUcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779226954; x=1779831754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=agpQDPE0e0tDa6PFtfyC+WslCRjLfXBgwgqDsBVIG9k=;
        b=qGO9NFDH85zk0xVCDEtF0oJiJ6mUyOT0CAbnh/T138so/3gEPuSqLXdqZ9LBSb0ozp
         m5KrGt8Fx9PTD+EpUOAxixWOygtBLq8IEONBe1eJTTFt1W1P83G/aQED6iQirq1loEvd
         rkqkUpw1P4WydbrfwUSinM1eHHjquHEljgGuVxCV88+lfKgzjBazYpl6Yd84KXeeyNo/
         un6MJX9jbBVMv2ilhj6IEXpdM6YJ9yvobjtbhN3Xc8gJoRrlhxMzeNJyB/NSpuF6HkIm
         ZMyDjcXxDdQIaq7iAVERQHiUTMmnNZHrEJaD40xo6Kp3nB0W8AQeGcWP3qsZevbGRnP0
         0KrQ==
X-Forwarded-Encrypted: i=1; AFNElJ8cHn6leyeauN70rQGttoohB6kbWW0ccovwjo6EbMOHWh+dHaAePUAdH8QC3H9QCXJRnt9Alba8AKZ2/WWP2hw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM8JtXgckln4dAf40fzB9LSRDGu1aAvRJi/2icaUPHV0RYu/V3
	WwQcmsuFWmc4DOFxkHeT/kMaNDs7KPTrQN5JJ0gXy5Sdp7mTgJdkdlc+7jE+FCAaBR1S7ewJOu7
	eJAg7WpYVgezY/nwXx0o/Z2jX3w/8Ct5q4fmvSxYX
X-Gm-Gg: Acq92OFCxB2NeKvp5XuQlQhXi9B8YjoKstuzYUDkwjbTreEOYxRPzfW28PCmBx1H7DJ
	ilOG3624NG6zNRrzQKnmwgs2DAt2ftulGbCeEaVheTOZf54cPXJqajFu+vbkae5YP11SPYAnYgk
	BsT+Aj/F4RL8G4z72RsBttK/ohQcQSqXApfvc8GvIwbb6+1WHkCPOs0SECXsDeAL6Geps2Exom2
	/bEomqcUb8shoeP8dVyTyAMrquwYBRT4/on25LVyzxbtXY6jvN4DMObFzzwMhe57ciYvOlcSqaA
	ao7gAjhuLub5mF725Hx9isbptG96Bq5Rfp+nHO8jFSBQh0U=
X-Received: by 2002:a05:6402:20c6:20b0:678:a5c3:4d12 with SMTP id
 4fb4d7f45d1cf-684985e277fmr173995a12.3.1779226953632; Tue, 19 May 2026
 14:42:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <F78521DA-08DC-424E-BBE1-231BC900CEE0@gmail.com>
 <CAG48ez0KsuR5z4RDgxWPUoS8e_MJzF74RgFDJayohG48A_N0PQ@mail.gmail.com> <CAAmtCfMHqdWbYh-Hc5sGbOhXSM-aCA9G0-s64G8FTM+rGEV5RA@mail.gmail.com>
In-Reply-To: <CAAmtCfMHqdWbYh-Hc5sGbOhXSM-aCA9G0-s64G8FTM+rGEV5RA@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 19 May 2026 23:41:56 +0200
X-Gm-Features: AVHnY4KelXMX0Ox3UHP6DtmSDnRxPxmxV49wSNMKd-K67wpQhqz9skVmJZNDODo
Message-ID: <CAG48ez3u1OCx+zCWEs-_gowDmQ=KLbXO2xZ83LCZ1o1gxRT3Ww@mail.gmail.com>
Subject: Re: [RFC] TID v2.0: kernel module for cache-line zeroization against
 Flush+Reload (CLFLUSHOPT + LFENCE + REP STOSQ)
To: Ahmad Hasan <ahmaaaaadbntaaaaa@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-hardening@vger.kernel.org, kernel-hardening@lists.openwall.com, 
	linux-crypto@vger.kernel.org, linux-mm@kvack.org, linux-api@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 11:31=E2=80=AFPM Ahmad Hasan
<ahmaaaaadbntaaaaa@gmail.com> wrote:
> Thank you for your questions. I'll address each one:
>
> =3D=3D 1. Threat Model =3D=3D
>
> The target scenario is a same-machine attacker
> in multi-tenant/cloud environments where two
> processes share physical L3 cache.
>
> Example: a cryptographic service and a malicious
> process running on the same host. The attacker
> uses Flush+Reload to measure cache access timing
> after every encryption operation =E2=80=94 no physical
> access required.
>
> This is documented with real measurements:
> - Without TID: 78 cycles (Cache HIT =E2=80=94 key pattern visible)
> - With TID v2.0: 286 cycles (Cache MISS =E2=80=94 attack defeated)

So you're assuming that the cryptographic code leaks secrets through a
cache-based side channel? That would be a vulnerability in the crypto
code.

> =3D=3D 2. Why Kernel Module and not userspace? =3D=3D
>
> You are correct that CLFLUSHOPT does not require
> Ring 0. However, userspace execution can be
> interrupted by a Context Switch, which expands
> the timing window from 372ns to 36,640ns =E2=80=94
> making the attack significantly easier.

Why does it matter how many hundreds of nanoseconds it takes to wipe
the data from memory? You can also have a context switch directly
before you enter your cache-wiping syscall, or in the middle of a
crypto operation.

> =3D=3D 3. Why not add this directly to libraries? =3D=3D
>
> No major security library implements CLFLUSHOPT
> after wiping =E2=80=94 not OpenSSL, not libsodium, not
> glibc, not memzero_explicit. This gap has existed
> since Flush+Reload was published in 2014.

I don't think that's a gap, because the standard approach to
mitigating cache-based side channels such as FLUSH+RELOAD is to not
access memory at secret-dependent indices in the first place.
