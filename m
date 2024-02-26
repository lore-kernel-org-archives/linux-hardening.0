Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846F21E878
	for <linux-hardening@vger.kernel.org>; Mon, 26 Feb 2024 22:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708987070; cv=none; b=VIL8E8sEq/Vz169+oudzwBUSrU7+YFynWJI2eJLRAUoGIiV8HqTDYAN0qiGXB1LmG0vfazGiga7RjNBVkIg2nta5iqFGohMD9RGxdYhqMNrlpfkE06ZVWaRerCz1aTfK5MdNrZFbgv+ZtFyLCIEY/fo9mu9rZgjQGnalII0Nyeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708987070; c=relaxed/simple;
	bh=9wln76VnEaWfDZRkMs2O/OEsQHa33RJYn0rGYikz1nM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aAthvQ/bwkwX2CJtntqukJNYxyskOrlJYVKfNWhp6ZoAEKyFpTSnt8fNpCAWX0l+i+4+dnFaQlxYAUCBaNg/lmdDxTRt72CNqa+7oG4sHBTYdIIFkpHXEgOlk77aMDIduNgWYfAhrLiZDohK0kx7aNJ16HSkHlK2kkro505tCoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=URxK7Ovq; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="URxK7Ovq"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-563bb51c36eso3839473a12.2
        for <linux-hardening@vger.kernel.org>; Mon, 26 Feb 2024 14:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708987066; x=1709591866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9wln76VnEaWfDZRkMs2O/OEsQHa33RJYn0rGYikz1nM=;
        b=URxK7Ovq6mgCNT0pAEqBb/3M/wjnmM/LSxXpmCakoJ1ePWBWfexAdkcuSxDKu8qmrw
         wnZfWZ5v8j38ev4wD9Zz2QxRZsrZveUstPE5T2J+pr21rnoxIcx01LeSJWlF8Wyq8amw
         5pNEpFVJPmJG9/uQTS6blToY7w/7Uk2TQ949U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708987066; x=1709591866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9wln76VnEaWfDZRkMs2O/OEsQHa33RJYn0rGYikz1nM=;
        b=mj+9UqvHEjCWmVPs6/ZM49dfiWrrYdJQQD9j9HW819d4vwEIGp4EEGVMDCSqjpZ4gD
         2de3BlEu7S6wcVgo/eDOvQRjp/jbYwzODkJ0auW+FYNVUmjqKjI7zpgRHFNxh2+MNlKy
         hDt0634Duy0o84MDk9o2ZdQUJjENMA984HEcPIH8PjP3F6wqtqOdkoD3bOS5H/xktTXV
         xD9n6LOtwcyNvtLStJ6Bge+kfhMNgY7wY83r/2F66zTJilKKDqTLfTW2lUsZXxJb3BUK
         o1r79EmPVEZg1RPFyHyE0B4giSEPSi14xSGmw2qXxqBIiun+CsvZy6DCWMIKuk0kgSo6
         gTRA==
X-Forwarded-Encrypted: i=1; AJvYcCVfOdbuUQmwOtXFS43qCq4Iqo0qqaaFwQl66agxQGWHgJB9D8uz7CWX81P4LDSs1LZOIIhbcG83YRp17GN5rXEXyfGUQ8YLUxupf0yDt5MX
X-Gm-Message-State: AOJu0YzGj8X4TxaO8KSqtsl412Lm8VbEQYnkxmWa/iBFKKkQQC6la/OD
	LXtpx7ScvK3QfnDT1IQHCTNGCOTSE94qUjtGJDwoapRldKEo+7pLPrJ7kXo7PiSXei30Jnkhlh+
	6ZKq9
X-Google-Smtp-Source: AGHT+IFDZL325iD7crQLA+NZKiQyWPHPot1oQnTIZqZgZMnhoyYuX+N+hGpNxEuQqRNHBLt/Dj0fCw==
X-Received: by 2002:aa7:c348:0:b0:566:1684:5037 with SMTP id j8-20020aa7c348000000b0056616845037mr1546868edr.17.1708987066322;
        Mon, 26 Feb 2024 14:37:46 -0800 (PST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id ds15-20020a0564021ccf00b00564da28dfe2sm172981edb.19.2024.02.26.14.37.45
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 14:37:45 -0800 (PST)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-412a2c2ce88so5275e9.1
        for <linux-hardening@vger.kernel.org>; Mon, 26 Feb 2024 14:37:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVukxpxu8p7GBicGu+neDy8eZE2G106v0q2n1jelpQMHMCsqeBZjZ2eQgEd4XVmbG9XzxwopmezCoAPrEEYffqTCzRnuQsmUCIngUlVAMZN
X-Received: by 2002:a05:600c:1d8b:b0:412:a80e:a5cc with SMTP id
 p11-20020a05600c1d8b00b00412a80ea5ccmr30242wms.1.1708987065108; Mon, 26 Feb
 2024 14:37:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221210626.155534-1-adrian.ratiu@collabora.com>
 <CAD=FV=WR51_HJA0teHhBKvr90ufzZePVcxdA+iVZqXUK=cYJng@mail.gmail.com>
 <202402261110.B8129C002@keescook> <202402261123.B2A1D0DE@keescook> <1405e4-65dd1180-3-7a785380@32026879>
In-Reply-To: <1405e4-65dd1180-3-7a785380@32026879>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 26 Feb 2024 14:37:29 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Vh7Ctaj6N_k9gdkrqpb687zJqQN19qTZXMyDw6TujvLQ@mail.gmail.com>
Message-ID: <CAD=FV=Vh7Ctaj6N_k9gdkrqpb687zJqQN19qTZXMyDw6TujvLQ@mail.gmail.com>
Subject: Re: [PATCH] proc: allow restricting /proc/pid/mem writes
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: Kees Cook <keescook@chromium.org>, jannh@google.com, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel@collabora.com, 
	Guenter Roeck <groeck@chromium.org>, Mike Frysinger <vapier@chromium.org>, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 26, 2024 at 2:33=E2=80=AFPM Adrian Ratiu <adrian.ratiu@collabor=
a.com> wrote:
>
> > > [...]
> > > +config SECURITY_PROC_MEM_RESTRICT_WRITES
> >
> > Instead of a build-time CONFIG, I'd prefer a boot-time config (or a
> > sysctl, but that's be harder given the perms). That this is selectable
> > by distro users, etc, and they don't need to rebuild their kernel to
> > benefit from it.
>
> Ack, I'll implement a cmdline arg in v2.

Any objections to doing both? Have a CONFIG option for a default and a
cmdline to override it? This way if a distro wants to restrict writes
by default then don't need to jam more stuff into the kernel command
line.

-Doug
