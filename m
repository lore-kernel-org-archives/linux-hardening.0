Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE38A15ECE6;
	Thu,  8 Aug 2024 22:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723154881; cv=none; b=CrRv1yHevKn+Z3lT3HO/pbSqVgA01UcpEag92WjV5/sqQz/W5x3m8SCsyAW2gMVaZISX3BYL97BuN/XTX507mJ/5gJsiVl+HGsDZgfMzVUFEpc1T63ByTd47ECBiOszZ42yPsHosPp4Bzcl9CD/ROt+3T9TdR45ZIYXJtwpYpm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723154881; c=relaxed/simple;
	bh=zuZUfAgXy1giOe2syrZyYDHp33Vb4HgiSve2hu4KyEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gEezAoXSzZs1aPTpjkn6smu5PbJPivD9y3wQrXJbMLgsvEBqDumGL1+JgmAVQ4U6ae5TXNfwMYOciOV3JsC1xspX9bmJ+DLsZ0VQj4R9kcEXHwLbvcba1OYWvie1Vdt364VznJstxiuXj3Gk33mdAnBhPOt8B7LIPXU6opr0GAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOS4VRg+; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOS4VRg+"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a7ac469e4c4so236259366b.0;
        Thu, 08 Aug 2024 15:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723154878; x=1723759678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zuZUfAgXy1giOe2syrZyYDHp33Vb4HgiSve2hu4KyEA=;
        b=eOS4VRg+el8EmxGOQYdBSFan1qE3r3EIJfMotnTgYp3VLE1h8t43s2MgSojK8+6bSH
         5w9wdDZgU5vZp9mDijC3CP4jpaeWfcJw4Vrq8lzfRwcf0lAV156D88cy5P9QFDeDsWq4
         0JDEvGh6kFkYc44JX2e9xFmdc9ITcZ8VZySpLScFlz4wpaUKnhAHe7GZnlYxrsKfvd1y
         pusRv/+BnLyocUnivVLFDF9Gr9zi5i0tUes7qsVAW5bdet+iLtEzY7ITBZRsduHe2ZRw
         SU3T5AFUXYdvwUNM6GpDYIXGqZBo/0pZDEJqlvseAA8YJ2GzAocQnleAYxCuVdXVoKsm
         Q1EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723154878; x=1723759678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zuZUfAgXy1giOe2syrZyYDHp33Vb4HgiSve2hu4KyEA=;
        b=MNnolHSR+tKgh3ecdv2nuyz+Umd4lVkq2J+LaeMnRJYvVg/oBosDhH8aJ3LvB8EIT8
         pRCnrEmwJTiHhL4U208+5VgEwjlt5259oO4mCUcEE5hKi0c20JB56KUbUb2v1ACRvOgK
         THBr2uuEXImh7ttShkXFZ4711arH0wIW8EOotFYk2RGXCpFAY+E+6XGKzGt0bcvh5GuJ
         Pzdtst0Wi0dAw18xWEGmthw+OyzWGF8QEidQ2KuhoAG9AxcrL0V5OGdEiaigLp1rI/oJ
         jyPlS5WK7mg30wA7p2eq76+BxUej2bApYP+s64tNvCbnhV6qls2MQmx4bmcG2d4YOfK5
         e4vw==
X-Forwarded-Encrypted: i=1; AJvYcCWhZS3zGkcbClTybD/drpRWvImpK+uF8B4AtBCrXHKoeWWGT9RYrd+G5hvrMYAhD8axoZUrWQt21sy022Mz+YTU+DdZS5GwZoy5myrY3yUftZc49E2VQjzZokYISf40gyYcxusIM/09RhPngHNQ
X-Gm-Message-State: AOJu0YxnOdS4D/NqWo1H/0ije2A8tRphgneaOK42df8g+wpsjLdHjORu
	5vLWVzBktC62yCN3e3GSpEgvKn0lnlRuh+u3lILH/+fCMW7Nt6fFZWZcRvaMXknnkwOrmp+k6wc
	Q9PIhC+0IPLRPJbK0o5Yi/zTBaDU=
X-Google-Smtp-Source: AGHT+IFE3FZDjSdFf+PDPA/Q7mk5gm3rHBt75WCvB4gV1MjfIlTPDW7WWr5hVhhGW+I6nWV+yhtV39S0xwASAdcqWnE=
X-Received: by 2002:a17:907:1c08:b0:a77:ce4c:8c9c with SMTP id
 a640c23a62f3a-a8091ef3797mr302416166b.8.1723154877844; Thu, 08 Aug 2024
 15:07:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808-b4-string_helpers_caa133-v1-1-686a455167c4@google.com>
In-Reply-To: <20240808-b4-string_helpers_caa133-v1-1-686a455167c4@google.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 9 Aug 2024 01:07:21 +0300
Message-ID: <CAHp75VfBjKLf3LqDXvAehW5sxGzYnU4sS3fr=JoaM-6p_gR34w@mail.gmail.com>
Subject: Re: [PATCH] lib/string_helpers: rework overflow-dependent code
To: Justin Stitt <justinstitt@google.com>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 12:44=E2=80=AFAM Justin Stitt <justinstitt@google.co=
m> wrote:
>
> When @size is 0, the desired behavior is to allow unlimited bytes to be
> parsed. Currently, this relies on some intentional arithmetic overflow
> where --size gives us SIZE_MAX when size is 0.
>
> Explicitly spell out the desired behavior without relying on intentional
> overflow/underflow.

Hmm... but why? Overflow for the _unsigned_ types is okay. No?

--=20
With Best Regards,
Andy Shevchenko
