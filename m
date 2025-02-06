Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0524D225405;
	Thu,  6 Feb 2025 07:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738828174; cv=none; b=ACcyYRE2N6fle5qNE87uSDYYOz2KDy4xsrzukX8tvzmoLq9hHj2iwd3FSGbO0+tvmGNoAuKtYVzd/VWZqbXkrYlKedw3VHUZqNBVJ09m5gUVLU8SwYjXRRaWS9vkzmFDX5VIZ4KIGsBQRYThqRKfPnNhSt9Mu5V4gWSVi5ij7SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738828174; c=relaxed/simple;
	bh=qrMxMIwkr3ywIhv2fnN93fwzAkRWORuisQKsfhPTLRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=saSj3wVZmeXGktSLEy8g27VfQMf45ZkwUzWmlYf8/bU0EAkeXYom70Akc4gisP/13ULByT4kolOh7WhkxLIREaFPKqlJH3dFao+fBxMLYNHnSm3ggwUL5RJoO6squLrQQQaaMzaHGlEZ2ccIA1T//c7u0FZY4KbatDk/KGUUFAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4afe1009960so179069137.0;
        Wed, 05 Feb 2025 23:49:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738828171; x=1739432971;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0z65Vz6+he8/8bsObm9G2Qc8ZtQrYHKjPd2qj2P/8sw=;
        b=SwsWLi4K7cDur8e4oXUGOi0EKNHZk9p4qtNtLpIy40iMUWOenF2XxUXMhYuJesSljD
         EQR9aXA23qI0R5oCBbimvYcu553aHI0b/txRFrqUndBBho3iRVMvY3TS8LfeRlV8FCNM
         AdIXzuFlXERfDEKqMulUpC4pPa90f3fKjS5ZUxcgdkSy5S7FqbzNNR7UOundMwdwb4vq
         CmJusYkmvPelAsF7XgCoPpIRjfmgbDb9P6KibTk3mVwt4yUzl3ANGHd7a09agOiSZwzH
         keyxcDrTjFALaKgys30gk1i8GhBFAk1MNx85S+QqISkFBOCfS8ZxwY1aVaM4EIiiEafx
         uZwg==
X-Forwarded-Encrypted: i=1; AJvYcCVvQeo0dF3cvvgmruiNrW/iKizeM1cVgosEP/gAdB7s188CzbJ668rLcXWxAvul++X1GfXdU+ZxZ0zlO7uC7s0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNHx5HDSoswqzrTmQ3fmXNppjPE7JycAnC13IhYk29Ee7wwdzI
	RgenTTG2JB5y6wUQJFFLHu7+CfkiAOJx7lu7C2SeeZlLMub5/15rY24R4MlW
X-Gm-Gg: ASbGncuoXMXNCWKi7QAbUmkLYJDrefJb0QOUZ12C5uFbZnlDh1dGfQDdtGG0GxuVCnv
	hE8JK+5bJsFepZiNnWEL+NTyMkYDA7rpk9FtZ/T9KJGtdsbPsjnsf8kIXYkB64f914LW/HATaH1
	4kaYkt4ySJhwfFzwm8ElpeTtdiSztkiF20oZMeN9+aO6+roD9KLonakn03QwkAJfLW9OpKKgUiS
	ZZA6z2OqqogFxLRECEOXYYE2ao+SthXWvuIBEcJHNUQDRuNIAxhEXIwReXV0KqYwy+qOc9JCWGj
	u10nCUYeGefs9LslHeyCkED+QcRO3Gu2Ge0qENVfTzvWUvb+YxsyFw==
X-Google-Smtp-Source: AGHT+IFEjiX8+JdLQiWvH1flroFa/FaHrdaILNSE6OfbqgmbjcKewucMz8UYgHpO79Fu1Aig3P6LEg==
X-Received: by 2002:a05:6102:c53:b0:4af:f275:e752 with SMTP id ada2fe7eead31-4ba47ab9f84mr3459522137.22.1738828171504;
        Wed, 05 Feb 2025 23:49:31 -0800 (PST)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4ba76ebc4a9sm155440137.7.2025.02.05.23.49.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 23:49:31 -0800 (PST)
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-866dc3cd96eso141766241.3;
        Wed, 05 Feb 2025 23:49:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX714YjkAM2XwmwJm3Y3yWHTRRTvv/nTHD99MbFTFp9bjljOs8gijFOPFNpDAz6Wj+QYZlFELMlECAP+/lxleA=@vger.kernel.org
X-Received: by 2002:a05:6102:3f41:b0:4b9:bf91:a864 with SMTP id
 ada2fe7eead31-4ba478e4191mr3440296137.15.1738828171133; Wed, 05 Feb 2025
 23:49:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204174509.work.711-kees@kernel.org>
In-Reply-To: <20250204174509.work.711-kees@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 6 Feb 2025 08:49:19 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUzKpJ_RaOxctfkL+=TJ=U-oKdF1iWH6or+UcwUTJNpcg@mail.gmail.com>
X-Gm-Features: AWEUYZnYp0Nf-sE5ADoh8PizqVhYmxn_5qVz5x4XQ110rvoWSTjJIXNTIC6KRRA
Message-ID: <CAMuHMdUzKpJ_RaOxctfkL+=TJ=U-oKdF1iWH6or+UcwUTJNpcg@mail.gmail.com>
Subject: Re: [PATCH] stackinit: Keep selftest union size small on m68k
To: Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Kees,

On Tue, 4 Feb 2025 at 18:45, Kees Cook <kees@kernel.org> wrote:
> The stack frame on m68k is very sensitive to the size of what needs to
> be stored. Like done for long string testing, reduce the size of the
> large trailing struct in the union initialization testing.
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Closes: https://lore.kernel.org/all/CAMuHMdXW8VbtOAixO7w+aDOG70aZtZ50j1Ybcr8B3eYnRUcrcA@mail.gmail.com
> Fixes: e71a29db79da ("stackinit: Add union initialization to selftests")
> Signed-off-by: Kees Cook <kees@kernel.org>

Thanks for your patch!

# stackinit: pass:102 fail:0 skip:6 total:108

Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
