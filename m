Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F32A1F3FC8
	for <linux-hardening@vger.kernel.org>; Fri, 11 Apr 2025 14:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744382339; cv=none; b=jps68s6tDJmBk94C+u9+w2kSfZkUv8qFO8NUov13OhVGnodQkiRkeL+dpou21MqUbzaxua8ls2njIWpSvIe4yUEU86lEG+tWth3x+wChFNVybweiwFilwfy/9lnPMbxMWD5Ia22HZijNXNiVx72gvxCR4ytOa1e/vyKJS5MoyqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744382339; c=relaxed/simple;
	bh=ohJk3QsHM1JB9lq0IkFIUIWyxmERIi01XFrnAZY3zGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gqdkIMlm4lOb+PRkBgOlF5Qy9M7G53BwalwouwlfkNIZevQvnqdtRlCFz+Tb3GDWu7SMjWb81Nsox8OleOZXfKAW3ZxWwU2/8APYiSVxLZ5EAlG4+1smYaXaDJf0nbp/0rrJJ6diXX80beuAtTCzl+3nHtDxIn/IhwiubGzjwzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rb3rTVU7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rb3rTVU7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744382336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8/gT2LiqvF91XS1z32OuHsw8JByYyLEcktwoMVwoN8s=;
	b=Rb3rTVU7STJLhM5KSDm4WmUlWmoJk1/Fzxm6j1W6c6TNI4w354m6XMNWuFksMkFreb/ky2
	pvVN2V/aN+CyMmm59quw2C43lZaV0kviSoGmn8F6xMxksCkhznu7GIYaWxjdYTykhSsul6
	e3k4DeL/EvDZ8Sa8kSsFyqZepcmK+lk=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-RpAuwi9fOXOwSFjKKO1jrg-1; Fri, 11 Apr 2025 10:38:55 -0400
X-MC-Unique: RpAuwi9fOXOwSFjKKO1jrg-1
X-Mimecast-MFC-AGG-ID: RpAuwi9fOXOwSFjKKO1jrg_1744382334
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-2c6ab096d68so204398fac.1
        for <linux-hardening@vger.kernel.org>; Fri, 11 Apr 2025 07:38:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744382334; x=1744987134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8/gT2LiqvF91XS1z32OuHsw8JByYyLEcktwoMVwoN8s=;
        b=epV0lGIuyyChIlAyCSS7LAhTW7loWsqQn95cJJambtfBShH16KSSuPYzJd6azZrEge
         Q9p6MEnBOX4PURCm2MBJIEB20gODLAZNX1NNEOkAHNm6bhR7C/BAsqL+UpJRdjG2O+IQ
         KrFueLTClRUSVjmRxZKy7aaaG7fCJAhg/DiZbAZdfJX6uJNVGiR57S7KOQ7h5rWff5Yi
         dVwgcFU+BtkbrRKgxEnV9e1iJUkxCJTS7It9MrGUOFAakBFqmJqkjlu1JWodjPMf7f4q
         5TyWJ9Z67mdjhQvkOqmXDU/bYGVF8XjxSHBvtbWR1qvdyTCLZhNx/Wlh+9TqEg17DJWH
         5TnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbCUR6fF4fFc7W+n1WeTWnxnQXKSON8CQ7UJURCLHZhJME4XY0/J5spGWHQAGzgSSS4hEN20iupouvtGUTeRs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsembkke/OwcG6GxCnjFH8OfHDanL7vdeTFN8ZnOQylQCHKcu5
	UZuq9SsQ8NaHOmocPK0wRYr+n7D15gdJObTCkikIdq+5KXK8vcOO3f+q8nqIW9HXX7fwEzEVBKz
	5glCL9RCylam9xv202XuTI5DveJ0n63D6yg6LhnmbwgpmkdGUs/kuefVgIOTlgaS/qL3nuiCuWr
	NNZtXH0DPhsqDJWW0AUKiCH50+JSFrPGTF7Pi+Z5CN
X-Gm-Gg: ASbGncsVwBaMRvBa2utor2jT6hg5sPXkIH3O0A169kOpUYrDzy33CfC0+skMYWhZwvx
	x3E0aWLKy+rEb9LF74DvCadzVtnhn4arJSbbpa4nx8wEmNN46ePhbVdLRUYnZQJJGHIU=
X-Received: by 2002:a05:6871:7420:b0:297:276e:7095 with SMTP id 586e51a60fabf-2d0d5f8c00amr688021fac.11.1744382333815;
        Fri, 11 Apr 2025 07:38:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZ40FSxApw5yS1+TbnTIpuzdl8qJ1ag6yfohHYzJ0JscM4meYKAlkqxF6dxd7SQMlRn7hemIvUqcEzCGQm9QA=
X-Received: by 2002:a05:6871:7420:b0:297:276e:7095 with SMTP id
 586e51a60fabf-2d0d5f8c00amr688018fac.11.1744382333556; Fri, 11 Apr 2025
 07:38:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409144250.206590-1-ivecera@redhat.com> <20250411072616.GU372032@google.com>
 <CADEbmW1XBDT39Cs5WcAP_GHJ+4_CTdgFA4yoyiTTnJfC7M2YVQ@mail.gmail.com>
In-Reply-To: <CADEbmW1XBDT39Cs5WcAP_GHJ+4_CTdgFA4yoyiTTnJfC7M2YVQ@mail.gmail.com>
From: Michal Schmidt <mschmidt@redhat.com>
Date: Fri, 11 Apr 2025 16:38:41 +0200
X-Gm-Features: ATxdqUE1g8MGxUwcCJZuvbWj2uUxcIOOQXjW4BwHw2sCBCCuDYcjVEft3WRWQUo
Message-ID: <CADEbmW0CTTCXjasu2yGJt_Qe2=wH5-Vp+TtbUxxDNaCN49Ev9g@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] Add Microchip ZL3073x support (part 1)
To: Lee Jones <lee@kernel.org>
Cc: Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Jiri Pirko <jiri@resnulli.us>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Prathosh Satish <Prathosh.Satish@microchip.com>, Kees Cook <kees@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uSVoXFWGKbyg7QuwfKGj73k6scC2DPxMfMDvICtXzAg_1744382334
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 4:27=E2=80=AFPM Michal Schmidt <mschmidt@redhat.com=
> wrote:
> On Fri, Apr 11, 2025 at 9:26=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
> > On Wed, 09 Apr 2025, Ivan Vecera wrote:
> > > Add support for Microchip Azurite DPLL/PTP/SyncE chip family that
> > > provides DPLL and PTP functionality. This series bring first part
> > > that adds the common MFD driver that provides an access to the bus
> > > that can be either I2C or SPI.
> > > [...]
> >
> > Not only are all of the added abstractions and ugly MACROs hard to read
> > and troublesome to maintain, they're also completely unnecessary at thi=
s
> > (driver) level.  Nicely authored, easy to read / maintain code wins ove=
r
> > clever code 95% of the time.
>
> Hello Lee,
>
> IMHO defining the registers with the ZL3073X_REG*_DEF macros is both
> clever and easy to read / maintain. On one line I can see the register
> name, size and address. For the indexed registers also their count and
> the stride. It's almost like looking at a datasheet. And the
> type-checking for accessing the registers using the correct size is
> nice. I even liked the paranoid WARN_ON for checking the index
> overflows.
>
> The weak point is the non-obvious usage in call sites. Seeing:
>   rc =3D zl3073x_read_id(zldev, &id);
> can be confusing. One will not find the function with cscope or grep.
> Nothing immediately suggests that there's macro magic behind it.
> What if usage had to be just slightly more explicit?:
>   rc =3D ZL3073X_READ(id, zldev, &id);
>
> I could immediately see that ZL3073X_READ is a macro. Its definition
> would be near the definitions of the ZL3073X_REG*_DEF macros, so I
> could correctly guess these things are related.
> The 1st argument of the ZL3073X_READ macro is the register name.
> (There would be a ZL3073X_READ_IDX with one more argument for indexed
> registers.)
> In vim, having the cursor on the 1st argument (id) and pressing gD
> takes me to the corresponding ZL3073X_REG16_DEF line.
>
> Would it still be too ugly in your view?

And if having "id" as both the register name and the local variable
name is irritating, the registers can get a prefix, e.g. the register
name could be defined as REG_id.

Michal

