Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0955821B
	for <linux-hardening@vger.kernel.org>; Fri, 19 Jan 2024 22:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705701636; cv=none; b=k90vT00Vqfd7eX/r9TR/MZydDfxUp2Z96gwGCdQFegIEgjvbf5gvMsGV/ObOqalSPYhjgFDI3HRD30Lgod5DHVSECxXuPsRAhKWIvZFx/3HecG+lVQR5zW840GATHkrcIIKtHuvxrzSPNOuiLj+bDmTH85Sf4Xm3OQC3XljPEp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705701636; c=relaxed/simple;
	bh=Xqh2spPXg/36Nd5acHIcaHi1wPMckOnZCFfqASQrpgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Us0Uzd1wShPZu3JDgXi6YPupWj+PyaUMVg+GA8Atx/zQawy9zEENB9HIKTNZQACSkU6hbOaoQzvswD+8daUq4sLRllx7p/7H4F+w61W9emgBE5+TunK9WEp2uSjlWSMzPv/w9SKrC8/kBzG4Kw9fIh3/fNzoLREvc+VNMWy42mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FXP9BOi8; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FXP9BOi8"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55817a12ad8so1477268a12.2
        for <linux-hardening@vger.kernel.org>; Fri, 19 Jan 2024 14:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705701632; x=1706306432; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/xlofjQtofHXFjo9khK5kC3pChLQbc+i5Psd0zeHygA=;
        b=FXP9BOi8lJxESl4aQoNDvBYdmNGftf8GHq4kmSUcVujGGSTLWLwMpmE2CcGvpgInhR
         8u014PV3juo9tNlK+V3DJ9BBPYTuvgwxBExSnRIZbiuLYh/yrU1teZ6KGJepiNrZUVW6
         EakghN4Rv4jwso9qObAvoFX4pF7R9H+87Ld/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705701632; x=1706306432;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/xlofjQtofHXFjo9khK5kC3pChLQbc+i5Psd0zeHygA=;
        b=feEMQYA7xuMO2o5UtOitcQ/mVZPB+gTrPBf9iIITlwMJX1BXc9K41pohhhbld6vEOv
         9Ckd2bhmxcQG4uFUov3bzDknmAiMNxJThwjWYAkMNgsKoNfZm3tb4NDJjNSPsVD8bbEx
         XPmiMOZQO9imdPG2oVm4+9d/lhtvkuRxh6FSZcsfOLYXwHkp8eqWkt+v00Ze/hqYF0Bs
         conkcoFNiUAHCif/HYcTed8muBdIAxiI6GskJkXvrcIPspNr34gE6Pky/INMlyw/1gkS
         muH7hUemiIumCqK92KZkHP8xOAwtDbV7gesCV/1sYKch+aVqxP4CpHZQLhslrGKokkK2
         Cxag==
X-Gm-Message-State: AOJu0Yx2NpLT41A3m+9MlEIewVVKvezkR0H9ZnkUy92ReO9xPD4uE9pU
	okSDnxzNaYEyGewJ0lk/MKhOwUu94tF8PiDKYfqvgSBaWZ08Ow3Fpzt9rI5JlS9neJywh7TuDYn
	8gNjO2g==
X-Google-Smtp-Source: AGHT+IGZiufp/Xk9/2Ev22o/BNKf55rrxLN+D90ofdlt69PU6H6J/S8aaEqAemacWdZsxpfG7721Lw==
X-Received: by 2002:a17:907:c082:b0:a29:905d:447b with SMTP id st2-20020a170907c08200b00a29905d447bmr276672ejc.96.1705701632713;
        Fri, 19 Jan 2024 14:00:32 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id w19-20020a17090652d300b00a2b091e93aesm10707755ejn.115.2024.01.19.14.00.31
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jan 2024 14:00:31 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55790581457so1578756a12.3
        for <linux-hardening@vger.kernel.org>; Fri, 19 Jan 2024 14:00:31 -0800 (PST)
X-Received: by 2002:a05:6402:28a2:b0:55a:590f:3464 with SMTP id
 eg34-20020a05640228a200b0055a590f3464mr186462edb.3.1705701630814; Fri, 19 Jan
 2024 14:00:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202401191311.B6AA79D@keescook>
In-Reply-To: <202401191311.B6AA79D@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 19 Jan 2024 14:00:14 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj0j07B=n1Bt4EkDJpN5CBmxMuZhv+nnFdi0DxDVSiZAA@mail.gmail.com>
Message-ID: <CAHk-=wj0j07B=n1Bt4EkDJpN5CBmxMuZhv+nnFdi0DxDVSiZAA@mail.gmail.com>
Subject: Re: [GIT PULL] strlcpy removal for v6.8-rc1
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Shevchenko <andy.shevchenko@gmail.com>, Andy Whitcroft <apw@canonical.com>, 
	Azeem Shaikh <azeemshaikh38@gmail.com>, Brian Foster <bfoster@redhat.com>, 
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Joe Perches <joe@perches.com>, 
	Kent Overstreet <kent.overstreet@linux.dev>, linux-bcachefs@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Lukas Bulwahn <lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 19 Jan 2024 at 13:14, Kees Cook <keescook@chromium.org> wrote:
>
> The kernel is now free of the strlcpy() API!

.. still mentioned in docs and checkpatch. Maybe remove that too?

              Linus
