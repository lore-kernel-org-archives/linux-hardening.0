Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4D0188CCA;
	Fri, 15 Nov 2024 19:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731699935; cv=none; b=Y9nkEoGQTXplfZskun72WQuGLBP8IzSlppK+9GeQmsBrylT3qYhVA8NETdcROCsfyNJ4d2DhPDZqYy0pAi9x0DItyo2Tid7FaMrUT/7qp3uFfSakV+O/2dwNWPwcr7NMplK3HRM8fBITK/sWHjfgapX6y0mErdlMM/ZuJ5xYNn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731699935; c=relaxed/simple;
	bh=Z+iZ0yhz0M1FaqlRl5UrjS3wyy/GFUMiYpRP4Rc2mHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sqwjFLLrzngJFvtotneuE9By3Cae+eRx7eVCjJ9cDuIsJoblvWY4J84W+4gtiVQM9I4jXpZC2Uz3e2UOHC4brDwJ5Cz9pvwK3ikrLcw+x+p7h6fDZHY+dmmZIykmOUUzSn/p6ldpuznvQIMZkpH8jacjXwO7IZZ3qIXfoGA0k8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c90FOU7E; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c90FOU7E"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9ed0ec0e92so278619966b.0;
        Fri, 15 Nov 2024 11:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731699932; x=1732304732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BEbL7zRFdziulZlQDc75V+Geg3ROA8HggtNAnYJJpEk=;
        b=c90FOU7EHmFUpVeP7oH4xZmJ1+exqctZIR+SJ0C0xpbjDsVJyq+EzM6Ulag2e9VodN
         UHCv7EYliu52jTP/g1R1R53D2fUqT6PAg9+13MkrhARarq0eeKRDqCSW9obEwIU10PsW
         vkMH4qk5G5h4xLRG0JAIJfEOJMqL5H71ynrR6A+qEz78K6LpDBsrgVfOIJkTHRjsPkiT
         FO2uGDyykCf0mQInQnzrCe0QnrsgydY985uyxPwBdObHVXqrS6JKVSQWjuWvYXl6Z/fh
         Glwm4FcVPIfu7eRAsatMPinwGg9BZ60PFw/bG+GG98y7/UMi8bln23l/l8cTUNJRe70b
         UwZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731699932; x=1732304732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BEbL7zRFdziulZlQDc75V+Geg3ROA8HggtNAnYJJpEk=;
        b=TJTQ0Lm1++40Wnb0gJWQzF+hxK7sulCKoVZ6DRmybIAdqmLgdt8cRHn5oPYwMmTqxT
         ETt6ubnXrjPyznxWAPR4SLMdP3tC5rATpubhKuE8clYvsuGkK4yK1Qc6xGD11ZD/N8SB
         vYqFRn2pipJamJxZwjVupsmEGbRBpnPDMOqXtxKknLa+NqUfPKRkIEQtijZlkmYbBzb9
         mfAttz5bAEEMflF3BjqnwiKBieM4YXPScV0gyg7WrECAh3Vcb/R3ew1Z64ZnG36EWmzm
         yl9oRSXXaDC4PUFP4jeDpjVqBThXbaEQYvyMwGnBGGIfiSUZP8t+hbsggMYxfceDncUV
         /t/A==
X-Forwarded-Encrypted: i=1; AJvYcCVawBhMqHdqGW66rZQzQe7UJpiJD1pESu8HI4E2EfThgDNB/84oSCOa78/Q6HsoKMPAEsbhqgf/uhWirP+/@vger.kernel.org, AJvYcCW7KQBqwRJOt6DJ+7OE2ZQS9EbtZB9E7skSSHXpUTSIZV01o/rNNeqNbx1msK8X4tmiuxhnFxFp20ITCAuWW+0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6ZiF7l2kVAhcS6P4XAytJrTGazf/d+511G+msrkYdmUKM/Fiu
	NA2j4jj7l7JPog4aukEtAIaf2Fzn+zJ9tO7hKBwuCOBL9pIYXw2ctwM52wPJ/x76fQ4UvS+XmP3
	A4nze+QdmNQTBEMWtHdjKo/ggzMY=
X-Google-Smtp-Source: AGHT+IEilKTn7K/983hObRMGbHcITXm/Clf8eejrBlu5SkYDg0+boJ9Vj19n+pVM6YiwHQMVcD2qJxm4t++QWNyBld4=
X-Received: by 2002:a17:906:ef08:b0:a9e:c440:2c0f with SMTP id
 a640c23a62f3a-aa483525e18mr345750466b.39.1731699931622; Fri, 15 Nov 2024
 11:45:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115144616.7453-1-prosunofficial@gmail.com>
In-Reply-To: <20241115144616.7453-1-prosunofficial@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 15 Nov 2024 21:44:55 +0200
Message-ID: <CAHp75Vfp++XMr8VGjjFRBpJi+uAk8PRVPxMLmQciedBzS8gedQ@mail.gmail.com>
Subject: Re: [PATCH linux-next] lib/string_choices: Add str_locked_unlocked()/str_unlocked_locked()
 helper
To: R Sundar <prosunofficial@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 4:47=E2=80=AFPM R Sundar <prosunofficial@gmail.com>=
 wrote:
>
> Add str_locked_unlocked()/str_unlocked_locked() helper to return
> "locked" or "unlocked" string literal

Missing period.

...

> --- a/include/linux/string_choices.h
> +++ b/include/linux/string_choices.h
> @@ -82,4 +82,10 @@ static inline const char *str_plural(size_t num)
>         return num =3D=3D 1 ? "" : "s";
>  }
>
> +static inline const char *str_locked_unlocked(bool v)
> +{
> +       return v ? "locked" : "unlocked";
> +}
> +#define str_unlocked_locked(v)         str_locked_unlocked(!(v))

The rest is sorted (okay, read_write() seems to be misplaced, fix that
in a separate change if you wish), please keep it that way (I believe
it should go before on_off).

--=20
With Best Regards,
Andy Shevchenko
