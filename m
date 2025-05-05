Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B406D4C83
	for <linux-hardening@vger.kernel.org>; Mon,  5 May 2025 12:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746446774; cv=none; b=le6uUeUCH1n2T5IsBAS4YZE8G8bnkz6HgpzyaAuvMzP7KKtki2iEeX3U0qL6aTcnw2h0/OaHwuJqJUYDpftefjQ6nkw76MeovvlDiwz66kgz/gWIrwl0lg6iaaAkZ1kl6RAVVzwEPBvEzFdBphLQw7ax4ndtq9nSYjsWL9y4QrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746446774; c=relaxed/simple;
	bh=ZaJvxtjr/UbWDuYMsc++2AbU/9RuxaJOqfgbALnPUfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oJL/h33xn8u6KvktK7pre6eYPau3plPwoScYCZJpvIl1HIZBL0mU0tDii8R7EUzkSOZC/N0F1pJGsEoaAojAsdlBTOzsYZbwrMoSDaz4tbkt/Bb+lSnOJAmVGYjqjMU2dALbetxJ7LWM9b+V/DL4tNZ/kenAZfzcmbM3pnJ+Mbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=OkqqroQl; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="OkqqroQl"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4769aef457bso60123881cf.2
        for <linux-hardening@vger.kernel.org>; Mon, 05 May 2025 05:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1746446771; x=1747051571; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZaJvxtjr/UbWDuYMsc++2AbU/9RuxaJOqfgbALnPUfo=;
        b=OkqqroQl0x/jqrx7vKiSH+a4gYhrssvcXVeHU++Q9KmgH5YrnY9ocxud3BTo9JUZhX
         7/XIncJ08fZBJni0ImFstaWuEfFim2XwwmbegBkvSEgSaQA4AfaI2FYc6QzXQnF7FqN0
         TPulG4Ib11i8jhTrWJqSgEuro1Xo0/m+VWHQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746446771; x=1747051571;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZaJvxtjr/UbWDuYMsc++2AbU/9RuxaJOqfgbALnPUfo=;
        b=IQRZrf3D+dvH2NtLs6CG7jPKMQLIR+ep9gcnjTUGbssV9yx4zYGQdIBZnAoqbp3xe2
         N7ihb/tJ0ODpWfS8MDPBfikmpSYK6Z6d6HTx+7xxSzqupVNbUhQdM6FInhMZOSpwyowW
         BMSvM+9NHkQUjb4k4WXfZBwwBP/o4e8fhH7rslNIGtwxkj+5wToNPxediJCvw/HWuvrq
         OMjsUlaF4o/V4a6u8tskqn8nUmH1JbUkv08Qfcde+qBN0rRXGqln0cMV+/SAU9YlFAR2
         vypuoaMMcYvX4mLCLVEYRkVryORcG87EySSf1xjAlI8z0sW0wlBMiXnaFPSLMsTHQQ3z
         /xhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWj5ffCMZcyMeyPxiufiZKO4FiaW0KSGPiOVggMYc6pi90/mPYXCTJ8WbMGQoO5JAAuQaxV92DmyB7TcdDawTY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywuvedb4ygpFmMKqNLi+nY+hN7kGOQjIsBc1ogJ/OrjW6g2pF5A
	iTCuxkTK8rVFQPf/dLnJvZ0PES1Z72rp3RawVgcPua3PeLziMWhsirTI1EJPMhbTrIhnWZnEWTK
	D8si5GLS51eNGfJdNCz1y8nNdtraAoT0DfhBUWGj9UX5boQb4tW0=
X-Gm-Gg: ASbGncsV5jvY7NTWYkGtp/bcf6qpQ43so+L/HxdFxpa4LjN47RO2Jo1QBNyTcRP2HN8
	ScyDPxomulef4H3c/LAuyUrQZGz5Ns/RhHyE6j0sbbaXsK5W8mchn0DU1a5lCe48gAAnp2i7dO9
	Py9CIJ1qBA0r4ffDsp94tp1Lk=
X-Google-Smtp-Source: AGHT+IH8SI5HcYSna3MRmrF+Jzo/8BRtzzCRz170ITGYYplPbxtcX03EZBdhlPxtgELJAcnmmEBSdz/pDR9cUgg8qqs=
X-Received: by 2002:ac8:7f10:0:b0:476:8f9e:44af with SMTP id
 d75a77b69052e-48dfffb6db9mr101038081cf.29.1746446771515; Mon, 05 May 2025
 05:06:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250503132537.343082-1-thorsten.blum@linux.dev>
In-Reply-To: <20250503132537.343082-1-thorsten.blum@linux.dev>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 5 May 2025 14:06:00 +0200
X-Gm-Features: ATxdqUGxKxrETQJZQnYyYx85TEL6U7n-PHMB2aUuzi2Lu_9JVdkOGXYmRq99yto
Message-ID: <CAJfpegu9rjyUWy3920CgJagdJ14X9SrrCcs3P7TrQvYkUah9VA@mail.gmail.com>
Subject: Re: [PATCH] ovl: Annotate struct ovl_entry with __counted_by()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Amir Goldstein <amir73il@gmail.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 3 May 2025 at 15:26, Thorsten Blum <thorsten.blum@linux.dev> wrote:
>
> Add the __counted_by() compiler attribute to the flexible array member
> '__lowerstack' to improve access bounds-checking via CONFIG_UBSAN_BOUNDS
> and CONFIG_FORTIFY_SOURCE.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Applied, thanks.

Miklos
