Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E645241667
	for <linux-hardening@vger.kernel.org>; Tue,  5 Aug 2025 19:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754423866; cv=none; b=kF2DlTphEqQRWEKSLOvSU2w4/vzN7H8bIT0G6w/4arqTM8lX7GD90CEy1mXDPJbLFIeI0hHXIUuJTiIpN/HM6j+mrxmch9lcpEaGOmmDxZ5jBgZ986XdiS6jYQiEmGjmn3yYFeg0/Cer2a9yPPESxMHh0TgY/QKi7cZuiSg7gC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754423866; c=relaxed/simple;
	bh=bC+zFzhWtUviZ0EXWS2t+T+yocqJQ0MUviaN2AZtakU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dUFqceIFh48RZ4XvBkQIi0a4sRaZSYoqJcB9aN7QBYsCrV/ChQZ5GySHhPikaNzihm8eWv2ny7bgFZ8GVB23j5Sq4Pdh8NPEoji5WHgPxAIuMszspqfeb2jphclNFBlWhzBVC4B45gs3uvxPSK/4YBpLYq7a7GoZMN54vhcO9cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dtyU/vD6; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dtyU/vD6"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-31efefd2655so202921a91.0
        for <linux-hardening@vger.kernel.org>; Tue, 05 Aug 2025 12:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1754423864; x=1755028664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MsxTPw5w3dvOw6Du0TNqYhfP8nKYvG4y7TuULGIfs2w=;
        b=dtyU/vD6+eUz45Iyhye/qTCtmvMAoYhAC7zSJ0HlBeLv4YQ9+UaRn7FwQF5iW3pRYo
         m5v8aNBBbf6Xq64Z8L+Tj7lxKh/R2L1ZsHb7GAEouqxLuAtAzrspBYseiteczUHqlFly
         t8+Itvu7oT3b9sJDJMkMtb5Mup7NL5fcqAxMW3fFx8u56gpg7wyfCO8IWkru0rQliSM5
         5X2GFA8zN9qovslm/EAKJMezGdw8skGJte8nMzVXoIrs3VVdXNY1+9stwGHtvkHo0Mwh
         FByMGHDGTe11MpNxk83DqvoQjxFpu0Z918wXVrVdZtFBFO/XthIkANdrsaRPxQdxd32L
         NZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754423864; x=1755028664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MsxTPw5w3dvOw6Du0TNqYhfP8nKYvG4y7TuULGIfs2w=;
        b=ii+FbYcpIv15sbqKoPUU4tmf+wBmg5Rxkbnn9hN+FdscNqxY1dlARes51H941s+YJA
         gB1tKJDQE5eYWxB8q1U3A0YdTPutIm76N/KPlUp0yLgWIwToWdnZ0lCUUzKBmwbmVKYy
         LNHOqRJIGhYnFmjvb4Tw86EvvIA2lrH38GS6IKwAB09bCYyThZWqB0F4rq+yPzdMILox
         DO1ugvQmrI8RPhV38/szdgYtLl+pbyEkzqpBm4zgH41JXoejox8w1Fm6v5ga82pEi44r
         5TRA1XLB9u5Esz7vF/5/iHrM7y/vlCNQ89Qq5f+ka0UZO6TqnNem4B6rS3WJF4nzvErH
         58zg==
X-Forwarded-Encrypted: i=1; AJvYcCWXlvy6nWHD7w1JgQxOFApN8r100BmN66xws9huK0iqvVEj4rWWMR9L4j8KwPlgqaBVZ7G6NIKB/JnAIPj+FZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUC1pTm4oo5QoRB2bnB7A7xSYc5r/egbFo49RCHi52H9wnktBK
	cbeb0ag6XXT/UCp2rCjLEP7LP2s6cLXpS7XJ2PnXL/ZivoEKvTn80BPAkYxM2JLhL8Th3NlDmsC
	+6J2/LGbzp9ZVoX6VsTbT+lzqoasMlZhJ1lUL4EPP
X-Gm-Gg: ASbGncvXrqm09XcrlgK66W5efSRTC11QHhNffBrWp00CHDIImXzyF+VgmdKjaRuW8Tj
	VLM1hi6i6y4ZXB5KTbdxtepI8dOakxpquN1zxnZtoMNc8QY8tJEn79+NIj59jdmQsq6vl2z9K8a
	W8slP8qWXt7XUBydh4BKwyoaGFojRfbZzKE8Id1aU217ozh2Zzjq96sLWov0JpCYAwHJQW7n+QV
	01eaxs=
X-Google-Smtp-Source: AGHT+IHKu8z9XhICdXETPTLsS+z0RRZ62+RDpW21sm8v0pPvwaiLLnpAF+0jPbMODlNzNNx8b8mybw2geegLclSoToQ=
X-Received: by 2002:a17:90b:53c3:b0:315:9624:37db with SMTP id
 98e67ed59e1d1-32166853c96mr228245a91.3.1754423864335; Tue, 05 Aug 2025
 12:57:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718203734.347091-2-thorsten.blum@linux.dev> <CAHC9VhSa_9cWiLfOUNiLPUa7PyECF-2hqzHZikYHj6QeYGMqEw@mail.gmail.com>
In-Reply-To: <CAHC9VhSa_9cWiLfOUNiLPUa7PyECF-2hqzHZikYHj6QeYGMqEw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 5 Aug 2025 15:57:31 -0400
X-Gm-Features: Ac12FXxf9GFYvD_gIJTvIFf5uHVEOE2KFf8JM43Ns-i9kOgsOlIelGwqX7VSTXc
Message-ID: <CAHC9VhS87wfk9j9_yzUNP-NaKOBL-YctvBLx_O4OQS2WVQ-OCw@mail.gmail.com>
Subject: Re: [PATCH] audit: Replace deprecated strcpy() with strscpy()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Eric Paris <eparis@redhat.com>, linux-hardening@vger.kernel.org, 
	audit@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 5:52=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Fri, Jul 18, 2025 at 4:38=E2=80=AFPM Thorsten Blum <thorsten.blum@linu=
x.dev> wrote:
> >
> > strcpy() is deprecated; use strscpy() instead.
> >
> > Link: https://github.com/KSPP/linux/issues/88
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > ---
> >  kernel/audit_tree.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
>
> This looks fine to me, but as we are at -rc6 I'm going to hold off on
> merging this until after the upcoming merge window.

Merged into audit/dev-staging for testing, audit/dev will happen after
merge window closes.

--=20
paul-moore.com
