Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8185410A17
	for <linux-hardening@vger.kernel.org>; Sun,  7 Jan 2024 18:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bStquiGf"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50ea8fbf261so1104141e87.2
        for <linux-hardening@vger.kernel.org>; Sun, 07 Jan 2024 10:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704652929; x=1705257729; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s0prdEAj89MfCO6uINX9NF3GFv49wanD+YL5iJFREZs=;
        b=bStquiGfXB78TOKeTSMx6QP5PWm5mQgB2XAtLeCaNGkEJMxqJAfakmzbF2iMETpI8S
         Ga02jpnDeLrhIlGA3lFrFAdDyPLQumYYj2uqYlrLsvnUNc742Xa+PaNw9pbCJ0fjb2Yi
         up0yAiTAwkCqEJBkFDKLqFwQo2CdrAfyqQ3XU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704652929; x=1705257729;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s0prdEAj89MfCO6uINX9NF3GFv49wanD+YL5iJFREZs=;
        b=OZlJ5X1yny7cXH/wmwHFydjAYWm2lccvsfDoBiABxvU6h22+XoCsHc7KEedw+qS/Md
         7MNYBZDRfJp1vQ2ef35IK4TWwKMBjvjLFjsTTbUr8K6xWr4PtlSO5OA8IU10TChoafR0
         UPpCnrXbBvffbiEKFZ5dVu9XL2Iv1jvlH+m0wYKkaBGNzeNRAaOMPiBkuog33/A8IeYa
         1H40AdQep4sYmBcLAnG5FMcr1RU9bN06AE8XpnO6GUHFgSTHL+O4aNzwaVflFie4SSLL
         ht2gNOkIfycRtarqAjpgXbkBebRUbtOVpCbj9/Tfw5RKAAZNLcM/mewJEadpN7eQCbr/
         KYeQ==
X-Gm-Message-State: AOJu0Yyt8PtMbYMhQ45a4rAFSPrdddInYNmbcQJ6CpONB3jZH6Mi2NzC
	ByxzbH3uMOi+B8JFNmJInbYQaJxiz9pXaauwXJ7E/3FTG3zHxIT0
X-Google-Smtp-Source: AGHT+IF3U+Rfu9DGjonXk96g+MfeZt+DR5ZGU22Js9MkNv+NMp5bFwyZfB092hIp7bUANnAC7MErhw==
X-Received: by 2002:ac2:4142:0:b0:50e:69ea:1264 with SMTP id c2-20020ac24142000000b0050e69ea1264mr773282lfi.43.1704652929334;
        Sun, 07 Jan 2024 10:42:09 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id dx4-20020a0565122c0400b0050eb79db2e6sm629811lfb.280.2024.01.07.10.42.08
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jan 2024 10:42:08 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2cd3f7e2aa1so11697161fa.3
        for <linux-hardening@vger.kernel.org>; Sun, 07 Jan 2024 10:42:08 -0800 (PST)
X-Received: by 2002:ac2:548b:0:b0:50e:7dca:7f93 with SMTP id
 t11-20020ac2548b000000b0050e7dca7f93mr823836lfk.77.1704652927542; Sun, 07 Jan
 2024 10:42:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104185138.169307-1-jeffxu@chromium.org> <20240104185138.169307-3-jeffxu@chromium.org>
In-Reply-To: <20240104185138.169307-3-jeffxu@chromium.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 7 Jan 2024 10:41:50 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiy0nHG9+3rXzQa=W8gM8F6-MhsHrs_ZqWaHtjmPK4=FA@mail.gmail.com>
Message-ID: <CAHk-=wiy0nHG9+3rXzQa=W8gM8F6-MhsHrs_ZqWaHtjmPK4=FA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 2/4] mseal: add mseal syscall
To: jeffxu@chromium.org
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	sroettger@google.com, willy@infradead.org, gregkh@linuxfoundation.org, 
	usama.anjum@collabora.com, jeffxu@google.com, jorgelo@chromium.org, 
	groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org, deraadt@openbsd.org
Content-Type: text/plain; charset="UTF-8"

One comment:

On Thu, 4 Jan 2024 at 10:51, <jeffxu@chromium.org> wrote:
>
> diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
> index 9a846439b36a..02280199069b 100644
> --- a/kernel/sys_ni.c
> +++ b/kernel/sys_ni.c
> @@ -193,6 +193,7 @@ COND_SYSCALL(migrate_pages);
>  COND_SYSCALL(move_pages);
>  COND_SYSCALL(set_mempolicy_home_node);
>  COND_SYSCALL(cachestat);
> +COND_SYSCALL(mseal);
>
>  COND_SYSCALL(perf_event_open);
>  COND_SYSCALL(accept4);

Move this part to PATCH 1/1, so that it all builds cleanly.

Other than that, this seems all reasonable to me now.

                  Linus
