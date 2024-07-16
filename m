Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0187819E7CF
	for <linux-hardening@vger.kernel.org>; Tue, 16 Jul 2024 14:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721140761; cv=none; b=sPN0ejnMQcehTYH2t1tXoWdw+2QmdTTCkssYpokTdEyP/rdD7I6RTlv8RlivfbirWGMkxLSvFjLQNboyMntNYeJeedgwb7Am5WXN3qCUuMyQ6kxqBM6FNpbsaWHk7QC+xL0XUMcpJ+ab97DVDvDKMrtHzNqX0XP3ej+7lJE659c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721140761; c=relaxed/simple;
	bh=MzRRUxdfl+9rUlnOGhrWT+i9Ba4CWdrZlHh7nGDZNM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nC16CcAc0LQzQ2EOIJHgtnJL8ON03DgpU5L+idZN3s/6Bla0oYbRJ85JpIHoB3gn8JHAGadslsEEa1SmcDSFepFOGO7YJgwL2ePvkHjuynj1miq6iU6DVMp5XtbBxldxKqpfU3IXsn6saQHmgFifkcu9zn5saZ57GPigysMcGHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D/0OYFnv; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D/0OYFnv"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso19758a12.0
        for <linux-hardening@vger.kernel.org>; Tue, 16 Jul 2024 07:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721140758; x=1721745558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dT5FLWbWUPfMqjFRBjpee8/HikhM3a2iAoNdQQA++MI=;
        b=D/0OYFnv7Z9RyQAEiH18j9jR2WOVYkZs3jLCRwMcCznGWHjkIZWrl4Ww84motaFZv+
         JYC/ehGqe4gEP0PzjGzJap1X5Wd3iOlyaEFqe5eLa0/SDYJj6hAMHgW+FmrU0o+WMaoj
         nR87V4yDV4L1LBnqLynsuwwUwfxotKvqrZXkwJDYHB61iQkpn7/dFTYNbhvWuj26YDd4
         vQHd6OTIvBQjdKrDdHXh9nmslEY/kbdvkPDwvP9YJyCIjk16Mqyd2DWQe/6kbsTJpaxr
         AM5D+h/ASI3R8Cy8bBB/yQeBWZT+VMcVHT43UAG+cF/+AgcL0QpzyTVukqbAuuUIiGDK
         cpwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721140758; x=1721745558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dT5FLWbWUPfMqjFRBjpee8/HikhM3a2iAoNdQQA++MI=;
        b=PuAXAwzRzwyfcm1uvuWtL7t4su0W+sokw169j0KmPo54qD0706K1gVlqEUQ48Ax6aT
         QYazdsBzh/ZwMg3Xk3MB8PODhMvSK7ftqDg81frqO14Tl/T50pO8fMw8KecsRbynPYI3
         5DjMgN7ySyVyx8Q3dD2YT2T9ZL0fpwsjjDEZGy/EwsNL7ZtL+yHC/SQxuvsg8jm8I1zl
         Fyjadvjx9G49YwDFOjGb6bHxn4ZziwVSlFf0W37ws22QvdPWz3hqbRF05e73Hr2jGA4e
         iJisSyQ84Fx1JdvTdvBikUSGtE45B8sJG+l5VFPbsfrg+o9xlcwVimJeLeeM5EmEbCHn
         0QOA==
X-Forwarded-Encrypted: i=1; AJvYcCXjlFh9WUnW7p+3RSz2zs6wij0cIlKsbP4DzthH8f9byQEq7/bU53RKPvQ5po7wvWapSCcJsj5gwlTmgpthCWYQC1eDpPu3QjEF0Pxa927Z
X-Gm-Message-State: AOJu0YyNfvocb4W9Ou7QLApgy1/3Q4nlB4Lz6dGuR6ParO5Af6VHJI7H
	WqfZyVTcul+iwuTJWqaVWYcp/+9wC96lz5RncAUFMwwBHJqqfNqT7WGEZ2jjPtsLFzrzRDaz946
	5lXePatCA3YoZpOkxXdHxHNAqO/F+xKeiZTPq
X-Google-Smtp-Source: AGHT+IGmSsybD0lwtju0owF8AM0wm2lcQbvYRwn3K5A2uMn2kfbPepm0PCfZm5tU5+Hu3yXbRdLVB8GSziRa18AlELU=
X-Received: by 2002:a05:6402:5106:b0:58b:90c6:c59e with SMTP id
 4fb4d7f45d1cf-59eed87975dmr285403a12.7.1721140758063; Tue, 16 Jul 2024
 07:39:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240714041111.it.918-kees@kernel.org> <20240715094107.GM8432@kernel.org>
 <6d1a441d-31f9-4bc3-8856-be18620e4401@redhat.com>
In-Reply-To: <6d1a441d-31f9-4bc3-8856-be18620e4401@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 16 Jul 2024 07:39:05 -0700
Message-ID: <CANn89i+iRU_GcRg9XUsAzahtGr5vKshJqyw02J63U_rChaCQjQ@mail.gmail.com>
Subject: Re: [PATCH v2] net/ipv4/tcp_cong: Replace strncpy() with strscpy()
To: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kees Cook <kees@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 4:32=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 7/15/24 11:41, Simon Horman wrote:
> > On Sat, Jul 13, 2024 at 09:11:15PM -0700, Kees Cook wrote:
> >> Replace the deprecated[1] uses of strncpy() in tcp_ca_get_name_by_key(=
)
> >> and tcp_get_default_congestion_control(). The callers use the results =
as
> >> standard C strings (via nla_put_string() and proc handlers respectivel=
y),
> >> so trailing padding is not needed.
> >>
> >> Since passing the destination buffer arguments decays it to a pointer,
> >> the size can't be trivially determined by the compiler. ca->name is
> >> the same length in both cases, so strscpy() won't fail (when ca->name
> >> is NUL-terminated). Include the length explicitly instead of using the
> >> 2-argument strscpy().
> >>
> >> Link: https://github.com/KSPP/linux/issues/90 [1]
> >> Signed-off-by: Kees Cook <kees@kernel.org>
> >
> > nit: Looking at git history, the subject prefix should probably be 'tcp=
'.
> >       And it would be best to explicitly target the patch against net-n=
ext.
> >
> >       Subject: [PATCH net-next v2] tcp: ...
> >
> > That notwithstanding, this looks good to me.
> >
> > Reviewed-by: Simon Horman <horms@kernel.org>
>
> @Eric: I can fix the prefix when applying the patch. Please LMK if you
> prefer otherwise.

Sure thing, thanks for taking care of this Paolo, Simon, and Kees.

Reviewed-by: Eric Dumazet <edumazet@google.com>
