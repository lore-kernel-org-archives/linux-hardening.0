Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E971DF75D
	for <linux-hardening@vger.kernel.org>; Fri, 18 Jul 2025 22:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752878936; cv=none; b=hbfwd8rGr2+7LDSj5TwS46p1MixhTh1BQ0f0czIjnFVo4rpb/MXpnqjLG4zhyAq1tCMmR4SLUPbzz0aiCUGN6P0wseHB12JO2hQFDbeXMo+A8b1btV2W+jvzqALIcwI+Quu2Sc7TO7N+lB2m2SgtRGDk+7ZomHMfp2JLgViRZ8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752878936; c=relaxed/simple;
	bh=u+GoV1d3OjrOfjZvHBGS5A7zm5qLVyzCUMqD4/+LCbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o/INjh6yl3YzrCBXmAOuuezokPBLt9d1156F8m/zNCWzzOZNHkFHoteEAQ/T1oc0Tl7BYxyQvbuq6YYm6i1PQCso/0+G2UygbnhJC53yLe1GpHDoToet1vUrnFAjdD2d7eX7Gl26OZzdgJCSLxXWp25qjqcXtwxTRs2k3Zmfe7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bjL4Rp6g; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bjL4Rp6g"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso3333214b3a.2
        for <linux-hardening@vger.kernel.org>; Fri, 18 Jul 2025 15:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752878933; x=1753483733; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hELc5E/W58AEsTFPxRlrtTifL6X7XT08Dw5sqYCmPJM=;
        b=bjL4Rp6gGF7xEuVxG7qlSDhV4Phey6dFgqlBaKL1c+GJ1QJWL/u70GkMjS8czgRjbd
         9Frt3HilNqmJ7slvohjJp+rG3gI8C8cTSxzNjvSyAjGywQl1ixSTMwXPJivZgLMEXzcr
         CNwHcxX45pEtNK05zbpFiDSbb34cPKkJGH1jg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752878933; x=1753483733;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hELc5E/W58AEsTFPxRlrtTifL6X7XT08Dw5sqYCmPJM=;
        b=D2BPqLTBEBSTsmP/+TlEez+tCgIebzjmPVhfbCr2fAe1KW9Z7TW1dgkJLWCA/B4gdU
         yVMYIw9Q7unAcWIgmOqjcQnBCMYHd3Us0WnBKjuz239cdGNftDt/q81JDzKrFvVIs4bI
         VveFxe02FH20BvPNAYCN1RUn7Fdo9EalFlOGO37MKRDHPlse0avamp4DC9BBKdBDn1ur
         s27XcGiMtLuT5ais6cujhWTjIjn1PXbeRFl1nXpDFkM4FIR7LQWXP+chGSJ85sm0hxP9
         IWtuxGEXBIhLOrEICmaaNw1/0tr4kyaWYrQjfdimlI82SIV4N3tG7gEVykED6QBmuQob
         /j4A==
X-Forwarded-Encrypted: i=1; AJvYcCVXsXUgNb7n9yo5+co/fniHeXXpvslip+83J7PXBSm1fKyeVq4YE1obV6+Xnpd6mS9KiTaXRbqAdPWRY7qrm5s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwipO8NpBQwZgKOgZXSF0kQA4xmevxvJjTLP8VXrI83af5ZWSB0
	iKBAz52e1ik3EHy1eNnHp+OM0yLpExGToK7WpybiK/i2HM6ESbR+mWpLymP0Bx0SEql/FAB+dA5
	CxXM=
X-Gm-Gg: ASbGncvwiDmjN9f+HYgh15nhgrKI6V1MyE2iRJh6VXtBDHkLEDPj/YtMSyodr7K0ZNo
	nWVXoJr1WJN6W3AVP+SAK+p/j8tI446d+27mKvDvAqXomyx8UtPc7ktjUogWIBCm/3XDEa/wPo5
	BjaHjKQOOFF56t7+s1HpS5H5+j3FU+mz5IMxL76deCurnMh8kHeFImvWiHmme71p84zdobh0I/O
	ZWnHDaichvAUpvhMQqlfVRe+UNQuOl1TmuKCZgZCoXoXJ+MwVSdCpUYHQeKRnZLD3VTIDNCV+P3
	e4WbZDqGIx8XD1m8SsDbH48rEaIm5r7W31HLU+lsc7Pk0DeCRsixrdUcYJSJM+qxu3CxI42lc8L
	LZwlKbmppNKvazvtvG6/XugmJvJq2v4TyaaRBOR7Z7eduO1On0rj5rLpl8rwyORRKOQ==
X-Google-Smtp-Source: AGHT+IGcslrem7BtesFahCJQwUUtN2/AQOeNA9ifGo5GoWUmx0DG6Z/wdERtGAAEIR/mSER8Gai8yw==
X-Received: by 2002:a05:6a21:6daa:b0:1f5:8a1d:3904 with SMTP id adf61e73a8af0-23810b4dd3dmr20856186637.7.1752878933322;
        Fri, 18 Jul 2025 15:48:53 -0700 (PDT)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com. [209.85.215.175])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cbf5a13csm1773630b3a.162.2025.07.18.15.48.52
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 15:48:52 -0700 (PDT)
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b34a6d0c9a3so2448061a12.3
        for <linux-hardening@vger.kernel.org>; Fri, 18 Jul 2025 15:48:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUiPp5WBkvSfGO4mQKlHBhcafdr5AN8vg5gawp1cjjzABpsenz0O3bmp5Vlcc13Oqjbeg9KV726x1BtAQBR9dM=@vger.kernel.org
X-Received: by 2002:a17:90b:3852:b0:311:f99e:7f4b with SMTP id
 98e67ed59e1d1-31c9f47ce80mr17566314a91.28.1752878931628; Fri, 18 Jul 2025
 15:48:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718193220.316685-2-thorsten.blum@linux.dev>
In-Reply-To: <20250718193220.316685-2-thorsten.blum@linux.dev>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 18 Jul 2025 15:48:39 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UjmcOO0hdy2n9aL4Ms2beMVbBHW6Pk60Q-KvMCudYChA@mail.gmail.com>
X-Gm-Features: Ac12FXwxU5mzcJB8ppCxVaB7BneXFy3b3EU4qPIxu2y22lPFk0Y9cevEpEvupEk
Message-ID: <CAD=FV=UjmcOO0hdy2n9aL4Ms2beMVbBHW6Pk60Q-KvMCudYChA@mail.gmail.com>
Subject: Re: [PATCH] kernel: debug: Replace deprecated strcpy() with strscpy()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Jason Wessel <jason.wessel@windriver.com>, Daniel Thompson <danielt@kernel.org>, 
	linux-hardening@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 18, 2025 at 12:32=E2=80=AFPM Thorsten Blum <thorsten.blum@linux=
.dev> wrote:
>
> strcpy() is deprecated; use strscpy() instead.
>
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  kernel/debug/gdbstub.c | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)

nit: Since this only covers things in the file `gdbstub.c` and not
everything in kernel/debug, perhaps that should be in the subject
line? Maybe "kernel: debug: gdbstub: Replace deprecated strcpy() with
strscpy()"?

Other than that, this looks fine to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
