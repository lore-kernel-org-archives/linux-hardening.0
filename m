Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B35638DC7
	for <linux-hardening@vger.kernel.org>; Mon, 16 Sep 2024 09:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726479969; cv=none; b=V5XQ2Ev57+E3AcbBSW4srVQR/9x7sp06xw+etMzclJMaYF+6AP6yCSdPnsWIhtrRSX9v/qy8bh6cejpTy3JXH5v8MY18zxvho/c7azK156B31onKfc/S8KraCNr615WEP/jjm1LDv70H+7ZTQptearykL6MFyGvwFae+kIrBTA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726479969; c=relaxed/simple;
	bh=HEBUOKgvtGaUWXzTU2mtZ+P+0x6Wpj//HDEDiJ1HWKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V0wMJqWq51Sfe7/jxj/kJc/LgXB5Wv7JNtfee58OCWZjMCMkd00MltrVNR7x401oJCRtSxK4Y7fAp6hJibBWmUgu2zz+ook+Ofnd22t9duXmANBDvi/GkOvJGZSmSHN0VlDqWqzhS6hyanzVSVke8t/Hb2KgYoMu0jihlPNKcik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W2HwmVBP; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W2HwmVBP"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a8d60e23b33so555038366b.0
        for <linux-hardening@vger.kernel.org>; Mon, 16 Sep 2024 02:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726479966; x=1727084766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gKBQDmkGN90GMEQUI7I/3uOX/WhTy9BlXV+xFj4qdlg=;
        b=W2HwmVBP5kMw/IsUvxcCIOTwnjkGe5hoe6uIIzfiTmmrOMXH6g0PyDedDhOczdSegU
         ZFBWG/3Zkg/6QPKQIn7SkmLf5CaquE5LWRe7GeVV3m/2gzqJV2n1eVV4tdnwLcn0HDOV
         7/Uj6Da6OSzJH5qIRO0IDVehD/nP5IU3lzl/yPNUuJjUSeZGgCV2I3gPo5Y7v1xf6otd
         b5cvGZL57ovLM0CLNA1MMII0X6iDvwvshFSU/abXFLPeDdKQ6XKk7YCHRUuKTbpidAC0
         ESN5tUFX5ZUctf2HB0Lj8CetRdfTiYT/TKb3CBeReO20wPlIlKYnuJUZFTTig5f6ns0t
         O4YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726479966; x=1727084766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gKBQDmkGN90GMEQUI7I/3uOX/WhTy9BlXV+xFj4qdlg=;
        b=vRiHeaO3xvqiDwQQTMFInzHm49zlTae4luFQiVHnBCo69WVno+AvgvQUJrA+kHFMAI
         VvI+OKIMGEtiyPnqIBNi5T9yhcU78xw+dth1tJ77Bhd4DEfT+ZgFioTNLjaBt9n6qKl+
         lU7sVnvALX7BuXUaqInFZaaift/iRjBznlAwgYRdmhGhuCyvGIWSuSDq9bRbenx0A2VK
         bjjt9tLoIES3GYX23t/Akyj39KJwvJLnIK5DLEacB6LTID7lXz+TjoC1zz4F2PM6Go1A
         c4CNx49w6rUgx8mtB4k9mrYAfSjRfOHF1eH7zsCDKq/KyAKyjvTST8R0UKYO8wJO9PJp
         2PRA==
X-Forwarded-Encrypted: i=1; AJvYcCUfhK8WyDzJi6iX9ajtgztLrZ7GBz/CGhUK/GU6dM/X2wrLbIOwJc4gjUyZ9U/Rjz+K/jIU6un/dUhy6Frj6N8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywev8cE0Qu5+cdfIS9fy8hVRA1FjMVXnsh0gLiuytULnPMcNUyt
	GI0y2PS5u94cxUJjTp0vqR/JB6EuMyJmzyE2mGAQJqmxzaeziBWJmL7D7R6TsBUhpiQHNSu5r4S
	WzMsILakCWwGQ8q+fOGt2yPOT655yDi+QKVQ=
X-Google-Smtp-Source: AGHT+IFoFkUbWVthlhVVC2zcwURsN2XBKy2HuY/4AFe7hG6VnJqU5CpcObM2KJ25T6uXoNEZrkyX4jNDXScgRMFKSuc=
X-Received: by 2002:a17:907:961e:b0:a8d:4f8e:f64d with SMTP id
 a640c23a62f3a-a902966826dmr1510707266b.54.1726479965536; Mon, 16 Sep 2024
 02:46:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909162725.1805-2-thorsten.blum@toblux.com>
 <20240913164630.GA4091534@thelio-3990X> <60B48C52-12A6-4810-8C8C-9CC1C1E77E68@toblux.com>
 <20240913234455.GA1842841@thelio-3990X> <FF37A337-32B0-4951-B13F-2EFB1734B6DE@toblux.com>
In-Reply-To: <FF37A337-32B0-4951-B13F-2EFB1734B6DE@toblux.com>
From: Bill Wendling <morbo@google.com>
Date: Mon, 16 Sep 2024 02:45:47 -0700
Message-ID: <CAGG=3QWawMUJv83UBGFk0izrP1+FdftB7x7ZLSYx4NvcGPWyYg@mail.gmail.com>
Subject: Re: [RESEND PATCH v2] params: Annotate struct module_param_attrs with __counted_by()
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: Nathan Chancellor <nathan@kernel.org>, kees@kernel.org, gustavoars@kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, mcgrof@kernel.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 5:23=E2=80=AFPM Thorsten Blum <thorsten.blum@toblux=
.com> wrote:
>
> On 14. Sep 2024, at 01:44, Nathan Chancellor <nathan@kernel.org> wrote:
> > On Sat, Sep 14, 2024 at 01:32:19AM +0200, Thorsten Blum wrote:
> >> Thanks for reporting this.
> >>
> >> Changing
> >>
> >> memset(&mk->mp->attrs[mk->mp->num - 1], 0, sizeof(mk->mp->attrs[0]));
> >>
> >> to
> >>
> >> memset(mk->mp->attrs + mk->mp->num - 1, 0, sizeof(mk->mp->attrs[0]));
> >>
> >> fixes the false-positive warning
> >>
> >> memset: detected buffer overflow: 32 byte write of buffer size 0
> >>
> >> even though the pointers have the same value. Does anyone know why?
> >
> > Might be a good question for Bill? The full context is available
> > starting at:
> >
> > https://lore.kernel.org/all/20240913164630.GA4091534@thelio-3990X/
> >
> > I wonder if the krealloc() has something to do with it? I should try GC=
C
> > but I don't have a tip of tree copy handy at the moment and I am also
> > rushing at the end of my day to pack for my travels to LPC :)
>
> I think the problem is with __builtin_dynamic_object_size().
>
> memset(p,,) calls __struct_size(p), which calls
> __builtin_dynamic_object_size(p, 0) and this behaves weirdly:
>
>  __builtin_dynamic_object_size(&mk->mp->attrs[mk->mp->num - 1], 0);
>
> evaluates to 0, but
>
>  __builtin_dynamic_object_size(mk->mp->attrs + mk->mp->num - 1, 0);
>
> evaluates to 4294967295.
>
> Both values are wrong, but the latter doesn't trigger the
> false-positive warning.

The 4294967295 simply means "I don't know." There's probably a bug in
the size calculation. I'll look into it.

-bw
