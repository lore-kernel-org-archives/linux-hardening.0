Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E09737F8B8
	for <linux-hardening@vger.kernel.org>; Tue, 24 Mar 2026 09:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774343805; cv=none; b=e0YrV/xZ364zNJCrtnOUyigHmF920HpzWZnMvyTLbHKkIZtWLhTe//zG34FW4/QrJTKkqRSD1+xTAvDPz2V37kdQB0sEKj+099xSXJPdDs8KlUcTD0VznVnesOI12HftJtuP8OEpgLeD/7xN2SivW2cLgGsi/J4iJYPednGvMx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774343805; c=relaxed/simple;
	bh=d2RtwnezpRl4urg1RLWpLR9gYpLAfG0zOJbGPiOmAl8=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YWX/Jm+G6HMQ5Y3zwgjY0BsVusnTyzaWGpACnVyF0Nx+deNCqHVSsWg2isrK4apsTU6OWfnFF+sSg+eNqCk8gqpkw8stzCJ2DP/iIcqz77+usMVbarQAGaZJ4kkBMFZu2ME1x/RWS4zzXZihJjFRGrVL1HE69Ff+3ws/hyzX1JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hp1tE/88; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hp1tE/88"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94769C2BC9E
	for <linux-hardening@vger.kernel.org>; Tue, 24 Mar 2026 09:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774343804;
	bh=d2RtwnezpRl4urg1RLWpLR9gYpLAfG0zOJbGPiOmAl8=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=Hp1tE/8828/HZBnUyCnsBaYxB2JLqDJ4Qa4BaBDqZy7OE/gVnwiBLI7jVYv8khLfC
	 bZOFG4e9BNIf1xotYP9auHqH1V1L1715UHIoA2Y+5iIRgBuHykvCcSOx7WrYmjXxTO
	 qMVUDinby+XtaMy4oHDCGFX3eDq+JrtGvRJwazaJEQIpHOWdq+avXwMoYjy1daoYIl
	 rUYPpR+sYK7nQSae7Q1ijMRif1ciH7zjzUIyzcxr+J0AlmU5NYtWkTzEQKe+FgVQJ4
	 rdpkWPSYAhStZd+UYoxlnFsBvykCzDxi+9LYNEj/wcY1T26ZbQ+/FW/Th7ABmF3HIb
	 46eoyZVFVY2NQ==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a278e0f7f6so1255463e87.0
        for <linux-hardening@vger.kernel.org>; Tue, 24 Mar 2026 02:16:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU2FBpG1o5CiPxJDb76HO6HJEu6UrvAXyPAFT3wMVkuPz5eJxFdBFC8g590lfmjalu36u8dTDUxMK5e5b3NQgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOr/wsPakgbp6Z7o+2FQVFzozZfWhuJQ3GXE0QmvTtrAD4UABC
	mTNWKGBY8Zk5ZaAlt6h6ycJ5QXdJtM1MtQ4VW9LURKedGptdTYXqp9qd/G/No8uw25+0q8mK547
	qcGhtfHfR+uBtVEXiI/Da66NLTLzfr0X9IiaEw9WScA==
X-Received: by 2002:a05:6512:401f:b0:5a1:422b:dc0 with SMTP id
 2adb3069b0e04-5a285b4466bmr5394517e87.26.1774343803256; Tue, 24 Mar 2026
 02:16:43 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 24 Mar 2026 02:16:41 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 24 Mar 2026 02:16:41 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <CAKxU2N9KdziPen9-_gfe0UZjyuMTOsbb583aeF3=kqm22rGieA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319000558.22108-1-rosenp@gmail.com> <202603201104.8D7B8A1@keescook>
 <CAKxU2N8ZZp5fcCWfMaqZ9VKwNQ3a06fsQPXpBQa-d1N07zPGng@mail.gmail.com>
 <CAMRc=MctGTeqBHQ8zaQ7_2YAoWoTUxOK4_hs+-EHEQEPnz+A-g@mail.gmail.com> <CAKxU2N9KdziPen9-_gfe0UZjyuMTOsbb583aeF3=kqm22rGieA@mail.gmail.com>
Date: Tue, 24 Mar 2026 02:16:41 -0700
X-Gmail-Original-Message-ID: <CAMRc=Me2RLj-vvCVNho9CPYVwsQHypC_KvKHJWkLyj=rMkfx2w@mail.gmail.com>
X-Gm-Features: AaiRm519BRTEX2gQGLowKC6jTLSHz0cjqDQ3RS2L5qInYINfzfPKlo8eh2B_Md0
Message-ID: <CAMRc=Me2RLj-vvCVNho9CPYVwsQHypC_KvKHJWkLyj=rMkfx2w@mail.gmail.com>
Subject: Re: [PATCH] gpio: mockup: allocate lines with main struct
To: Rosen Penev <rosenp@gmail.com>
Cc: Kees Cook <kees@kernel.org>, linux-gpio@vger.kernel.org, 
	Bamvor Jian Zhang <bamv2005@gmail.com>, Linus Walleij <linusw@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>, Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 23 Mar 2026 17:43:00 +0100, Rosen Penev <rosenp@gmail.com> said:
> On Mon, Mar 23, 2026 at 3:00=E2=80=AFAM Bartosz Golaszewski <brgl@kernel.=
org> wrote:
>>
>> On Sat, Mar 21, 2026 at 12:00=E2=80=AFAM Rosen Penev <rosenp@gmail.com> =
wrote:
>> >
>> > >
>> > > static int gpio_mockup_probe(struct platform_device *pdev)
>> > > {
>> > >         ...
>> > >         u16 ngpio;
>> > >         ...
>> > >         rv =3D device_property_read_u16(dev, "nr-gpios", &ngpio);
>> > >         ...
>> > >         gc->ngpio =3D ngpio;
>> > >         ...
>> > >         chip->lines =3D devm_kcalloc(dev, gc->ngpio,
>> > >                                    sizeof(*chip->lines), GFP_KERNEL)=
;
>> > >
>> > > But this begs the question: why add nr_lines when ngpio is already p=
art
>> > > of the struct:
>> > Maintainers for some inexplicable reason want an extra variable for
>> > __counted_by works.
>>
>> I believe what Kees means here is: you can use ngpio for __counted_by() =
like so:
>>
>>   __counted_by(gc.ngpio)
> __counted_by doesn't support nested variables like that.
>
> drivers/gpio/gpio-mockup.c:59:61: error: =E2=80=98gc=E2=80=99 undeclared =
here (not in
> a function)
>    59 |         struct gpio_mockup_line_status lines[] __counted_by(gc.ng=
pio);

The following spin on your patch builds fine for me:

diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
index a7d69f3835c1e..9427ab8c45f73 100644
--- a/drivers/gpio/gpio-mockup.c
+++ b/drivers/gpio/gpio-mockup.c
@@ -52,10 +52,10 @@ struct gpio_mockup_line_status {

 struct gpio_mockup_chip {
 	struct gpio_chip gc;
-	struct gpio_mockup_line_status *lines;
 	struct irq_domain *irq_sim_domain;
 	struct dentry *dbg_dir;
 	struct mutex lock;
+	struct gpio_mockup_line_status lines[] __counted_by(gc.ngpio);
 };

 struct gpio_mockup_dbgfs_private {
@@ -436,15 +436,16 @@ static int gpio_mockup_probe(struct platform_device *=
pdev)
 	if (rv)
 		name =3D dev_name(dev);

-	chip =3D devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
+	chip =3D devm_kzalloc(dev, struct_size(chip, lines, ngpio), GFP_KERNEL);
 	if (!chip)
 		return -ENOMEM;

-	mutex_init(&chip->lock);
-
 	gc =3D &chip->gc;
-	gc->base =3D base;
 	gc->ngpio =3D ngpio;
+	gc->base =3D base;
+
+	mutex_init(&chip->lock);
+
 	gc->label =3D name;
 	gc->owner =3D THIS_MODULE;
 	gc->parent =3D dev;
@@ -460,11 +461,6 @@ static int gpio_mockup_probe(struct platform_device *p=
dev)
 	gc->request =3D gpio_mockup_request;
 	gc->free =3D gpio_mockup_free;

-	chip->lines =3D devm_kcalloc(dev, gc->ngpio,
-				   sizeof(*chip->lines), GFP_KERNEL);
-	if (!chip->lines)
-		return -ENOMEM;
-
 	for (i =3D 0; i < gc->ngpio; i++)
 		chip->lines[i].dir =3D GPIO_LINE_DIRECTION_IN;

Bart
