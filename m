Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F611D0F41;
	Mon, 21 Oct 2024 07:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729495912; cv=none; b=QIOTRkM+eVJBkNQFHre61Z9hvM7g+O/NZYl5HB9Lk7rC3lNyIRCjGrLgfLxPdwr6Vchplfs3bOJkN2kIwVLjYD9hNHqhKxM6NUhErW4bw8CLozAUY7RuIwdX9OiPTacrmU8Dot7Y2Z5e/hqfhvzBHIQJIDUq9oaEZCLXkWHZbR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729495912; c=relaxed/simple;
	bh=x56QYfTtpSaW6T92GC+6kY8hsQt71XOAsUTiauRLXuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c3tZX+SbA56lMlkV4NcnuqJSQA2jUCLT2+VO8Q+h/xumu6N8yuPy1v2FwQ2OB7oCDpSrIHmIN8/tfpeXHlEjbfMAHa0cb4MxBqRETl1c7KJ3TeWOKVaLzligB4AFB9dmRj8otBM9csKllPLUZAoHjFf/c7ZlUuCLUW4Dlf5zdlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6e2772f7df9so33923677b3.2;
        Mon, 21 Oct 2024 00:31:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729495909; x=1730100709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jr+kpALnRUsAPIgtZFzgufk7e4vaGeioyiXEU/DOG3s=;
        b=BirLM5eJI/qukBzZ/M6cFVTpCriHOGcp2mkUNGZcg2Z5PTwdiMKezZi6kin2lOCGpu
         AKf7ELogO42W2fxqj7Bm1cfy15rejvMlUQksQqIgowpirIoNQQ4jh4h2vPR3v7Xl72+3
         Mk87c7i+3AObZ74qM+59x14uZzUvO6XcjQELxWhsoRnh1v4Dwu06fAoaIg4Rpg/ITgKR
         jNSppkX/EukU5ta2bZ6loniAhFST0iC5PgZt9f0MyUMlBji3IIYByFey18JPySGwCybB
         O2DfBHLgb9j3Q9ObA03sbWEEr/QWlhxjfwIR82yOCL756a1BNWYpGRjJCcOMfencOvzW
         xD2A==
X-Forwarded-Encrypted: i=1; AJvYcCVny0ERBxpoCfNmRBgYOCWXq5ebYbvSePlEovehPa2gTDwGrHHCRcSa/SHWmOkF4pyqF0bQKgDBxKbpy4xa8LY=@vger.kernel.org, AJvYcCWh4R2KXT2YCBWwoIe1TLlpQqO7XUI3CO3a2HrC5IJZcGvRTXEX2TjMawy49vCXFlUJTPhBUP7/dld6CZjD@vger.kernel.org
X-Gm-Message-State: AOJu0Yy72y4qncqaSbqc14v1ZkuTZTANBwHkZVw0amu5m9aPHKNsRaQU
	HpAMSwxslca+q/0Z7Hksqh6nvPjGAkDiN4znfTHivOPTdM0MhY2Sz6KRoUgA
X-Google-Smtp-Source: AGHT+IHtIABokKmWrSV50XC1fSDO4GddECRooaJ1CM30ZWHXyXLK2XEsrLulrQIa2od777tS3j6Ynw==
X-Received: by 2002:a05:690c:4b0c:b0:6db:d7c9:c97b with SMTP id 00721157ae682-6e5bfe887f3mr94928637b3.40.1729495909193;
        Mon, 21 Oct 2024 00:31:49 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5ad5addsm5830597b3.72.2024.10.21.00.31.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 00:31:49 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6e5ef7527deso9672357b3.0;
        Mon, 21 Oct 2024 00:31:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUMY+GMpMk6TPD3EtxiS0pVFUHRohyRp3/6fsTJ+jWndn7UPGYYa+ax0I7D9mxCAVa9k/1w7FMBQQhlC05G@vger.kernel.org, AJvYcCVgUf7pFj4YvXwGBLLBGuKi9uDP2//vzLQgT1sbxDyL8qAviqeGGtqd5FjGEd1xLFWfhKyr2QPhsGA5PtmiUVo=@vger.kernel.org
X-Received: by 2002:a05:690c:3389:b0:6dd:e837:3596 with SMTP id
 00721157ae682-6e5bfc31904mr97889987b3.14.1729495908789; Mon, 21 Oct 2024
 00:31:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZxMV3YvSulJFZ8rk@mail.google.com>
In-Reply-To: <ZxMV3YvSulJFZ8rk@mail.google.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 21 Oct 2024 09:31:37 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUG7z0Qz=6GfeidmnrD_s_RQzMeC1wq0c2A1eQB7rG=Xg@mail.gmail.com>
Message-ID: <CAMuHMdUG7z0Qz=6GfeidmnrD_s_RQzMeC1wq0c2A1eQB7rG=Xg@mail.gmail.com>
Subject: Re: [PATCH][next] powerpc/ps3: replace open-coded sysfs_emit function
To: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc: geoff@infradead.org, mpe@ellerman.id.au, npiggin@gmail.com, 
	christophe.leroy@csgroup.eu, naveen@kernel.org, maddy@linux.ibm.com, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 19, 2024 at 4:14=E2=80=AFAM Paulo Miguel Almeida
<paulo.miguel.almeida.rodenas@gmail.com> wrote:
> sysfs_emit() helper function should be used when formatting the value
> to be returned to user space.
>
> This patch replaces open-coded sysfs_emit() in sysfs .show() callbacks
>
> Link: https://github.com/KSPP/linux/issues/105
> Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.c=
om>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
