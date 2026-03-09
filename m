Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3C833B6C4
	for <linux-hardening@vger.kernel.org>; Mon,  9 Mar 2026 22:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773093629; cv=pass; b=fFWGugWJMXnvSigAwkqdn1sjhOJNm6LPR6pwEHVwTDz+eJHNClfTQTJsOjw43mnlM38kdvW9cJEFRw0uLUPiReelMNflwA8WE2aNnFwsBohN1V2sq9/k2nU0S9p6ygsNtT1Xm3WiHPkn9/+XzD1AkkR9l7Ax41GwM6lcUHbhD0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773093629; c=relaxed/simple;
	bh=QphhNh4f7gkUbyN0Yk0KSmel1SMQBwACUum7u7vnrAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RAgma3yf4rGugF7Fq8rPAT2MwHyOypTlWsbyjuUpYooQdsdMUYRjND9VOADCgUsEv4gvkVoVKkeNcDas+Gj8hPqJJtwR13vwe9ReOIEhjPOUStcLUyOqCuoy6JbHlbXsldRR67mfJ4HbXWZh/W93BqFfXqF59Gxdtf34QCt1cTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NMBqbxGx; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMBqbxGx"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b96da7b2e2eso328265066b.2
        for <linux-hardening@vger.kernel.org>; Mon, 09 Mar 2026 15:00:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773093627; cv=none;
        d=google.com; s=arc-20240605;
        b=WbcoyY5jwesUIlLL5JddUXs854RxmBmyiNPhSHUIrpzhAQCATF02C2go3f8wD+a+Rr
         aKtSGanA/pcaAE9GI1JvMH+9SivZDBLgcljHqhT3AquDp9ZH1tg3Wc9A/Ohjfkj/FQc1
         ZAgGejN6NpNU1Ks0Exlpm18znCntLMU++DYyVJLxkd/dnUxrGhPijnicojXIRL1+HdXP
         zuO1DuFs/2Fk7v+v6o7DrlBzBd1Iuj9QhTtSencMFMoX67tTyAP8Pjzyi0U1CWruzU5i
         lW8f68DVfxzear+vzEN97xFB4V5RHrrKvaGgjaJWD0+u8l1LsA80JdtQQ6p4PzsG9TDW
         Jyzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5D58sQUjXLLDfC4Cb+JyinMTeRDp8+6d+A4ebahMYHg=;
        fh=z5Ci2z2r43uxURUTTBG6GbnjMaKyRQbz6TzUc79foZA=;
        b=BOHeELeMm5YjSn/VwTmZJkMYF2QiqdQ8NKjMLqTNYuDMStMtiofj1fxEI3OsKC4pug
         0NAQzKmqG2h19p1N5AWzj+dD2AHab1Jvn6Mh+uA1DeHH4l3zKkOrWSCMijdMqbmTiE1C
         BdslKRkYywMA74Y+3Wqqfo42R8ZMwhs3NkF9O7KfKjMcuTnXYlYtlV8AL8+ldZOiTXub
         ZbxBJG4RvpuEz/kBMZo/Qb1WZk4Q4FB9F5vI6s+g+q/36nNM9kWZvtW+hi7uvVLkAzcD
         yoGF5sn0vAGTmT5OjSymKXMNJt2MUE3U4Cjijfx9H4/MGoSA3wFUB08XO2Xys0T+24iA
         7CPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773093627; x=1773698427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5D58sQUjXLLDfC4Cb+JyinMTeRDp8+6d+A4ebahMYHg=;
        b=NMBqbxGx3V2njBKM0R+jjEDpkzmA1Thq8/ZO95S47tl4QZXVPZXCp31o9ZRaygvLU8
         vHSGAH9tA1nY/37T785Zyr0XhKpW4zj75NsYt+7uJTycj8KZcTmTpECoBRid32apceIX
         DKsWw+72/gxtTE1/dPUzQvzALqz5USz3ZHFSQBahNHZgJn0k5UKfLedyTHawzBheCkHL
         HcWxVj/UKEFWYjDNS4hElZftJM2/U1Ze9hmBvxdcnWDhmAKMNAO8g68xVbLNccy9pR7/
         cRzyNeTdSWK5zRyPhx4cz2GPVROXpojvMT9HPx0oDp1gEnXEq3fAerjgLLuq7EsWFnvl
         NBkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773093627; x=1773698427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5D58sQUjXLLDfC4Cb+JyinMTeRDp8+6d+A4ebahMYHg=;
        b=ivfrYrNiAtXI6uHopT6lgTWG/0mJkbEWZH1qMJTBu2yV0G4SERpmWNkzSUV5Z9mlIR
         h7NhoD7/KmUcSC6ZyWmQIPR8AmdrVCYKjxLJsw/iT9MQEX/tu59XzwF+oEcpe00OUBUx
         V1HJGaB7Ug1S21wwuUd2JDv6leVHRGjQypO3BuXbqHpvnrIpdNPLaZktUcnkUiVeZIwD
         yzWsC9VI/VVIrnBKVM6S4u337nVYOredHaVkKNqBrbfrRYp7A3SdYRDSKqi6pblnh6tN
         mW1tp4a0O1yP3Dsl71FI1V7ebbdaoqJDqprgst00AXzOJwcJv7RupXyupSjRhYvAE2SM
         Z6Nw==
X-Forwarded-Encrypted: i=1; AJvYcCUPnBQbrrbEchRPuhGkJmELr9OgOW6vgjg83GnBmUzCf3X2RQl2z31j3iQL0O1Xz0liTNRAPqOqsHBhpRFdsc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGITzZyPw6wz/9/wHPINi6phpgwUGdM2UqO2uddMpuYPDy/FAp
	hGOv0bC6NurTbIUBFELtA7SEe44l0OnoPtDLpjDRx4Jj7abGt0KJH9x5+ekSCnU5lYCZ5PG2YD7
	5M7LxlfPBLdSEofdLGlvPpmlwU67aCtU=
X-Gm-Gg: ATEYQzyqSyPGAgfm1E49nhdZStksOZPvMlkOiBCuDTgGcB6/2Ywn1Je1g1DSTk+lDPk
	QthXzov8UdvTO6EHVlFHpPKUTNTKuNdIlsFVCg31b/ojojWLnhi11zIr4xjnLlMjWURbz6FtYzy
	+xwzw2ZCM4F2L3FCchqrV0CpXIBJuu0EROSVMNcp4A4cJF7PD6bKKoYTXE10X99nk8IxcjEek67
	6TTtb6IqgOZv48eb4IO0Tc8D8fwJwpt9ZMn+8r+5coNJf2v7iD3aM7MBKQGenCRMPkdaRXkyAS6
	9P97/vdOp/40gmI3ZGAqeqRdisnnkvG68lBpM2zWzQzTbbC1GsMmHKYfDpYAPzwK5H5S7Z9gniG
	WTy6m6w==
X-Received: by 2002:a17:907:72d3:b0:b94:21a8:f7d9 with SMTP id
 a640c23a62f3a-b942dfb47bbmr716289366b.36.1773093626764; Mon, 09 Mar 2026
 15:00:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308021535.48098-1-rosenp@gmail.com> <CAD++jLkLj235Q=U_9E-hSneW5E42JjU=dRBJxKJNnqwgBLCm=w@mail.gmail.com>
 <CAKxU2N9JbAzEYfmLpbw5b9Y6MsYUZ1FfLirfy8Hg8MCOUY6PAg@mail.gmail.com> <CAMRc=Me+oUX5xbNY7PX43cTH0e5ouu=Ex3TqhvWvoefmR7jYYQ@mail.gmail.com>
In-Reply-To: <CAMRc=Me+oUX5xbNY7PX43cTH0e5ouu=Ex3TqhvWvoefmR7jYYQ@mail.gmail.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 9 Mar 2026 15:00:15 -0700
X-Gm-Features: AaiRm501bzkrH4SLjzi0bHRZdX65CXg0f05EKPvilttmHBQT5wJ5o03G2KV3H8Q
Message-ID: <CAKxU2N8_V7U11X18Ja+=tdYPWT6jnmM7bYt+5GHgeXAXOJ5cng@mail.gmail.com>
Subject: Re: [PATCH] gpio: msc313: remove kcalloc
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>, linux-gpio@vger.kernel.org, 
	Daniel Palmer <daniel@thingy.jp>, linux-hardening@vger.kernel.org, gustavoars@kernel.org, 
	Romain Perier <romain.perier@gmail.com>, 
	"moderated list:ARM/MStar/Sigmastar Armv7 SoC support" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 2:03=E2=80=AFAM Bartosz Golaszewski <brgl@kernel.org=
> wrote:
>
> On Mon, Mar 9, 2026 at 2:27=E2=80=AFAM Rosen Penev <rosenp@gmail.com> wro=
te:
> >
> > On Sun, Mar 8, 2026 at 5:06=E2=80=AFPM Linus Walleij <linusw@kernel.org=
> wrote:
> > >
> > > On Sun, Mar 8, 2026 at 3:15=E2=80=AFAM Rosen Penev <rosenp@gmail.com>=
 wrote:
> > >
> > > > Use a flexible array member to combine kzalloc and kcalloc.
> > > >
> > > > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > > (...)
> > > >  struct msc313_gpio {
> > > >         void __iomem *base;
> > > >         const struct msc313_gpio_data *gpio_data;
> > >
> > > Do you wanna add:
> > >
> > > const unsigned int saved_size;
> > So in the code there's
> >
> > for (i =3D 0; i < gpio->gpio_data->num; i++)
> >
> > which is equivalent to match->num.
> >
> > __counted_by doesn't support pointers AFAIK.
> > >
>
> This is a regular flexible array of u8. It should work fine with
> __counted_by and I too am in favor of using it as it has become
> standard for flexible arrays.
That requires adding an extra variable in the struct.
>
> Bart
