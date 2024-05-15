Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B848488
	for <linux-hardening@vger.kernel.org>; Wed, 15 May 2024 01:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715736065; cv=none; b=pvmkFxSu8cSgolvuClUOXtq2KBpbLuoqc77Rrh0YvEzXfmhGqkvUzh4qC3v4d/FU5hxcO6B11EcM/BGI1vBBElEYAa0cXuoUBF/BOpMjwWY56Ob9VSZ1sp92wpstdHD1c7tyfy2ujt0cunwrJ+9a2eaziWTejIrBZEfeKiaMbm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715736065; c=relaxed/simple;
	bh=RWL2uQhi8Ed+uiGVKCNPstf3I/C9ZgqT5ZURnuftkQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E3aOwpexFnNd3ivxa+Ql2uwLwp0QQ4KOJnd2uCOOFt2Mal28eK6Q8rXwLRU9jbcDsaDP43QJvQ9Mq81dAR2XOCSSmd3eHkXiUdAs8Hxqdk2kvgW4hdKuq5tc5IlpDrYCXdgGUjsW5JHeP+qf1F7qU5Wc37E3hSAG0vTcz38pVCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CgBQ7kz2; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CgBQ7kz2"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5231efd80f2so3805580e87.2
        for <linux-hardening@vger.kernel.org>; Tue, 14 May 2024 18:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715736061; x=1716340861; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nr8iJJBMAoKbZhUVSQrEstzktHb70Vrcza52uLAmnxg=;
        b=CgBQ7kz2KOQ7LB0p87VayYzsaKbYOTez3nuLT6ZueTeECNWbx5/GQxOE5X6MRuAQ4Y
         eDvyHY72iDzmLspX1AOK9C70CDgCN+7Cn5UGfgtTkHQ/T1tj+XQ+u30HfX3jiL5K7W+A
         1eGoun5rQTsKmw6vsk4zQN9CAd7yMbYCmgiXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715736061; x=1716340861;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nr8iJJBMAoKbZhUVSQrEstzktHb70Vrcza52uLAmnxg=;
        b=K1CKyZdgkLmNMQrofdyYGCwTlCLJX9MLY7V1h16L1fcy0NR/Q4cUTqrmKA+RW+Dyw5
         t9x5EKKBL3H26growcI9mUGyqPpJ/lXm4/yGLvriO0ZkYtg6GseMB/9wsqi0LFIS0nmt
         WClSeVGS27kKXIzlDo3wAORtw0DWuF7RKrlmr/o8GO0swY/Sqoqr/B72nFhzCJmjzfg/
         UGGRz8euoEzh4AGJC2r5ERKGUp4JZAimCVCUiPIh/TPLYGrrn7BP9dQfs138ZsfuYYnI
         EpISxGKfRSADQ/9T4v09iUifDmAlpqjtgLVepcVZUlqpVnn6L9TZ1iwvxG16yqSReAwF
         Zbqw==
X-Forwarded-Encrypted: i=1; AJvYcCUHHIFr7Fl5j/6RXgmFi0oXtPdjqSg8BAmq1FqrwShSu2ZjysIY/D/jIGictuKCX5KY2FP/1aO3E90qHjph9jdHulbC8GMApShvoJiwVd2o
X-Gm-Message-State: AOJu0YxgBK8GCUJxo+wRQk0Quy9746uvxpEuf2Fja/KJkgqGvnfBCyDz
	JGCW4O53YldmIiybsuP8P9CP3hs0cNcf7PTejW1otURbbE02f7FXOE0YbZnuoWnqzMde/OuHfpe
	Lw9Oipw==
X-Google-Smtp-Source: AGHT+IG4FJtdE8Gh9iEv4OTUKlMzmrAnl7KMkMbs+2oBLK4QuIxC4pvj5Zce3FoIzmnKBdDfH+nh0Q==
X-Received: by 2002:a19:5f46:0:b0:521:684:ce1b with SMTP id 2adb3069b0e04-5220fc7ad14mr8982917e87.20.1715736061317;
        Tue, 14 May 2024 18:21:01 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52389b09bd0sm158024e87.138.2024.05.14.18.21.00
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 18:21:01 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2dfb4ea2bbfso73647951fa.2
        for <linux-hardening@vger.kernel.org>; Tue, 14 May 2024 18:21:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWfTRmSca6TrR/F+0JMQ6WKve6z5DPZMLPEi45gRcvqEQ7Kn3wGZv+9j+uqRSjSpFfnmCa4aZ4cwQBoxyxF/jwXJx05jyMzQGxI/8K9KoPS
X-Received: by 2002:a17:907:9625:b0:a59:db0f:6bdd with SMTP id
 a640c23a62f3a-a5a2d5d56b7mr1123543366b.44.1715736040490; Tue, 14 May 2024
 18:20:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415163527.626541-1-jeffxu@chromium.org> <20240514104646.e6af4292f19b834777ec1e32@linux-foundation.org>
 <871q646rea.fsf@meer.lwn.net> <ZkPXcT_JuQeZCAv0@casper.infradead.org>
 <56001.1715726927@cvs.openbsd.org> <CAHk-=wgsGCKvN0Db6ZRZqJwXQrmhZyWB6RmABaOp4DiZbXgNew@mail.gmail.com>
 <16982.1715734632@cvs.openbsd.org>
In-Reply-To: <16982.1715734632@cvs.openbsd.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 14 May 2024 18:20:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi04ZCm3vTtkcVnAUdiOpX3a0hBZ-aQWONwCubOJQEdXw@mail.gmail.com>
Message-ID: <CAHk-=wi04ZCm3vTtkcVnAUdiOpX3a0hBZ-aQWONwCubOJQEdXw@mail.gmail.com>
Subject: Re: [PATCH v10 0/5] Introduce mseal
To: Theo de Raadt <deraadt@openbsd.org>
Cc: Matthew Wilcox <willy@infradead.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, jeffxu@chromium.org, keescook@chromium.org, 
	jannh@google.com, sroettger@google.com, gregkh@linuxfoundation.org, 
	usama.anjum@collabora.com, Liam.Howlett@oracle.com, surenb@google.com, 
	merimus@google.com, rdunlap@infradead.org, jeffxu@google.com, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 May 2024 at 17:57, Theo de Raadt <deraadt@openbsd.org> wrote:
>
> Let's wait and see.

You may not be aware, but the Open Group literally endorses the Linux model:

  "When mprotect() fails for reasons other than [EINVAL], the
protections on some of the pages in the range [addr,addr+len) may have
been changed"

at least according to this:

    https://pubs.opengroup.org/onlinepubs/9699919799/functions/mprotect.html

so I think your atomicity arguments have always been misleading. At
least for mprotect, POSIX is very explicit about this not being
atomic.

I find very similar wording in mmap:

  "If mmap() fails for reasons other than [EBADF], [EINVAL], or
[ENOTSUP], some of the mappings in the address range starting at addr
and continuing for len bytes may have been unmapped"

Maybe some atomicity rules have always been true for BSD, but they've
never been true for Linux, and while I don't know how authoritative
that opengroup thing is, it's what google found.

> (Linus, don't be a jerk)

I'm not the one who makes unsubstantiated statements and uses scare
tactics to try to make said arguments sound more valid than they are.

So keep your arguments real, please.

               Linus
