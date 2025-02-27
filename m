Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F581276D25
	for <linux-hardening@vger.kernel.org>; Thu, 27 Feb 2025 23:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740699801; cv=none; b=X5tjxzfWLBLoDuHDHDT0irxNuNJjIejb34VWvXrdXaYZdJRqb9kSYPUK3spi3zXLYiatqHO8FhpPKr07eOd2rPmf2zK8TalkkJRgBsB+Jpbv/dTgElmLFVM5rW51NrmA0LTA07mu4m7jr0f6VfrNSNwWNiQBm3QTEg/fACYHENA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740699801; c=relaxed/simple;
	bh=XTtVjQ4kq+/ahGTfmaEVrVy1YQKoKT9VRg0oViebMB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m+UAbp1SFS/B0eHDogZX1VuJlmgwzgUENNccg77N3AEFxm/wcRUseD/8Lmo1swq3QlF101cJv49tFJV/LDR9NQ5nR/pSNYO/SY/laRxxwKYArjk5IPXlMkBd13FZnmcLszvL/J+yRoRXQUDGIew2OS5Ca3j+7Ce7/xqo9Wruozo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WxBTBzur; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WxBTBzur"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5fd062e9f91so79324eaf.0
        for <linux-hardening@vger.kernel.org>; Thu, 27 Feb 2025 15:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740699799; x=1741304599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XTtVjQ4kq+/ahGTfmaEVrVy1YQKoKT9VRg0oViebMB0=;
        b=WxBTBzurUQLyNqrD3+VU3kzMoSQwYOcFX7GFcb3r/OIAxTy6RjHcO61bo9/8uvXjFU
         ZBDyEMg+sIwI3rMhrd2nXzUPsSVWubXjSZjx7nV88eYs9NCHR1xWeM6v/n743SDQdHQb
         Nel0+JtxE1zss3rq29Y0bR8EsC05+ZNP/fIKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740699799; x=1741304599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XTtVjQ4kq+/ahGTfmaEVrVy1YQKoKT9VRg0oViebMB0=;
        b=CHeM+agX3gNOyLFW8hwaQIDwQaG5fjUVM7wVVBkwVGpmc613JQMFgmcfzke0j84RPs
         Kh2/y6T9FYpdbNgwKqPkf0s9WOqRAhjXgCi1FuQSsTWGbG9IyB3QjBkket1X+xFPo+4j
         urp+G6PjI8p4FEANlUEd343NhVDdQHaGqs6DKRyOuRFugGSdjZGHvDjPb5b+PvvWtRAK
         JKjVgCqBY64Ue+E8QKCxTthO55YFuVCi0ADw2cxh6nU1j4hfiTqGsvJ8+Qm5YSrn+te7
         IdmxeMsP3LK+eMcYGeJTA5kidt2AAS/d7guA7dmP8R1J523eoNJ3yPdR5kdxevRhVwQ/
         jMEg==
X-Forwarded-Encrypted: i=1; AJvYcCWcypwB3LIZHCeymMR0Lmy4BjRsmvMU4fAiODzrDnz9xBbteJzt1A7LCH8kjnRPgjY2pHcefxogYE0x9GUTaZA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf4O/vzuuUeB9Od9HgjLB1nqlZaPJhDMPfasJQa5XI+zGJdgvL
	5XuoEEGLFmcnfGZs9qug3pPBNu137sgTUSjNCc2uhA32o2glfYLpmYE4pI6iDDAglzDa1V2Oib6
	7RzooWNXZO1ivYIuAXO7UKmQV+bgpJJT+feYq
X-Gm-Gg: ASbGncsevWeJiFhSodTUmN8N5+TUm2PHDMEpWo0qlga03mVnZl56qNnBYr3qyCnePIJ
	p4+D5Z8I174PX7tr+xhxqt5Ge5IhHO+tZHtsU0KVuhvrVEg32wDpgcCM2aFsSB/YJlaaXQUQmFg
	8nzrBjPaI4hvT+9Mn3GPIS6hG4YLq5FWWVBJQsxGYf
X-Google-Smtp-Source: AGHT+IFVUyUsYDptOf1uEkSXiVm2KUCfAt5kpvDR++NsMlronN4mKbbFdn4W8gEd5sIJVSXFhEkNggEOqBxyd7D1hps=
X-Received: by 2002:a05:6820:a110:b0:5fc:e9dd:45ed with SMTP id
 006d021491bc7-5feb352ea7bmr204153eaf.1.1740699799150; Thu, 27 Feb 2025
 15:43:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224225246.3712295-1-jeffxu@google.com> <30b4de93-70e8-4384-ae56-9f6b6cf0f347@lucifer.local>
 <CABi2SkXkfFAMhmXP1CKHCZMxdKWcHx8T9_0-nwBPWycTbxOctQ@mail.gmail.com> <afbaee91-3bea-4127-9dc1-7b43b0090229@lucifer.local>
In-Reply-To: <afbaee91-3bea-4127-9dc1-7b43b0090229@lucifer.local>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 27 Feb 2025 15:43:07 -0800
X-Gm-Features: AQ5f1Jo_gJY3RsgJ5xmWVYLTo90Mu9L8ltsde4Nhv3yL6k10ypx9JSGFT-uMpC4
Message-ID: <CABi2SkVcbuxm5j7xekSuyV=9goKxAPcDE_7OEz2JLds1+K0j0Q@mail.gmail.com>
Subject: Re: [PATCH v7 0/7] mseal system mappings
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	torvalds@linux-foundation.org, vbabka@suse.cz, Liam.Howlett@oracle.com, 
	adhemerval.zanella@linaro.org, oleg@redhat.com, avagin@gmail.com, 
	benjamin@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, jorgelo@chromium.org, 
	sroettger@google.com, hch@lst.de, ojeda@kernel.org, 
	thomas.weissschuh@linutronix.de, adobriyan@gmail.com, 
	johannes@sipsolutions.net, pedro.falcato@gmail.com, hca@linux.ibm.com, 
	willy@infradead.org, anna-maria@linutronix.de, mark.rutland@arm.com, 
	linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de, 
	rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com, 
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com, 
	mingo@kernel.org, ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com, 
	peterz@infradead.org, ardb@google.com, enh@google.com, rientjes@google.com, 
	groeck@chromium.org, mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com, 
	mike.rapoport@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 10:01=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Tue, Feb 25, 2025 at 04:17:01PM -0800, Jeff Xu wrote:
> > On Tue, Feb 25, 2025 at 2:32=E2=80=AFAM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > BTW can we please drop the 'mseal, system mappings' prefixes on this
> > > series, it's really weird and makes it really hard for me to actually=
 read
> > > the individual summary lines for each commit. 'mseal:' will do.
> > >
> >
> > I am not sure.
> > I had comments about adding mseal, system mappings, as prefixes, and I
> > think it is reasonable.
>
> No it's really horrible (sorry I know it's hyperbolic but it really reall=
y looks
> horrid to me) , I've never seen prefixes like that before in mm in my lif=
e and I
> don't think it adds anything.
>
> I also find it MIGHTY confusing.
>
> Please remove this :) you can git log the relevant files to see the conve=
ntions
> people use. Typically xxx: has something really short and sweet for the '=
xxx'.
>
> I realise this is subjective, but it's a small thing and would be helpful=
 for
> parsing your series at a glance.
>
I need a prefix to group the patches, especially when the first patch
is just a config change. "mseal" won't work because this patch isn't
about core business logic of mseal.

How about "mseal sysmap:"?

-Jeff
