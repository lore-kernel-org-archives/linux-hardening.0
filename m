Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7C47DA68;
	Sun, 17 Nov 2024 20:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731873840; cv=none; b=qAeNlFIlw9wYnwiU198k/i0AqjTJTFcasaHQeN5QNmmyrdGNSz5+Zr0hhLQBn+PjEPU1A4fD5B7Ck168XAPZKbmwXCJ2zOJKe0PQqb2Ga9IRx96FkaFtB+gKYVZAjFUA0TgvSk2PtxGFBswWMOOWi6/XXm7tit7Y20e1uBHUo98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731873840; c=relaxed/simple;
	bh=72Lu1o44HItdEzv5B2r9aHjBGnXSZdKV0BqqFhnB63Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j0ONn/p+ynLM7+V0lu3RGbPsLbl/Hc8rFU+dnfJB5dDtZ3LcRUH8ABGDDFNbMgcvylxr/sR75TfYqR2KNkCjqvMCFBZmHi3vIi5DaGSdyqrZpWJIt3qrwH+0h6MaFp610xITG6ldrDbVhw8hyt/2rpe8W+DYgLP85o5Q/wMBb+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CBO5a2IF; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBO5a2IF"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa20c733e92so360702466b.0;
        Sun, 17 Nov 2024 12:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731873837; x=1732478637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AK+DiBN4CK5JwQubpBBSvmzj0hpDs8Mv8Z4W0yceMXo=;
        b=CBO5a2IFnfT6ZzeZdaA9UzlLH9ECu/4sgjuF8/2mkBFtNy83N7rEcy3uWEKmUZzYQA
         +2LCupEkhRxzd3TzaVZWOwttKW908+tpYquq7aXuJRu2MUzELteaG5H4kvmZMUep2/vM
         7+XO6Bfd1j3fnGL9Gs54+lcqFPwAqxpGZ32opiaGEPksRJb1f4OC26W7FcfbHeVp1UqF
         fb8gdhtImBa5N8isDnZUxUi0sq+ZrItrtpJsYVtb8n8lKMUra0Hu5QvIkkgKmXgoxc/I
         c+R4ox2ejUEfAD8MtzvK58Qm5EwtMlReuaiw3X73MwWbJ8VW/fA71WDWXVr1Ptt2gcpr
         ZMTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731873837; x=1732478637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AK+DiBN4CK5JwQubpBBSvmzj0hpDs8Mv8Z4W0yceMXo=;
        b=k2Ptd0PoUT+fRSAuZ5cKA+gIOiY1dNDDQB6Z0COwVM4g29XzOpDr8inUg5kbbf0k7f
         OcYdJ8Td9B6Ye4uSOiWIzl5M2ZcsMMOVFWDLRsRAorjNXtE75xsuonl2T0BTtamxX7cT
         tgChLkskaJgfT0JSRj7BQRSmyqkKZpkUR7hmqJ1u/eefuApu/8GVwEKwE97qeWIdlEHa
         qIvDXhV8mUzPz4ssCYuhESVIaDYWMc6HvmJD5uryUtlzqMEM4nM9YU6HXaLWcEw6KzO2
         K6LM1xVi+ZgK83YuqN8CMDL9KGK+lqhaNrJvFu+zsPmG5mZL8pmFe134cPAJj0kn/XG6
         +faw==
X-Forwarded-Encrypted: i=1; AJvYcCWCuq2FdL86x3my+nphrM/9NJMctBPXQk+pkxS7JO4xbwNn+MWyJfkS+VYWcObzVpu9RpOoY+t1Sj71Iqubi6U=@vger.kernel.org, AJvYcCWaSU3QnKOAExIKXmq6NetQcm5J+gDP0kRqZpYYPqZWgs7p400OqYhaD+NqRGuTq+Wc0Y5AYT4eHDohnSoF@vger.kernel.org
X-Gm-Message-State: AOJu0YznSfLTKGXGFkK+j7Vtu4Kf/XDQ/FtYwApBPIuK5LuPKnCSdFzc
	KljEPsHVtUuyzZRicbemMhY7cDa21yhBSzwR5kys7xvA6KzXFuS/BZrhwBaxPOSnn3dgIFTQrKX
	HEq4k9LPiXzQTg8/sJtnWr8SeNO8=
X-Google-Smtp-Source: AGHT+IEL3EyLHdOzdT3h0p13980U7qVvz1QDBUVycMczXLxUWvkeIzBkm12SwlempIHi328POYKFdfbuUSypJGxWgHI=
X-Received: by 2002:a17:906:d542:b0:a99:f887:ec1d with SMTP id
 a640c23a62f3a-aa48354c913mr895299866b.49.1731873837212; Sun, 17 Nov 2024
 12:03:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241115144616.7453-1-prosunofficial@gmail.com>
 <CAHp75Vfp++XMr8VGjjFRBpJi+uAk8PRVPxMLmQciedBzS8gedQ@mail.gmail.com>
 <CAHp75VdD1KYh9KJWHwhxkXy-+jfh_o=Rn05AtL4QBb0HC-oz6g@mail.gmail.com> <2a5500a5-c1b6-4c5c-bf37-4cfeda5a9e1e@gmail.com>
In-Reply-To: <2a5500a5-c1b6-4c5c-bf37-4cfeda5a9e1e@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 17 Nov 2024 22:03:20 +0200
Message-ID: <CAHp75Vd9tm_QOYHJ2RgK3_vF_aztEkuf68yO7a=QLHKpJAH=cA@mail.gmail.com>
Subject: Re: [PATCH linux-next] lib/string_choices: Add str_locked_unlocked()/str_unlocked_locked()
 helper
To: R Sundar <prosunofficial@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 16, 2024 at 5:48=E2=80=AFAM R Sundar <prosunofficial@gmail.com>=
 wrote:
> On 16/11/24 01:16, Andy Shevchenko wrote:
> > On Fri, Nov 15, 2024 at 9:44=E2=80=AFPM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> >> On Fri, Nov 15, 2024 at 4:47=E2=80=AFPM R Sundar <prosunofficial@gmail=
.com> wrote:

...

> >>> +static inline const char *str_locked_unlocked(bool v)
> >>> +{
> >>> +       return v ? "locked" : "unlocked";
> >>> +}
> >>> +#define str_unlocked_locked(v)         str_locked_unlocked(!(v))
> >>
> >> The rest is sorted (okay, read_write() seems to be misplaced, fix that
> >> in a separate change if you wish), please keep it that way (I believe
> >> it should go before on_off).
>
> Thanks for the Review and Comments provided.
>
> Please correct me, If I am wrong.
>
> The function name should be in sorted order means,  str_read_write()
> will go after str_on_off().
>
> For example, the sorted order of function will be like:
>
> str_on_off()

> str_plural()

Leave this one to be last, it's special in comparison to the rest. See
what the type of the parameter it has for the details.

> str_read_write()
>
> > Oh, I looked in v6.11 code, in v6.12 there are a couple of more
> > misplacements. Can you fix them all, please?
> >
> Sure, Will sort it and send as seperate patch.

Thank you!

--=20
With Best Regards,
Andy Shevchenko
