Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972E426ACC
	for <linux-hardening@vger.kernel.org>; Tue, 21 Apr 2026 04:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776747275; cv=pass; b=l84iM/WG9uSjTG88zO8/yQanq/7ADgPkfkv5GK26lDp4dVnm5zJhv+OwS+GUQ3U1lFqgRDw7hmab/m93yfl1680emuTmFZI4fiP2wcQne7Dg5uVppLw3BN6jI756LtWgOzxMeeoq2moZvMDkRCf77U0MV8u7DJevLUoO0lHp8nk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776747275; c=relaxed/simple;
	bh=zoEuG8hBEwU+J0NdVTvnR9oirCOkP2yu1ASGnIzv29M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hhmUz+lejNb+XCkpToYOGgK1g3TlBi2u1ZU0Abrhh+SzQZEy1ZKdwykMJQ9a/cJSedvkJxK5tXxtvW9+LCAyZqj4zfl8/lmMWOWSULoGOckI4PxvIswlMxozj8YDiF2ktGscCZN2x8lNa1KbMg3TTZ9GfcZCrzSodLEH2KafWgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pzoGRvLl; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pzoGRvLl"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b8f9568e074so654585366b.0
        for <linux-hardening@vger.kernel.org>; Mon, 20 Apr 2026 21:54:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776747272; cv=none;
        d=google.com; s=arc-20240605;
        b=lxcoov6E45mpWEF4LV0A0UMEIf7/wvR1WYRpOBbJBjcK1FIWr07hHlgeYJf2a+4dx1
         zphIb4IEY0deSGVpVpI32a1+Q8FPnQ5TC9BvEWOOlYQrkqJ+fxY1fWl2ltN4SBu1oZHt
         kBvpUEiIMCDsvr33kRpmfGrRXl21RLbubc/FyvW0e+NsE03ozhdrT+md7iZYLYEF5UAV
         fotAzdi0ajWzFXJZEXa41TOtaSuxfqH4WQ7Y1a9wd+vnt2lqIjq3Kr2sVVevEAPe9jgr
         8eVRd47BhsZ1z2XYKxdqUnOXhl8PhURTgwgdTU77QfmwAgh9FwRlK2CD8OzjtcqVR6Ac
         hhDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zoEuG8hBEwU+J0NdVTvnR9oirCOkP2yu1ASGnIzv29M=;
        fh=vpek+QZG8fabwEgO5WfSJbiBFzIrNc4+Sdr0bb+lBJA=;
        b=AkK/f/fy9CNIy6RXOaX49vn5hpJA0ulnU8JNzYosoZ3+FlGFDSjcti+sem4JlXDl10
         3n6/kroN9QRHjAKWoVqHGAr7AD4fWJACgVxjnGRll0v2+GMFF3MI97UonwNgMvFw31we
         QHIiDj2+MR6Bwyqd5Gw9OJ+Q9rJKmUNgGlc59CGLBrbowJl1tNQ+WhCaa3UX6AeFd7sp
         MKLGJmmJN+lkFppnN2dmu3fx3ig3ZsXlk26mXWT5lbON4CKW8ym+hANAaiLITcRyJdD4
         MHFlxjF2M0enlnsDSUHTwoKEuxJ5f/JZf5CmG7KtX/mFe7BqDYWmHQEprh8rXr2L4Qqs
         1i7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776747272; x=1777352072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zoEuG8hBEwU+J0NdVTvnR9oirCOkP2yu1ASGnIzv29M=;
        b=pzoGRvLluOWht/MMWWRqawS086Ow0tCQY2kzEtyBcLMDQF4RLM0cdqKmrldJ4Sb/0a
         djPbQgCJc0gqeJjHjkb3N1AulpoHTRUY42FmifZ+vtiabI+v+n9yG6FOYJR1CT40trzh
         zWqNFxvrsR+sHFG7ybgV8stWfBHexR1UmUGzxuNSbgygasLys0VeS4mgsMB6qxd8zJDe
         LO/1LoteDnS6NX+aow4C0104vXr6dQ8Sxty+GW4sjOm6qjGqJ/ZyC7KcxSCcaXh9pnjA
         U/srMI8mhOUteNpNUKDLGHCNen5naVZlgS5cN/c2ytKwwBK0OAIjfzSRIqxjF7zvn59l
         YeJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776747272; x=1777352072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zoEuG8hBEwU+J0NdVTvnR9oirCOkP2yu1ASGnIzv29M=;
        b=RiW7rRw15NQmbxLz6jJMP5RcmtbYohGDkwtU4avFi+pE5qD6SSF1zTqUpqzuuUO697
         ZPvkSRWC34z9aMLHlReSdXgh22nr36RXKzJpi8x8hjB1MoqVxzQofCS8cAdJFV4hKvZ4
         +IclbQ537X+IsiLQhurJcexCZyLe1lhBFKcFewLPr+LwPhOPefhGOHGguyV5N5m4CULO
         O/2TUdNfg27OyIEPbW9Xwh/FzRX86gqXC6AVjX8Go3UV9rRuHvhwb7p8dwVO3rFA9DEs
         dunr96LRG8LQBzT+TWs+JM8xZwx32Z48M1x2OtY2ZFL84TpbSea9OSPzOzPUyVDhkgNx
         oiIw==
X-Forwarded-Encrypted: i=1; AFNElJ8dX1jdcM69jAJZ9i3hN/1fSfpCcgPwMUBg+xBH+9F30hu3KGN6YcSOqJR7vCOeT+5IidFbmLWSJkbifmTidfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWf4Dcja3oxSjYhN+iX+9kE4rOBSwyUDzzn4hPE3A5KEmAgXHl
	CXqYL9nrVwSkvg+dotTVXoVVFIjvgyNarRWKVJ0Xv+cXRJA0pKu1O5equ4B83aSA6paX56U6gLO
	MEpleXwgc2N3oFFoooBHOVOvuVSjT11EXhcOI
X-Gm-Gg: AeBDietDNf49q0oCj2XglUztSSbF/9ysRSj0QVfptYHYBmFvncrrI4vAy1Mne02BQHi
	czGCgAeOYEMVXUp+YIN3/D2R5q37+Wh5hkVBpzlWSDsrNPGhBfcPz60ki94wW4YtmNHyTjPJ9v6
	2GfvisF9KoTICWKgoUjwZxPytUVTS+EBim+iKrCBEJmQBbCxoe9SnF9nqs+rsQnHXyQ0uV0Q2Pb
	b4nZoaj3dllZf41IrbkrLBOOTUyzGSH99z4QhoDZadO8qKs+rFmXtMsVM+PYAESwPNAw4PDlNZJ
	DfU08aFy2eoxyx9195m+rzARvoIue+66G91Psd8eGOIr7c4FdzQgz1bP2lZXjqJirwgAhiJIYhy
	BuI5d5KK3VuAn884Hnu+WS7sGAurxmOOwqtOTphSy
X-Received: by 2002:a17:907:94c7:b0:ba8:422:6015 with SMTP id
 a640c23a62f3a-ba804226350mr281797166b.1.1776747271585; Mon, 20 Apr 2026
 21:54:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407143306.78809-1-shuvampandey1@gmail.com>
 <20260419153111.90635-1-shuvampandey1@gmail.com> <CAHp75VcW0cexQk6Zg-RwKSMBpOxPa3YCAomK7PFXEGLQ0VkrMQ@mail.gmail.com>
 <150cda6feffe0826cfd43e5d8f0b4199b6268486.camel@HansenPartnership.com> <CANAAWHKpYc5EJvFg9yMQ5JPhCt4_EGERi+9iG1j3TX-1GRqGQw@mail.gmail.com>
In-Reply-To: <CANAAWHKpYc5EJvFg9yMQ5JPhCt4_EGERi+9iG1j3TX-1GRqGQw@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 21 Apr 2026 07:53:55 +0300
X-Gm-Features: AQROBzBtxt6MXTT_aCTe0vSF2u06G-x2Q80A73S2V6nEm_U-M-nVEH1dAoE0W3E
Message-ID: <CAHp75VfB0Y7K=chk5wpKtZcgVfCN5X7zhNEq6QSrirdgHs5_bQ@mail.gmail.com>
Subject: Re: [PATCH v2] lib/string_helpers: renormalize string_get_size()
 after rounding carry
To: Shuvam Pandey <shuvampandey1@gmail.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, Kees Cook <kees@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Shevchenko <andy@kernel.org>, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 6:38=E2=80=AFAM Shuvam Pandey <shuvampandey1@gmail.=
com> wrote:

> > Well firstly I would note that the original behaviour isn't a bug.

James, thank you for the prompt reply!

> So I agree this should not go forward as a bug fix in its current form.
> I'll drop this patch here and revisit it only if I can come back with a
> better understanding of the intended semantics.

Shuvam, perhaps we need to add a few more test cases first to
understand current behaviour better?

--=20
With Best Regards,
Andy Shevchenko
