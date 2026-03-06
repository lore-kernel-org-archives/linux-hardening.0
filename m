Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8488C371D0B
	for <linux-hardening@vger.kernel.org>; Fri,  6 Mar 2026 19:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772825120; cv=pass; b=saYjThrMO2+p1c6o/0j7KDgBxaY0NgAXso+RZQbqW3Q1t5UwvhuHy2MZNl9Af63iLdSm9yWt2TPXpRqPPQX4LzSSZqA2g+liIOQVJj+X7Pj4JvLQUjhXObPdh12UvhRT7Pzev3lrYCe2nH6HYOpRT10FDxflQaQiDdmZHDePVMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772825120; c=relaxed/simple;
	bh=nSRTaUyOy2CdPO/r9tq8gDn5OQlNwlgXiGGi6Uex0NU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HNVszdHDB1NvX+HXKDfSm3+l7jVQdXXJIW9wI7PPiaAsNSK65bDSQtl8k/mV/xFSv5aDsslO/3/YxdPMym/ydSy/hwT10K4Mmu8T54NU1kJekYvXIYkoesaDweTDGGR1SasJtVcdJ+RMVlP5bf2EG6gl2JfB1lTp2IIFlzcwDK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dhOYraCI; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhOYraCI"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7966d747c84so8656927b3.1
        for <linux-hardening@vger.kernel.org>; Fri, 06 Mar 2026 11:25:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772825118; cv=none;
        d=google.com; s=arc-20240605;
        b=WYNAnRxhDmDq/NB3P+mQyeA+Y3o5eryIc3O4wi/Bc7efUeFwvL4ZvPYvXhtGscp3h+
         wdA2YFE5Bd8xpYEW3/Cf1z9e8jN3YuMNIgN2PyHL+SBTphr6LI//9koOlNLFsgqBE9Ho
         6yUisMQGBvjyPNY63WrMo4LQPnBr7Kcz5sWzdauZOoQquNz0kXWCHg/DMV0WPVvzMv5m
         Ce8PNoQHW7gmNxF5wI41vsfIv3AR0n5c937xzlkBfZso4fQMsI/aooGfGJYhhuzwnfAa
         KsEbeygEbWXPTownrpNHMH5+xIpelhi5m5oij5SHNN5Sf5GGpNOu2cb3QxQbTrfNdwX/
         Qceg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=lY6sP4liFUCfsR0JZcNZnSXYRH2hTABEqRhwR3Jxfn0=;
        fh=bvFhubQunx9cZIEXYNtg2f7eiZ85UfS7XKOwrz+UOvI=;
        b=HYRfvuw1pjmtiZrN9rryO9LQDn2TeWMyQ6JIdlxWyL4yk6djvlbFd4Nvfvrp957bD6
         RYOS0kQlj0pNm/1/wS5jbEw6WwB1B7ClUWQJ5cxH7tnYvj0rF7bT31+1fUnQB9k/L37e
         JA17v4CNf+L2lE1c1zJ5+i3NyJVnN5G108HCobriXmLGvXqrNOWGeGMUGBSGr/PAXET3
         v5WKwG9V91SoJA2LGccUSKC3+iDyBq1RjNgKQalrA9w/8HLslmass6ouiu52YpuVriQI
         3/BSHXQH2+V9bM6K/sDv3A7WxKCH1nrSmRjPJr6OC8cHOzBrOJNMW/sI4EPqGy/qwkX/
         9lIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772825118; x=1773429918; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lY6sP4liFUCfsR0JZcNZnSXYRH2hTABEqRhwR3Jxfn0=;
        b=dhOYraCIRvlH0LLarMfjDp5ZclM40S4shv8I38CVRiE4iSia4rll0b+lsg9OErosb2
         Qrih/YF6dPH92q5MSpLw4PtcqJOHKLMpHYPmkTd5zIV51pt+XF1fLI3D3hPJLDIi14Px
         epc8zjAniUXe07PHSnslz3SisSs2EBTL3Npy6vIkKsMy5ZxskN62S4yuLWUSlNk/6j3z
         88tiQWUTyUPMr1ZAkbmXwXrNUP/cpbzrAk8NngZqrbIshAaUnrkzzd0vh0Q572EaeKyY
         /2HmzZM+ZdR1AmUlbNu2V3ecLDAWFObqWDV7Pzvoac+jwzGA0A53hr282m89OkNuYsvI
         /DTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772825118; x=1773429918;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lY6sP4liFUCfsR0JZcNZnSXYRH2hTABEqRhwR3Jxfn0=;
        b=Lyc/mwGijnKvqpggwDcyb8BncihbC6Zkx0ksfk+AwrkVlAndLEF13uTUvfo44vkl8g
         IDvO/tPru/IF4NGltpY5TA75tKEc85X7EFzB/e2oSL3y0pGJm0U2HdloDGdkNvWnWTH8
         EseE2kx1cOZ2yB5NCYlmQXyW21obtb6/sEzE6defXm7ad2OiWlNGMvUVysfH3Evt5IEE
         PVksOqxSbouqWV6H5kTL1xO0VhfmSiDpYMBF6Jc7tMjDqHxerDzUBjZRH1nQIaEGmcnf
         LGlUVWpQhSFiU7WdnD09sJlNaz/df/VbqnLGqhESLmwlkT/1JFcEbz8IPQ1dz5hgwuxz
         6q5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUgwqDUn+Ge0UQjhs5voWmJ1WhxgajWohQ7H0AQ3JfL9vnGoj9hrDczVfSMEFxaZz6WI33oBEFDmSf+oGckqEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaK2x4H63NX+e6Hikww8XvMzFgp1gEi4kfIXwV8ERFbYk0OQvI
	wXCWjTj2qAEQoa0ccD7fEMSFzJz7XVHOgGv/ajngv7YFUGtuTgi1mOosQWN4IDwQM3dXHkcLnAI
	ZnK5RXeHvVhFpA7Dolp2EgcZCYhAzgY4=
X-Gm-Gg: ATEYQzzo1wj4XxyrkCNVqSmyQN91PXF9EL1VmGmX6ZJjZfsCwHCnUExIfW47AW3npUa
	ORjwE/4Qva5L3hiUtG9YOOmF5tQgKOM581zFTrWZXFoIwjL6yEvNmT3uLQkfZA5qTL+z4cUARBK
	eCU7ap82unZPMc+gkfZwIbdhK/kJLa5rhT5+Xyqu0euirOiEKE9MYa8XxwOjymIKnknow5eGS/6
	B8jvLOI1g8rdN+ZXfjp8lj8/b9PZEH/ECAXD1+SH+wgaUCeyCrbW6PymHWHSTqS1ruPEJ3qOD0O
	Y/eiBQ==
X-Received: by 2002:a05:690c:15:b0:798:5ce8:f46a with SMTP id
 00721157ae682-798dd6f5b17mr24082977b3.3.1772825118598; Fri, 06 Mar 2026
 11:25:18 -0800 (PST)
Received: from 95991385052 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 6 Mar 2026 13:25:18 -0600
Received: from 95991385052 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 6 Mar 2026 13:25:17 -0600
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20260306150613.350029-1-arnd@kernel.org>
References: <20260306150613.350029-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 6 Mar 2026 13:25:17 -0600
X-Gm-Features: AaiRm51im8Opzhh4FrDhukBOYJIJAUVnJyGocvgFTBcd1zQhrlQ-HbSj120EYv0
Message-ID: <CAPAsAGzSybyM_GsP1JxzZTj=SFeN6K8t9uQ3XAXBWiN+019Wmw@mail.gmail.com>
Subject: Re: [PATCH] ubsan: turn off kmsan inside of ubsan instrumentation
To: Arnd Bergmann <arnd@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nathan Chancellor <nathan@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Kees Cook <kees@kernel.org>, Marco Elver <elver@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, kasan-dev@googlegroups.com, 
	linux-hardening@vger.kernel.org, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Arnd Bergmann <arnd@kernel.org> writes:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The structure initialization in the two type mismatch handling functions
> causes a call to __msan_memset() to be generated inside of a UACCESS
> block, which in turn leads to an objtool warning about possibly leaking
> uaccess-enabled state:
>
> lib/ubsan.o: warning: objtool: __ubsan_handle_type_mismatch+0xda: call to __msan_memset() with UACCESS enabled
> lib/ubsan.o: warning: objtool: __ubsan_handle_type_mismatch_v1+0xf4: call to __msan_memset() with UACCESS enabled
>
> Most likely __msan_memset() is safe to be called here and could be added
> to the uaccess_safe_builtin[] list of safe functions, but seeing that
> the ubsan file itself already has kasan, ubsan and kcsan disabled itself,
> it is probably a good idea to also turn off kmsan here, in particular this
> also avoids the risk of recursing between ubsan and kcsan checks in
> other functions of this file.
>
> I saw this happen while testing randconfig builds with clang-22, but did
> not try older versions, or attempt to see which kernel change introduced
> the warning.
>
> Cc: Kees Cook <kees@kernel.org>
> Cc: Marco Elver <elver@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: kasan-dev@googlegroups.com
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  lib/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>

Acked-by: Andrey Ryabinin <ryabinin.a.a@gmail.com>
