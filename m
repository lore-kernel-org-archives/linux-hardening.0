Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0792D9EFC
	for <linux-hardening@vger.kernel.org>; Mon, 11 Aug 2025 18:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754936030; cv=none; b=VYi6Sa1blC/yAf9HFRD9f1mmn/RtDZbUaf0tdUS65FiF2QZQbOrAI9dPBDT9GFscAQOmNA5JumaJLQNSmkHkF9U2xt6IjA8yboOLgMxPAGeWV5qqWi+Guv/PAd8QdxBXzatSo5W89iCpGkf9bFU4uxJjrCqqzCb82HEASrSMfOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754936030; c=relaxed/simple;
	bh=ANm4Uux2/v/BkH0mMC8Vcvx5lJDO9zkQ5mDxi+2+IZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DgVonh/tn5/OhRiqkmEpmv9LymwA3GYW86JJ1zhoNB3zE8EV5DwVqY2zbpInVoPRu+RWq4q0rKfDJOD73cGipJ5RDriqtbzk324t2dw8ydPK03yrU7Ek5dpOcKiapKDOuMCR/zH/+uPmRyS7Ps6++HLdOB386Xh7GmEOhFcYU2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CrRT6JDS; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CrRT6JDS"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76a3818eb9bso4263680b3a.3
        for <linux-hardening@vger.kernel.org>; Mon, 11 Aug 2025 11:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1754936025; x=1755540825; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ANm4Uux2/v/BkH0mMC8Vcvx5lJDO9zkQ5mDxi+2+IZ0=;
        b=CrRT6JDStMnr3Pt9JqrYGt76D5oQSHdJafT+btuiUChDpi6YAQGkwcTLwKHfMt2NHg
         ZXiPh9K7ZeW7u4DnnNWfrtBM5Cz95y+KwTZ1JC9qzsZXnYC4iaFXkCSrUvuQN+6pmll6
         U31+zl/BD57MJor/tt9SClJwo4A0IKsddBnmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754936025; x=1755540825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ANm4Uux2/v/BkH0mMC8Vcvx5lJDO9zkQ5mDxi+2+IZ0=;
        b=c8rUK1uasR9EDxEajkb54ptNu6pvIvkLCDjERQBu3i9FSbrEWz18hcJgrnk6NRv3Qj
         c7Q0kb4QKwR8nev21M+7P6h/w6ADyUp53zeUjMXCYsB3QJ6K+aPDhsoHYQvaKZ6v1ep+
         5b2eFllIwr2fsfx0dpY19KdLOqlhyxGXGiOnWLojaxp4Izx1NR6D47PIIrKK7ylUiDeX
         mMyRprCZqoUaiq6TRfIL8Yk4SMuxEa+N+h8p41h9cBpAbszuji0eMsqvAaSLTviUCHbY
         t5/Rn0z+gvZpBptJPytf6kB2LJsO1VuGxYsqsJiznwGveUrJeDzvj4pL13K41ye4PeCV
         3krw==
X-Forwarded-Encrypted: i=1; AJvYcCV6XYLcF4OPdeiccxyb9iXG25efXqqWuPSjcU49LZA1jqqHFdtOVUVhRCPJT9zMhWx9ngt/T0zMlGmSZwbgq5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwqZUTHLmB4gfRW0YlNuiRgrx6MDnYKCWITGzb8vihked963M9
	IQoxpob4K3ftyWRlHVEkf+/0eWS9x5X24sF5To6BOkE9Z+Zhkltyth2JeJzbahFlhxauffxkV52
	oh68=
X-Gm-Gg: ASbGnctXz4xsvJsuZlINnCwBAw8aDNj8jK5yWbXtxwIuonEsU6d2LeH6GI8GIutNPOT
	nAKLVHL1SbeWydwEaZe8s2JBXAYrRRp0z8E19G81gRZdgNuA/zuJoJknJrLDdPXwDI5dbmvTQk7
	ZLNEB5HOqi9jJvccwZDl3daqlSWO38EwHRrsMOe6r3stWdbB/PqoFFZN160Sslazse1llN0QB36
	HhRtgN9KxSuKuhdLjivzV6tyqgZEd+nso0HGpIc+wP8Hf5XGVMdv4+0T4BzY8inSZNxEqjOqdKD
	A4+uGY37TS/7k7a+e1zaG8o/iPknRlNaIUowBDkVDfsJmatC/ePT9yBk3RGgwwL/3LEgIgSgAsz
	8QsfqLBCFv/R8IZTvu68REK8fRVfIvnalzOBPgBoPpceHe2DuB5XYuyjNFPvf039lXRKbf/dx/u
	+t
X-Google-Smtp-Source: AGHT+IEXeMp8U72mTRhqU0W5GZnEcNU8C3fErW/ngbQ6Y4b+KfvI7mEgjQSrccKHow1CrANE9RM+sg==
X-Received: by 2002:a05:6a20:728a:b0:22c:a165:3664 with SMTP id adf61e73a8af0-24055160270mr23730445637.26.1754936025392;
        Mon, 11 Aug 2025 11:13:45 -0700 (PDT)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com. [209.85.214.177])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b423d2f4fcesm21927878a12.33.2025.08.11.11.13.43
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 11:13:43 -0700 (PDT)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-23ffa7b3b30so43322785ad.1
        for <linux-hardening@vger.kernel.org>; Mon, 11 Aug 2025 11:13:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXHXf7j5NuKVCsq8ooQTGGLH396HOC6tkRNR9RltdlLy6Ygnlsqc73SWAhr1bv9XSH6p69mVDfxjmvBoLKMLjo=@vger.kernel.org
X-Received: by 2002:a17:903:19cc:b0:242:a3fc:5900 with SMTP id
 d9443c01a7336-242c1ffce82mr181750335ad.8.1754936022978; Mon, 11 Aug 2025
 11:13:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811170351.68985-1-thorsten.blum@linux.dev>
 <CAD=FV=UrEv+=KmjZTDt7F5ftuw5xrpOyEim0OrGAkoiJ5Wi2cg@mail.gmail.com> <17A3048D-E2E3-41FD-A6A0-853B2E481B12@linux.dev>
In-Reply-To: <17A3048D-E2E3-41FD-A6A0-853B2E481B12@linux.dev>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 11 Aug 2025 11:13:31 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XzSD+pz9RNZDS0paDUWKJ-AW91U5DuEQziszYchuZGAQ@mail.gmail.com>
X-Gm-Features: Ac12FXyQvkSM0ZmqfknQHYkXyeurhKpeTOYtq8R_cD4QpIIkIrGjU0oRnuKfLKs
Message-ID: <CAD=FV=XzSD+pz9RNZDS0paDUWKJ-AW91U5DuEQziszYchuZGAQ@mail.gmail.com>
Subject: Re: [PATCH] kdb: Replace deprecated strcpy() with strscpy() in vkdb_printf()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Jason Wessel <jason.wessel@windriver.com>, Daniel Thompson <danielt@kernel.org>, 
	Justin Stitt <justinstitt@google.com>, linux-hardening@vger.kernel.org, 
	Daniel Thompson <daniel@riscstar.com>, kgdb-bugreport@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 11, 2025 at 11:11=E2=80=AFAM Thorsten Blum <thorsten.blum@linux=
.dev> wrote:
>
> > ...so I looked a little deeper here to see if the buffer overflow was
> > actually possible to begin with. Looking, I _think_ this is true:
> >
> > * `cp` is a pointer into `kdb_buffer` (location of first '\n')
> > * `cphold` and `cp` are equal at this point.
> >
> > ...so you're guaranteed not to overflow because the destination and
> > source overlap. ...but that means we shouldn't have been using
> > strcpy() either way. Both strcpy() and strscpy() say that their
> > behaviors are undefined if the src/dest overlap. This means that
> > really the right fix is to use memmove().
>
> Good catch. I read about the undefined behavior in the function comment,
> but never encountered it and haven't really been looking out for it.
>
> > The above is based solely on code inspection w/ no testing. If I got
> > it wrong, let me know.
>
> Yes, I just compile-tested it as I didn't expect src/dst to overlap. And
> then my last-minute change to strlen() made it even worse. Sorry about
> that.
>
> Are you going to fix it using memmove() or should I submit a v2?

Do you want to send a v2 that switches it to memmove()?

-Doug
