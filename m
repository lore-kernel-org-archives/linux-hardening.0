Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E678344056
	for <linux-hardening@vger.kernel.org>; Tue, 10 Mar 2026 08:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773132707; cv=none; b=C2GOauCP6BujW1X/604Cfu4L68clPnPAMAMnrdAbdAqFTFHtm0YHx9XDRxTdybosewiFEoCG1wV1B0eUPYkhXoDY1GE9oDfvlpZzZqtYzLwp8HU+Gp9NWx+8K1oNSqxUF+70FO/xQ+JaAMJByvDiaVE/fZshCyvlfZpiVd8ZAeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773132707; c=relaxed/simple;
	bh=vVoj3FLi83VXmJyuCRq2Dd+bxXjKaU+NntpFAWe/BT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gZBDmKOZvzBQ6fyPEOVXUaD3+LlJBF0sCkGeITrtwqLVAVexJv7LwIDlHZBJdcj/dZYmiEOe+kL9irfq9wSywRuGUBre90Ga7BwnIbt4K5HmpSXt4eUgu+I42Pd4NM1zSH9tSwpGRZqK9pI6kgmz+FONUIMdvXDqyvFuAmdgdnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zct30tSL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zct30tSL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A99A3C2BC86
	for <linux-hardening@vger.kernel.org>; Tue, 10 Mar 2026 08:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773132706;
	bh=vVoj3FLi83VXmJyuCRq2Dd+bxXjKaU+NntpFAWe/BT4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Zct30tSL3h4O0vrlc0FGEfY06o2E9w0S4RpZ3oU4xghwLQTLssYmSSmsIOaAXXJed
	 GKp04zVWjV/rboXJu0znMzuHIhNcjAAHCPTqfjdOHx5SJOogCMDfFiXwQaeV6zNlj8
	 DZyLtTSXYgnjg+zrA9J5y5CyI2Tucq5+RKbfV0zVr7P7ZZHdlQKSI3dR4wndWrXYh8
	 4W4NSylgs6Xj1JcmztWDqzx7kskIHyPe4fUKskMhME8+fhxxKMlUrWlrpJ01IelZQ8
	 G0RZjP94IHthM+0mqwwd46gxPz/r4ZLGHNMhvCgMMgoFvulyrcuC3K43Rc2UQmbtts
	 hLwezImpohRfA==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a1330ac6c3so5426809e87.1
        for <linux-hardening@vger.kernel.org>; Tue, 10 Mar 2026 01:51:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUe+BPsYLgQqQK04iosYO4RafLhClNv7d1sICMWqX9qsYGi1gMsoBmsi+uFCJAuchdTfJfHmYgXetbgoUyWNHg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywin8HrYNeEKveist/oTxjxF3ThQfvjkx4gDDs7xCIBaBD8TwIo
	pK8S/1BsDa7nrvZ3847A6dxETgGu9F7zHuN4+kNXSuWf1hIYyHinR9abRkeks6TiNrEodEoVIUL
	I8PViXlR5+O7uPXGR7FdxeWtb95QBopD3C64krNF5JA==
X-Received: by 2002:a05:6512:304f:b0:5a1:3e8d:aa27 with SMTP id
 2adb3069b0e04-5a13e8dad62mr4744483e87.36.1773132705315; Tue, 10 Mar 2026
 01:51:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260308021535.48098-1-rosenp@gmail.com> <CAD++jLkLj235Q=U_9E-hSneW5E42JjU=dRBJxKJNnqwgBLCm=w@mail.gmail.com>
 <CAKxU2N9JbAzEYfmLpbw5b9Y6MsYUZ1FfLirfy8Hg8MCOUY6PAg@mail.gmail.com>
 <CAMRc=Me+oUX5xbNY7PX43cTH0e5ouu=Ex3TqhvWvoefmR7jYYQ@mail.gmail.com> <CAKxU2N8_V7U11X18Ja+=tdYPWT6jnmM7bYt+5GHgeXAXOJ5cng@mail.gmail.com>
In-Reply-To: <CAKxU2N8_V7U11X18Ja+=tdYPWT6jnmM7bYt+5GHgeXAXOJ5cng@mail.gmail.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Tue, 10 Mar 2026 09:51:33 +0100
X-Gmail-Original-Message-ID: <CAMRc=Md3uAPzndudyvpFiLki8fkYHgAtumtaauXMkXwU4vANBA@mail.gmail.com>
X-Gm-Features: AaiRm52QyqGRA5XZTuwTzrHYnzWWeX8i1qdpXgK_Fun3PV5g-eaSB6k0RbEVzRo
Message-ID: <CAMRc=Md3uAPzndudyvpFiLki8fkYHgAtumtaauXMkXwU4vANBA@mail.gmail.com>
Subject: Re: [PATCH] gpio: msc313: remove kcalloc
To: Rosen Penev <rosenp@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>, linux-gpio@vger.kernel.org, 
	Daniel Palmer <daniel@thingy.jp>, linux-hardening@vger.kernel.org, gustavoars@kernel.org, 
	Romain Perier <romain.perier@gmail.com>, 
	"moderated list:ARM/MStar/Sigmastar Armv7 SoC support" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 11:00=E2=80=AFPM Rosen Penev <rosenp@gmail.com> wrot=
e:
>
> On Mon, Mar 9, 2026 at 2:03=E2=80=AFAM Bartosz Golaszewski <brgl@kernel.o=
rg> wrote:
> >
> > On Mon, Mar 9, 2026 at 2:27=E2=80=AFAM Rosen Penev <rosenp@gmail.com> w=
rote:
> > >
> > > On Sun, Mar 8, 2026 at 5:06=E2=80=AFPM Linus Walleij <linusw@kernel.o=
rg> wrote:
> > > >
> > > > On Sun, Mar 8, 2026 at 3:15=E2=80=AFAM Rosen Penev <rosenp@gmail.co=
m> wrote:
> > > >
> > > > > Use a flexible array member to combine kzalloc and kcalloc.
> > > > >
> > > > > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > > > (...)
> > > > >  struct msc313_gpio {
> > > > >         void __iomem *base;
> > > > >         const struct msc313_gpio_data *gpio_data;
> > > >
> > > > Do you wanna add:
> > > >
> > > > const unsigned int saved_size;
> > > So in the code there's
> > >
> > > for (i =3D 0; i < gpio->gpio_data->num; i++)
> > >
> > > which is equivalent to match->num.
> > >
> > > __counted_by doesn't support pointers AFAIK.
> > > >
> >
> > This is a regular flexible array of u8. It should work fine with
> > __counted_by and I too am in favor of using it as it has become
> > standard for flexible arrays.
> That requires adding an extra variable in the struct.

That's ok, it's negligible and provides tangible advantages.

Please do the same for your other patches.

Bart
