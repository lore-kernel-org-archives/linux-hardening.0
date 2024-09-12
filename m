Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A248D1BFE02
	for <linux-hardening@vger.kernel.org>; Thu, 12 Sep 2024 20:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726174056; cv=none; b=Ca1a6YkghlwODxxGRXNII33ce//pP8n5usDupeBuoWDLUIdGy2bWcQxGdSjAREKVt5Svh6sgKrYvl0zp7p4H2eivMlv50U3yMYnCfiafm53yD6f0UDKDsWXxUUpL9qRspOXuGK17/ImmZsBazpN/EwyxHcjsGdQqpv/j1NO00Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726174056; c=relaxed/simple;
	bh=YVOONdyMDfAAPT3E8i8vp3i+ah2xetTTBd9LCjlO3Ko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iWQQLjFEJDOcTwcA4TYIaMhXqBmRs1FhTlgmu0Wc5iiOqpveArMdXyyWQ0F0Sz6c3Pb2UqHrgs6hXTmHc4TDhJfVo4b8z1I+3PqLnmvZMxp2hkl4tJ2L/8VmFwtSMMh+ChI6dYNF0h7TaNoCreGlxmpJ1d7PK9FJSA/q6ZH/Vsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2eiThzkk; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2eiThzkk"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-49bd32f6a11so398916137.1
        for <linux-hardening@vger.kernel.org>; Thu, 12 Sep 2024 13:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726174053; x=1726778853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EW6ORuO6UAIknL/dRfg0azJ4PmYS1WR3P3nm1fuxNAU=;
        b=2eiThzkkVdTBfRG2fQ4tQhgYOyjOkxV6cQc4kxjoeWiIW84RHisbJWR21QsqCU5z1S
         x7ySv3GdC5aBq7qccu4AXKD+ArIYXi4dU5Eyh+s43lMn2j5kiwnEJsUtN9ady+QOJDKR
         Bm5RH/9mOQT+w/cNif+u/NZc7b6s3A2dsZ2kKwOscfLTmtYoUMaAnhq2NBiGlLX5gCNH
         4ZoheI1yfgcmaprwyNITmst1SP3O8bU4CttVBuhMMi1zG4zRZ5Kdv5hAHe2oGq1/6Dhp
         VMCizoduj8H47z1QH4NOYfEsoHLXYpO7Zmdp5yCqqzXi7au8fqIRz0zN1EWGj7YXi6gy
         Mx0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726174053; x=1726778853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EW6ORuO6UAIknL/dRfg0azJ4PmYS1WR3P3nm1fuxNAU=;
        b=cu6uhEL29l8fZE2jxJRpJnphN8iMHYmxr9UlFeXuQSPT7zN9KrhSy+3hujbw4bqrj6
         Bc+R1HRK2qmqPXatWKKsaQmD5MSIGs52rThNluqXdEYm1PFG5Znb6eOjta4gnosgBlx0
         z6T/xOky+k1/UEtsKX9mN7XCr7mO078CL8YAXEIpE4fAsPxwqkHu6FlXdZ0TRNdtR1oQ
         wJ/Ff1uol0DkvyfbIc5rwJPk2ubQCpBZfuFrxpa2CYuXLmDL3ltQ3m6a6sJG6RFw+Sgl
         UC1rYVENBJzjaOv1e1RQCAlUeW7ZxCnnhI51DDsdk3Xx2tEmjySsjcFWCF+AUSLbG/3j
         N90w==
X-Forwarded-Encrypted: i=1; AJvYcCVUk3lbi2AvwsH+yjiV4i+tmAKDMWi1ENYn1ZIymLlahU/zk3StDqRYhk+fHJxUAK0hy5SvyZnx4RWBI7cFOEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyR7nL6oZpNGFBo3hNMHPnkkEldN/c8RfbjxAsIm6ru58QevMP
	fE8cswLkHrbjbF5NrD4MOkiX3telSQcTJeqE5EojY0CJ8O9t3aD/Vin2Fa84OKCqd2g2kUjbcQk
	O1oqMDEOPZGcdoKuhurgyzNO88ov5C8Z2MOLU
X-Google-Smtp-Source: AGHT+IENltP/J2FRcSH0t6JFPlpXTtj8oHiZ0wN117RfOO9nTGm+9hN4pJU4dEgwVrAW+FqPGfO3010PigbLkApwA3E=
X-Received: by 2002:a05:6102:c92:b0:49b:eae3:bdae with SMTP id
 ada2fe7eead31-49d414806a4mr3292598137.9.1726174053304; Thu, 12 Sep 2024
 13:47:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909-strncpy-net-caif-chnl_net-c-v1-1-438eb870c155@google.com>
 <20240910093751.GA572255@kernel.org> <CAFhGd8qQ_e_rh1xQqAnaAZmA7R+ftRGjprxGp+njoqg_FGMCSw@mail.gmail.com>
In-Reply-To: <CAFhGd8qQ_e_rh1xQqAnaAZmA7R+ftRGjprxGp+njoqg_FGMCSw@mail.gmail.com>
From: Justin Stitt <justinstitt@google.com>
Date: Thu, 12 Sep 2024 13:47:22 -0700
Message-ID: <CAFhGd8r2PO9qLej9okVpwcfL2Kz5oCahdnzEVRpCJVm+b5g-Bw@mail.gmail.com>
Subject: Re: [PATCH] caif: replace deprecated strncpy with strscpy_pad
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 1:43=E2=80=AFPM Justin Stitt <justinstitt@google.co=
m> wrote:
>
> Hi,
>
> On Tue, Sep 10, 2024 at 2:37=E2=80=AFAM Simon Horman <horms@kernel.org> w=
rote:
> >
> > On Mon, Sep 09, 2024 at 04:39:28PM -0700, Justin Stitt wrote:
> > > strncpy() is deprecated for use on NUL-terminated destination strings=
 [1] and
> > > as such we should prefer more robust and less ambiguous string interf=
aces.
> > >
> > > Towards the goal of [2], replace strncpy() with an alternative that
> > > guarantees NUL-termination and NUL-padding for the destination buffer=
.
> >
> > Hi Justin,
> >
> > I am curious to know why the _pad variant was chosen.
>
> I chose the _pad variant as it matches the behavior of strncpy in this
> context, ensuring minimal functional change. I think the point you're
> trying to get at is that the net_device should be zero allocated to
> begin with -- rendering all thus NUL-padding superfluous. I have some
> questions out of curiosity: 1) do all control paths leading here
> zero-allocate the net_device struct? and 2) does it matter that this
> private data be NUL-padded (I assume not).
>
> With all that being said, I'd be happy to send a v2 using the regular
> strscpy variant if needed.

I just saw [1] so let's go with that, obviously.

>
> >
> > > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#=
strncpy-on-nul-terminated-strings [1]
> > > Link: https://github.com/KSPP/linux/issues/90 [2]
> > > Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.=
en.html
> > > Cc: Kees Cook <keescook@chromium.org>
> > > Cc: linux-hardening@vger.kernel.org
> > > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > > ---
> > > Note: build-tested only.
> > > ---
> > >  net/caif/chnl_net.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/net/caif/chnl_net.c b/net/caif/chnl_net.c
> > > index 47901bd4def1..ff37dceefa26 100644
> > > --- a/net/caif/chnl_net.c
> > > +++ b/net/caif/chnl_net.c
> > > @@ -347,7 +347,7 @@ static int chnl_net_init(struct net_device *dev)
> > >       struct chnl_net *priv;
> > >       ASSERT_RTNL();
> > >       priv =3D netdev_priv(dev);
> > > -     strncpy(priv->name, dev->name, sizeof(priv->name));
> > > +     strscpy_pad(priv->name, dev->name);
> > >       INIT_LIST_HEAD(&priv->list_field);
> > >       return 0;
> > >  }
> > >
> > > ---
> > > base-commit: bc83b4d1f08695e85e85d36f7b803da58010161d
> > > change-id: 20240909-strncpy-net-caif-chnl_net-c-a505e955e697
> > >
> > > Best regards,
> > > --
> > > Justin Stitt <justinstitt@google.com>
> > >
> > >
>
> I appreciate the review.
>
> Thanks
> Justin

[1]: https://lore.kernel.org/all/20240911015228.1555779-1-kuba@kernel.org/

Thanks
Justin
