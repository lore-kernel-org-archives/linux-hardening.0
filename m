Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795683177;
	b=zIFoyi8M4B4+sVssVobHwxPGh8qhStPeJApKJ2xh8OqN5kfzYlNIwqx1370afME7xE80
	 q48XeqL4vePA3ElSwjZmkUI0N5XAihB2Fv7BzdniOsNIPvnetjrEYeixPIpbrKh0h4lph
	 p0sRTm5RcUktha9uKyanQBCRrYdzGNZ/Wg3ecCVjSmwBsFdaqMcAuxJ4u5EZFM3Gjd01w
	 RtOOZzVy3rYMsoTyNfpcPj48ne2fdnGgdY0um4OeL8eXlwQr7UC9FAEvVN0WXaFqEhSmY
	 UvZdWZY+l6S+j9mSzcSlymX8ab/vU2iL3g2blvxxDy6Jdd8y6E0d235dD0qHUOB+gSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795683177;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=LQC7n5UB+twTmoKbhuhV7McngclJ8wPtfQsYLymxWtQ=;
	b=z6hqr2IsEA5mQogEBF4Ajc/D752XuCIp3DvhunsUHVgceQzZpgfzMDRks5iOKx+R4+jH
	 fGDVykkwOI1XDCnoOmrc+OkJ5cHJ9vM9d0tHPxzyXlwro9EqEBPbpxpWyRkzvY4aB7VBI
	 5fbVm0OVT6xHjJewtyNbzoiWCZKuDGRUuvaYhxTYVfi8c05oox+GPC/fX1T4zT+D/22q1
	 jr3WjX60mc+rn31rq+hLROzbVrbaWdJiSks54pvu2eLJHXQrDqZx0F2IOiFq3hT7NytjS
	 VH+eVl9ai1J6gNJbeMn7HXgmMgJqYNfiuZMIiIOghqzmLHUk/hgtYjZ8eGg/WB6YXHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.222.52
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F41606A329
	for <linux-hardening@vger.kernel.org>; Thu, 26 Nov 2026 08:52:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73F41606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-97ca72f2cd9so3625365241.2
        for <linux-hardening@vger.kernel.org>; Thu, 26 Nov 2026 00:52:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795683176; x=1796287976;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LQC7n5UB+twTmoKbhuhV7McngclJ8wPtfQsYLymxWtQ=;
        b=xsktZimoFRUz0aFpk61BDpzQ0bI7q4pZsIqFJsVzWq4JPl9i3Os2Ga+xgfoO1Uoarv
         mFndUvkAr0P+9nxtcKbv2CBz0yXzxRC0q65T367dCEANHo4TQinYl302d9Bdr/5MajW/
         3W2JMR7qpQ+RFKMj3SMVY/N8EhHv6EFheQOeU07c9lwbyIz2ZoOxIEw5NI9MxiVc6XO1
         ofj21Aq0C9uAob7FfZRd9EE89L2/gYG4PAKBukNgwVuK7cCXrZCK40tXx8VnJkLYd8wL
         eyzQ0eIqFzM1znfg/FC5bjWW9fc67zQay0sp9MFtRzVxuA1vr7/z2I4cgCClb+ydQiX0
         /BNA==
X-Forwarded-Encrypted: i=1; AL+hErHg6AvJXIDn1E6Xm26IEy9J7ImVkZ1RJ9Mo3XZUKKD5mkY5vMLqIVGmpLdpMqMhDs7aie/rAw7OGGXi/Hqa0bk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/nlZs81F9jYyLN6opx0xBz7dntIFNegPG2hlO7oDLUdfEKQSba
	8EBx3V78IcXuQL7IbN8mTceR++CfwNjohpoFTuprRsZyHOZir1gZB/HS1EdJTtyD
X-Gm-Gg: AZFdTZe0YWsiQhBtlbo1P/4l9FbJY16UKpFNjSADPyQS1KD3sXKTJhqz5H2H2fyyA94
	d/RJC18Y1hxxQu30kNilQHPjRb17478GyDHTAc9s28ouRj7ZwBHfDDDcInuBwarkW/PUlE1X+uB
	KGevlRqycJOXS96k3/LtQjeuAVZlVD0awQEoLLGeI9uWITh41lkBif32JJFpXouAeKM3/Lk4+CK
	07OsVGz1zcovDMhqTS/FyYjirL1dkEHVi9EjuP3An1BaWWXg8YGiWSirHO1CJkfHBwweouXiSre
	icMLLo+bXuDIiT+Ip/KZyDnv2gPKEkuZ3PfLpsuKWN0SnuIu/HPr2Cniq+r1TPhQX8CrlheWmw3
	J8t5akGzM18udoTAQwjRPPJSrG89i4ZyOGL0ACt9K3AF3vpUP7n9uudaY/YrubXNW16z7WHa36b
	ySB/Z81syfErYDT30JGAxjh7/QE12zIhGVkrg4kIvIhT/ctvn2eFrNAVox/9ba2suzGoKLNwOP9
	tAlYNkpUcwMA+1Luj3ng5DiHrR6Ef30cbUodlmOjzY7cyEDwNMA6XDO4amvPhHero8cfd0ap0yR
	eU6LrOgWkewPgQg/eZGTXD7OLHODFXn7fZV4lYftwsefCiXlyGR8J5GNnBjvVVGD1iWVYSeIIo4
	BZ66+oMIjKIJ/AaJv
X-Received: by 2002:a05:6102:5113:b0:7cc:22f0:830a with SMTP id ada2fe7eead31-7d739390e9amr11603321137.8.1795683176383;
        Thu, 26 Nov 2026 00:52:56 -0800 (PST)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com. [209.85.221.169])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e6dec57ddsm20485186241.1.2026.11.26.00.52.55
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 00:52:55 -0800 (PST)
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5ee3a3d281fso4320006e0c.3
        for <linux-hardening@vger.kernel.org>; Thu, 26 Nov 2026 00:52:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErENCJarp+hMTQaNdjxaaPJ1nz+NoeyxivuG/7yWhuMi9t80xH2qNxAmCfb0/mzRtmynjY3b2o0wN6Y3iwTJovE=@vger.kernel.org
X-Received: by 2002:a05:6122:e16c:b0:5ea:bfe3:6035 with SMTP id
 71dfb90a1353d-5ee8aecb450mr12178985e0c.8.1795683175291; Thu, 26 Nov 2026
 00:52:55 -0800 (PST)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1795639368.git.alx@kernel.org> <396395e1d02ca080da67cfd91a1c49058b2676b6.1795639368.git.alx@kernel.org>
 <awdaYz9NNVv5fHv9@ashevche-desk.local> <awddHt_xvc-lIygA@devuan>
In-Reply-To: <awddHt_xvc-lIygA@devuan>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 26 Nov 2026 09:52:44 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX9gnV0beBEoh65FzPCwrQy=WpGtK5qKsOF3Tsv9iUj0w@mail.gmail.com>
X-Gm-Features: Aa3M54rOnub7bCh_NzEEm3acSwF_6HJABwfoziM7rtzTMFRTInpGyKc2wQ19vKo
Message-ID: <CAMuHMdX9gnV0beBEoh65FzPCwrQy=WpGtK5qKsOF3Tsv9iUj0w@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] device property: Fix fwnode_name_eq() for empty
 node names
To: Alejandro Colomar <alx+linux-hardening@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Alejandro Colomar <alx@kernel.org>, 
	linux-hardening@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, 
	"Maciej W. Rozycki" <macro@orcam.me.uk>, Andreas Schwab <schwab@linux-m68k.org>, 
	Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Daniel Scally <djrscally@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Joe Perches <joe@perches.com>, 
	Johan Hovold <johan@kernel.org>, Kees Cook <kees@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Len Brown <lenb@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Linus Walleij <linusw@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Saravana Kannan <saravanak@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Tom Zanussi <zanussi@kernel.org>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alejandro,

On Wed, 25 Nov 2026 at 23:18, Alejandro Colomar
<alx+linux-hardening@kernel.org> wrote:

> > Date: 2026-11-26 00:00:03+0200
> > From: Andy Shevchenko <andriy.shevchenko@intel.com>
> >
> > On Wed, Nov 25, 2026 at 10:03:55PM +0100, Alejandro Colomar wrote:
> > > str_has_prefix() returns the prefix length on match and 0 on mismatch=
,
> > > so the mistmatch case can't be told from "empty prefix matched an emp=
ty
> > > string".
> > >
> > > For instance: the OF root node's name as returned by
> > > fwnode_get_name() is "" and will return 0 for any name matched agains=
t
> > > it and since len is 0 too, fwnode_name_eq() will return true.
> > >
> > > Let's use strprefix() instead, which also makes this function simpler=
.
> >
> > ...
> >
> > > Message-ID: <avrSUUM3HMgxTNpl@kekkonen.localdomain>
> > > Message-ID: <nat4ilqmzzpuyrjbuahl367ip22tfnmjorydlppuwqiscxaujo@kf63j=
4lb3flk>
> > > Message-ID: <nat4ilqmzzpuyrjbuahl367ip22tfnmjorydlppuwqiscxaujo@kf63j=
4lb3flk>
> >
> > What is this?
>
> git-am(1) has --message-id and the corresponding am.messageId, which
> stores the Message-ID from the email header field from which the patch
> is taken, to document where the patch was taken from.  It is stored by
> git-am(1) right below the last trailer tag from the patch (which should
> be the 'Signed-off-by' of the author), and before the 'Signed-off-by'
> appended by git-am(1) itself.
>
>         $ MANWIDTH=3D64 man git-am | grep -A5 messageId
>              am.messageId
>                  Add a Message-ID trailer based on the email header to
>                  the commit when using git=E2=80=90am(1) (see git=E2=80=
=90interpret=E2=80=90
>                  trailers(1)). See also the --message-id and
>                  --no-message-id options.
>
> It's useful to document where those tags come from, in case it's
> historically useful.
>
> I've extended its use to other tags I take from emails.
>
> > Is it documented tag nowadays?
>
> It is not documented in the kernel, AFAIK.  It is documented in
> git-am(1).  I included it, because I find it useful.  Feel free to drop
> it if it's not wanted (I can remove in in v8 if it's not wanted).

Please drop them, the tooling (b4) can find the origin regardless.

BTW, the kernel way to link to emails in commits is using Link:-tags, e.g.
Link: https://lore.kernel.org/avrSUUM3HMgxTNpl@kekkonen.localdomain

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
