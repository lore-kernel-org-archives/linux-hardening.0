Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8859C17B50B;
	Thu,  6 Feb 2025 18:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738867487; cv=none; b=im7DadONszgpqH44jizWa2zwlmIEGQXflbRj4xgDlSCP1X1unVh93l8OewLNHRe/QUpPV0mYrLbPKYe1WiKkmao5PrQGITLlea6viu6sxLe9shrqDybaLi2mL74rU6pnFbOo59SMpcGzTxxrF58jI/aeVgxRWo985zTAuSi035s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738867487; c=relaxed/simple;
	bh=H06jBhEq0ZvoyRwldPFwqWy+epMU+OsCTJMton0k8KA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fKbxVzK390VFy5JLIiFHjA1jZM5Vet/Lh0xEo0dXEznKyYZgChqBkL65N9qLfHWT36TSFqwld6ogHuVZS9LvsrgFZjXzIHTXErV03VRKLpTFkBrSNcGNTkmMDYJNg1/874InAu2sWdvOmpo533JxoUd4I1v6yv2J0AvYhBiWQ9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZ4OZexZ; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZ4OZexZ"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-302217866b5so652511fa.2;
        Thu, 06 Feb 2025 10:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738867481; x=1739472281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H06jBhEq0ZvoyRwldPFwqWy+epMU+OsCTJMton0k8KA=;
        b=HZ4OZexZn+B5qRN9FIR92ZasZ+rCQp1P6ueS5aJquUVe4k/Q79FYPdTNwS11/fHBT9
         KtMDlj8pCUhDgwAvTwnKPJTYPNl0HGydwlQsihtCS6f1aSBHIqeofNkcfDB2/0xob6Pc
         GUPeETPEtnZKz7DQ8caeFPHgR8hUf3tIzih/bbXaPNngsq0Q3I+mQVIICi5zMq300AQR
         ntgSCp6hDjYhdoEbbOdFT9v1Wa+syPeR996jjdl3LCv7j9k6tZ6FbDk25It0jjjPCH9u
         TQ57D0UgNwJTkrOxib9n0MpCPnRULCKWK2B2W9koF4/+YqR1BUrifuVbARG8c9y2tLOQ
         WuhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738867481; x=1739472281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H06jBhEq0ZvoyRwldPFwqWy+epMU+OsCTJMton0k8KA=;
        b=eEVzv02k45tHtWB/34m+1oRFaIKQbov7vsnaPeL7/X62TO88nMQG2qrPoI1tcGzJbn
         8uKN2Pl1/hRVFzKwhy9/xUrHV3yYNIvt2tL5QbtxBCstxuhONYQ9h8cWbZQRcpH1gmEJ
         qKuDF/L2fpQy/XdImJADleu/8ZJviN8Ceqd2WhH/lT1RZUnSfWhldRplae4ZVT/BdTHd
         KzYilW8FmtARZ7Z5K3dhjuYMj5toG2Ma9y1/WJ5p+RcSQUYt+PEXk3i4EeNd3zaHYZ8N
         ll76RfoUgH7qR2vcnyTY45s/DrSz2DuYElCjvgGGfD/Fewl53Mhujq3v+7VmredQz6UJ
         leoA==
X-Forwarded-Encrypted: i=1; AJvYcCWdgaJcsIRIcYkl3MpjjTVDHyYmYrocJaRSgDHp4O1s6uGLU1G9vtNMWilbWCmnxhVXqwmoL4PtwN9vPlTN@vger.kernel.org, AJvYcCXKGvMP2cT2mGCAoIW+bQVQv38fHO42oYSsfZzdm1XkOXTOrqUVa1hRqApYWmH1u3i7hdKh09CXMZ/3B1v+M5c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yznr+J8ZGemfo1nDIJeR40fH9BuPECD17kMCQMcgws96X4FjV2f
	d2ehN6d0XkXfIYGX9UlGhDAu5PDEkgXGTFr5CbMRyDWujtWpNPdAsnICnOqAs2wxNE5b+DXurE9
	9//+BIKRW8JaznWt0vzRuh8qEq9w=
X-Gm-Gg: ASbGncuw4EjE8oEUTSYcosq0zXZqHsJYAA7c2CX/9Tu4oaeWTEvZ8XoRqo9QSlVgqy6
	THdZuL+IiK52Y+AmaZBrEyPLwu3clKKXB0ho9EjBW63yuBMd42JzI3jpNZX8xTveaAlLSo9zD
X-Google-Smtp-Source: AGHT+IG18G8c3BNK0462z1B7bHuXmFbkRkoQrfyVbHlRk8icvjAP9ATJESDc/jxw0zv8YmIwtjHga082a7yX+HHZEAo=
X-Received: by 2002:a2e:bea0:0:b0:302:1c90:58f3 with SMTP id
 38308e7fff4ca-307e561e7e1mr155531fa.0.1738867481327; Thu, 06 Feb 2025
 10:44:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206175216.work.225-kees@kernel.org> <CAHp75Vf=84tWvv57Kj5A5bLenQSkC5yDHTHy-u0iK1_U87nvBw@mail.gmail.com>
In-Reply-To: <CAHp75Vf=84tWvv57Kj5A5bLenQSkC5yDHTHy-u0iK1_U87nvBw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 6 Feb 2025 19:44:10 +0100
X-Gm-Features: AWEUYZmQcvul9joL7qcMjQEXWIhbEmA3MIwFwA7IB5y_DbfYl1Y7BR1lcbApAJ0
Message-ID: <CANiq72kGUOgP60SaEwiBcgsDJnjdvJZ1VJtyf3a_+sQJjiffng@mail.gmail.com>
Subject: Re: [PATCH 0/3] string.h: Use ARRAY_SIZE() for memtostr*()/strtomem*()
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Andy Shevchenko <andy@kernel.org>, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Philipp Reisner <philipp.reisner@linbit.com>, 
	Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 7:42=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> What's the minimum Clang version we build kernel with? 12?

13.0.1 for most architectures according to `scripts/min-tool-version.sh`.

Cheers,
Miguel
