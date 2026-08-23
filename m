Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6499637E5E3
	for <linux-hardening@vger.kernel.org>; Sun, 23 Aug 2026 04:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787460282; cv=pass; b=dIVjkO7zvn1z2mXRsP+WYc05mRdb6h2QO4kB6JwJqcPX1n7VLax3Jct2jV1Yp+0hanKjp42V+otYoFxR4Dv6hGSpx080EPjHdpykw+2Uuby3H+qhAsmV68PviMXmCaAODr6YUF2HH4T2qVyAByasCOcnM6efb8OQyrO7htmqglk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787460282; c=relaxed/simple;
	bh=rUA8STlsYFYQiRvYWCdYW5+b5xiB+c/F92/ZCn93/g8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pBWc+kNgPfJ1EaEl3xFQwRZxyd9++FXBJd3DvzMwpdLHqAm4fw2davKnyltfXnL1LIrBvoKS7OjavucHxGTFN+FJ6y6mTAW4bM1PeuRZMfWimFf5WKaBvT5qmwybKcfPoDftCKIQJ5+39E9coyrhtdfcu/My+OrGd3UgktIkHto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c1q/tc0S; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1q/tc0S"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6a1542cdb53so2906480a12.2
        for <linux-hardening@vger.kernel.org>; Sat, 22 Aug 2026 21:44:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787460280; cv=none;
        d=google.com; s=arc-20260327;
        b=YcZNsDp8RwFm93EJv2lynbA8Ml9Zzqg0eRe430yqi+4KN4o66ABo6Kr+4DYE+071+o
         slUat/1SQVqirP78npKLSOK4uJ7H7FarSbXgvkbpsmK9tFKovXmrtcxJ3SpSQMEdmveS
         XqQu2JghuLELsgZuYFS7t040Dbn/7+U/uS1jtDQ2U2TlloAsyOSnm00ACP492SfZiCKH
         rcEcSyhhVvi0YZm1DgjcdsFuXTcX/0b5+SHTYVDNPAYm9JiuLJRZ46AzYMMPFpWUjq2F
         ohcbAist+na7RHWDlA6+ooMI6ttEt3YVqVDTV8wBjBULXOzn7mSEYekJIHl6pPfcdA93
         bkTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZSqjSSah5KBgALutr0hY72c4Zb4Ws8WYQo3Q/l3ach8=;
        fh=u0wxbN8DkToCLvxtz1LO0jXSiUvL6xJRPzNKkYUvne4=;
        b=E9qOGUDFM5EWqi+iC2PQ8UHGyVGgrYEbfeNo3khdgULrdU4B0h3UDHTeVwntm+9Nlg
         Z6TekhBbjVQC8TOecHihXY0NJvrEVP0d1PVi/kFLRTDZa0RHbm+thb1YWQTgc0x0IRI4
         zNTGd/JcEyw5O6StwH8tlhSFMqE1oQXgbhtnvPMFEeil0b4AJMhqDz5EPZXCKbs3KEYi
         PFpCSLRwjoYEdsl/JhYfTLhkOoxKvxHo8NDn62WdeUkpdC6ALrTQyH7gPTYKBp8ArYPT
         fWsZ2fgg1csinjaBHJLGNWhO3voDFS6Q8md44rpjPl2t3Jgt41UDm5GoMdfZIjVH6Kxa
         J27g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787460280; x=1788065080; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZSqjSSah5KBgALutr0hY72c4Zb4Ws8WYQo3Q/l3ach8=;
        b=c1q/tc0SF6zdK84DnOsm398gjIRp2zwOqHqvWFDxhL5H3RdCoS7UVWxog13Yh47NdK
         xqYsQln3oDUELzBzegsotci+ihhYGHxRL4aU0dOPQDEGibtfnFeXmLkbbfRd+FKqOd1k
         7mKtAv5a4tDzzVScjeB+5Xs6AoeNLHRFkdCiOMPR6N+MA+DpPk5IdQiP7uB9kUaD7wy9
         dy8a80RaSe82u/+4JJpmBtxP8eVxSLLWCG5qf7U1D5BWIhnXjQGXQjbTi0bFuN7QYGM6
         AyXa13YtswoCxd5m4GfEFc8qa9wJhGTHrkvaFU1v7HbzzeT6dILzQysp5Dk6zNhkjMsO
         Ze1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787460280; x=1788065080;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZSqjSSah5KBgALutr0hY72c4Zb4Ws8WYQo3Q/l3ach8=;
        b=K/L29ryPn/mGuKVE7ugQl+bfyggYKtXX9E9z5vT/yMu+vEWotZvVWvic5bhGR0T/Ik
         2sQ4VFfSTulH0oH0t36AWKEunVENgXh7u/817KU7n02E+7IXphDSjCqopOMUKR4ekstA
         3lPYy2whEer/3Iz19v7PKk9VMzmxCA+DBn6IqOBlR3SaY9kaMY/EMUDucv98GXXiPzKj
         nXGfIk+5j+gTSFk81PbpRJcOighZEWmb4+2eLf0QzcE6iXsYgX0VRPaYEGAKFsOJupXI
         cvgnjx2hODohpWVBUYk7rWVkSsa1rueNwm9nFMGxEi4ec5KYhS//GdUc6A4M8xQF3YXw
         2zCg==
X-Forwarded-Encrypted: i=1; AHgh+RqOkRM6cbkxVgGSxg/kgGbVfYtJa5qecgPcnKu0w9t0WDMgcHGu07Ay1Q0kWYvw7vEK28T4qLzzXKrFX3KmGuY=@vger.kernel.org
X-Gm-Message-State: AFuF++lk3aZ8GDfwoR3GTuW6JOnLpwakBkbpF12m1N0asqliZNHLZqe9
	f9syWLq6KLf9LpfroSz3OUlC3ZNY0ChCHxVArbp/34d6nc9kDZxPAmdpuSNaHCp1YAy4VnSLtVc
	tPR42f5WU5Kw9ZostwGU+QKqzJdqt4pg=
X-Gm-Gg: AR+sD13lAwBYsc/qtNU/WGfqYGPfqp8pDDFIYzPmQrIcq9eeTHq5BWGvEEyJURRsM4b
	uiL18s7uZ88IZGZeHRN+RiYd0gGI4Ir7Bm9QattSOEwUnOf7UBRCrCsskfyxu7FPNexi0q3/gXs
	1wGqEcs3RB5/yJfrYIpppX6XD1l9F0x2VVDNPeCsjKj+momYiN89CT3In9OiqFEjm2wfW6TtL7t
	cF0k1NnBAG5IIP13kIdepW1WjBzDOAhWfgouh8CZkOosaZd7vZRt6c00XYeVc0ULTGG4dgaQ9IB
	MfOhhGy1Fa7Ayi3HDjiY7Ln/RnDi2mKWvCVaRxzTyX07eedITU14ClnIc2NtFv0uTahhfYaXzqm
	HX1d8Tn8ds5VIPhgcMGe4ngW093x4h26QpYuw2Ci0QkwulvIpi5EHFT7Zkyl/EEO08h1IiujFlJ
	4PdYEbNBdOBJry20ksrN10Z39J3cx42RWuVeiTZLx5Jod0vaav6YOaPDyW
X-Received: by 2002:a17:907:8990:b0:c20:3679:a2e6 with SMTP id
 a640c23a62f3a-c24925eb3ffmr1126262966b.10.1787460279494; Sat, 22 Aug 2026
 21:44:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504031209.618949-1-rosenp@gmail.com> <20260506110910.su2s6ncsi2xfdiwm@pureblood>
 <CAKxU2N8PUdxo54oHtcroqe+Q88k0obxPg_9OCRsNsoOwvcS25Q@mail.gmail.com> <20260630123029.ozveska7eoenci3s@unturned>
In-Reply-To: <20260630123029.ozveska7eoenci3s@unturned>
From: Rosen Penev <rosenp@gmail.com>
Date: Sat, 22 Aug 2026 21:44:27 -0700
X-Gm-Features: AcwNN1WOqpjNvvrbFuuZdDr0EWOQvQOz6eBeeTVou_Zk_7DEeqlQ6lYFj7PXzJE
Message-ID: <CAKxU2N9wE48D2WLPvta98kB6xXciOdvpOzgGrnS9kkBHYfUwXA@mail.gmail.com>
Subject: Re: [PATCHv2] firmware: ti_sci: simplify resource allocation
To: Nishanth Menon <nm@ti.com>
Cc: dmaengine@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@gmail.com>, 
	Vignesh R <vigneshr@ti.com>, Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Tero Kristo <kristo@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 5:30=E2=80=AFAM Nishanth Menon <nm@ti.com> wrote:
>
> On 18:42-20260629, Rosen Penev wrote:
> > On Wed, May 6, 2026 at 4:09=E2=80=AFAM Nishanth Menon <nm@ti.com> wrote=
:
> > >
> > > For some reason, replying drops the CC list. manually added them in.
> > Found the issue:
> >
> > https://lore.kernel.org/lkml/20260630014129.1548147-1-rosenp@gmail.com/=
T/#u
>
>
> Please repost with additionally CC LAKML and the TISCI maintainers for
> the patch, this would go through my tree.
https://lore.kernel.org/dmaengine/20260630013917.1537819-1-rosenp@gmail.com=
/
>
> --
> Regards,
> Nishanth Menon
> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DD=
B5 849D 1736 249D
> https://ti.com/opensource
