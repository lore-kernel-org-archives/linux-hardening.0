Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pk+ZLWqU"
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28E2A6
	for <linux-hardening@vger.kernel.org>; Mon, 11 Dec 2023 16:46:33 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-54c64316a22so6807645a12.0
        for <linux-hardening@vger.kernel.org>; Mon, 11 Dec 2023 16:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702341992; x=1702946792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zGDztTP9Y8jmLygA/ILQ99z4JlzsbnXKKrjvScgU9V8=;
        b=pk+ZLWqUHYIvu8d9k+G0s0CWKocvLC8DYhIushLNhPUSTu8f8+VH7lteILZTs+irpa
         Ak6dNTTDPlcBVf6+pFizlMoGDszp4ZtKdxCNcdZHiqj54f+i3xAE7sN7mDC4GIDvHtT3
         hCvFceWhvSMDpIs07mILYdbGSkVvmtToYfc/idiLuOF1ZOJqQtLKZAPEj0Cr3Yo9le0W
         LAstZg+Ed7LuLP7Bu7kUfdZb2Ci/x21m5mGoXPNBMGrGTplnfZ+xCIx5DWGZmOzN78QY
         ftWrj8fB/LXiODnVuT5LWkeNSDAQKNc42ww0Dnbowp6aFyJNf1Ao8vFhuH+srOzBekLq
         mSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702341992; x=1702946792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zGDztTP9Y8jmLygA/ILQ99z4JlzsbnXKKrjvScgU9V8=;
        b=DYTDTt26S4PZcr6nCpiP7Wf7FKh8set3hjYqtMPAFvW3EfRbLQ3g1/0L77KNa+tU6O
         FAhnKluiZlN21VoX5MPghOjGrftYhR/NAmEXz82dYtweNwD0CDWOy0Kw4cc7rbtX0Fg0
         iSG6A6ivXIRZYzHexM5TGiom0Ty6HpHjs/sOl4L9HQyIkIKSqsMRrvLHxKCWgTsArqc7
         DekN2S16ulY80NJgZQ9o5aadVEyv0ZWR2mi2ufwklREgibykDzEBAQsoyHqBMWv6o2Sc
         zHhgRm6WckpMsqoJoX6QanRK/RO8seJruFcF696t92m2OTmSjVNZCF+z0qzco0bNqeo/
         K2kA==
X-Gm-Message-State: AOJu0Yy0+PYv2ah4PngWOusvinHIrExQu4ywDI5fP2vM2fQ8Wlok1CE2
	i/O82dObYP2ZxL8LfH4yuVQ1GJZVWISV/qq7EEnIKQ==
X-Google-Smtp-Source: AGHT+IF3Vb9uYK4veE0AEj+63MVpg5F+Fk633PnRVz/Mrgr8rxF8f0TZLUH4FJYcKHO1B7bz6tONcIHqoCsdrSHNL48=
X-Received: by 2002:a17:907:72cb:b0:a19:a19a:ead2 with SMTP id
 du11-20020a17090772cb00b00a19a19aead2mr3218422ejc.139.1702341992095; Mon, 11
 Dec 2023 16:46:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231026-strncpy-drivers-iio-proximity-sx9324-c-v2-1-cee6e5db700c@google.com>
 <20231028162638.5b477ded@jic23-huawei> <CAE-0n51eAH1tcqXVeReavq0US-Th2qwC_s_uAzRKTpSG-kXuwA@mail.gmail.com>
In-Reply-To: <CAE-0n51eAH1tcqXVeReavq0US-Th2qwC_s_uAzRKTpSG-kXuwA@mail.gmail.com>
From: Justin Stitt <justinstitt@google.com>
Date: Mon, 11 Dec 2023 16:46:20 -0800
Message-ID: <CAFhGd8p76R-oaPWR0G6wESe7kgM--2bzU88j2vz4QGy8wKNffg@mail.gmail.com>
Subject: Re: [PATCH v2] iio: sx9324: avoid copying property strings
To: Stephen Boyd <swboyd@chromium.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Gwendal Grignou <gwendal@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 30, 2023 at 2:44=E2=80=AFPM Stephen Boyd <swboyd@chromium.org> =
wrote:
>
>
> We need to free it in other places too, like if the count doesn't match.
> It may be easier to extract this section and just have 4 string
> literals.
>
>         switch (reg_def->reg) {
>         case SX9324_REG_AFE_PH0:
>                 reg_def =3D sx9324_parse_phase_prop(dev, reg_def, "semtec=
h,ph0-pin");
>                 break;
>         case SX9324_REG_AFE_PH1:
>                 reg_def =3D sx9324_parse_phase_prop(dev, reg_def, "semtec=
h,ph1-pin");
>                 break;
>         case SX9324_REG_AFE_PH2:
>                 reg_def =3D sx9324_parse_phase_prop(dev, reg_def, "semtec=
h,ph2-pin");
>                 break;
>         case SX9324_REG_AFE_PH3:
>                 reg_def =3D sx9324_parse_phase_prop(dev, reg_def, "semtec=
h,ph3-pin");
>                 break;
>

I've submitted v3 of this patch [1] trying out Stephen's idea. I'd
appreciate feedback.

[1]: https://lore.kernel.org/all/20231212-strncpy-drivers-iio-proximity-sx9=
324-c-v3-1-b8ae12fc8a5d@google.com/

Thanks
Justin
