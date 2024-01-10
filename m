Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E8ADDA0
	for <linux-hardening@vger.kernel.org>; Wed, 10 Jan 2024 05:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VualP6Tk"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-203fed05a31so2516900fac.0
        for <linux-hardening@vger.kernel.org>; Tue, 09 Jan 2024 21:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704863412; x=1705468212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hqYcNWY0+b4B+ZSOG0sn5MgB4C9W0WVUcXjDmWofD1Y=;
        b=VualP6TkUfHsIjmRB07FzILzkiQk8aUT4StQEsGMZPVngz6NTLiejhQpAcjItTlTMX
         gDycuVtkj3RPxxCrCYCdgkEPjQ2+wKvj7C8GOU2VucCbkjsBy5Wt4N7ALv9KgW7XCnTK
         moSDemU4A5teYf3TFFZnUoprQW7a4FjdL/vUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704863412; x=1705468212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hqYcNWY0+b4B+ZSOG0sn5MgB4C9W0WVUcXjDmWofD1Y=;
        b=Dp6aS6yHuEgLo7n3UkBSnwfcEeYRXD4WO81lJUtydFJPY0aICM7wY5Nt/fL0sg5wXz
         eedveq9lKYSIvrhCY1q8J1SdzwCue5BIWKGN7Y8nbEshflqUDhqhCiIdv+SuQKa83QiA
         dCcjs2QNA3mQ8ilu/tIYHEMYh/HGMANGLjqxRCgnd9dvzKxWloAu+wqj3tN5d95nGeI0
         +VwclOitto8RrA6n4USj5iDmw/S9BgGLSEMS/SIuXWS51xRbOeIb5NcBIgM1bam0/OY/
         EVlUxgd23zKBgXaFz2LIrRj3UzvZ4PMKIQmdxDqHRcIZqbmyHejVcf9gKN2GNWqYYzp4
         FiTw==
X-Gm-Message-State: AOJu0YwdBrhOpRaWqf/Spvao7ZtxcQWiOgH0yK3jAafcJ6ubkaRe+VdY
	pqDCcmAIDhqcY5dKcnVE4ABLg55bHIKO4jhH340C+EUwJJX/
X-Google-Smtp-Source: AGHT+IGNsvR7puufHhdh8BMcPQbS0gnnOxM0dRuq29mQYdK8iwWzGA1wLv0fQE2MxP5JUCfTd+Ie7pgIvAzCeOBeYqE=
X-Received: by 2002:a05:6870:1b8e:b0:203:ea22:4d98 with SMTP id
 hm14-20020a0568701b8e00b00203ea224d98mr235952oab.87.1704863412576; Tue, 09
 Jan 2024 21:10:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109154547.1839886-1-jeffxu@chromium.org> <202401091144.2C203AA7@keescook>
In-Reply-To: <202401091144.2C203AA7@keescook>
From: Jeff Xu <jeffxu@chromium.org>
Date: Tue, 9 Jan 2024 21:10:01 -0800
Message-ID: <CABi2SkVGW5n0NJqa_1RHnXt=GEizm0ixvGiu+F_mStFwx7pjQw@mail.gmail.com>
Subject: Re: [RFC PATCH v5 0/4] Introduce mseal()
To: Kees Cook <keescook@chromium.org>
Cc: akpm@linux-foundation.org, jannh@google.com, sroettger@google.com, 
	willy@infradead.org, gregkh@linuxfoundation.org, 
	torvalds@linux-foundation.org, usama.anjum@collabora.com, jeffxu@google.com, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org, deraadt@openbsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 11:47=E2=80=AFAM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Tue, Jan 09, 2024 at 03:45:38PM +0000, jeffxu@chromium.org wrote:
> > This patchset proposes a new mseal() syscall for the Linux kernel.
>
> Thanks for continuing to work on this! Given Linus's general approval
> on the v4, I think this series can also drop the "RFC" part -- this code
> is looking to land. :)
>
OK.

> Since we're in the merge window right now, it'll likely be a couple
> weeks before akpm will consider putting this in -next. But given timing,
> this means it'll have a long time to bake in -next, which is good.
>
Thanks for the heads up.
-Jeff

> -Kees

>
> --
> Kees Cook
