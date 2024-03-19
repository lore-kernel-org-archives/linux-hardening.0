Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1A03FB90
	for <linux-hardening@vger.kernel.org>; Tue, 19 Mar 2024 21:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710882021; cv=none; b=DYDdT7MMAOZxc4ylHSsTWJIweya4aCvUxt9IMde+imZyksSkTs136t1TVSKi97oZMTwgbDvEivd4Ps/D+Gq7VcnoahFJfHfqE2N9GHR3QHK3xprZY593SkujMZjF2qiJXoj60ejLvCocDw48qXbM89qmhU3B0m0ZoHMm2m4JORc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710882021; c=relaxed/simple;
	bh=wpmJb/vawcr/bgZTTTWypOk/KxnH3sCIe+53p9+QArc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ShDGamOy7uxM7L4cbBrRgBXNTeYgRnCcuyM80yqZ6Jl4ksfnOxerB1qiU2k48HHQD3PZij/1C2XQwg1kOXvQaRsa4bmVvGoCNexZ831aoOIpr+3TgsTb6r8sew/AIct9G/ubRxLkoLQmxAQ4bc/lnU7Ja2LE9pzfvnH1Ef/eX7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lScGxJFz; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lScGxJFz"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56bab906859so120330a12.3
        for <linux-hardening@vger.kernel.org>; Tue, 19 Mar 2024 14:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710882018; x=1711486818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XiHFjOZrEM4sT036lCzm+As9FCgL6wQXfthUNkxfzew=;
        b=lScGxJFzdPXAS2VhAKigrNtZft+Ev/Vy/cvRAqhcW/ItpNMKPe8tSuGLOrfBs4e5As
         l8bRZeCMo2j6c7ALIYNoMCkJe8Z5OYEgl0XjztCusoK/9s9QneU4nolmhQvGIUqKs5cA
         H60zI5r2cUbKZ6GtZ1vvF2aoEDfiAKijulthMD6afY69TbytbS9FfIg8iqle9JauAg/6
         FlI0UsFeIEppMIN6sa36GRONAdRtBAuH9KDShbMy4PKzvuHRf2/2O+hX/ykw7vmYXp+L
         jlMuoSxPZV7+hKiiM0witkDycah52qUJGwEGHb/6cNN9a+KRy7y1QtmYhxrrKxpDu35n
         5/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710882018; x=1711486818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XiHFjOZrEM4sT036lCzm+As9FCgL6wQXfthUNkxfzew=;
        b=fQQAOczllZTiFUf3lWScI4iow7qsO9+8zKVVjCpPqY8GEvcSlqc+e1P62Dy1tHx7Aa
         HnexITpWH2j0YAREcGH4z/pP0VedBY4UfNS/VBxpQCWxrpiHIBobVW+BSwvPhL3TZ37t
         GTDNNzxCOfaKrMXBDpP8b5bPxU5oPCIkjq71D+0eGbe60lbuhWxUM1v+ijv4hnc+Bdqh
         4VLFuRGKOyyh8H9+zrjkMNysB5rJdoesH7qKGmjx3OW+ICz47SaaA3Sp72pKbInwZUL3
         kVWs/h7LQGMYrq8Rk1MfJmqsvSvPxrvT8WjTuyg+439f/AWxRDH0mi+TvQthFF5oC5a7
         Gsfw==
X-Forwarded-Encrypted: i=1; AJvYcCXOstxsocInI+noPQ8HWo3lDd0s4LSOwrJpYhwQkcK27lIwIMDb5sT8DDqHS58lraHeavrz5EC4w8QxdBG8k6AUutl2UhPAJ+fJcOV5MkFO
X-Gm-Message-State: AOJu0YytYXKIg3djq6QpcAhe+9By7eknxencpDJLCGx9nhWWcGOALAQ6
	3lg6/TpJbDDMcsrWL9oJr1EmyxBcfMrKFHOuZ3G/qwtAGZXkaRSlOWN7YfJ/FM+/mMhk4ZzO6Ha
	+QKfAeot6299oQdM6TJrMlZdEUqW38hOKsjXJ
X-Google-Smtp-Source: AGHT+IGsCM7wuFKHn5ZhX2dMOIOSw8LutGxSmqkY9l0OFvWbZ/BAMaVK+Mi+Tr26DwvFctw8kZL19/iVtdSMVZfhoHs=
X-Received: by 2002:a05:6402:1f8c:b0:568:9b15:112e with SMTP id
 c12-20020a0564021f8c00b005689b15112emr11012930edc.19.1710882017946; Tue, 19
 Mar 2024 14:00:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9bba38df-5881-43f7-b1b3-f77e7b57bbe7.6c628ed6-0c2a-48f7-ba62-bcb23589b41f.60196f95-e445-4678-a450-875badf86498@emailsignatures365.codetwo.com>
 <20240318-strncpy-drivers-tty-n_gsm-c-v1-1-da37a07c642e@google.com> <AS8PR05MB9810B8AC6B5033FD6660EC69832C2@AS8PR05MB9810.eurprd05.prod.outlook.com>
In-Reply-To: <AS8PR05MB9810B8AC6B5033FD6660EC69832C2@AS8PR05MB9810.eurprd05.prod.outlook.com>
From: Justin Stitt <justinstitt@google.com>
Date: Tue, 19 Mar 2024 14:00:05 -0700
Message-ID: <CAFhGd8rBd7_7apXF9XTtBHkUG4FSmfa4YLkiQVow_pA05-9mSw@mail.gmail.com>
Subject: Re: [PATCH] tty: n_gsm: replace deprecated strncpy with strscpy
To: Maarten Brock <Maarten.Brock@sttls.nl>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, 
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 19, 2024 at 2:11=E2=80=AFAM Maarten Brock <Maarten.Brock@sttls.=
nl> wrote:
>
> Hi Justin,
>
> > ---
> > Note: build-tested only.
>
> Really? Without warnings?
>
> > --- a/drivers/tty/n_gsm.c
> > +++ b/drivers/tty/n_gsm.c
> > @@ -4010,7 +4010,7 @@ static int gsm_create_network(struct gsm_dlci *dl=
ci,
> > struct gsm_netconfig *nc)
> >       mux_net =3D netdev_priv(net);
> >       mux_net->dlci =3D dlci;
> >       kref_init(&mux_net->ref);
> > -     strncpy(nc->if_name, net->name, IFNAMSIZ); /* return net name */
> > +     strscpy(nc->if_name, net->name); /* return net name */
>
> Where did IFNAMSIZ go?

There's a new 2-argument strscpy introduced in Commit e6584c3964f2f
("string: Allow 2-argument strscpy()"). Since the compiler can find
nc->if_name's size (which is =3D=3D IFNAMSIZ) it should be A-OK to swap to
this new form.

>
> Kind regards,
> Maarten Brock
>

Thanks
Justin
