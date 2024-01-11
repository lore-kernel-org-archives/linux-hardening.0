Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC04E7FC
	for <linux-hardening@vger.kernel.org>; Thu, 11 Jan 2024 01:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Y03ezPx3"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40e461c1f44so44270025e9.3
        for <linux-hardening@vger.kernel.org>; Wed, 10 Jan 2024 17:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704937659; x=1705542459; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6u030KI6il12QBShR1lcsXxHEUIec68JdndFK14yRTA=;
        b=Y03ezPx3xDL8foZzVl1bYb/7PAZ7EEsvaKS07R5jv/MfUeByY7xzML9ud8IcFi3cJO
         NESzo7QMcbUtu0ssFCpMvoMCFKdOIEcR8hYUICTMDWNPv5MTzbm2kCdlEujS29iZHn94
         MRyxZddEaC2NkBv0LLqiM2ur73ux1KzHNtlao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704937659; x=1705542459;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6u030KI6il12QBShR1lcsXxHEUIec68JdndFK14yRTA=;
        b=P9Bj1k1sYU5ZXknvvZuB6lejPXwWECD2L54+J7/qPaoQylGzXI8qx4vtLh3o6HBqFV
         4CBIPavVXbU3vxoPZ86pKrQq407C2Ipu0AMg4IUosZPi3siVK79a53k+UcW8mqUtYiDG
         O96931RSK0BnvNj6nY2l6SjXmkLJWVkUz4rh0NjHbZRiDv6JlyPO+mSsZTzMu0jm+UqZ
         4Nw+qcodZsqiQbrNifGoI9ijRPwo5UkSdZ9MVDtgOBQOadZlbWDyDXLx4JlPFr3hP7HD
         zDglnUIw+++jBPY87fbjElzrtRNWdKES/xSMegBqnsHz3VTbegLX/EfcT9c23/s7YSxH
         1cFA==
X-Gm-Message-State: AOJu0Yyy8i33Xs2Rx7ZvvBRUrQfDWyEq7OIDwDmFQ9l7J8CVY4miZuMx
	8nabkNKo7fCdwJo8M4Q7msV51Dq/zd1Xt8qA/H25PuX59OBgYPyJ
X-Google-Smtp-Source: AGHT+IHUOqlG98zuA32EZqnuBCyb2jcqWIvKOE+46BV+ujKwjIUN6U4hJT3j9Z03+L2BWCzH2O+cAA==
X-Received: by 2002:a05:600c:4693:b0:40e:433e:8922 with SMTP id p19-20020a05600c469300b0040e433e8922mr149225wmo.96.1704937658762;
        Wed, 10 Jan 2024 17:47:38 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id mj10-20020a170906af8a00b00a26b36311ecsm9968ejb.146.2024.01.10.17.47.37
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 17:47:37 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55790581457so5068843a12.3
        for <linux-hardening@vger.kernel.org>; Wed, 10 Jan 2024 17:47:37 -0800 (PST)
X-Received: by 2002:a17:906:abc3:b0:a26:8ee9:9b31 with SMTP id
 kq3-20020a170906abc300b00a268ee99b31mr175059ejb.4.1704937657031; Wed, 10 Jan
 2024 17:47:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <wq27r7e3n5jz4z6pn2twwrcp2zklumcfibutcpxrw6sgaxcsl5@m5z7rwxyuh72>
 <202401101525.112E8234@keescook> <6pbl6vnzkwdznjqimowfssedtpawsz2j722dgiufi432aldjg4@6vn573zspwy3>
 <202401101625.3664EA5B@keescook> <xlynx7ydht5uixtbkrg6vgt7likpg5az76gsejfgluxkztukhf@eijjqp4uxnjk>
In-Reply-To: <xlynx7ydht5uixtbkrg6vgt7likpg5az76gsejfgluxkztukhf@eijjqp4uxnjk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 10 Jan 2024 17:47:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=wigjbr7d0ZLo+6wbMk31bBMn8sEwHEJCYBRFuNRhzO+Kw@mail.gmail.com>
Message-ID: <CAHk-=wigjbr7d0ZLo+6wbMk31bBMn8sEwHEJCYBRFuNRhzO+Kw@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs updates for 6.8
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Kees Cook <keescook@chromium.org>, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Jan 2024 at 16:58, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> ...And how does that make any sense? "The warnings weren't getting
> cleaned up, so get rid of them - except not really, just move them off
> to the side so they'll be more annoying when they do come up"...

Honestly,the checkpatch warnings are often garbage too.

The whole deprecation warnings never worked. They don't work in
checkpatch either.

> Perhaps we could've just switched to deprecation warnings being on in a
> W=1 build?

No, because the whole idea of "let me mark something deprecated and
then not just remove it" is GARBAGE.

If somebody wants to deprecate something, it is up to *them* to finish
the job. Not annoy thousands of other developers with idiotic
warnings.

            Linus
