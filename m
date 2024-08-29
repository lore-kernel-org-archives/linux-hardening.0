Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9991917C6
	for <linux-hardening@vger.kernel.org>; Thu, 29 Aug 2024 14:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724942187; cv=none; b=SdxmDccKphvFw9v0fsU1VISZFbZQVo+S5NOudnI1fDhQ35f2ig2vZ5UKF1YJrcZzk4FiydzaC/wfHJQAVii5gTBiD4DXaQAWVFbewCoIlJ69Z2YaOQLy7UYWmLG0Wl6MxeEEUaJltkAD3BUFVBarf81/odiPZmIGoPAFg0dg02w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724942187; c=relaxed/simple;
	bh=nulYTML2CQN3srodtgPbbRw5PaE2zNCVZgQPtBVymog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=oIpl4/3x9l2A9gedBSMWvnr0NtMH1PJvtHcMPN3MHMAUQoQ9lLlPa/ET768CxgjMbXOalutlQSL7wK9yAIMlkDyamD9T/GQ8N/yAJSCAdkLKshQJXi8TwRydgfJg1wiMd3F80gxGzV1u+RQlq69cmTnY3MCDNuHdVgAaFHgWFOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XwG9lJaq; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XwG9lJaq"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2705061b3fdso83064fac.2
        for <linux-hardening@vger.kernel.org>; Thu, 29 Aug 2024 07:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724942185; x=1725546985; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nulYTML2CQN3srodtgPbbRw5PaE2zNCVZgQPtBVymog=;
        b=XwG9lJaqRcr7jIRZ74oMj9ZhZcABWBvyhJNpHpVJiO6ICkd7FKlDllrF7mJKIrY/x3
         4GRcMKsdOsuPiTk85TBeaWquMVtbzjkNiBpxwP+ZBUKt3bay/ci8AnRG1NEdgB0ykbjI
         XyfzJPTXmedajXF3fOsZ3KUoBCyhh8sMQI6+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724942185; x=1725546985;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nulYTML2CQN3srodtgPbbRw5PaE2zNCVZgQPtBVymog=;
        b=QiOHsfJD+xP9Ld9Q7BJV4rOCxBa2rbT/DHYvMbhWCbPYM/gi8Rc7EIWW8MfhJqHAnc
         7U0qMyYsITq1el+Qft9fQuZCrsThO2U1WnIVVMMVEFrypBz4QD6ZdXlTUVgvoloj5vdv
         eAB9Xiki7UNdfT0ZbL+UZnV8u76TqvKki4xImtFlVmwVvgARK+RRztM1TcMLtQAjL2J+
         MqauuKzM0WeZGXuc+/7CoQnoLasVlp/s3DywslZ8lUTs0aPNtU4hLsiSrjmObOO6OmqB
         pE6f+DeoP9ljhsQu41j7o83WNZ6Hmn/gXyzGkOaPhgShQJs34zEPEUg+W7Qru6zpTxys
         TUnw==
X-Forwarded-Encrypted: i=1; AJvYcCW0IHElhGgn7MS4cAbOXJh/PbG+8d+i+Xy9GFq4DitoW+yNKyUQtrMVVOSaw+MpyeMjcq0SvSz+hz3OwSzJ7ds=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsLyiH/af5+Aw8vo8fWlABfxyq1hhM8Fg/e0doyGocu9B5fgcE
	KPdpUC5e0x6nzYdggSk051nLYbGuYGUc2BwNSFkkRCebZsUG816pcy14ZGXKASRgEgLutEPdiBQ
	bdsYPCHmet+q10EPxcgRhYGgAM5mqjxbTpmUU
X-Google-Smtp-Source: AGHT+IFIGinZlY9HQPgLeWEPBjUQ0cUjWD7+XFfmJV7NnhhPhUf59zXN8PcA7MV/PdklBJuNqmJs0Hf+c6WnPDFNyY4=
X-Received: by 2002:a05:6870:548a:b0:260:f1c4:2fdd with SMTP id
 586e51a60fabf-277903b9f7bmr1468497fac.10.1724942185340; Thu, 29 Aug 2024
 07:36:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828225522.684774-1-jeffxu@chromium.org> <jxov546uro5lffibw5asff3m25pfnondbp3nrqc3fde322h3on@ypkdkju4xaho>
 <vyllxuh5xbqmaoyl2mselebij5ox7cseekjcvl5gmzoxxwd2he@hxi4mpjanxzt>
In-Reply-To: <vyllxuh5xbqmaoyl2mselebij5ox7cseekjcvl5gmzoxxwd2he@hxi4mpjanxzt>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 29 Aug 2024 07:36:13 -0700
Message-ID: <CABi2SkXg3WBsDpTnYmG+Dj8m6-rSoL=FW8cBVrfvk=qwdMM4zw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] mseal: fix mmap(FIXED) error code.
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Pedro Falcato <pedro.falcato@gmail.com>, 
	jeffxu@chromium.org, akpm@linux-foundation.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, rientjes@google.com, keescook@chromium.org, 
	vbabka@suse.cz, lorenzo.stoakes@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 7:03=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> I will fix this in my series, thanks Jeff.
>
Sure.

-Jeff

> Regards,
> Liam
