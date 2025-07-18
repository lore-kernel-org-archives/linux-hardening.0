Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E285A1C862D
	for <linux-hardening@vger.kernel.org>; Fri, 18 Jul 2025 21:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752875585; cv=none; b=Ad8J0nEjoeCOpzM4hHGb6qzT3w6tdFIpiiRxP5xq0k+kMtZnewAcaPFZYiPkoxkCnsejC+M3B7iKrMoMIYELKCAdmUsQXB4V3s9IVsDhiVoIK0bsdNjifWV5SzLwVLk2iPGwX3eX7QbzUVsqT6gvf1sHuiyxpHEt/93bK1RPBAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752875585; c=relaxed/simple;
	bh=m/GVkH7kFga5E6DvDF13ZQV8++8dXVqa9LQzwKfgKw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AWemEWZ4MaVnXbS8Rgms2+/Hw2OwFMn9p+hckqAhhD696bunYYxF95J9DpgE8J5VydqxF7q2rQyMZKY0bJx1ikcYr0GSvaJ0q7M9dPnE1WGVIlhO/L+qYpp6dJk8V6o4ZkTBcFpisAp8EERQvZ4ljZ7nXdZ8KXJtufBO1Z/pZpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Q5B6q4uu; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Q5B6q4uu"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e8bd2eae9e0so2077540276.1
        for <linux-hardening@vger.kernel.org>; Fri, 18 Jul 2025 14:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1752875582; x=1753480382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/cQbSOC5kbaML7lIX5aEU6S9YhJ0RymQUswAa6phlM=;
        b=Q5B6q4uudbJ1JW9aniixTUzBJSecTybb7pbWTUnzgrt9vcKXpzTtXu7aAOvYvcaVC2
         5m8jY65KSVjtF7tBQckcFl1qQ9SmPMw73eY4rUN0yOqUQj1DQbX3+LipS3VpN/pwmRxH
         yfVT43TP79sWpavdCtosj9F4Ij6Q5nlZbhpk+H19mKPnyRShjkd1fXn521eKh5iuoyD0
         skxSibpuLhWGEIUccMiwS8XJAf8YCsWOz1hpVcqml6xZjNo5jHjDiUgLDtdbkJYxMCz9
         ZftlZOwFqGA8qfadd6QYXrPgcVF6mslscgHlG5sJNPsoV0f20A0ewpogj9ATkF3bZG/s
         F3ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752875582; x=1753480382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F/cQbSOC5kbaML7lIX5aEU6S9YhJ0RymQUswAa6phlM=;
        b=psdBJMoZMw5dgMyO19ppK6ctS9v5ghQyGZUaj29kSlUoH4bf3DPfHNxBXfb+wC2hve
         I15n5/a8pXFGVrrfC53BIRyWclDHloUfxGvorm6Z8kmMHsMADVVsUnvo1tgkqPUQK1mN
         nMzw1coZHgTk4FXaUqDOgB1qZnPqpglz18LFJIWMuSA5/BJHFKBlUWYRrE63+CK8cc7m
         E61HM5Tso8jz2UgVHnBnYMqNpry7F36EXOU3iANyiypyf2tdepT1WlandAnBUrcSFa1l
         ovK3f1mA4NbSvuOFwPOVrT9KW/pXR9W0JX7tQ/XNZNhR2NgcI7bQrhxd4BHPaL4HC5bN
         c7UQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPBBgmFQ5hGQeV64hblWnZCXNsscWetRYSMbf3kBa/C5s5RjClqzB9qRIb8pl6+Dw1wLJn4r3PKRy4C3CuSsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTJbWlUqhLKHw9J4dQtSn2Z1wK5PKX4s8E6BDPEv1vdC44Vpzc
	fmmvAbOjHnJFU0S/K2h8BhQa3k2Pah9tAlqkbYX+mxfkyd7+s0PlCACEWYJjHwXoU0VRH82T3lK
	XJbdsq7j3b4MnlrkcvpYyw029V8+S2jIxccysudP8Z0zexHGBJ+8=
X-Gm-Gg: ASbGncu8k0tsxCWaTjDnWduILlpnDpkufvcxOlpEY+mJt/Tf3AP9GuexzUUWzV9T8ou
	2h23oZUqKi5JQOIfBMAUnx5GzaOYPnR3cdHHxeOjevt66NJ5aRaOfKDdZAYwVo9qkAud2RfG5Cb
	jWtFGDeS+r6cp/S20RUz/j7cEemwJCFY2P2IBlMhInuwFvkjFO0eep8V4XYsTvooo3tUaYLmWmy
	0WO+dY=
X-Google-Smtp-Source: AGHT+IFf5bnxZbREvMvlsbfizsYWDzhgcbPnRrN1Pv/fcSWvOqeCSaHZjLEK4HTUY1AY4fj8c+1pm2RjoePlp3shqXo=
X-Received: by 2002:a05:6902:e08:b0:e8c:93d4:b0ae with SMTP id
 3f1490d57ef6-e8c93d4b42amr10116844276.21.1752875581835; Fri, 18 Jul 2025
 14:53:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718203734.347091-2-thorsten.blum@linux.dev>
In-Reply-To: <20250718203734.347091-2-thorsten.blum@linux.dev>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 18 Jul 2025 17:52:50 -0400
X-Gm-Features: Ac12FXzCPEr9FkZrYDFFpVvOY_IL3QCEVZrKQZHLJkmmAUMqwWFbcM7dIijU3Ck
Message-ID: <CAHC9VhSa_9cWiLfOUNiLPUa7PyECF-2hqzHZikYHj6QeYGMqEw@mail.gmail.com>
Subject: Re: [PATCH] audit: Replace deprecated strcpy() with strscpy()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Eric Paris <eparis@redhat.com>, linux-hardening@vger.kernel.org, 
	audit@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 4:38=E2=80=AFPM Thorsten Blum <thorsten.blum@linux.=
dev> wrote:
>
> strcpy() is deprecated; use strscpy() instead.
>
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  kernel/audit_tree.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

This looks fine to me, but as we are at -rc6 I'm going to hold off on
merging this until after the upcoming merge window.

--=20
paul-moore.com
