Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D391D52C;
	Mon,  6 May 2024 17:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715017815; cv=none; b=XdCfMVZR9kZIymKfELz3+1OL3wdSsW17NpNpVll9RgLBfyciy0zq4a7AWTxGYFGQvB348xBtCtB6vk5QdoPDlwNvOg18YvjFU4EdotDgJE8m6f5Pj01TOPWDSCal38fJIYbAIaJOf2UoqeJKw0MZWCdLd0Hf8Paf3R5+obNazEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715017815; c=relaxed/simple;
	bh=gXKML0ANf/VHTXTDJLQs6FDzugzEI1UK1X68Cny0xps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rmo1uULnvkYUGhCBu+hwJaOUIRV3cWY5OLkOcElTB5AaYOd05eva1eCa0Ezvr+zlLniYp+Atodr1O4MxGqAtsJQSMuuho0l7iTQzI4GVr/lgGXTDzsV8DQ+velr3Rs8CoEdGMoCLozoCaxQ4xkf2JO8aMZoAX3cjx82Pzv8IlTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HPmPREm0; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPmPREm0"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5e152c757a5so1283160a12.2;
        Mon, 06 May 2024 10:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715017813; x=1715622613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gXKML0ANf/VHTXTDJLQs6FDzugzEI1UK1X68Cny0xps=;
        b=HPmPREm0ul+P81ACw5vB0aD6E5kVB60XDvVT+yATzBQz1mmY9QTA2j3W8pVXMM/7VE
         VG/QX3IqGitW5oecVekPgsBgriHM8TlQcBMYgFHa6z8EZS/vWzBQSLC3ebBeGKaOzcDO
         mnDRR/007n1b5/XouF8XGsF7IiSksLKahpr0L/z0weP+cPu7gZ71exyHSQcYuFJbVqbC
         D1BY/Jbs0qFX2VglNS425KRqBl8LBdKz/ikODj6/JmTlIIXLPmv3Hl3UTIimYU3o6A1G
         Xq6+BiIsSozAIYuMpe7i7vZBOIflhABLcKyZGlzls/zK1zYitC0FgoF6AuIzZHk3qLUU
         I/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715017813; x=1715622613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gXKML0ANf/VHTXTDJLQs6FDzugzEI1UK1X68Cny0xps=;
        b=D6sUo26XES8KpWa9Z6tl3x53x/vHyBU2cf6TFRbUf/9GrFXvM3VUmSdb3GEQoI+m/e
         giWp2Nzq6bid/EF5LJWJGPEAdJd89FxunkmArP4y5z11fFhmcGQXgl+7II5m0yh/uWIB
         bKa8NPJc8zwFvdDVpu5eN1I7AaXToJEK5EvHqHjybB6mKhtcvQahrJsqWa0AkSI8i5SO
         FgEIpvOgsp5YC7BG1iGhix6OUIF7wlwHzThCyt0vrdmbFwHH6InAEOB2GgGdq1VhnV5U
         Ymp4xlw9kyYYTr59l7D9LcbccN8oilX7VTSJQ6SkjD5g/a8wTcFhZcBCMvE3/Davo4pT
         5etA==
X-Forwarded-Encrypted: i=1; AJvYcCVYDdkYuoRYltD53b+SJmwgztuyckbv2WfvE1cYjRZD+ptwvuxUF0j5E9+qpygR4zaKmGU4S42GqBFd74D9xQV0BGiW13z+G8ZIjaw9Frcfu8rjyBscJiBIbxnY6zCAIC/6cpjozGj/OHNb8OqK
X-Gm-Message-State: AOJu0Yyq5WK/ZRe57C6AGwUJeLBl2osgTg9JFmu6rp5uTyB6C1e292fM
	dK5TqWF5TrYAefQ5iGOorKUdimqEY9i2ATrmc+3LQ3CsHew4yHXG24/0p2fY8om5uCkSs966VBd
	IbhC2Z3cKDKbHuZj+NtX5tcxSxx4=
X-Google-Smtp-Source: AGHT+IG4MTEscwBrGFBYlUwy88bX21aQBDdIpQcUbWnGYDzwoP+HaAt0v+w/QBurXrLdxocWMEF3Zi+9LXgDXgvwbyQ=
X-Received: by 2002:a17:90a:9f92:b0:2a5:3aec:fdef with SMTP id
 o18-20020a17090a9f9200b002a53aecfdefmr8095728pjp.47.1715017813346; Mon, 06
 May 2024 10:50:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AS8PR02MB7237CD9ECBF7907AD8B1CC938B1C2@AS8PR02MB7237.eurprd02.prod.outlook.com>
In-Reply-To: <AS8PR02MB7237CD9ECBF7907AD8B1CC938B1C2@AS8PR02MB7237.eurprd02.prod.outlook.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 6 May 2024 19:48:49 +0200
Message-ID: <CANiq72nJj4PmvVdkUHEcC-2HvYZSGctWMqj43mnTJrt0k0QKaA@mail.gmail.com>
Subject: Re: [PATCH] uapi: stddef.h: Provide UAPI macros for __counted_by_{le, be}
To: Erick Archer <erick.archer@outlook.com>
Cc: Kees Cook <keescook@chromium.org>, Alexey Dobriyan <adobriyan@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Dmitry Antipov <dmantipov@yandex.ru>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 7:42=E2=80=AFPM Erick Archer <erick.archer@outlook.c=
om> wrote:
>
> Provide UAPI macros for UAPI structs that will gain annotations for
> __counted_by_{le, be} attributes.
>
> Signed-off-by: Erick Archer <erick.archer@outlook.com>

I guess this is a mirror of the kernel one at
https://lore.kernel.org/lkml/20240327142241.1745989-1-aleksander.lobakin@in=
tel.com/,
but it would be nice to add some context, e.g. Link: tag, to this, and
possibly a comment or two.

Thanks!

Cheers,
Miguel
