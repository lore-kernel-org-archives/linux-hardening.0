Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2612F3B0AF8
	for <linux-hardening@vger.kernel.org>; Fri,  9 Oct 2026 17:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791566610; cv=pass; b=h44LpHOntZ6Y/90Ek2Yfr7TL/C9NShvPcbjvzfsKlZPwCRy5c7QGYykHp94GGELDoXeJuFJ3AdkVArZhN2ZufYffHCksPTyAfaX0HjOHc0oM342IpH1yzr5RMRTFUnH9NdvJnKsZsttD7keZVf0089DnsZR6D70K8RcmjHo8eHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791566610; c=relaxed/simple;
	bh=Ju7gwhPhe+gDtBXlanX2ZOcJL4sUKBXDC/LuKD7vhrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JlMiKpGoBsbzVqNLjaZWHMcDbb9V/Zo8dPp+2pHqr2eTpHqs06Bd4s9z14YK3f4cGA1fapyJbZsXycscFudvki+yOpix1tXY7hvQlK8w+9Sf8U85pO4HFKxOYsbiDUAOBk2MhPITavJEZppJfbG34958A0BMYLDuwjS7ybcZi14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MvzCa+VK; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MvzCa+VK"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48441a2ba1bso25143f8f.1
        for <linux-hardening@vger.kernel.org>; Fri, 09 Oct 2026 10:23:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791566607; cv=none;
        d=google.com; s=arc-20260327;
        b=Ioy2WQEUTRlwdYpCjOgcCAySHytYkrEUsrqvxJUCJS1EYz1N0+hPYDCk1naIC2QaIf
         +CAkaFtUWYVpId2M7jnkU9IyxTayQZq3yItmDfc5jQ2LDTVb+yUUT3eLWm/s6mlaXrCz
         G5iZIoRLTC/rTwW19d/TZUImAFc9G0RH9kvRMbtpXknO3w3XHT3vKihMJ2BwUZ3BhGiT
         DzzQnugsQgoqZK8k4SglLwjYJLH15sBu275fgIi8843u+Chku9Tl26B+ZOY7CCfD9yNS
         5M3i369nZranlgEAUpdTiP72UZjEWXnjPGwh9QMHL7xXRMjS3W9NmV9JiVoav68PX5Jt
         6r6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UviV7uLa4QuU9wMqSrfcZ2tk7TpFd3xUn6hAcyKbZrA=;
        fh=NBv7UEB3EbzKwXer//RC0OsY8B9q/H/zUCjnSDVc518=;
        b=N0dbzW39muCaoqicYR527VI47uLChk+0CqV2rGSncpHiq/gf6UZYdQcfSDsE4yndn4
         9NhZPHQ1ptcyIPATIzwwqw8oEAhX84wV42YWOiSG2mG6EfE1TLkhiahTaipV+T6umW4V
         XpC6cxKvWDEwfnJ8h6tmbaA4AvDK5EAVVC9xzfyQ9XTeakMNk1ueZN1rsibx2UQDWTXA
         iI5F2h9mPwKXSa4TPue57tY1CvVWBkJguiKz6I+khKthPRmYKZtJ9ZqTmoa9VExeqY9c
         Owb0B+8EL6ypDvEKWLV6uBmIC4GwchtEGcmC1WRUaH8OYFQD4E5bcexTuPN+G/Wv8hWU
         56Vg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791566607; x=1792171407; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UviV7uLa4QuU9wMqSrfcZ2tk7TpFd3xUn6hAcyKbZrA=;
        b=MvzCa+VKiyDnelHUmjUccg00cB9OywmIWuU/UXHneMkBqq1XMLSK6/n/9Xc9DKNwFq
         DGdEKXPBMYnR1JyEnf8cveksXRDGdwZ85EcAjt5d9i+nUW+72rZGzL9iBDfaxB1Qnfid
         m2Un+0IFsd192m1N6/pQGwZDF58jqbOLuUxsiGiw+bMadnTQm2gUP2HGZHQBNJrv6PNc
         v0ZztsoiTIHuLKhv9/+npOX73T2uw4nOecIT3tbqKMjiNGWAQcFzJcQX520JgQdKNCcN
         r4s5GzG2gBNldhH4T04J3iPmZ0JjMeeukHvyC3IcMHY25ZoiQX2bOJXerZ6zteM72FdM
         9sKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791566607; x=1792171407;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UviV7uLa4QuU9wMqSrfcZ2tk7TpFd3xUn6hAcyKbZrA=;
        b=VKA4DnJ9tlkO6fwkWVoYBNioDAozv3UcXWXwnyh98lTV1MYIqlPLQn+rTEob1Xtg26
         bHARdvCkQBD4Wa0YRXUbK1D8AcyhK4iMV2/yUNdnkqvkXaPktApeCeLvpCEnjmFkPFzr
         Nv7ZeEGloW1n/AmFGuuFaAkuLred9KupERY4Qr7uR/hk5iPVrubgAF1iT3O+Pb1SGv0p
         aFJBxX1RMKdV1eyf4fOAB6BqrEkf2Lt3VohSjvG0dfF5uPcvWqC6asryIYbUu240VG3E
         7PziZD/MwblSxAiew/frDx1nkbnyTyW2UZaOxLQGncMAeepVzycldJZ3K7yfmOLsVohu
         QZcg==
X-Forwarded-Encrypted: i=1; AKwUvBwQC0aPJ6pGC3rzrs8aCHULzu6YkpLB/wWQfRcdIfdY7TGFeIS02UyGoyRK9IjCQ+Yd++IUandZI1pnKPSa4tA=@vger.kernel.org
X-Gm-Message-State: AFuF++me0bl3G11n3GnCpjMRytsShUkDuEffeSlRJ2jGW8K4zVVm/MX+
	IrXkWHf2tFkcsbADZFazSIZnpfFwnQmejDtN7RxceKtQQLLSvrVdO8Mz9YE7fM4OhJ37FpVSRVK
	YE0B8kExASISySoG/Gk/N3LZ7K5EQuu/cFAOWG7ig
X-Gm-Gg: AYBFou0F6CRkHJWjfMgdW9jGPIhJNA7L8FLszQ3/LCECFAWFEeq2zUil0UklzIJQm7+
	vbCHRiJNlsXemxbOKDSjeARaOD9jLxMZp8BaW8TTHPbBwqb+aX+IE4P2KHrxyN81597HPIau3wA
	1J+MkAgupkbrPnVZ3VES12kbAaI8309I5VH8GDEuBz7rqmXr0U+KD1p4iz4l5kFke8EKI16LLgR
	8qSJCl72X99KmxR8f5tOvP4Gk/nKXXcDwMaT8WqV94M9O0YDwYESQ2P7/tNBxDSAqMTMaBkQGZ5
	fCPrQnNeEC7xNaM03a1mHCFio/DhJdW7Eh7wN2YfkpHZmK7g1zCFDtnWcTBSqvEz9ph/WgnvDCS
	NlHekgdQg/mogy8IeeRqTqnDW771HdWMPtWw/NzQPB3KnZIrmBHNX3r6LlGHloqB9j1jiserchV
	QDqhUuTygzQWqaem05kth5BjZc2XjNIA3edgJxRBDYX6hnKkhp0m6eSNS3
X-Received: by 2002:a05:600c:628b:b0:4a0:251f:dabd with SMTP id
 5b1f17b1804b1-4a18e48edd5mr43689545e9.16.1791566606839; Fri, 09 Oct 2026
 10:23:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007-b4-landlock-fix-domain-fortify-panic-v1-1-042e9108f5f8@oss.qualcomm.com>
 <CAKwvOd=nPgEm=AZbEu12Eb90GtRUThY6YAjSiHHuNVHP8TZHwg@mail.gmail.com> <66usntltyie7ii2rrqajy3izxrvwubwf2vqnery552v3akhwo2@xwb4t76d37wx>
In-Reply-To: <66usntltyie7ii2rrqajy3izxrvwubwf2vqnery552v3akhwo2@xwb4t76d37wx>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 9 Oct 2026 10:23:14 -0700
X-Gm-Features: AclHuK-CLR4BQdqBSfFuLWEHCSgtnQKEmsz-7EKl2ZGIqsJwmtfHX25-OeazvEY
Message-ID: <CAKwvOd=E7wgGPf+kgOY8sGi0xO-cFMAJK4PMBFknoEupJi1CXw@mail.gmail.com>
Subject: Re: [PATCH] landlock: Move the domain layer counter out of the
 anonymous union
To: Abel Vesa <abel.vesa@oss.qualcomm.com>, Bill Wendling <morbo@google.com>, 
	Nathan Chancellor <nathan@kernel.org>, Kees Cook <kees@kernel.org>
Cc: Tingmao Wang <m@maowtm.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Justin Stitt <justinstitt@google.com>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	llvm@lists.linux.dev, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	michael.bommarito@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 8, 2026 at 4:49=E2=80=AFAM Abel Vesa <abel.vesa@oss.qualcomm.co=
m> wrote:
>
> On 26-10-07 14:49:28, Nick Desaulniers wrote:
> > Would you consider this a bug in clang, or an error in how the
> > __counted_by attribute is applied?
> >
> It turns out Amaan Qureshi has already reported exactly this Landlock
> issue and proposed an LLVM fix:
>
>   https://github.com/llvm/llvm-project/pull/228309

In that case, I would _not_ work around the compiler bug like this and
instead wait for that fix to land in clang, then bump the required
version of clang for counted-by.

Kees and Nathan are traveling for LPC, so I don't expect quick
feedback from them, but they should confirm whether they agree with my
proposal.
--=20
Thanks,
~Nick Desaulniers
