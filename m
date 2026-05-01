Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FB71E9B3D
	for <linux-hardening@vger.kernel.org>; Fri,  1 May 2026 08:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777625501; cv=pass; b=I+ie2QmsqpOdsiKayhXNenIo81IEy9ANenw+l3ImR0EO5+hayChXaueQ0Rq24krhKCGRhDVPDxJe+FMKFyvthYSGbNQ7v6ALJb6JnZPXVP43WLbUvPSE1R2Aqev77/yGDVJPfU35hDOonmKZrEO7Au29usRd9z0K6NQ2QXaMUp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777625501; c=relaxed/simple;
	bh=hNBediedbx91Etaa96NByla0Y+Lv0BfApkyy8wNcAMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JbGeTMuogxu7PJoOV4XShO+5rNAcq9YvaLT6UIv+6GbyBPu4L8sLfOKrrZLPQwwzbE57eAJOEncZfmR9itDtY+Ni5rSjWtAYJocrngULiI7sh5Ye4LQHiBV5Wawp8r1ZgHy9colQmJns2YXE9MwFrNJRSLFkDB8DurSGomNtSvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6RdaIt7; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6RdaIt7"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b8f9568e074so277468766b.0
        for <linux-hardening@vger.kernel.org>; Fri, 01 May 2026 01:51:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777625498; cv=none;
        d=google.com; s=arc-20240605;
        b=evKBhRCLkL/shVrnBQYWZHw3ZhTUsUedkoJzQkrr6jkIN8oiRn8kI2nkqJGy+3ZPIX
         pmD8rSqq1g/XuPP5wXK54c7iIC6v4/m7NEQHyukzeZHqHS2LI8yE7KrN6QeVFXtvPsLM
         Jv/Rtq/H+vpZ4mpDKHdvPhxgMzaGvhye4xCgvuzuy9to+D/D0qUvaS4nJshvV8/x8OEN
         UOOJCx3PqMJpeTgY2vira/l5x0DrHN3/aS7desIiUXWkk/9NAT4elu+CawwYShLGe+f6
         AsfHIEe8bGKLTh724vHcsiApuSja4PuSspKAP43TxRVqDDMLUojvC8LKcTeWGSlztux/
         fv7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hNBediedbx91Etaa96NByla0Y+Lv0BfApkyy8wNcAMY=;
        fh=N8IH/bUM26v8KDwqsgq8vLqF2woHqTq7JtX1gttzIUo=;
        b=G+vL7Y5LoGfyj4PtzwZcbms3GYnlra8eq4AeypLS7ijbFzsEl79EIlI0kAuIpbwM9V
         1P4cjFs2Aaksf2uNlnAropVWHnU3AyqCbpa4TOD9xRCb2Z/eTb3isYzPAPq2sFjWOzyX
         PfS35WylW3NXKVMMVyJwB93vh0Lpq/tIh9/mMCOJHUzJALvSEZQT3hyTunUVjbiESYHI
         Sp4deNbiehA+4Kid0icGhrM09+V3kvxrjxEyoCGSXQ5i6RLdygwq79xbWMz3ilaH91WF
         A4reP4M+0nzzbUkHIYDpOiDAQVQqdkccym1RfYDlnQwa5Amr8TY7KN6v9vDgJQLkIiSH
         HJNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777625498; x=1778230298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hNBediedbx91Etaa96NByla0Y+Lv0BfApkyy8wNcAMY=;
        b=G6RdaIt74CgfFrZVPfVhlbSHjj/5G6YNgV+lySJi/LKIj/AoWRQvQHDIzUJ5hhfXH+
         pNwetFqhv6aHsk8UojhLhhQb1pRzv2iu8o9JJFUMm2sLD0iHzxka0RfvVGzP/sJKC/Yu
         GCoE0/6UoxuHSH16PBm/+FmbFrYvavEjQ5wEvPXMmWeNl+Xb6RnlhsoeHlnykD1R0rzR
         LfCcEPdan/BjFsdTkHfcVomNy1UDyPy9zu9AIS/8frYVPMNaFBfIfIQOq6RqUOatcolc
         PNc1j0sV7IFnCExPQV2dB+UKOLU8sGKWsXynRfzWrOMcOs8eMUPv7n499WMl/lKoTtwc
         zY9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777625498; x=1778230298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hNBediedbx91Etaa96NByla0Y+Lv0BfApkyy8wNcAMY=;
        b=JPVZkqtmOLOP9CvRjkmP/FvPa1VuJK5eX+oDRDr7ybCRL+ZLbra8SBVn+p3oVSGo6k
         Sxy4s0tNj7rH6OhcrdXMiI8ZHGMABw4ODgnt8LBbUgYiq89S6oTlf2HPnMHpl/x9ObTL
         scKqf0pNerehhLGm9Npix2GwfvR8/G30jNVMKI2loF6HpYGE6+PzCOva1EjLvfPsczb0
         J6E7qBr2YaxJvDI95e+aPx0JLV3HzCKbwv0y5WLtANzaBanLgugAZfTUa5lJvljLL9Yv
         MFfKPcZG5FwXiVqu0/HSmuQd4zsR53IRrqJOYofwbGI9Z9CaBv/TCVMcM4TSSL5rv7/o
         VI6Q==
X-Forwarded-Encrypted: i=1; AFNElJ9InkxsKKC8QPKq0ctmuPhA78sWOQmQfzQrw03eHD2fyrm1rtcJntAAgBfuqGQUmnURCHr1B+a4cLnYEjLWE7c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9Mrr0tvVNhy3hCMUX6jSHqZyQ0/wklVgZxB7ATbXVtdX4UnDe
	HFhHNN8ZlUtJD0TIsTN2ZIyw7Yo5gu+8mFRHLPQjjCIsuMR+s8HV1vaq30UrwGTZZGlS009K85U
	WrOLlRY7jSho3t7Wqys4Nlayhz2HsfG8mwKdj
X-Gm-Gg: AeBDietYwmr8HxYNDrkOf6c3Fd0iy63SyJDShk314gcR6175QWK7yOoQPZITPlh+OUF
	R4+ePlWN9UjIRNwn2tblqDHIFILfofru6Y9XxTi+J0MW5pOKfz7eUsKzw3vf1lr1qTLbuQbVREX
	rYHaG7wnL5WoBrZFP2V9adVOUEGdK/Z8gn8p+uBFXi4rtHOU43wLA7JGTWdxm3/pw+TDPTIM0vZ
	RYc7n0PU6aO7lI8atjgVhvsWdxoec6nHUz9CBEPDjy+bDKJu8ctQP6XGghl3VshgcMgNad76kmq
	B4236OxhLM/X5tWg9hD66VSMFl386AwJED6R1uLq/kRHU7mqpkCMdmQBMsGnLAM/gSEmHu57Dng
	RiAAsOVKNwmkiXhcqN4seT1Xzsr1/GQ==
X-Received: by 2002:a17:906:c106:b0:ba8:c3b6:6497 with SMTP id
 a640c23a62f3a-bbac50eac0fmr404007866b.14.1777625498307; Fri, 01 May 2026
 01:51:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777529232.git.jqqlijiazi@gmail.com> <ff9cd26fe84bf581f83a560a8f043437b31f8b79.1777529232.git.jqqlijiazi@gmail.com>
In-Reply-To: <ff9cd26fe84bf581f83a560a8f043437b31f8b79.1777529232.git.jqqlijiazi@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 1 May 2026 11:51:02 +0300
X-Gm-Features: AVHnY4J5z3IwxiSUNyAGd17az1Oc3MjghVCqYmwrU88SQIr2kLF2JcwqPKfJGhA
Message-ID: <CAHp75VfWPKSf-Q37uiUJeVQj1g=N+iy4Ftr1Nc+GnW18cSgGew@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] lib/string_choices: Add str_alloc_free() helper
To: Jiazi Li <jqqlijiazi@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
	linux-hardening@vger.kernel.org, "mingzhu.wang" <mingzhu.wang@transsion.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 9:41=E2=80=AFAM Jiazi Li <jqqlijiazi@gmail.com> wro=
te:
>
> Add str_alloc_free() helper to return "alloc" or "free"
> string literal depending on the boolean argument. Also add the
> inversed variant str_free_alloc().

> Suggested-by: Andy Shevchenko <andy@kernel.org>

You are not supposed to randomly put some tags without approval. I
didn't suggest anything to this patch, I *reviewed* the first version
and commented on it, but I have *not* given any tag (neither
Suggested-by, nor Reviewed-by, nor anything else).

--=20
With Best Regards,
Andy Shevchenko
