Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E744EEB3
	for <linux-hardening@vger.kernel.org>; Wed, 21 Feb 2024 20:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708547749; cv=none; b=jaGJ9NNFR7w7bKDnk4ZcCMNz6EPeOqwue5ZQlPbytNVvYogIzvyHRwQQDZyBZxCq84XHWUVVTFG9YCLSkxs+/9QdAejOYPi0lor161yiEMZ+KDtXlUjhL7lkef8zkOIkpm6JOXrsK+aaVBYmbmHNcWg7MOluNlDYKsuQGBT0MaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708547749; c=relaxed/simple;
	bh=GFhPlma8ElxwHflsLYpQTVGFiMO4B/Q3z9xrY8lb7y0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SVLMNB4dDkq9bIokapPHfj0SkHe5usqe7w3SiKI77XOfykOWViWOXuqgmwuvHT/B1H7skAWQEqmrj7HIkf5w5UYkX6TgPyDw7hWqA9CcO0Fhv3B9ZGaslFs7qGVMJVQAC9xm55p5qCMt6JnudNIUZ9JHJZgE7JcqjMwtuxwbu1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d5uw1dHu; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d5uw1dHu"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3650be5157fso1055ab.0
        for <linux-hardening@vger.kernel.org>; Wed, 21 Feb 2024 12:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708547747; x=1709152547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8iAiTEgCppjIE3t1disnBeWTtqYJCr/gkvmRX972lsA=;
        b=d5uw1dHuK1vX4b8apainJ4nKwcBdnNQEmSalL8+/88S0VB1C9tC0JvhsucSmAHFsee
         guG+U7bdWgrLE7bFXOPGAMPkQ+St9rSZJziPaNv4YhUuga5oXV02F1bVvT67qobgR+LF
         WRkFz1qk5wuJO2zOcRMkhIJpKaZiJxypZ6vEf4oQikJw/8irf9r5fRTubG1SPcD95kL6
         BzPkL2/l9h/0P/Eu2DDwhd+KDYWw3oGBoEAqay594E6Dau+G1Y8c57EvbU5TWRgwnMzg
         KDVXbfKTPnYRrWXdc5rXnc+HKaabB5QIkRLxLlOhb93M3d5BFJQ4WDNmMiCCwUZcauCA
         uMlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708547747; x=1709152547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8iAiTEgCppjIE3t1disnBeWTtqYJCr/gkvmRX972lsA=;
        b=U5lV9b4VdobgTZdCjrHrewFTP7Jxuulq+58vYx+BvbgaFG3HACmXLbHP7PKaWb0CAy
         ROdUn0xY0wvgzIBAnzXQ6s7aQWYv+L6iQleFlYvVf3kWwX9qIs4GMbVpHYgOKuk1kge+
         Cpg1ewU5ZRzL81ujJgRUm+J+2GAReysv3ja2Grrg6APgFLg0yRaf/n9JlQ1ofHnip1ei
         scQoNxg5hd3kHUPH0bDmvC4rLedyvf32t6Fb4NkBwOXF6VtnoS+ktErG1xq1GlD1kycX
         tsujDF0vviUtLizmXKLnGLuuhSC7rhLb/UMhQb3z5x2RNiYUV+EeQup4b4fB6NX01Jtm
         9SeA==
X-Forwarded-Encrypted: i=1; AJvYcCXqq+y2N/4V6lYiQg/SrNNBUr6V5BwemQ0bLNuzKQ7M3sn2xf1+5UwzzFk0sOM3pwv6QvvXxC6uvQU7/WOPvpu7lEnDX3QhM5JBqdedbAzY
X-Gm-Message-State: AOJu0Yz3yWInEI2QJUkL0SQnRI0NNJ6nQPFLnJFvwql3iYueEbo0iPbU
	XpfibnRDBnm9N9+bw8+o0K+J9B77UaWWWty8SqqWAUHc1sRgRWfAB6qmyYqe8EF1h8Jp3R1llCs
	dbX9vjjV3Tsww13cP4gft0eG0W7qU4gDOvaKPUmlu+oaijR2a6Q==
X-Google-Smtp-Source: AGHT+IHkUH8682wBjX2MlXCiKDKRKTZ78A7IDkSZwKh62FAeHimOB2zWqCHjoUmuvZXD72aiFX0+O0WGwp10g7NziwQ=
X-Received: by 2002:ac8:4907:0:b0:42e:660:eb8d with SMTP id
 e7-20020ac84907000000b0042e0660eb8dmr285459qtq.5.1708547393077; Wed, 21 Feb
 2024 12:29:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221092728.1281499-1-davidgow@google.com> <20240221092728.1281499-2-davidgow@google.com>
In-Reply-To: <20240221092728.1281499-2-davidgow@google.com>
From: Daniel Latypov <dlatypov@google.com>
Date: Wed, 21 Feb 2024 12:29:38 -0800
Message-ID: <CAGS_qxpyNVqigHB+kS-1xqzR4BAOQXoMSNS+d5khkLYrkpmOgA@mail.gmail.com>
Subject: Re: [PATCH 1/9] kunit: test: Log the correct filter string in executor_test
To: David Gow <davidgow@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Guenter Roeck <linux@roeck-us.net>, Rae Moar <rmoar@google.com>, 
	Matthew Auld <matthew.auld@intel.com>, 
	Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Kees Cook <keescook@chromium.org>, =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Matthew Brost <matthew.brost@intel.com>, 
	Willem de Bruijn <willemb@google.com>, Florian Westphal <fw@strlen.de>, Cassio Neri <cassio.neri@gmail.com>, 
	Javier Martinez Canillas <javierm@redhat.com>, Arthur Grillo <arthur.grillo@usp.br>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Stephen Boyd <sboyd@kernel.org>, 
	David Airlie <airlied@gmail.com>, Maxime Ripard <mripard@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org, 
	linux-rtc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-hardening@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 1:28=E2=80=AFAM David Gow <davidgow@google.com> wro=
te:
>
> KUnit's executor_test logs the filter string in KUNIT_ASSERT_EQ_MSG(),
> but passed a random character from the filter, rather than the whole
> string.

Note: it's worse than that, afaict.

It's printing from a random bit of memory.
I was curious about this, so I found under UML, the string I got was
always "efault)" if I make it fail for j=3D0.

>
> This was found by annotating KUNIT_ASSERT_EQ_MSG() to let gcc validate
> the format string.
>
> Fixes: 76066f93f1df ("kunit: add tests for filtering attributes")
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Daniel Latypov <dlatypov@google.com>

> ---
>  lib/kunit/executor_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
> index 22d4ee86dbed..3f7f967e3688 100644
> --- a/lib/kunit/executor_test.c
> +++ b/lib/kunit/executor_test.c
> @@ -129,7 +129,7 @@ static void parse_filter_attr_test(struct kunit *test=
)
>                         GFP_KERNEL);
>         for (j =3D 0; j < filter_count; j++) {
>                 parsed_filters[j] =3D kunit_next_attr_filter(&filter, &er=
r);
> -               KUNIT_ASSERT_EQ_MSG(test, err, 0, "failed to parse filter=
 '%s'", filters[j]);
> +               KUNIT_ASSERT_EQ_MSG(test, err, 0, "failed to parse filter=
 from '%s'", filters);

note: if there is a v2, it might be nice to include `j` in the message.
