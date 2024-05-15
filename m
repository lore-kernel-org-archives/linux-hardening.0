Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F2822EE8
	for <linux-hardening@vger.kernel.org>; Wed, 15 May 2024 02:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715740175; cv=none; b=gMwWGuMpmMeXbFGT0OkRg89ttPtUj5Ze0XBXe85Q+YC3udqXmyBLFvpUPxX318nKqJTT8Fz5BlDE/ofBM9YQj7/SORMLFxcyGA+WdndOUrGtHTuC+elcD0lQ1UO5BX1V0vEfrfiPKNaFanD29k8ru2lYFJ73VI1970XjbuXNwSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715740175; c=relaxed/simple;
	bh=uIVALT8fMTxGKl7HLSAvodUgkyb/d8KBVovit9yBBdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mr6kt3RzqWKDWMoU9eH60g4ettAtVAF3rcQIEcQ5XsD8Wqbli2Dw6TZldVQcaID7GhRruJaoxPZGweA1iFd7+FYxSx8gaJJ3aLO3JPcW38X3aEfxZqjuRYOzSo+LO7u/Hx2C0lsGSSgAFJ31COHWQKmlqd3IKp8MUDGN3bbs3LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NU5Jup5Q; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NU5Jup5Q"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51f72a29f13so8411192e87.3
        for <linux-hardening@vger.kernel.org>; Tue, 14 May 2024 19:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715740171; x=1716344971; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HhWK/QjBhcq/4T9972QoRB3M6/JeMKBp9jipg24+Woc=;
        b=NU5Jup5QF1DIPloiZmr68JF/E7i6T9CPqtBFY60w1vuOU1w9MRsQzW3df006sqOJGK
         Amxmq0prhmEF0N6/4fINpX6NtgMqC4FlmuBpM0CjfrJMaMA6tmSo9C2sBpc2bY5tPAX2
         5kL8SGInwWwDynSLL9IGfmIv5zrhQGKVDFhG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715740171; x=1716344971;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HhWK/QjBhcq/4T9972QoRB3M6/JeMKBp9jipg24+Woc=;
        b=Dx+OxbNV7LuL2ZMmj4a71iloIPacBoxMaD5acubSzuobAqDbJsT5wUpObigk635hQv
         qJ6cCpOL8SDH1AzdIDqipVmF0SbnFDWjJtUoDwPn720W8ILLG/dritC2gsZWv1wNVsT5
         EyPCu/5QtTX9Z4nbnLiqEGC7pvOx/ijOPkbDPPzGUq8Z2Vzt+dNGUa1o5Vab5NsCQdlO
         8oIo0nWbENlhmzvja3G1DUPy8I3+uhR7hdDabl4tMScE5hn3UdzGcoFhXg/dWqtyJuCr
         KspnlxAX7HW/7ka9erU5XAJ2UazDXHmXAI82FcZfgxR2mRhDZ1yNb7R8eLWZobTyEqNf
         5Ftg==
X-Forwarded-Encrypted: i=1; AJvYcCX0yYqj29ts8PwOh9teWKuM5X5895NzciAlg3sav3WpyiwqkDv68Rz55lIvgEGD9OAb/M3cy5lAVprJJ/I7YXPpO6SGK+BRyhmcy4kNLCDr
X-Gm-Message-State: AOJu0YzdnxX9Ua3ozqBp0/lLd9nUJbVh67zLj1KLgpnj9w7efIJxaej8
	Ecy/CRX19Mm1+knjkU9bi3Y3VwHKJIHTUVP0fVnYe6IyabfDhjJW8mK+VfTyAg8+vhwmxhAb9EC
	M7ux9yg==
X-Google-Smtp-Source: AGHT+IGsvY8JNWtaWwkroVbRrILkUyc2uVYc3ITXQT3DcUUKqNxPfSnJ5UWYQnHN1tAdMkKJaCuaog==
X-Received: by 2002:ac2:4c55:0:b0:519:6e94:9b4d with SMTP id 2adb3069b0e04-5221057930cmr12566435e87.48.1715740171444;
        Tue, 14 May 2024 19:29:31 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733bed0af0sm8215479a12.49.2024.05.14.19.29.31
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 19:29:31 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41ff5e3d86aso34003085e9.1
        for <linux-hardening@vger.kernel.org>; Tue, 14 May 2024 19:29:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVku4vurUknMGTxqJscXxW9jpQhzjmRk6Kkk4GgbgnmyElkxR+LZOeM95U3cg5XHrUbtqPkA2qW4P4p5X7tO8HElRDRxXl6vNgHPj6LUJCE
X-Received: by 2002:a17:907:7f08:b0:a5a:63bf:5175 with SMTP id
 a640c23a62f3a-a5a63bf5227mr784689766b.10.1715740150546; Tue, 14 May 2024
 19:29:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415163527.626541-1-jeffxu@chromium.org> <20240514104646.e6af4292f19b834777ec1e32@linux-foundation.org>
 <871q646rea.fsf@meer.lwn.net> <ZkPXcT_JuQeZCAv0@casper.infradead.org>
 <56001.1715726927@cvs.openbsd.org> <CAHk-=wgsGCKvN0Db6ZRZqJwXQrmhZyWB6RmABaOp4DiZbXgNew@mail.gmail.com>
 <16982.1715734632@cvs.openbsd.org> <CAHk-=wi04ZCm3vTtkcVnAUdiOpX3a0hBZ-aQWONwCubOJQEdXw@mail.gmail.com>
 <84192.1715737666@cvs.openbsd.org>
In-Reply-To: <84192.1715737666@cvs.openbsd.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 14 May 2024 19:28:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj=Yb1r_g=geQe8YDGv-TA-UQBQe6-OVhA8FOGjWKnQmA@mail.gmail.com>
Message-ID: <CAHk-=wj=Yb1r_g=geQe8YDGv-TA-UQBQe6-OVhA8FOGjWKnQmA@mail.gmail.com>
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

On Tue, 14 May 2024 at 18:47, Theo de Raadt <deraadt@openbsd.org> wrote:
>
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> Regarding mprotect(), POSIX also says:
>
>     An implementation may permit accesses other than those specified by
>     prot; however, no implementation shall permit a write to succeed where
>     PROT_WRITE has not been set or shall permit any access where PROT_NONE
>     alone has been set.

Why do you quote entirely irrelevant issues?

If the mprotect didn't succeed, then clearly the above is irrelevant.

> When sealed memory is encountered in the middle of a range, an error
> will be returned (which almost noone looks at). Memory after the sealed
> region will not be fixed to follow this rule.
>
> It may retain higher permission.

This is not in any way specific to mseal().

Theo, you're making shit up.

You claim that this is somehow new behavior:

> The other previous errors have been transient system effects, like ENOMEM.

but that's simply NOT TRUE. Try this:

    #include <stdio.h>
    #include <sys/mman.h>

    int main(int argc, char **argv)
    {
        /* Just three pages for VM space allocation */
        void *a = mmap(NULL, 3*4096, PROT_READ, MAP_PRIVATE |
MAP_ANONYMOUS, -1, 0);

        /* Make the second page a shared read mapping of stdin */
        mmap(a+4096, 4096, PROT_READ, MAP_FIXED | MAP_SHARED, 0, 0);

        /* Turn them all PROT_WRITE */
        mprotect(a, 3*4096, PROT_WRITE);

        fprintf(stderr, "Write to first page\n");
        *(int *) (a+0) = 0;

        fprintf(stderr, "Write to second page\n");
        *(int *) (a+4096) = 0;

        fprintf(stderr, "Write to third page\n");
        *(int *) (a+2*4096) = 0;
    }

and what you will get (under Linux) is

    $ ./a.out < ./a.out
    Write to first page
    Write to second page
    Segmentation fault (core dumped)

because that mprotect() will have returned EACCES on the shared
mapping, but will have successfully made the first one writable.

End result: this whole "transient system effects" is just not true.
And "mseal()" isn't somethign new.

If somebody makes random mprotect() calls, and doesn't check the
result, they get exactly what they deserve. And mseal() isn't the
issue - bad programming is.

Anyway, you're just making things up for your nonexistent arguments. I'm done.

            Linus
