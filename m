Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65757267B00
	for <linux-hardening@vger.kernel.org>; Wed,  9 Apr 2025 15:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744212812; cv=none; b=Nv7nFZpmiySxWX+po3knQCayNEQUmwkrlHRwTrvsCb7XlkBRPI4u8UJYgHzkR5fbH7mM5yM4nW1Y+wiQk98Jfw19O/+/korkxCEX/76FIzbOP1zOSwwedL80lN+7/pJHSjdCKaSqfxn5FpTDaDguyIUiESyFMk2KpunLc2WdrxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744212812; c=relaxed/simple;
	bh=Q+E+gm5uopjkervKkp2H2F4qs52H2bSWJcrVdOv471I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rb2umJeQakW6tMH18vIC+4oii7ISbxSGQPTau2FmsA6Te3785987UnakmFQkaAwA+A+BtL9UsPgRyh3g6FxQUX1hgoMdCeJ6cQ3IY0m93u8JRjkGsm2VNiddXqmZNXZizH93c8+1SIDnJirEFLwSIh0X7SBmHW3akTIV4vNeqiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LdTC/CCz; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LdTC/CCz"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-523ed8ac2a3so3211516e0c.3
        for <linux-hardening@vger.kernel.org>; Wed, 09 Apr 2025 08:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1744212809; x=1744817609; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TdxP6TrUHsK7q8J2aaqhZA0bVAluAt8YBqPZ1F5Nh/M=;
        b=LdTC/CCzxEDHcpl+vmw0+nZoiNNPJWQyHMiRmY8lgDaIrVUH2KYHysKgMCUVVGO3f+
         v8Ky9SFRkr9RVqGyMKdfGoP7wNDgazr9gi6y0n4BXaFJ6rLXHOgw/OCCYM9v7p4/t1Vk
         0uuSEZVIuhlE6r48TQSRFYU3lbQ07Dt8XZNec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744212809; x=1744817609;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TdxP6TrUHsK7q8J2aaqhZA0bVAluAt8YBqPZ1F5Nh/M=;
        b=drDX2le0NSH2N00SH163+qO5KlyLRNTaO6gXXMVaz8VDtPuW5FBsMdOcmks55mltaD
         U0Ypaa727DwKrGksA9ZqUEZdzZOE1srKqXhy93WOzfS+C3WcVeBNSOWTU8iY0vb0N84J
         3ltLOBl9c9BSCTR/sPRrkJ17GE3q3OvHKOFz2Qeo2wh4jJA7e4xtJOvlNAQ1g0I77Y7a
         bqiE1RruTl4jLVYXqWlcaFsC8QecJLgFRvqY08DvqL6F+yrcCemD5nG9VL3Q0trGUCzW
         aIBOfh89xpggTBoRK7ly6lpZKFVTU7Ge8/OQhO9Drt6AOzqPo2ZkqQKno0Hi20lKdTKD
         fXFA==
X-Forwarded-Encrypted: i=1; AJvYcCUL4WgTbyDhrBAVeRwVMVlpzlY9bxF5R0j4cCcYNmBbZjGL2tw9VFqokNVgJpM8t/iMj8xIZC4lXrPKne00VhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIE+38Hsnnl9zen0QXUcjgANJ79726JOQaFYasAp2aoaMUJ70g
	r+UdicBdy/hyrWSp+29sKun8vNhXGnRE0puuualm0CxQ2Nzytm9D1/YBOriy6QHWoZu5dyL44MR
	Bwc3Ujw==
X-Gm-Gg: ASbGncvPUuJ8ccxEWAorRzHjlwUwE9/En67tAg52hqtFVenWQdXHO5PnWr3itdTJCAV
	ZcltRGmTIFZ+l6CbDHzdWQge0rg89BK0WEsrMZ3MZuGU+nsfryg1yFcnUYqIgLX09a3mJl5uQLG
	rsm0nIyAl7tRbJH83vkSneQe8C0ttKRGwrGFsurlhfRUNM6ZaBbu9hQX9PId8xPIQWlq2VBTe8X
	jhZ33BXXE5D0e7IIvwf+UjcOI8Eoq4rKak9lCtotsc7+1s++0Fhu/1dMp61KeAlp0oI7JL/aGqo
	bkxJtvgJE/hQIyOADZ8FUXHiC4AX+m3jc//w4K+uDlPoF3w1QC3Vr4zYHQBlCQswDpwjFm4rS51
	hzbAUxId+2YiPLhU=
X-Google-Smtp-Source: AGHT+IG5+gUgH6JZIp3pam8VkwhVigzLkUy41JOWpO2smKuLgGu3fBa5poDZrwHn2BRIr+twrLkzKg==
X-Received: by 2002:a05:6122:3c81:b0:516:230b:eec with SMTP id 71dfb90a1353d-527a91a11e8mr2877495e0c.5.1744212809132;
        Wed, 09 Apr 2025 08:33:29 -0700 (PDT)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-527abd7495bsm259961e0c.14.2025.04.09.08.33.28
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 08:33:28 -0700 (PDT)
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-86d3907524cso2927429241.0
        for <linux-hardening@vger.kernel.org>; Wed, 09 Apr 2025 08:33:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXI0JczYz/aNvbusQyWhIMFudBQhCLf3Yxqd7m/PncySL4I2ZN4PKNMpJ2ph/3WwGCQVT5Orhjrq8U0YLo3J9A=@vger.kernel.org
X-Received: by 2002:a05:6102:91c:b0:4c1:6feb:83aa with SMTP id
 ada2fe7eead31-4c9c41a2f70mr3107478137.9.1744212808088; Wed, 09 Apr 2025
 08:33:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407-kbuild-disable-gcc-plugins-v1-1-5d46ae583f5e@kernel.org>
 <202504081630.4CE88E855@keescook> <db50faff-7290-4193-b861-f60e36f1d1e3@sirena.org.uk>
In-Reply-To: <db50faff-7290-4193-b861-f60e36f1d1e3@sirena.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 9 Apr 2025 08:33:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjc+piYyUw36s4ttEkY32jVkxhRtyrt431wew7XcDS2Qg@mail.gmail.com>
X-Gm-Features: ATxdqUE2pdW27qPIvkrpo9DrN9_CijkuWYa_if9ESQH0ro1aFZDLb4UaGrE4hZA
Message-ID: <CAHk-=wjc+piYyUw36s4ttEkY32jVkxhRtyrt431wew7XcDS2Qg@mail.gmail.com>
Subject: Re: [PATCH] gcc-plugins: Disable GCC plugins for compile test builds
To: Mark Brown <broonie@kernel.org>
Cc: Kees Cook <kees@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Apr 2025 at 05:20, Mark Brown <broonie@kernel.org> wrote:
>
> Note that the patch is only disabling for build coverage builds where
> the resulting binaries generally aren't going to actually be run.

Well, there's a reason we do build coverage - we also want to test
that the non-build coverage case builds.

And it's not actually obvious that it does - it's in fact rather
likely that the gcc plugin is broken in general, and it just so
happens that it's the build bots that find it.

Which is why I honestly would prefer to just disable the plugins in general.

Because the problem is the plugin, not the build coverage.

             Linus
