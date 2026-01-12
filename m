Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE433446BE
	for <linux-hardening@vger.kernel.org>; Mon, 12 Jan 2026 10:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768214882; cv=none; b=E3naDS11cevgII+2DJhJFYKmISqsej3k1PLwaszk7lP/GJJayXCS6+xEKqmxlR9iucx0byGCKbMI/mS3loH9YDpQQpw+9wze2bfWKugcwIQ7gMdmFX5dmP6L6bt1SeaJdQQSslo9cweIgUnRjfUn7z0urts55RGZOOWgdDMr1hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768214882; c=relaxed/simple;
	bh=D72E3IDd+3+bcuC0NArQb3Qh+8gksLIiiNsTkZbccFc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jUmMm20MHYbx2TBHyuO7LSHcLm7CbQ/d4v+9dTeLqqCO5ZrueV696cJncAQinMuVnL2bQFMqu3x78kf2rwjFLGcVJIpKGSuUOCJ0kclfsTttgcyymDRnSf+XKbImN/HJkWMjGDnYOnfogkKL3NhrivDvyIPhycUcLyrfh5IQYnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q9iy/hNi; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9iy/hNi"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-432d2c7dd52so2923603f8f.2
        for <linux-hardening@vger.kernel.org>; Mon, 12 Jan 2026 02:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768214869; x=1768819669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d5UWjql1jIqwyGnOZH7hD51P4glsDa+UHkdhwjjn4co=;
        b=Q9iy/hNi7iL6JFRKCDqgG8jZ4RhPdlsB5CxxUKIcmIzPsd/EEuI1s9+x38evB0iAIS
         I3z5Z3KKF4flkegwR5/yX0WJ89IvR4JFrunTOx7TGXVd9Gh1Q/tgQ7SKVrsD218DA5ru
         8Ekp3zmhJ9ZoRibVsjTIwHz/Sfh6e14TBBZBHkaLImwSbBW0jj7XyJ5h+hSX+XR+PDPJ
         WKxlFT+56PntrD5M1lQIZzKEcM3O7QFSHMAzZubHkZSS8oFPK6swqRrW1rcJKzm8pQZk
         W2e7wDGZhkIZCn1xU2koyOC/P2kczEeydzsJHR/HAxu6pk4iYDuP0RZu/bBW40UgeZJ5
         NBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768214869; x=1768819669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d5UWjql1jIqwyGnOZH7hD51P4glsDa+UHkdhwjjn4co=;
        b=g6RdYgDBbI5p34KG/TgEoW8jTC3iby6lOht+Ux9He168KU2M09jfY8khiRAXwmKvcA
         TD21zuqubwpicCglhxUbbFKGihCTqwGD6oO1Hq0i55o6V4xqJQa/Dcqln2HnVa1VaKwe
         7w1dLurUKlAnLJhRtmJwLhr4TWUSgStY7gDAIlCGfPPOkJAe/kmyX0tuE+HWKPjF6w/u
         aeTH0SV6YmativxFrx17oIyWyxdeNQ0K25m5Gvz+i916aTEkZh4ULeSwMmEBeWMmdWdy
         u5oNRtVPT6xAxdjmLruVxssrzhi2AfvNdJwQHMWPOkRoTMszJDFx0yrPDBUKtK7B9uc5
         f7kw==
X-Forwarded-Encrypted: i=1; AJvYcCWy0w5zfQec24RS+Z4k/5gkKy65SQm2LnRi+99WytLnfaCOW6GqIxdPe74bG6C61edvqLXpTOsLzoD6ZjLg470=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeYFmNCAlZnWTDGkcDUeKnI9S2nRLf/TdR/Hx3YFvhBgJtsOUa
	TrYzbeqBGOtCrYKcCH1NBtP9kXj0pve3XyIlA24ZrbVeVhswXgLk3sZT
X-Gm-Gg: AY/fxX567VcX9RnTOwJInIb8BCOZRmprOzC8M1g80pf5VLd/vhujE884VrbC3ZyPPqx
	b8TARUrarYo0imZO8SqwXLM9JL4ZYa+Q2egPqrCgWjPKcBAPddtwekcmUI7QOTWsNFEyXRb4iTX
	6d9Q82LyYE+PKVtH3RJ59ZNk1DxHrAWR1FYPK8K2O0rFqTEZf7iJk69Tzdd6mac8IbzdeTIa9Ik
	JfGP9raOplPyedB03jnWjZqFf1MmeSOz7yu5Q7/u2ffpu89ER5aTPVgs3phJgw/bL07GN1h2ptm
	VC0kJdBkBZZpSCQMgm8JiTTCu8WQBl6Iqh3LgwzyP5r+BhSemyYXgZ4Nz2Yx6K9ei1TobQxxmt4
	kZQZSWhm0l1eBDT9z4wzc8MDSaz+r6JO93qHks7neI+r2n0dtAwcBA8r7FQmXRj2HrlGirvVxCM
	Mcgc2DYsWJPzHpGUq+VSxdVQGEPc4D+Vp4YNcT4glbWTFox1wrx8T3
X-Google-Smtp-Source: AGHT+IFXFVtTeBvoHzEED0vI40Y0CdQbat8YtdBXem6XfxPsNJMDhRGYeaAfb7zh3DW9IGrAgmwNQQ==
X-Received: by 2002:a05:6000:2c07:b0:42f:b9c6:c89a with SMTP id ffacd0b85a97d-432c379f5d3mr18542127f8f.49.1768214868496;
        Mon, 12 Jan 2026 02:47:48 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5df939sm37629155f8f.21.2026.01.12.02.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 02:47:48 -0800 (PST)
Date: Mon, 12 Jan 2026 10:47:46 +0000
From: David Laight <david.laight.linux@gmail.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
 x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Kees Cook <kees@kernel.org>, Uros Bizjak
 <ubizjak@gmail.com>, Brian Gerst <brgerst@gmail.com>,
 linux-hardening@vger.kernel.org
Subject: Re: [RFC/RFT PATCH 04/19] x86: Make the 64-bit bzImage always
 physically relocatable
Message-ID: <20260112104746.6521740c@pumpkin>
In-Reply-To: <3f2e8d7c-6029-49ef-8e31-a3eb5efb385b@zytor.com>
References: <20260108092526.28586-21-ardb@kernel.org>
	<20260108092526.28586-25-ardb@kernel.org>
	<3f2e8d7c-6029-49ef-8e31-a3eb5efb385b@zytor.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 11 Jan 2026 20:01:02 -0800
"H. Peter Anvin" <hpa@zytor.com> wrote:

> On 2026-01-08 01:25, Ard Biesheuvel wrote:
> > On x86_64, the physical placement of the kernel is independent from its
> > mapping in the 'High Kernel Mapping' range. This means that even a
> > position dependent kernel built without boot-time relocation support can
> > run from any suitably aligned physical address, and there is no need to
> > make this behavior dependent on whether or not the kernel is virtually
> > relocatable.
> > 
> > On i386, the situation is different, given that the physical and virtual
> > load offsets must be equal, and so only a relocatable kernel can be
> > loaded at a physical address that deviates from its build-time default.
> > 
> > Clarify this in Kconfig and in the code, and advertise the 64-bit
> > bzImage as loadable at any physical offset regardless of whether
> > CONFIG_RELOCATABLE is set. In practice, this makes little difference,
> > given that it defaults to 'y' and is a prerequisite for EFI_STUB and
> > RANDOMIZE_BASE, but it will help with some future refactoring of the
> > relocation code.
> >   
> 
> I don't see any reason to support non-relocatable kernels anymore. In fact, in
> a patchset I am working on I have already removed it.

For just 64bit, or 32bit as well?
The 'bloat' for 32bit will be higher due to the lack of pc-relative
addressing.

	David

> 
> 	-hpa
> 
> 

