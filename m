Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=74.125.82.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793278843;
	b=opN8ZlTzC4NnnYH6JjE1L8TCx57h03/v1zG0KiOdCLHpilHv3cAuRmOLRJ8E4LN4Muqa
	 uiBKCFay4NBMG9dCTeP0j3EWOOcZIuIYTYPrdp9egZdJsXYBA5rHQZKjAoDbTv/A7Fhs4
	 Emr62lYiUDDyy9hZfp/vv/LcblhP4ptXrOuEEHyN5p7RyASSqmvMZ/ATncncKo9D4hWAG
	 t1/Kk5M7M5+Ggy5cj7Lt3RbNCBBHHGUsRZfS4zSkgcwYGEQOqMbmrjQnZ9u3EXLZtFyOU
	 uHC79dd4Gv/OIe7ekXITUP7e/NwzlxmO8B+yDZE2KRVR6tUw0R99we/1MCMYPRA8paQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793278843;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ganH4EWpICXirAxibAD+5YRIHmRwYY6kvCGrRyrhM1Y=;
	b=MTcGbFORLU5LeRRFUELr5cOi0aKP6fYfA5+xzGGYmLTNdWYAXf2yuvwCwPSVTETUQdhe
	 WOfDACSS5dz35qr5aSPYAF0tzBX8xw/4529HxsrutoPptTEoShC0QrzStbcaZXsTJg93k
	 VQGR7RwHKACFFZLgiJMl4qZSiO2yWdIzEXrlx4EU6KW7Gjb+0neltcc+PqRkJQZg9ItTt
	 Q25IxEjrEcNOuR0Ugr+wL04YAjwWL1ozhMgWPb08zo8eXM+jQZLav+SMJXg7BQhN7Y/kM
	 Se89pV75v8ODlTA4IvXv57qOzSt7DmZlLlbvRkAw59mXrVLqJsi1Z8g3Dsr6iiWNKkA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ofPvZk+o;
	arc=fail smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2309606A33A
	for <linux-hardening@vger.kernel.org>; Thu, 29 Oct 2026 13:00:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2309606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ofPvZk+o
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-36a10095f3aso279600eec.2
        for <linux-hardening@vger.kernel.org>; Thu, 29 Oct 2026 06:00:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793278842; cv=none;
        d=google.com; s=arc-20260327;
        b=nEwlUhOT8w/MRSJdwes/y2RpWPzc5e5oIavcByH0VVt1C0PPSt6WJsgKHMnkJzXBNl
         TOMvV9W5Y6giGw3EfJAfl9C9BpkSwWuk+Sk87lDgODXIBh06dGDnwX9udJn71F0SemZr
         7IyxsFBf6EEEs3XUHC4Ju/JC4IJDG7jXMPUkdHjPSj5IFcIjTw8QNMvyYk8GA4KCsimk
         BO4LYvfdx+P9Al+lFGt635KzB90a7jF93eog4bX5ZvllBzTcKEv250lTdSbw8hJxwBmG
         6CI8Tswe0jwGrOYoHZuCMX5xzJ3vefbjiQaiNe1ekajYArIaYR4ZLngY8TKmDuwVIX7g
         ACKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ganH4EWpICXirAxibAD+5YRIHmRwYY6kvCGrRyrhM1Y=;
        fh=hHuGIAQw2fOUFw0qQ9g87tuWq6zNqz40V1VCFj2bb9Y=;
        b=oD5RRGqU7FY35WNzGG/1cpEoOJd+mzCjFgJOo5i2q+iFify24+7JaUGAgZM5bE9d9l
         tyANq3dwkyUuC8WhO2zuLMxrazvGQ/joWFubDd9tqICe6Ei+sGpG79PsiSQmpi16cDk/
         rspVADuWnqYSYNh92zRBoQAY4CkdvFMcty6hi7+zrkGOYqKVL+lozCxnXgTkMsU2XxpP
         3Wla0p6ozSPz+zF5VRglI7EPRDa8ykUrbht7ud/lGpnWE0QIicfxXkjGheGvboUciBzG
         +bVKtvUudPKh9iMs8xNtfJO4s6AckvKT38kWauz7gYysXNxdBAH10wt+mHO+6T+us/74
         mUTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793278842; x=1793883642; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ganH4EWpICXirAxibAD+5YRIHmRwYY6kvCGrRyrhM1Y=;
        b=ofPvZk+oAY1UtBN8lfS9Hjg636A5yXXxymVbjphADhkntlAvo7d+OJU8vVQ+Az1YKb
         dWukwXu2x313G1oppF7iAuhlMKCT3diyXTgTlAKXWjGM+Iwm50zBqxbGFoqtU4CjQPRi
         ToYeRwJPj5xeiznntBlX4VFyiQuMizC0YzA2Fycqh5ak/5xu31DBjOip8vO4Z2tuK/4f
         9PhR8pLQtraxqSwScA6jTPUn2IoU48Ael0NpD7F/lfQbSWkS9kG+njGnjZ8V4i1r6jjs
         NKUP7iwgO2CL1t6jHHe5bxmc7L4p3wIS4RcYs0ebru/xZh/T2s+t/RLRgJoRw7N6mzGF
         pkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793278842; x=1793883642;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ganH4EWpICXirAxibAD+5YRIHmRwYY6kvCGrRyrhM1Y=;
        b=aQ1mnoh2YSoMS92DrdAFIL8JJaJJwnsskokbt36RbxufGTTmLRjE1RfeA7PFxQTvJ8
         UUhKQnnGhU6N211dmNcG74qEoOJr3dXgyoCBJnTYVYyZPdTNRq3sXoS4ev4P1wwCEnCb
         gCtH4XOiyQHurpaZgF00fLujZR9dR6vUUwDp5JIR/oUARvoRosy71O5GkxmbqcNqA35Z
         +yWwwdH06UWv3q3/UP2hDFLEfmKDokTQyQcRY2+rjhVZDpsh0Qdx8vaDUtbNp7AYE5ZM
         Z6ac08CzZbc2aX1gwC3bK5kWY7PQhk9Yqcng89v7uxMXKM/fl5ulykyYkvXnv6+FmTx1
         6URA==
X-Forwarded-Encrypted: i=1; AKwUvBzhFgstclAEhavBhk/fVSv9v7Es9Ld7AwV9sjgn/Sn0jPigED4jfs6mW2TtWcthpgjbdX02rwY7LH2XnLj53DY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKEc9T5hb2VpZaZqileHuCyKrq3en6ssXlqCWNcqGPJhhh8cS92
	CS5vNgeMHj7NkAm0ghb5DzsUBv5F8YCGRNsuTDdhZjQK/xlkbbBbwumHRmzMpIkz/Y4rD1Kpz09
	akBUO/hb14/8UoRLxneW22bqGAQSsm1g=
X-Gm-Gg: AYBFou343U0jJPuTEc0haYaDsyVzK6AOQmdqM0pdjYn+lh94q5cZcc0rZqAsHOgAR14
	ZDfD+G+JDjEeaLzdpdXx3Dx7ckedBjtaBjYSV0lIz8kFG5nzyz9P8e6OjA5HIFVjAQIk6rjDs1W
	xxFSQHPwRh6rMjejRdD7/8kLEIm3MokcnTx6Qg4kSpQW4C2uBuvrJNLioet3DFk8UJ8rOZ1mJgU
	NCvnY+2W42F6Krcy+5fVg3pHtwOmUQ06KAHWMkblxR46RZ265xXHsOmNrOEOfBTMsuceTmJ9fvR
	MEA8B+gJt+14oqSJpuvWYoxFw1QeLlPqK7LuudqReDkckqD2Nh3qgVrGEmjbF7WuNRiC6lqJFbY
	4PE2pmLv/03w1PysI4y5SS30sWI2HU73AxyEdMRsEzSDNNXwvjmWBMsORAu4FgUmjag2XwxRok+
	ZIRI5PxzbUk5Ks+G/WqGceNXJyEtDCaA4BcXoCiPobeyYtv9gM3NzxXbKxqPUf5I1cGnyJeygEd
	/x99t1KEmq7K31Nsyl2GJP3iwCjLG6I8Q3ERg==
X-Received: by 2002:a05:693c:4196:20b0:36a:e7a:e89 with SMTP id
 5a478bee46e88-36a202cb0e4mr12034617eec.2.1793278841146; Thu, 29 Oct 2026
 06:00:41 -0700 (PDT)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1793027261.git.d@ilvokhin.com> <5bfdc1491d297b5e98cf42322c790f06481c28c7.1793027261.git.d@ilvokhin.com>
 <fb3b6a24-74ca-4da8-8593-352afd515313@suse.de>
In-Reply-To: <fb3b6a24-74ca-4da8-8593-352afd515313@suse.de>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 29 Oct 2026 14:00:28 +0100
X-Gm-Features: AclHuK_VOCF7u599iESvOsHhN0DoC1VeK-LagvEMwpUC6WNOUUTl411X-macJoc
Message-ID: <CANiq72mMm75svCqevd8fHtVoczDpvpo4NwL0SC8=bWy030vQuQ@mail.gmail.com>
Subject: Re: [PATCH 07/10] drm/gem: Switch to __nonnull_args() macro
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Dmitry Ilvokhin <d@ilvokhin.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Whitcroft <apw@canonical.com>, 
	Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, linux-leds@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 8:32=E2=80=AFAM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
>
> Should gem.h now include <linux/compiler_attributes.h> ?

No, it should be included for you (unless you are doing something
custom with the compiler flags etc.).

I hope that helps!

Cheers,
Miguel
