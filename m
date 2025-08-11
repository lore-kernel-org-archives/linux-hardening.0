Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A1F22F77E
	for <linux-hardening@vger.kernel.org>; Mon, 11 Aug 2025 17:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754934544; cv=none; b=Rw/P+c5JNcrgdjk1/s2/oKCMJS8g4KSSpgKMA8YJPodAqKOtNXpzhbY7MgMz1nAL3guiVQgn0Uub+iPzAoKfitcv4JzE/9gqO87LCMfXqnXLVz77ltvCXxHD7xss8h+YqeJZGRZFEc0miMRSJr9mNHIJJC6Dh9w0T8COrTdByEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754934544; c=relaxed/simple;
	bh=4kxgWwHr34mUxtsj/GXegd0Nh3IyvQbeVbRqJQOaCFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kY740DyvKPhOqYmSCnoH+63tlKmCpgwvZnj8us449cU4P+UB7MuHFMkFYhEtAPd+qUtCl/tANW8xuvX+pMWpS5g1UWSDTJibKsCsSUEN63PHkb7mHdU9Ks8Fmj48GimA5MlnfGSwuKi/HnLMrlOvboRKAKPd6JKuCvDiGV1d580=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eFj7Os80; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eFj7Os80"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76bddb92dc1so5852587b3a.0
        for <linux-hardening@vger.kernel.org>; Mon, 11 Aug 2025 10:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1754934541; x=1755539341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wt9K5DEyPLjM+bq7x47Rs4ozsUCicWqFg4lpxq8FXHg=;
        b=eFj7Os800Q3R7qhaME0Hgv/gDWgpaNK+wNPmhJvPAuHiS/smFVCMAStsn4vVLsBck9
         UBL46NJTHdsTSOdAJT/i3HjMa/tGqDONVWrAHzWp/5r9L2EY4x4eQpKqsz6qB+ffB67F
         VgmtYHtwC2U/GCPY/63IbszTGfMRxphheCEIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754934541; x=1755539341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wt9K5DEyPLjM+bq7x47Rs4ozsUCicWqFg4lpxq8FXHg=;
        b=wq8lbkf83oj946G37CzVNtXpgYfCTzPLsvQwMJdop80jxNmGNC0ReO1bvNXVznEv5f
         AxaMYz0Oaty0MaOlgcscCKIMKS+AA6/ZudjAjIrM7CkU/AG8fRLA2rfg0CY+8pB8LilO
         pVrZ+AJZWB2RHm3Fhw5DbaVz+LEV1dc13t0QuE7xrOM0nc4bjm8n2tO9n6KpkmcyAbCI
         zG7eHCh+fO3VNXTXjQMhNenjzMxW2/k92Hv/BXVjNWfUis5IDzqlHRfUZHjoSj7/NKFa
         4I89gPaSUU0NYDKodtaVgBox49619ag6adjhf1gVrsHvTDmkYIg0L7BKqdmlGlDHVOts
         UcmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgqhC4u2xA7er4vcoJcH3BwDafjElTgiAizXy4+e3ig0lPmL1lyBhSi+JqgC8bZlZKxQ2UEeDJmNmarVZ2Jg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaneK4m1N4nNsO5avueH0PF2edOgvoRR9EzVLSXeoE+GjCoKge
	NdqNFvQmw4kH3xdWiJvFy1teDtX9jxvlebdWDbKBGEb/1Sz4RsXeD832bWWng4O1+rwKVa5fFRg
	jgAs=
X-Gm-Gg: ASbGncsv/vIzTFOtPNWlLeT+/9uqUINzG5aBqJXppZhIWiXUu7utNb5we9yERl0Eo86
	RrEy46mM/qaT+9KqGIPnF7cyclAXups7jaiD8SiYAHO2VeucmGy7iHV+ooDWcvxKxH46YCH8sAQ
	B8XgQh+wTHy9hzqtX1UPQ222MdWCtmQy5oa4xtgm4Bv0Jd7d+A077MfpJZfYIfBvW6naI/eOM/b
	IAXbmTQfF9OjArVAi0TIOrWe4dw+AjzrwySMAJP6YK2mcFfcGIFEBrDvMDfpVJjC81hFXRZSQbV
	+FxEPqRWOaBJjdJDBGDoM0n2aKed9O2gAQi97t50Iv6x90F63bYJQke5Qwib1v6LMhsxrBs76UW
	/Xp0wVNYGChgWgq3TFiYkeqRVtZ4caQxt+n/lgyovAcVUKCGJRgAFlgOKj+R9Hxwidw==
X-Google-Smtp-Source: AGHT+IFP0j2WbuLHI5a+OHw8MAWGV2wey3qyGvYAMs2jFlT5V7XcWBZw4W9mpPh8iCloPODYQMVWzQ==
X-Received: by 2002:a05:6a00:1409:b0:76b:e0d7:c3cf with SMTP id d2e1a72fcca58-76e0de37469mr640897b3a.4.1754934540702;
        Mon, 11 Aug 2025 10:49:00 -0700 (PDT)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com. [209.85.214.169])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfdf9bdsm27320276b3a.111.2025.08.11.10.48.59
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 10:48:59 -0700 (PDT)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2401248e4aaso53909235ad.0
        for <linux-hardening@vger.kernel.org>; Mon, 11 Aug 2025 10:48:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU0m6Q7A6SMirEWrM/Hf+gG1ZVSHDU1w+zqtjm1YfCtfgA8wS8M93QMm5i+AQSEDQDbjmV59qBArMecs63NccQ=@vger.kernel.org
X-Received: by 2002:a17:902:ef0a:b0:235:f459:69c7 with SMTP id
 d9443c01a7336-242fc36c67dmr5818775ad.52.1754934538293; Mon, 11 Aug 2025
 10:48:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811170351.68985-1-thorsten.blum@linux.dev>
In-Reply-To: <20250811170351.68985-1-thorsten.blum@linux.dev>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 11 Aug 2025 10:48:46 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UrEv+=KmjZTDt7F5ftuw5xrpOyEim0OrGAkoiJ5Wi2cg@mail.gmail.com>
X-Gm-Features: Ac12FXxPkL1S2f4PQPz2QV2wpNlFygKeHqK0V0jC13wbb3oVPpObsEueWXqhEY8
Message-ID: <CAD=FV=UrEv+=KmjZTDt7F5ftuw5xrpOyEim0OrGAkoiJ5Wi2cg@mail.gmail.com>
Subject: Re: [PATCH] kdb: Replace deprecated strcpy() with strscpy() in vkdb_printf()
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Jason Wessel <jason.wessel@windriver.com>, Daniel Thompson <danielt@kernel.org>, 
	Justin Stitt <justinstitt@google.com>, linux-hardening@vger.kernel.org, 
	Daniel Thompson <daniel@riscstar.com>, kgdb-bugreport@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 11, 2025 at 10:04=E2=80=AFAM Thorsten Blum <thorsten.blum@linux=
.dev> wrote:
>
> strcpy() is deprecated; use strscpy() instead.
>
> Use the return value of strscpy() instead of calling strlen() again.
>
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  kernel/debug/kdb/kdb_io.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> index 9b11b10b120c..2062494c413b 100644
> --- a/kernel/debug/kdb/kdb_io.c
> +++ b/kernel/debug/kdb/kdb_io.c
> @@ -732,8 +732,7 @@ int vkdb_printf(enum kdb_msgsrc src, const char *fmt,=
 va_list ap)
>                          * Shift the buffer left.
>                          */
>                         *cphold =3D replaced_byte;
> -                       strcpy(kdb_buffer, cphold);
> -                       len =3D strlen(kdb_buffer);
> +                       len =3D strscpy(kdb_buffer, cphold);
>                         next_avail =3D kdb_buffer + len;
>                         size_avail =3D sizeof(kdb_buffer) - len;
>                         goto kdb_print_out;

It made me a little nervous that you're not checking for the fact that
strscpy() could return an error code. Without the check you're just
replacing one type of problem (buffer overflow) with another type (the
code running with a negative length). IMO in cases like this either
leave the strlen() in there or check the return value for errors.

...so I looked a little deeper here to see if the buffer overflow was
actually possible to begin with. Looking, I _think_ this is true:

* `cp` is a pointer into `kdb_buffer` (location of first '\n')
* `cphold` and `cp` are equal at this point.

...so you're guaranteed not to overflow because the destination and
source overlap. ...but that means we shouldn't have been using
strcpy() either way. Both strcpy() and strscpy() say that their
behaviors are undefined if the src/dest overlap. This means that
really the right fix is to use memmove().

The above is based solely on code inspection w/ no testing. If I got
it wrong, let me know.


> @@ -872,8 +871,7 @@ int vkdb_printf(enum kdb_msgsrc src, const char *fmt,=
 va_list ap)
>          */
>         if (kdb_grepping_flag && !suspend_grep) {
>                 *cphold =3D replaced_byte;
> -               strcpy(kdb_buffer, cphold);
> -               len =3D strlen(kdb_buffer);
> +               len =3D strscpy(kdb_buffer, cphold);
>                 next_avail =3D kdb_buffer + len;
>                 size_avail =3D sizeof(kdb_buffer) - len;

I believe the above case is similar.

-Doug
