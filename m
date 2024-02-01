Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3CD47F47
	for <linux-hardening@vger.kernel.org>; Thu,  1 Feb 2024 23:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706829371; cv=none; b=rzjLNzsPHXmZ0KglQjoNt2AB9ZYHvAj2c8LsYxeJMONDpreixJ+NcucIToz9QEbZ052IAixAFkYEcrRKeUfQl8zkXo32OyivnYOH/5ytMYB98mC7ydsmxc7F+w64HmPR7BDCS2BFvCO7mCZkWM7cmH67bT/SiEUhXjr4s3/AF6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706829371; c=relaxed/simple;
	bh=fY0i4/MKLDNI6g9oyGYppVz4kakO1fL7ygQCWGCJrpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mKK0fTsXNzYvKIVmgJjpXlB3HcqlfM2GIIMnMb84Y7nZfbqGHVPM2J1yZcdWxw0QGQlhTb+f582oAc3P036X/okStwRvhcmZ9JqPFqWbPKNV8WhVySyMGITTr0hrpc7aFqB99EDo2JxMxroJmO7Te7szTT4KiIpDgTx9FLuRb/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=THdG6U4t; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="THdG6U4t"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a359e6fde44so156330166b.3
        for <linux-hardening@vger.kernel.org>; Thu, 01 Feb 2024 15:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706829366; x=1707434166; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9K//vSZ1lGeh0sw5K4/Yw1CUaoAoUAFBdXCL4ofyJ/A=;
        b=THdG6U4tXYUDnIDyhv9A2KM4lr0R2xFotrokEhW2yKg2pHKVdjSC1AEgc0baDsOfyc
         h2q8FK3YdIA3wRdfGT6UG/GpYZk/5/Ghd2pLFsQsmcyZ5F74+B80BAXtmfZ2bFPmLoFS
         8lU7RdKQtx0j6eO9Z6iQ0l9E/ElRMz+N9h9Lk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706829366; x=1707434166;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9K//vSZ1lGeh0sw5K4/Yw1CUaoAoUAFBdXCL4ofyJ/A=;
        b=B6VE1PZKHK8M6qIIJOe2KjmtIVuN9MCJkNQN4rVDr5ijuYyieZxgQDFKTPmVKxtODt
         9JcldyBe4H4Bszu0T2l53nHww8NIZyksALISO58REqkFdlm/cirAeyX2LKNOWcJjU0H4
         TPpgpiLpW8nrhwuj4smxmK2myHYeVT+4yJfsFvpE/xDax58n1lYkvfpzRxuaNrvpFM8P
         c4n9uOtZn6dv9qGyLQrxuFjWRX9egbg2U5OKAPo41jIB9ZtLz7Djs5rrL+6ReJJIaBhA
         qfInMblq5aQ78q0imgBXK5yPSwUBC8tvjZgC+l0ZJ+Q+DyDs1adVi0GXD1DsPG6sScNm
         rURw==
X-Gm-Message-State: AOJu0Yxquh0Tx4ELoLOS84YjoffHfGFQT9P5FMs9akWAkD9HnK3fss6r
	CJODRbph4UK9+yA0YDN4DpsYHMhEnJNipGf2YJe9DnOveeFPe/hL+cpuQEvsB+MMlFNmB9zGJhS
	R7MFMlg==
X-Google-Smtp-Source: AGHT+IHp7V20MsSlQ27zjh16Fh0/N6RgAOSTiGd81saqMVTT75W8ivsmJQ4HMAzBT7gebsB4UL89lA==
X-Received: by 2002:a17:906:1cca:b0:a36:cd78:2f13 with SMTP id i10-20020a1709061cca00b00a36cd782f13mr2114232ejh.72.1706829365905;
        Thu, 01 Feb 2024 15:16:05 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVnWPr5VRQ18YIMW1TBYbMi8emcK0rI7jOWKnFDzjIoaYL2s1Et6fRi1nWfkR3YdBd+bfCnCwMfUD50bux/f5jkFbJBEridQv0DKxKqVlDg
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id w6-20020a1709062f8600b00a36c3e2e52dsm254525eji.61.2024.02.01.15.16.05
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 15:16:05 -0800 (PST)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40e8fec0968so13431945e9.1
        for <linux-hardening@vger.kernel.org>; Thu, 01 Feb 2024 15:16:05 -0800 (PST)
X-Received: by 2002:a05:6402:60a:b0:55f:4602:bf7d with SMTP id
 n10-20020a056402060a00b0055f4602bf7dmr4355014edv.26.1706829344286; Thu, 01
 Feb 2024 15:15:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131175027.3287009-1-jeffxu@chromium.org> <20240131193411.opisg5yoyxkwoyil@revolver>
 <CABi2SkXOX4SRMs0y8FYccoj+XrEiPCJk2seqT+sgO7Na7NWwLg@mail.gmail.com>
 <20240201204512.ht3e33yj77kkxi4q@revolver> <CABi2SkWB2eV24LBJtgJ73zEwaAWuFhAwrfqx3Rs=tqnpcJ0qRw@mail.gmail.com>
 <58408.1706828083@cvs.openbsd.org>
In-Reply-To: <58408.1706828083@cvs.openbsd.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 1 Feb 2024 15:15:27 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjqozic6JuRimXD=RamnJmD6FoaQki7RtNYrezzx_OfOg@mail.gmail.com>
Message-ID: <CAHk-=wjqozic6JuRimXD=RamnJmD6FoaQki7RtNYrezzx_OfOg@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] Introduce mseal
To: Theo de Raadt <deraadt@openbsd.org>
Cc: Jeff Xu <jeffxu@chromium.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Jonathan Corbet <corbet@lwn.net>, akpm@linux-foundation.org, keescook@chromium.org, 
	jannh@google.com, sroettger@google.com, willy@infradead.org, 
	gregkh@linuxfoundation.org, usama.anjum@collabora.com, rdunlap@infradead.org, 
	jeffxu@google.com, jorgelo@chromium.org, groeck@chromium.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 Feb 2024 at 14:54, Theo de Raadt <deraadt@openbsd.org> wrote:
>
> Linus, you are in for a shock when the proposal doesn't work for glibc
> and all the applications!

Heh. I've enjoyed seeing your argumentative style that made you so
famous back in the days. Maybe it's always been there, but I haven't
seen the BSD people in so long that I'd forgotten all about it.

That said, famously argumentative or not, I think Theo is right, and I
do think the MAP_SEALABLE bit is nonsensical.

If somebody wants to mseal() a memory region, why would they need to
express that ahead of time?

So the part I think is sane is the mseal() system call itself, in that
it allows *potential* future expansion of the semantics.

But hopefully said future expansion isn't even needed, and all users
want the base experience, which is why I think PROT_SEAL (both to mmap
and to mprotect) makes sense as an alternative form.

So yes, to my mind

    mprotect(addr, len, PROT_READ);
    mseal(addr, len, 0);

should basically give identical results to

    mprotect(addr, len, PROT_READ | PROT_SEAL);

and using PROT_SEAL at mmap() time is similarly the same obvious
notion of "map this, and then seal that mapping".

The reason for having "mseal()" as a separate call at all from the
PROT_SEAL bit is that it does allow possible future expansion (while
PROT_SEAL is just a single bit, and it won't change semantics) but
also so that you can do whatever prep-work in stages if you want to,
and then just go "now we seal it all".

          Linus
