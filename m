Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F07019F42C;
	Thu,  6 Feb 2025 18:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738867582; cv=none; b=bIcOFTwzIuSTZ/4rTHmn+9j3Ye0FnI9PPOXWXILjFL1tAUmb4JQoyWWYg/tPjAnDFxk70nKND8jqJTt75WTMgjwU1hs+VhQ1AUvRzevj/IgF5RPnonCVtRCxIHXOIr/2WPeeV6994iW+GngQ6QiXkuQJ3qIdM3mCIxaqlBslL34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738867582; c=relaxed/simple;
	bh=pzT4QF0kWNwyO041dX1IdeXux9AvDC80CLRnBOiGKeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I9swmZWHvAPcXBLbwUMBbf8qYvUN/2om1svFbEmMNjpWCQIN5VkPAUHP2dSWqkgm4tWKPVv1wCoWCcnlCqKwso/rtDR+nSWkbmtEUlJSPa9GQev/rLkAHOTNeDb0lC/OEDmaax/CKRudc+Cmyj6XqSsfsgxXaKqt6eexuWLrP+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m6S9Hahc; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6S9Hahc"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5dcc38c7c6bso2500244a12.1;
        Thu, 06 Feb 2025 10:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738867579; x=1739472379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pzT4QF0kWNwyO041dX1IdeXux9AvDC80CLRnBOiGKeY=;
        b=m6S9HahcXzcwc5eNHcN9ZRiH26Zb/L3WtXV/VQeLQp7V0J8lpoQwyiFgfcySqQf7lO
         gQ3wpSWamAWu7NOmTdEIMGmbGTGpqR4m5y5cp7dplVQDZEut3EcAJVWl9KvLeKEhpEdB
         Dk8t4JLp6RWiSiDcdR9tHHAACE+u+usBxN8JT071tq/tdn4dp84Oweh3u+Gd3lP6rT0G
         Ku5nKCRSt4tI/aIRrYHUwZdpCctgt/PfPy287SfYwCAMcS9FxP8O3z8vUoPoi3vLb7qA
         Dpjnj5+2xVUmxIW4K96uSpVHPb62zN4Hj36yBXBuCgfU+GfDQSkjL1pAxYpM88hUcGzw
         /sdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738867579; x=1739472379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pzT4QF0kWNwyO041dX1IdeXux9AvDC80CLRnBOiGKeY=;
        b=pR7u822hlhCmF5WIiOg7fWO26zF+tHotBJEvIqnt6NXyI887npsA41A6/iK/JOzhL1
         IoSE+kgq+gcVBiXh3nhCk6PoDaKlxCAKyN4+jymvAmXOtWlg36Wg2oYmUkjANarLAyi+
         bmFH/xgYbPqB3RQ5AeGblVkF2Tk9PVOs8ir+iH/r8AN7kAy+M2gy1fwpXphTNp/f53eM
         iKlnLEJrvs3G88YnGijTFxlw5JKY/7Ulc0h134jLiCEiDdjR4JuvnuzxiTPPE+yIfSew
         7HOhLFlcJ307GEzuEl6chH9+706mKH4+y/2k+hmAiKcUXc92o9hjRXCo/edD/9ECdR7U
         jtRQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2zKteoW5UmRkQgBJUvmtxJvDeykJ4zGTMNRqvVE5BqCqo7WauFrzDYznG8ZXAjmXNXe+yhQ0W+EqAxPA6@vger.kernel.org, AJvYcCXsQZpoyv1+ut0erhapgiNpP0EiNLQT07+K/lk+ldagwu57uMYdtgGwOo93VFW01nCfjHepatsMvnq4Yw5nvBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPLonGRZ4LMsrLUwa0oXhdBgd4gAJFDi0NVVK3OZmF3nmDv4pp
	pgBiKmV91ilB2LnX+6BG0ZL4KYnyzqMf9NI/xJfoi6ron5EZh+6Cck8Bd8GSh7NISOeceKGTfuy
	o6hY7/SngWZ/6AtjFKkrR26/zztnP3A59oBw=
X-Gm-Gg: ASbGncvYEue8CCGYPg/asg/tlBF44bPDl1Bz8eVPTSKYYD3yOp83M2h1KAxw/j63mFD
	ajhPM/szv3k6m/p4s4/Kqdf3v62PUEjyXf7TJ0sI0TvZmSij9u3OFJxrwfWLZXyiS6uzZRVLdJt
	Q=
X-Google-Smtp-Source: AGHT+IFiNmefUf+mNqYk0jECfFpnzTpcj9ZBe/kLveoBw90rH+JKaTDVwob+mi6XZxKrpQxmOV4tN/0GGrlH7k5lrQ0=
X-Received: by 2002:a17:907:9307:b0:ab7:8213:cdb with SMTP id
 a640c23a62f3a-ab789ad3a59mr1266766b.13.1738867578483; Thu, 06 Feb 2025
 10:46:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206175216.work.225-kees@kernel.org> <CAHp75Vf=84tWvv57Kj5A5bLenQSkC5yDHTHy-u0iK1_U87nvBw@mail.gmail.com>
 <CANiq72kGUOgP60SaEwiBcgsDJnjdvJZ1VJtyf3a_+sQJjiffng@mail.gmail.com>
In-Reply-To: <CANiq72kGUOgP60SaEwiBcgsDJnjdvJZ1VJtyf3a_+sQJjiffng@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 6 Feb 2025 20:45:41 +0200
X-Gm-Features: AWEUYZnl_v25JRZVZMfCXn4n6JYqfVfyix8wpGP-RASEega_qdLtImG5HYQd0VQ
Message-ID: <CAHp75Veo-C3A+XVr1RuFumoULWNOugN+CFE65d1T5o+TZSmw-g@mail.gmail.com>
Subject: Re: [PATCH 0/3] string.h: Use ARRAY_SIZE() for memtostr*()/strtomem*()
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Andy Shevchenko <andy@kernel.org>, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Philipp Reisner <philipp.reisner@linbit.com>, 
	Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 8:44=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Thu, Feb 6, 2025 at 7:42=E2=80=AFPM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > What's the minimum Clang version we build kernel with? 12?
>
> 13.0.1 for most architectures according to `scripts/min-tool-version.sh`.

Okay, does it mean 13 has no such a bug?
Otherwise the commit message and other comments might be clearer...

--=20
With Best Regards,
Andy Shevchenko
