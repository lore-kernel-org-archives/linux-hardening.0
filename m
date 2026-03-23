Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097D63C13F9
	for <linux-hardening@vger.kernel.org>; Mon, 23 Mar 2026 16:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774284195; cv=pass; b=qt3Kk4Xn7aQP8zjfTibIyvH462ucaGaKK7A+AYk4lbuPBrPPL0SjS8SeDkemkMn7VieDBKn9mAyCMV+ADWzJUWsOg8GrbjuXodAQyAgsyGR8NFMlj7bCjdUC/4UbKlVACuZiTAks0gWK2Xl9z9EnGkZB6a5yP4nfVxaaK325fmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774284195; c=relaxed/simple;
	bh=1fvRhUogs1V9rKEcsI/PCKxEMWCn6MR0Es71uuKVz88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kA+qkwcXJOurRz8/wUwsM/12rvplFGLdLs88NVKLosxCmxGchZTTc+Vw1gAduSE8qKFytRBkXV1wAtiTUFR9+YPbEJ9rOnDTmws1My0fo9j4zITdRDwco4So4h+BwhOzXgOCdP8Dyu980QczkpCWn2oD5gCOrs29rSIsu1pD+cA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kksSMOby; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kksSMOby"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b97f9587e6eso598923966b.3
        for <linux-hardening@vger.kernel.org>; Mon, 23 Mar 2026 09:43:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774284192; cv=none;
        d=google.com; s=arc-20240605;
        b=eScFDFhSjFgTjTvRU+/ab+951YyqUxF8kTfxCnaBksbIWxqsl+4ROaIZmk+Yk7aPMm
         Fp4Gp/XYt5omqQ9vYUllPhIegsr7PHm1iN807tHBSLcEEs5sQGKUpcuxSwhhl6+lmcM0
         nF982MEPNTA8zD+60rgJ8GqTqmw26NFJ+YwSWHzGaVv0Hh9yyjKpBxte9gKoh0LXj5m8
         sqruJTMbHric0n1UV55n05XFnC573HbaEKa0ZFgYdP92vERZFZzjfzcvKSOcQXNegMjq
         AQ+m6nIhb1Q7AAljo2/vEw9i09FWRH7EG+RNP39uuLdNn/PfLKSUPcMzsYaRdzJUG29J
         SzHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qXz025swToeMHHQtF/dGQpue1EMwmv0J9i7P0ZIHR38=;
        fh=ug7aXGPPj6gelblmKtIFawCfWgL+8Y8DUDlALTr8Muc=;
        b=LYswdl0HREgyTo1mwIdmbVHur23aDFLM+nq79Az/xZ+YcOGLzYWPnbUExvFl8DqYvJ
         edQPd9jv1ejJdOL1G1m4WoyQSswxfzZNSbEBE+/0ZyJ7eZmZXF0oM+JYza0bXV0MZD1K
         5b0v/YgRDRzurNr0IY/2/mfQwHBdhAMQurbE37ChEXbAtlCTDMZcU9FqzdfNphA2IkEp
         BDnn39odl/0zXxk3NsssPmMS5IyVkwHbvMNEA6P05s/uZHvKkMuXwyTwEX2ZXoJIoCtW
         bAswv16PIiipQcZUv7Bd1UBOqePJne7ehJxWyv9+cD6teROTZsAFvT/ierKDr0u6ydUs
         dwpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774284192; x=1774888992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qXz025swToeMHHQtF/dGQpue1EMwmv0J9i7P0ZIHR38=;
        b=kksSMObyD7jS9SsMxSrYGWpIdb52bWibg3ZjeJW3kFJusT5eyY4sXEIdQeWzuGL0nI
         1bYhT5BgFttbASkUqCzesXgGl/Zvt2D5E73qi18slfKkhTZNdjJ27arnbupRh6X/YDzu
         QoU6kRziSOsM+OP9yttJPmzw3pKbv9QwP6cf5uL1ShKMSf9rxz+LSyufNbfuNaDF0qhC
         NWimtDLipbenUUAiPv899moLANcAU0mUdJZjpRu7iTOZdEgAzb8jCMffykoffhbp2SpO
         ERu5a+Z7TOonkpw4ruxy9XO4OD40INW8cvcZNTFd7q0srRC2vreI09OF33UIA4yG+EOT
         XfGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774284192; x=1774888992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qXz025swToeMHHQtF/dGQpue1EMwmv0J9i7P0ZIHR38=;
        b=UuHvaa0fZjpb7F1jeUm9bp3k9w2uULQ0zxgvEZ9dQ4xpeCZMnr+kAyuXDNxBKBGwq9
         hsopKQaJfSqgRqy3DeUFW7AmwjNVjBMhY5TyABAr60IG8qg+MeBkJ5ji1pEieLc2Yytk
         9CmimfoboYo5C8eJZVOesMuARNd6x77Iic/PRIZEvh+uJ+/ZJ9Y1sTDwvz9IkEfot25i
         pptquBNQrs6VnG+DZUisDLCBJBVWECHld0p+R2MDIMass8l1vlOJTZcX/blPurOwx6OV
         27MPX5tW+P5d7bH1HzlTE31mS99INDMDF2suLqSEN649OgckhC7IoUELoMLiG99NJL/k
         dLig==
X-Forwarded-Encrypted: i=1; AJvYcCWgt/ySH04Vx2wA1458jCtnXdzRVPZBiZJvwJWsDvL5PSP/jVvf+QSByYnNc9IVTRxwXoWi9ap09DFEqeHG56c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6gVSJyN2JtxUu3zDc7Qe0WR1LBpV8JsFBUwtH8LGiVF9P+KNG
	ZOnsCFv8OBXsl3A+FZoVyygsXNlbSppoTRzG6+OuK3nz0ojqoUYqzFSHK+CZ0wu4lg2HiluU2d3
	5aDkxjwDT1n4LhDUu2JO9PDaaRBaO07Y=
X-Gm-Gg: ATEYQzyeaQllREwjLFF3UvXievp9lSekuB0d2G7Y6i43yhatDXtRcSYRKkpmOEcBu1w
	iIaUOM1uwttwyLL5JMMiVBgk7kSB5973+BpCyqKICUXa4CDp7U8qaCr0GYOwFKvtwZ17kcgkZRQ
	5GtLB9KrfTBl8BN5e62+tY7s4FxV8dShJazc46Cj3T2hfMtvoz7GHsDhlMnzu55szPsCjgK6eP8
	RnlFv6bnJ8ZZCuolgXXJwGJqOWhs5wLyXHTANzd/x8x0Kprg+IkTueJNICfrclLy0rtuyegC2Jk
	c2uufPBoMv6AIW+pW3Xu8uoNgOgT8wkYtSIkv/jGqvnIsyBpEcsm4l6czTZi6v9W7onKHrlJByl
	SH8JgbQ==
X-Received: by 2002:a17:907:c20d:b0:b96:ef71:49f9 with SMTP id
 a640c23a62f3a-b982f0b9a37mr982589366b.9.1774284191993; Mon, 23 Mar 2026
 09:43:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319000558.22108-1-rosenp@gmail.com> <202603201104.8D7B8A1@keescook>
 <CAKxU2N8ZZp5fcCWfMaqZ9VKwNQ3a06fsQPXpBQa-d1N07zPGng@mail.gmail.com> <CAMRc=MctGTeqBHQ8zaQ7_2YAoWoTUxOK4_hs+-EHEQEPnz+A-g@mail.gmail.com>
In-Reply-To: <CAMRc=MctGTeqBHQ8zaQ7_2YAoWoTUxOK4_hs+-EHEQEPnz+A-g@mail.gmail.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 23 Mar 2026 09:43:00 -0700
X-Gm-Features: AQROBzA2qaX1yaM8KyWefigkU6SOxX6FP_EtmkeEIENTjos0A7j-OoAxHhEnBi8
Message-ID: <CAKxU2N9KdziPen9-_gfe0UZjyuMTOsbb583aeF3=kqm22rGieA@mail.gmail.com>
Subject: Re: [PATCH] gpio: mockup: allocate lines with main struct
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Kees Cook <kees@kernel.org>, linux-gpio@vger.kernel.org, 
	Bamvor Jian Zhang <bamv2005@gmail.com>, Linus Walleij <linusw@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 3:00=E2=80=AFAM Bartosz Golaszewski <brgl@kernel.or=
g> wrote:
>
> On Sat, Mar 21, 2026 at 12:00=E2=80=AFAM Rosen Penev <rosenp@gmail.com> w=
rote:
> >
> > >
> > > static int gpio_mockup_probe(struct platform_device *pdev)
> > > {
> > >         ...
> > >         u16 ngpio;
> > >         ...
> > >         rv =3D device_property_read_u16(dev, "nr-gpios", &ngpio);
> > >         ...
> > >         gc->ngpio =3D ngpio;
> > >         ...
> > >         chip->lines =3D devm_kcalloc(dev, gc->ngpio,
> > >                                    sizeof(*chip->lines), GFP_KERNEL);
> > >
> > > But this begs the question: why add nr_lines when ngpio is already pa=
rt
> > > of the struct:
> > Maintainers for some inexplicable reason want an extra variable for
> > __counted_by works.
>
> I believe what Kees means here is: you can use ngpio for __counted_by() l=
ike so:
>
>   __counted_by(gc.ngpio)
__counted_by doesn't support nested variables like that.

drivers/gpio/gpio-mockup.c:59:61: error: =E2=80=98gc=E2=80=99 undeclared he=
re (not in
a function)
   59 |         struct gpio_mockup_line_status lines[] __counted_by(gc.ngpi=
o);
>
> I didn't think about it and I do prefer it of course over an extra field.
>
> Bart
