Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4487D17BB07
	for <linux-hardening@vger.kernel.org>; Sun, 29 Sep 2024 15:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727624166; cv=none; b=O4AFfWgQV0vsNHoRMF16rTh3ZDx5MAIVFms5hu7V0zP2ESrquYXeoYjjHgodp/8XjmPll/9RnBUuq6BB5SRFEaLg21CsvuCtrlD2NcTRoNLtlIiZIxepqhN9jQAI006RvaMNPZE4R7siAg9OizGScDU01hRXndc1guJh28S5FO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727624166; c=relaxed/simple;
	bh=Z24+oNbwDBYDjUFeXrH3yiHjyPp8DkpOlh8f85DEeEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pL0ld46IDzQvStnU18O5U4f7UUzw4k6uxpigGinoTf2jguBv9ldqy0bh4YFvdDzGgjIUc/MKc4JeUPauinRdkiszNIeNkrmpW6aTGWOOD7YSEzoX64Sl14z4+IymoBD42zR8iwPkj0+Zk+LDez14ObJ3jqu0xxRxNoW4aWc4iEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fqo1V1hU; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fqo1V1hU"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7a843bef98so504953366b.2
        for <linux-hardening@vger.kernel.org>; Sun, 29 Sep 2024 08:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727624162; x=1728228962; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7aEO2yZHG3E/MlCpO8gpWwrr+WlYuH7Zy33FEPXBtWU=;
        b=fqo1V1hUfxbJqSzJxUGEcLRxrvSPEX5uFlgKrS3cSqCvu5f4rlHl8/Z7d03nIaLuGA
         +4HBtebXlB8YAAEI+3v43wq/kkxSYudsZVKH3KJ879EK67mDsTVcnCyLhLftb73fvtoA
         v+/fgneKnMGYeDHpWsxgEBqxN10oQRSIak+Y8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727624162; x=1728228962;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7aEO2yZHG3E/MlCpO8gpWwrr+WlYuH7Zy33FEPXBtWU=;
        b=rMx4XndYnobIjogwRlgGgCGg1Y8Ek35zLqz3v1cJgUMtoPqmc6Ot6PdEd0cns4g3B3
         Oyt7JJ/WHgwOmA6RJ2fuTq4tTux1TfvH+rMBZTmU1bPTWzN2r4n/ch0TQYbqeV1utH7k
         qqZvEGZ+nW15PS2L/M0rH0LvuJrSHFWeKNkf47ywHrgK5IQnSoVMpgA668tilS3rn8MV
         0Ne+1d9SJOLcEMUUC9XYzxni/e6iJGwdYkTnbqPaEVrl9rJ/TRjT1DoNHU9Np9bGc9bQ
         GQkUxPzQzcXU3YpJ8Gg+ZB7EWSjKtO3iaUGvdABFbtL5RS1ChBZUXhrzgXG+qHLC21BT
         oRAg==
X-Forwarded-Encrypted: i=1; AJvYcCVKx5OflhswfKfmOJ1AFBF5QXUhobvLYFXE5SM3VKHWPbMgqN/c8oL4F8SVn0MAMWinCd8mt0IRCrGOZW2Ay8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqjKQV0VepmlBTNfI0jMW65oMq6QS+j1z/ccGVJxyxxrr+O8W0
	n8YRG8egL7okYNn/bbhYFTDHWymrBFUrwi28oWYDHVTpbNSWLvWbEPSyOJNnKxJLWIvVEXRDx3t
	8Uvg=
X-Google-Smtp-Source: AGHT+IGzyjMNO470Lx5U8zx5UW8pv8co3Hn1patvoFZcVr/QlmOYwQNP3f/19mWAXfo8M6pIiJQEJw==
X-Received: by 2002:a17:907:3f03:b0:a8d:5288:f48d with SMTP id a640c23a62f3a-a93c492d701mr1131110466b.32.1727624162323;
        Sun, 29 Sep 2024 08:36:02 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27c5b52sm390716066b.53.2024.09.29.08.36.01
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Sep 2024 08:36:01 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a8a7cdfdd80so578644566b.0
        for <linux-hardening@vger.kernel.org>; Sun, 29 Sep 2024 08:36:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVZ5r1kY/G+zCwQUV66iYPHc/Zx00XWbb1LX12y3EdbYQGxCXpZG8PxfuBiy4e1hks+J2Ao9183Axot2E8TeAE=@vger.kernel.org
X-Received: by 2002:a17:907:8692:b0:a8d:44a5:1c2f with SMTP id
 a640c23a62f3a-a93c48f089bmr904801366b.6.1727624160624; Sun, 29 Sep 2024
 08:36:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240928-fix-randstruct-modversions-kconfig-warning-v1-1-27d3edc8571e@kernel.org>
In-Reply-To: <20240928-fix-randstruct-modversions-kconfig-warning-v1-1-27d3edc8571e@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 29 Sep 2024 08:35:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgdQ5TjbXX0D568GZebYnt5ZuhTW5-ffeim-aoyT9LnbA@mail.gmail.com>
Message-ID: <CAHk-=wgdQ5TjbXX0D568GZebYnt5ZuhTW5-ffeim-aoyT9LnbA@mail.gmail.com>
Subject: Re: [PATCH] hardening: Adjust dependencies in selection of MODVERSIONS
To: Nathan Chancellor <nathan@kernel.org>
Cc: Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Sat, 28 Sept 2024 at 11:13, Nathan Chancellor <nathan@kernel.org> wrote:
>
> MODVERSIONS recently grew a dependency on !COMPILE_TEST so that Rust
> could be more easily tested. However, this introduces a Kconfig warning
> when building allmodconfig with a clang version that supports RANDSTRUCT
> natively because RANDSTRUCT_FULL and RANDSTRUCT_PERFORMANCE select
> MODVERSIONS when MODULES is enabled, bypassing the !COMPILE_TEST
> dependency:

Argh. I should have checked, but I didn't think anybody would 'select'
MODVERSIONS.

That's such an odd thing to do in general, but I guess for RANDSTRUCT
it actually makes sense (since a plain version check is nonsensical).

Now that 'select' statement is truly crazy and another level of odd
duck, but I guess it still makes perfect sense ("give me the build
coverage, but this is never going to be run, so don't bother with
MODVERSIONS").

So Ack on the patch. And now I did check that there doesn't seem to be
anything else with odd MODVERSIONS Kconfig rules.

            Linus
