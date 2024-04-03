Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276DE152DE8
	for <linux-hardening@vger.kernel.org>; Wed,  3 Apr 2024 17:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712166426; cv=none; b=Y5kCrHJv3qLwxlCOWcrnt3EW4sqSNwnUOaVOsTtEKcuhKxiU+sZxkuzfvxJUyzLjVB1op0DeMS93yR5QELe+K/EutIzI1j0xdYe7yK6+KtpP8B9DpZjUrOFic1CsZqZdHw49Y9oTNGVlKswYVOunWwRQ/GY5sFU/XRaZxM3ts0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712166426; c=relaxed/simple;
	bh=2JeOLqt6iFkrlIcYwbpDrQbQoAoYiMHND8+3QmCr6qo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CyJRRj6gESwwrGzw72bfMIcU8i+Y1gjTJrwSKQSAFk/hoDJQ874JNhA7+lxNlFefUv0aIjv9KNELkpY2ZGozIFdG2wQCHhVwf09BHLgcedozcAP1GJml67GqEl0YKVb7VNpp/S6HueAOmAvQC8ZuJnBvhb/wynHSWm1leb2YkV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OGC9k7vD; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OGC9k7vD"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a450bedffdfso15973766b.3
        for <linux-hardening@vger.kernel.org>; Wed, 03 Apr 2024 10:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712166423; x=1712771223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JqrURadVh6bfrB2uLbLqnbQWG9RW9Mp6NnYEctBPd/0=;
        b=OGC9k7vD778aAa5ZsyGKYQntGnNcYoEoBo0bLXUPQh+y8Q24/HMc+w/8cVM46cO3cp
         ugV0wo+hwY99pD2rNxKVxO6+bcs3uRDkgzAr/4Rv2VFZ8ZLaviYJNaAYgmgSPJwIHHbq
         R2oeNe1n01wScP3PJp1fxu/ALO09Z4tZDg0+ESDcpP9TcQHxEY/21lBiuPTi8vZVoR1U
         9JLDo4ZKLEBhAy7oWG9vxkFnlVRSa6nEBQ8eZFC7DFdjQFcvyZ2jJvdtxCt0QyfkzUhc
         rb0tTcLeUi8xHnUGE8vRogTTwYBTe5yRV6NfFj0IqqpI6F646Kb0ov8zcvsz4+prUnKd
         64WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712166423; x=1712771223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JqrURadVh6bfrB2uLbLqnbQWG9RW9Mp6NnYEctBPd/0=;
        b=FKiWv7h8HAQQESxr2SjcsQOKfoKIaY98F61kgWJtaFqcCfSsx5vRmf0T8rjJDKzrMo
         giscmjqCXjgLlmldP4cS3yWdgjD0Ypii/Ys9r0TCVcXww7Du7dfUNaCdUwKFWIJ25GRZ
         G8+emztBLeIohL+0X4N/3dfShRjGJ67FUbunvMtjs1969lEJ9AjpY83xqb8YquUPFiJI
         CCCpCuXMYvUjGHZIFHTMJ3LANzjO0jQ4HbMThyKCt1ssGzCqujsI0SZZeT38qwTg2KnV
         Xd9QPJfPHYr+RY3VEKl5rGT0jxffQ1F5fxgNFEOEmSizrTiUXATilwrBtuxLW0wWstrz
         Px7g==
X-Forwarded-Encrypted: i=1; AJvYcCXsWdfbHJFgwtk568YoNWE4qkvO9XaMtXRNDFzvHBPHhs0Ye6E482sviuJDW06qQyVAY//NdDErXn2EbLU9fAorB5VCZn0aN0/eX+hqRncy
X-Gm-Message-State: AOJu0YzBGzaAdRvQwawvKK2YMPmZxXiC+mlbWMfGMxdBh2nuQ3C0OMKW
	f3RV/bDJajWDoQHcn1yYt+nw9fIYVmsmfXjfu5zDBPhzdmos41z3/3utF8LjSqNTFNU2fY+Vg9O
	CMbCrJVx001++4OJwW7PaNG6UuiEkoUrIajDZ
X-Google-Smtp-Source: AGHT+IGSZh3cGZaqkR61KLJvDstkfMIgQgaXFfkZwJhOF9eaxuv59oIjbf/wbWZywUuB5lPZKadWGDHsD804an1EBCw=
X-Received: by 2002:a17:906:aadb:b0:a4d:ffcb:1f4e with SMTP id
 kt27-20020a170906aadb00b00a4dffcb1f4emr11402ejb.75.1712166423477; Wed, 03 Apr
 2024 10:47:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403-strncpy-kernel-debug-kdb-kdb_io-c-v1-1-7f78a08e9ff4@google.com>
 <20240403112336.GD25200@aspen.lan>
In-Reply-To: <20240403112336.GD25200@aspen.lan>
From: Justin Stitt <justinstitt@google.com>
Date: Wed, 3 Apr 2024 10:46:50 -0700
Message-ID: <CAFhGd8rjDRTY8JjWx_zt8xBHGcJYzp5VpFf_sN+s-kRcr1JKBw@mail.gmail.com>
Subject: Re: [PATCH] kdb: replace deprecated strncpy
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jason Wessel <jason.wessel@windriver.com>, Douglas Anderson <dianders@chromium.org>, 
	kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 4:23=E2=80=AFAM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
> > -                     strncpy(cp, p_tmp+len, len_tmp-len + 1);
> > +                     memcpy(cp, p_tmp+len, len_tmp-len + 1);
>
> Roughly the same question here. The original coded is obviously wrong
> so trusting it did the boundary checks properly seems unwise.
>
> Are you sure it is OK to make this copy with checking against bufend?
>

I am going to revisit this and find a better solution. Thanks Daniel.

>
> Daniel.
