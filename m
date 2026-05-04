Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0684939A073
	for <linux-hardening@vger.kernel.org>; Mon,  4 May 2026 12:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777899162; cv=pass; b=FG2oTtIZqDC+3lZ64ptYITUheVDKEMt2CALPgyQMfrc4H05AVrXY+00zc76dnB6AIb6ABdEZmM2SIl7eHq+Jxh/HkLl4bko49r7v4aVUSe8v23Vz6yGVfaSv3c4mnCaGmor+FQHJwRtIrOOFtmthc8HTdJHGS9OujZpo/NkV3l8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777899162; c=relaxed/simple;
	bh=EnNR5snQr2I8q4Uy2Vqh3/6n578MZmN4/uSfefPFQek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JbYVbAkpQiWFzz9+ZdtK+UU248eagcDPeHhJUbcpBubhfTt984ZsuxaZmXeOmRChOill4LfrcuuRj0khkEz9ISXNqrwJxnETduKd7m+RqbCfrIR9IYyMl5uzbmwJx7w0zJ8j13+2EvNXHF67MkwfQrQwP8CyHZE0Glu0J/XUT4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rJG1pQcA; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rJG1pQcA"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ba922426c5cso704654666b.3
        for <linux-hardening@vger.kernel.org>; Mon, 04 May 2026 05:52:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777899159; cv=none;
        d=google.com; s=arc-20240605;
        b=PKBxxTdtwIG1h9X1OA3IgOUiCawmnpKm2iiUZuTtgWLTwC1ARGVPMStMK7Dg6rQPg2
         skJj7gjPTn2shqfYUz6dx0Y3iXdhvHvvn31HT91kVa5UtCn2e3NZ1CR9slPprov2PdXB
         Jk2xYUnUnJFNFkBq0aDCPkS4pmgmFJyn5Di+r/HRFFju1uvl6XRSCej6IHgpGcKLDsVS
         b4uMXS8PL0ygwOleTpNVtoMa+fX5Y/tE1BASCjBj1xsyC33xMG1kMtBsQROproG/2q4a
         959siBLqiBHgcrzSL65JEh9fll8ZgxluVfMVOiAhxGFHnWzN8aTlRHoEqo5jF7ZAK+N+
         vKWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EnNR5snQr2I8q4Uy2Vqh3/6n578MZmN4/uSfefPFQek=;
        fh=UL0d1mmCOhtt9ZFFREzsSFdiENCEM1v0oVjqAReikrA=;
        b=ecQXLSkW6onm+PeTH8sViAhbs4U0/5pAPK0oWZwcPkIkFBPDDR3bt+2EtRK4d1tdv0
         pUOTcKCEhmUbmzu/x7RVUGmuhYZq6347BupGUSs3l3aJxSr2PMEOGX4N8e2wCHH/PiqR
         ArHLQMm0WQRv/V8PZZiNxWYsGLpXLg7aANU32D9CWGQ9fmT1+1Cy1m/he2KevSyY4oil
         GxIsm/Rugf5PT+KjOdbK3Cv1FobEtSXq6J1jLJUfLp5A1i/qrZ4EBb5y1pBpXYukrCAy
         u1gs0OGViCxCgMDdyleXykjcPvjyFwz6bYzFuqeEP2kYKRerQqOto47dxDSpdlnQAhpf
         sllQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777899159; x=1778503959; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EnNR5snQr2I8q4Uy2Vqh3/6n578MZmN4/uSfefPFQek=;
        b=rJG1pQcAPwu827eaa5EZy1oZi5D7vGFQE+fY++/L289p3U3KL8xSqfMrOauVWZWIP1
         pnhv+u4DiODuBrGniwrnNgoQJM6LJhniKSemg4phAdDbgaBM9i7u9eLUhqo2UfjMzdOU
         /HyH6EHMtN627lKhRR1gdzQys1NjSztzPF4cwNm9DCU9YSfodz9F7i0PbJPnm+CZPB8h
         6WrZlAh9cUcw1Ntb2+ldZspLj1seJpywnhuKvxBn3e2wzUah+uUsj6Ze7GXMPdCzuZml
         Qk6Kq40Qk+3YaqJm7AzXmCTeeHsSFuHdCNQDn7c4vT1JZ0d7+Z9J5Xsap1Jd1Hdh2GnK
         pbRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777899159; x=1778503959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EnNR5snQr2I8q4Uy2Vqh3/6n578MZmN4/uSfefPFQek=;
        b=gYYExtK815m5lUGpjpUxug89/NxQ8Mx9yPcsZr31DoJXC8UFphAxf8g6C7EBdzf009
         wYFSagcLw51HD16NFQSTCyyS1cNtvsU7uu1YivXm6fpwxaGSjgsMyAATpV64C6KVLJ4V
         HgEJEZV2OaBuIRt32R2gJNa3NgmBmna10k4YfiXT1gIcpAzr9RZWaUw5OBChIfovPefB
         hXPC6qVwYvr7cJs4E0LuXPbjnCfI3vR0Jo12/14NhiVUrKFys9GsW6Vb0Jurb/CATQuA
         YydbUl3d9/afKz7NTeSqErbuJmt40otUiiu34pNR6eRSshKdlZX71pDUyPl4cSf5fkV+
         el0Q==
X-Forwarded-Encrypted: i=1; AFNElJ/6vQcyOxNBTc38iGfs3hnjwxNdSft6LFpgVNocyyxZirDXBsv8Hjl6M0qkPRZM6tuZi+nmNmiR+jTjfyNxPyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsKCsGZPAG5vcpbI5vp0SMbpRf/z3yKEyfQuvn0YyEWqqdSxqT
	ia/WVh5g4TYGaX4ntqpB072XNGMRI8Y+zX82/dHSBSwJT+z+wTS/NxYC4DBfBDJ357BMQGfxXzp
	yDrTTIkXjIDkql6FSylMBWMg5MaGColA=
X-Gm-Gg: AeBDievZcLTOKtLDd76abCuA8N49z6eqMLqJRfohTqTzqfQjBujacPL//usD/D90rkH
	0BdpzoR3q53QRG7QWGPfAdxLDL6Hk1FGtpDWP4vjPueDaT1v/3LhbfFSfsdaC71L5AzrnyALKtP
	vbXQ9I7twMccuqoDxvuKw916HJycjADV6321iI/v31D07KWH2aptaz7C4jSsSJgKfCVYSvzKvKf
	6D/DNOreSwsUTmtVrPgq0qBvREfgRTQ+N6GojMovtuByvuAVsm3To6TaHUkOGbubt68PY1OqRSc
	VrSt7uAdvmTO4s1RofwI1+FV0bFhSv/z6gFnVL7+VLuZr33m2Dh7nR0vf8ADPqbVeNobZYMLf4+
	LBCAdpUwxgzmOkIgRKg==
X-Received: by 2002:a17:907:72c6:b0:bc1:8da4:8ae5 with SMTP id
 a640c23a62f3a-bc18da49ccbmr270892266b.44.1777899159120; Mon, 04 May 2026
 05:52:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430205050.400822-4-thorsten.blum@linux.dev>
 <CAHp75Vd10OdNQfhb-hOAapJ4=uhZ+t26vp_WMAoeCska6NCyOA@mail.gmail.com>
 <afW3tJH4XfeX_OXG@ashevche-desk.local> <d9845986b6db299315f6e5e2c02b1f030e03ce45.camel@mailbox.org>
In-Reply-To: <d9845986b6db299315f6e5e2c02b1f030e03ce45.camel@mailbox.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 4 May 2026 15:52:02 +0300
X-Gm-Features: AVHnY4KNRJ0GPBYnfsHZhWNmhHO6vCHEZCCfXCWDpWw1txt11w6Cica3pFnlzEg
Message-ID: <CAHp75VexYoM9VJ3R0Nxn1WtXfhaDScf3K1TkuVR1HaqnX685Og@mail.gmail.com>
Subject: Re: [PATCH] string: use strnlen in strlcat
To: Manuel Ebner <manuelebner@mailbox.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Thorsten Blum <thorsten.blum@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 3:26=E2=80=AFPM Manuel Ebner <manuelebner@mailbox.or=
g> wrote:
> On Sat, 2026-05-02 at 11:37 +0300, Andy Shevchenko wrote:
> > On Fri, May 01, 2026 at 11:55:33AM +0300, Andy Shevchenko wrote:
> > > On Thu, Apr 30, 2026 at 11:53=E2=80=AFPM Thorsten Blum <thorsten.blum=
@linux.dev>
> > > wrote:

> > > Please, do not spend time on amending strlcat(). This function must
> > > die. Instead, convert current users to use alternative ways.
> >
> > Note, there is a patch by Kees to address this in partitions framework
> > (vast of the users of strlcat() in the kernel). Not sure if it's alread=
y
> > pending in Linux Next or not yet.
> >
> > I have done a simple one in ACPI recently (in upstream already I believ=
e).
> > So, you can use those two examples and continue killing strlcat().
>
> i would like to add this to the file Documentation/process/deprecated.rst=
.
> Does right after strlcpy() make sense?

Yes, please.

> Could you point me to the examples?

c2d466b9fe19 ("block: partitions: Replace pp_buf with struct seq_buf")
36cb728754ea ("ACPI: processor: idle: Replace strlcat() with better
alternative")


--=20
With Best Regards,
Andy Shevchenko
