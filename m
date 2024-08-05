Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028041684B9
	for <linux-hardening@vger.kernel.org>; Mon,  5 Aug 2024 20:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722890679; cv=none; b=PNzgqzEj5z0v/mcnkKS3My1RVgEK9dp0JA/IylSHfNzy4jmBaxkI1qJl1TU87fYJEfxVIJX06KZjnBlLBNcLwsOKLZCqkKU7AuRLNJNGwzGSMQ5qXHiGKKGUMBasAv8C/Mc3Cb7+TjY2CjYfb639UQi6WVD/blOs7mP3eapIOT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722890679; c=relaxed/simple;
	bh=S3+/yGDGoGuYOn547Y3RnmiiAX5VnYowfIsnCN7y5OQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YB1LRzOzIV5gt+e1hNdUKCpR6+nu1VOByWQocY2aoO50Lf4IVRVZLSmcesAsXx4lMU6zPTZa6zoXTJfdjLH8tAWsLsNX1FVSeWz6u7qY6lT5Dw7Sg9GTsafxziGF8JxeKPQv0loOZtAZuAbeN4sh5kJygUtGSVYD2e08pODuc00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CG63HGAT; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CG63HGAT"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-44fdc70e695so124561cf.0
        for <linux-hardening@vger.kernel.org>; Mon, 05 Aug 2024 13:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722890677; x=1723495477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g6wqt4kGYM7Zcf4b7kRydXxqCjvpgmcWCUmlWuhWPkA=;
        b=CG63HGATrA/Zx+sOubUK8RL42LqwpimFNdbx66WFxTTMKoUX8c/pIyfj9IUt2iZGOA
         XdUGRjbkwIr99yVvuUc413mpB//yYSTqwN0cpXOeVaunZaqN2VEcZf0KCU182pONEpMC
         PP/ByBhTVaFpKntDPR788nlmL1NsgMzZzy2n1EhpXlj8DjsIoydI9a+MmDb5m0Bk1mTN
         c5nxe3Cc/vvco18LZ3txLO4difF/n/dCdYqdkDUPzg3+xMkotfSoEqxgYi4KGqlm2YjG
         CxnbkiOx2Lf515x4gp9r38WIZ8vv+Cs5F7oewV8jyVuaUonvWutP098gQnuj+ZVcOUgS
         bcZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722890677; x=1723495477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g6wqt4kGYM7Zcf4b7kRydXxqCjvpgmcWCUmlWuhWPkA=;
        b=AhJD2IvmoQEhNNL0EGcO6R1G0jTHo6cOhZE9AtVqfgK3WvvuHakO5gFtBYPG2qQFBJ
         9InqTGaiGnDGH+VZsyhZWh6sW487XwuIij2eai7MTDO0vgJzUKe+IZGcRS6gYH1Iirg+
         675BJMEOGCH5fOXk3DMrZ0V1+ECXeZP3/+TgWynYyFo5m44sWCajDLVYuU296Rs5FmCi
         SQW1/woiJUm+yiKVA14Gc7vm4poZ01C5KpDdkmzjy6adKDrs8vmU8rEgkceuRJUfk12v
         fdCvKbAPeohQ+24HTGZArXzMxa28gnuSr76QgxZrux0zQ92+GgxlAPtTE5Yn3OYdD+sZ
         9b6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUVjCrUGDGDQn+gZUwMuXk3Ci9teVp2OGqDet0UaPonTtXxuXME6RUYD5gZTmw37UzQV8qv8+TRkcszQx6upCDVy4sJp7ytYUbCTH5/ZUzN
X-Gm-Message-State: AOJu0Yy8eEnI9Bn50hZkzJVGSKXPAJpYktzR/d/eaiWaR0vvUmJdj2QT
	dFMZXO0taHlye8xCSmy/Ql0BAocT59qbCyhBte9nm+MIdlV1ZDQJFe3pCBS8hs7oj4U6iZ8NDCU
	E+nqhTnoyjqD8pQ5ySGaPi+oWhgKtpYzAW0JB
X-Google-Smtp-Source: AGHT+IEw7JjEW+m5DpwhJFyFx5H5/pf7x+UKgeaUDat/ic/VKSYE52o76EKN35RwUaI1gKHMFrzEC+iNjBo/lfDEKO0=
X-Received: by 2002:a05:622a:1491:b0:447:e8bd:2fbe with SMTP id
 d75a77b69052e-451bcea8b05mr70691cf.1.1722890676706; Mon, 05 Aug 2024 13:44:36
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240625160718.v2.1.Id4817adef610302554b8aa42b090d57270dc119c@changeid>
 <20240805165336.GA10196@willie-the-truck> <CAD=FV=WGfQeJr2CuA7J5XgytAVpVxZPpH4EY8e8y63wMOaHRwA@mail.gmail.com>
 <CAOUHufYWHECbnhfodCKzNp81YHCHomC2NhgZCtX3cHdzn48ROA@mail.gmail.com> <CAD=FV=VodEuhwaTh5ne0YCPkvxna0rkL9_mKN2tJzhWL3ToVEw@mail.gmail.com>
In-Reply-To: <CAD=FV=VodEuhwaTh5ne0YCPkvxna0rkL9_mKN2tJzhWL3ToVEw@mail.gmail.com>
From: Yu Zhao <yuzhao@google.com>
Date: Mon, 5 Aug 2024 14:43:58 -0600
Message-ID: <CAOUHufZALU9==QxkczwdE6yE_FBgaJ3XmKLKrp=Yqot04GtOpQ@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: smp: smp_send_stop() and crash_smp_send_stop()
 should try non-NMI first
To: Doug Anderson <dianders@chromium.org>
Cc: Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Mark Rutland <mark.rutland@arm.com>, Sumit Garg <sumit.garg@linaro.org>, 
	Misono Tomohiro <misono.tomohiro@fujitsu.com>, Stephen Boyd <swboyd@chromium.org>, 
	Chen-Yu Tsai <wens@csie.org>, Marc Zyngier <maz@kernel.org>, 
	Daniel Thompson <daniel.thompson@linaro.org>, 
	D Scott Phillips <scott@os.amperecomputing.com>, Frederic Weisbecker <frederic@kernel.org>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, James Morse <james.morse@arm.com>, Kees Cook <kees@kernel.org>, 
	Tony Luck <tony.luck@intel.com>, linux-arm-kernel@lists.infradead.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 2:29=E2=80=AFPM Doug Anderson <dianders@chromium.org=
> wrote:
>
> Hi,
>
> On Mon, Aug 5, 2024 at 10:26=E2=80=AFAM Yu Zhao <yuzhao@google.com> wrote=
:
> >
> > > > > +     /*
> > > > > +      * Start with a normal IPI and wait up to one second for ot=
her CPUs to
> > > > > +      * stop. We do this first because it gives other processors=
 a chance
> > > > > +      * to exit critical sections / drop locks and makes the res=
t of the
> > > > > +      * stop process (especially console flush) more robust.
> > > > > +      */
> > > > > +     smp_cross_call(&mask, IPI_CPU_STOP);
> > > >
> > > > I realise you've moved this out of crash_smp_send_stop() and it loo=
ks
> > > > like we inherited the code from x86, but do you know how this seria=
lise
> > > > against CPU hotplug operations? I've spent the last 20m looking at =
the
> > > > code and I can't see what prevents other CPUs from coming and going
> > > > while we're trying to IPI a non-atomic copy of 'cpu_online_mask'.
> > >
> > > I don't think there is anything. ...and it's not just this code
> > > either.
> >
> > I agree -- I noticed this a while ago [1], and I added
> > cpus_read_lock/unlock() on the caller side, because having the locks
> > inside callees can be a problem for callers who can't sleep.
> >
> > [1] https://lore.kernel.org/linux-mm/ZnkGps-vQbiynNwP@google.com/
>
> Sounds reasonable. I'm happy to review a patch doing that.

Thanks.

> > Also, do the handlers always see `crash_stop` set by the sender? If
> > not, would it be a problem? (In the above link, it has to do extra
> > work to make sure that handlers eventually see any updated values.)
>
> I _think_ this is OK. It's been a while since I wrote the original
> patch but I seem to remember thinking that I didn't need to do
> anything special. Tracing through the code again, I see in
> gic_ipi_send_mask() the comment:
>
> /*
>  * Ensure that stores to Normal memory are visible to the
>  * other CPUs before they observe us issuing the IPI.
>  */
> dmb(ishst);
>
> ...so I think that means we're fine, right?

Nice -- I didn't know that.
