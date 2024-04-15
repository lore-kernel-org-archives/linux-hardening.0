Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C8713A89C
	for <linux-hardening@vger.kernel.org>; Mon, 15 Apr 2024 18:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713205314; cv=none; b=r6/9Pggi5CRQEJqheOcI50dgnSoeu1UE0EABlwW9ACpw5WmtSeVfbhiBtiu+T06OG8axDaM8NKdbIulF47yHpKbDdtXY4DNvW7oG8RflZtHbOMPZ5W79sdFCJ8kSRMLJoHOuQJN79o0dBasugnsn0YmI3T9QqO6/KmDeQ6WIcqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713205314; c=relaxed/simple;
	bh=umxCZeWTQDH3zMqqM6T6ZP1c8rPGI3duZNpIriEi1gA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J0V1aijt+iKMqa9noEpBzurzXD4QYniTjPgQPWvXjk6/BTtH+bvQf890NhYMA6DtBUL3x9ezrb4RnLZgHoPhbjBUqnAsKr6BscbWj0QI/Wk4lWO1gFbfBeSVfuUIWN5FJMYeeNUEIVQvu/pKV8I2ES/SZ19397Z8T8KrQOlR3GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=N0sjVTh8; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="N0sjVTh8"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a46a7208eedso503561666b.0
        for <linux-hardening@vger.kernel.org>; Mon, 15 Apr 2024 11:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1713205311; x=1713810111; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yXQXQf6BkxnxREYjP8+VxnnUlawTjdMp0f5jlbh5Zh4=;
        b=N0sjVTh8hVSUrH0ksW3s6BU/zmJsqAJPjbFxBmbpjfDgNo2MaXVLv/L9UDwlWx/VLU
         BeM9bGCS0IYSsidRUf0STMJGhCWvnU0orvN5COtKGO/hKGF175+U7gYKpaJfCQTbUuBG
         Z7Fx92aNansBwOmagvaH7qz58u9eLSn+Ai/rE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713205311; x=1713810111;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yXQXQf6BkxnxREYjP8+VxnnUlawTjdMp0f5jlbh5Zh4=;
        b=PVczqXYobT4A76IMgx8Xy/a2nhAGDC9Ijl48ZbKUhlW7VbPKOMueLEftlL7EsDNF78
         tPwvV0GsYtsO0gwikOmC/r41xgDVV9m6VIUyKwh61ik5dEhLwtYy8OhjjBg/j4pFI95N
         SAy25XMjzHeTHWZ0kcQLOuuPyyGCwjDUgF2dqXIWuCjqbmf2RFYimzFW72kyXi8kkdwk
         JDLsvxzdgWrkchMY/TVDsWxrb9G2bKNG381k1RvhU5Wd72AmIokKi5+1j6aGL8FmO1Ou
         CgCj7zbCSfCLjsmbhwZV/xpC0oahiWvGImWjO3AfO3ev+WXyYzP1GONZrwfO7e4ANePu
         9Wbg==
X-Forwarded-Encrypted: i=1; AJvYcCV033UJ5z1m+y7RRLGfXDFI/yaauvejop80tSDZXq+VyAjYzw/4YMhtMbcffiIW18P/6pZKhZSUhJIc7H2/R41mPVOqL2APoOL8DNOabIqa
X-Gm-Message-State: AOJu0Yz9fo52U65lCepL7YW2xt5m0Jt4Rx0J3eA5SHmwoRdGGNTMRDr5
	odVm0SaPk5KPv+PYnc+4CpRC9e+N//zcJEfhO67ZOvY8CmsE3m6qSs0lgfEh/i4n4oI7r3AsYFG
	fVm4oFw==
X-Google-Smtp-Source: AGHT+IE8pfDWckSwYIdmJk8mO2h0OzeBwHtCgtuw8B55lKf0mqOCAMKHCYJMQavWyYDO55Y0pBt8Jw==
X-Received: by 2002:a17:906:1851:b0:a52:5fcc:2573 with SMTP id w17-20020a170906185100b00a525fcc2573mr2790829eje.13.1713205311150;
        Mon, 15 Apr 2024 11:21:51 -0700 (PDT)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id n5-20020a170906724500b00a47423b4c33sm5766178ejk.128.2024.04.15.11.21.50
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 11:21:50 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4187981999fso5239865e9.1
        for <linux-hardening@vger.kernel.org>; Mon, 15 Apr 2024 11:21:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV/oEaLlSRNKVIh1ciloUJN33K3AWlvMoIT+3s3Ofufxz5JMZ5pUwbv/jd/saNqh/oOwNiBWdETBkuJl6bXfXC0Z2YNwKjr9GSkcsD+qMhC
X-Received: by 2002:a17:906:110e:b0:a52:320a:6320 with SMTP id
 h14-20020a170906110e00b00a52320a6320mr6421452eja.51.1713205289339; Mon, 15
 Apr 2024 11:21:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415163527.626541-1-jeffxu@chromium.org> <20240415163527.626541-2-jeffxu@chromium.org>
 <d7ed2809-95d5-453a-9169-abf14a52b2e4@collabora.com>
In-Reply-To: <d7ed2809-95d5-453a-9169-abf14a52b2e4@collabora.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 15 Apr 2024 11:21:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiPPBab9FkjZhFogr7rwKgZyAqU1xx9xqK4Cqkq0LdeLg@mail.gmail.com>
Message-ID: <CAHk-=wiPPBab9FkjZhFogr7rwKgZyAqU1xx9xqK4Cqkq0LdeLg@mail.gmail.com>
Subject: Re: [PATCH v10 1/5] mseal: Wire up mseal syscall
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: jeffxu@chromium.org, akpm@linux-foundation.org, keescook@chromium.org, 
	jannh@google.com, sroettger@google.com, willy@infradead.org, 
	gregkh@linuxfoundation.org, corbet@lwn.net, Liam.Howlett@oracle.com, 
	surenb@google.com, merimus@google.com, rdunlap@infradead.org, 
	jeffxu@google.com, jorgelo@chromium.org, groeck@chromium.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com, 
	linux-hardening@vger.kernel.org, deraadt@openbsd.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Apr 2024 at 11:11, Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> It isn't logical to wire up something which isn't present

Actually, with system calls, the rules end up being almost opposite.

There's no point in adding the code if it's not reachable. So adding
the system call code before adding the wiring makes no sense.

So you have two cases: add the stubs first, or add the code first.
Neither does anything without the other.

So then you go "add both in the same commit" option, which ends up
being horrible from a "review the code" standpoint. The two parts are
entirely different and mixing them up makes the patch very unclear
(and has very different target audiences for reviewing it - the MM
people really shouldn't have to look at the architecture wiring
parts).

End result: there are no "this is the logical ordering" cases.

But the "wire up system calls" part actually has some reasons to be first:

 - it reserves the system call number

 - it adds the "when system call isn't enabled, return -ENOSYS"
conditional system call logic

so I actually tend prefer this ordering when it comes to system calls.

                Linus
