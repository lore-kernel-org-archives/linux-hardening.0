Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF22415887F
	for <linux-hardening@vger.kernel.org>; Tue, 23 Jul 2024 18:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721759635; cv=none; b=cBIj0sAF+I1rCNvjTDj4fVo9JT3BQeR+9wA55IcpzgOfijf4iLsAfLUQPVQMrkyf6XJDfAR4PAMS0XxokrsDWw7hWOk2t8E5tBVUCAEBHcJom3FkHi1uSG+ZmWzmWvwlNa4WATzr0cr9iFR0QyqN2RPrMiv6tZBiCofkalUMImw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721759635; c=relaxed/simple;
	bh=NFq/ekDOEm1BCUiEQxAbPVsS7vv5PxDQqveu1WlBUdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uc/kUYyguLALdUn21xR+kYVEkOzhq5xG0It0ljQUIxHM9O3BiM/WZwt0mw4mvy8qW2TqUBS3X5RLCwlHJ66aEpC/hgVk9+bkC8267tfI2CPQQD3YYVI+F0ALuLfwHFafFauFzWVnchMnYmmrv4E2quyDCWCyG9niC3LgFXT9ElU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BWoVOlkh; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BWoVOlkh"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7a94aa5080so23747066b.3
        for <linux-hardening@vger.kernel.org>; Tue, 23 Jul 2024 11:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721759632; x=1722364432; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jVlnyN0btPbYCcHbH0TkKobCqtHm6zMls3/CNbNfk/I=;
        b=BWoVOlkhhWtTHUF4nKcFnVEDmWEvMIIXT6uWr6WvJC2qcVhoYqcbkuTxV17PNZMuss
         EeBEyGYv+kp7YDQB9vqG2Zsi/lOz3tbPFvhTt5cC9ZkMiuljwqHJ+T8HncDwcgNkMV9o
         0GzdAoD1N2Z69DtYI0erbcGA1WelF6MmHcrUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721759632; x=1722364432;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jVlnyN0btPbYCcHbH0TkKobCqtHm6zMls3/CNbNfk/I=;
        b=fs64+KnF9s2iKC6BbbskJ0akCvHvtPwDqrX/Te/uEgV6Km4VWvAiw1+mKYVSpD9UHG
         gea8iznP+aPl77Gop5xlu6riyBMc5HUC6Jbyv0Meamiy1qEUlD8UyN2mT3jD6IqA5+N1
         QOVxO6VqvQkNoi2FBKGj3t5ff+HoFvK+mkPQOUTirlUwcvMkDDkqRmWwOd7YcISCnner
         GUJYejMLscoQ+lS3UDgHo3kh7mhIS3pIz1vkIDOXKbKbHPPblhP7r14GHVVvqTO8XsGR
         b1/foyGniLC3VGY0BTsSUD8AaP+4U6F7gBaiKrZ9ggUnAyQId8sph1K/X8ct1LlciqSc
         D+jA==
X-Forwarded-Encrypted: i=1; AJvYcCVd6XBGUWkC0Ik1eJ8oZBTxlMEmr3Fu8fsWGWyC2jYLlahP1No9ACjbFTzHQkK1dHO9vaMacl948WTVHHD/LuOcXYBNkcDuZ7Q5NTOh0f9/
X-Gm-Message-State: AOJu0YzwKolVJfhLmqWLTAplLcG05PDMvAk4DopTOiwU3LVpfb/3TrPR
	VnowWdLAy0S4PJLCeP8tyrbjjqKpIbsw7PYjcnRuuU6qWTFwCvqH48XToKqaOCbD0P8pbiyX8PN
	pBN2nhQ==
X-Google-Smtp-Source: AGHT+IHmbBEx3CDk8shdetootBOIOFM7llqElM4AMJX2p9bEUs0DTwC7UIUjuJ/wInMYGUCoWwwUGA==
X-Received: by 2002:a17:907:3f0a:b0:a7a:a138:dbc5 with SMTP id a640c23a62f3a-a7aa138e2e2mr175222666b.65.1721759632034;
        Tue, 23 Jul 2024 11:33:52 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7aa5e4e1d9sm41722266b.27.2024.07.23.11.33.51
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 11:33:51 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5a2a90243c9so4768733a12.0
        for <linux-hardening@vger.kernel.org>; Tue, 23 Jul 2024 11:33:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXaLRgVZfYKoeW6lbUKwVWv72vkgVefAZxFQGyUqryQUlaFGWmBDi8R7vHGWy2078T7Sa2+KY91FgyXfzqOZnmtQ6WMHJOU6hZzvR5qRzfS
X-Received: by 2002:a05:6402:26c2:b0:5a3:f5c6:7cd9 with SMTP id
 4fb4d7f45d1cf-5a47a61f330mr9178333a12.26.1721759630852; Tue, 23 Jul 2024
 11:33:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723171753.739971-1-adrian.ratiu@collabora.com> <CAHk-=wiJL59WxvyHOuz2ChW+Vi1PTRKJ+w+9E8d1f4QZs9UFcg@mail.gmail.com>
In-Reply-To: <CAHk-=wiJL59WxvyHOuz2ChW+Vi1PTRKJ+w+9E8d1f4QZs9UFcg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 23 Jul 2024 11:33:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiU8igSGkycZ1e8+6-NF9obbbt1aZXYwd0ONzXnHsBgHA@mail.gmail.com>
Message-ID: <CAHk-=wiU8igSGkycZ1e8+6-NF9obbbt1aZXYwd0ONzXnHsBgHA@mail.gmail.com>
Subject: Re: [PATCH] proc: add config & param to block forcing mem writes
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	kernel@collabora.com, gbiv@google.com, inglorion@google.com, 
	ajordanr@google.com, Doug Anderson <dianders@chromium.org>, Jeff Xu <jeffxu@google.com>, 
	Jann Horn <jannh@google.com>, Kees Cook <kees@kernel.org>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Jul 2024 at 11:30, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> but while that looks a bit prettier, the whole "fs_parser.h" thing is
> admittedly odd.

.. don't get me wrong - /proc obviously *is* a filesystem, but in this
context it's a boot command line parameter, not a mount option.

The "constant_table" thing obviously does work outside of mount
options too, it's just that it's documented and used in the context of
the mount API.

                  Linus
