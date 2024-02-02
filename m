Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545AF14D442
	for <linux-hardening@vger.kernel.org>; Fri,  2 Feb 2024 18:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706898605; cv=none; b=Kd7/K/949znoe6Mk+PkQyuqP3b+stduHXCOTpeNqCR3SltP95jtpisnZINdB5Lp51Twp8kbK+Ui/w7H1/3aXsGxWIEVvxvFDz8kCI498ppSbglJw61487+gpaP1PHgCKKAeJwWp3z58xUfXlAfGGGpsGgLN0hMZOE7heQsPvclA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706898605; c=relaxed/simple;
	bh=+B2EP3owSfGpJRy7wHKXkx5eiCN3WHUSCd8s+L5o5Ps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bnXS7NbGjLP+7g10IFuQ1NP93JsyoPW1QL2pDe6dW5LFv8IRcF0FzdnUuD1ePw81YyJXyy0IWXET/Cw3sgO3W4lxdaODChRVeUbHYx2GAtmRVOYaDbX5aYRYaRE3kwnvVxdvpPjxPhEW8o0uesGMP06K3hJauHuAOtps6SA4FwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DTsOsIw6; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DTsOsIw6"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a354fc17f24so310798466b.0
        for <linux-hardening@vger.kernel.org>; Fri, 02 Feb 2024 10:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706898601; x=1707503401; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Wred9oKbZUWrUWPqoPWJe75vDju4/OS5/kZYLMHwsFs=;
        b=DTsOsIw6MG+XwIwjWUJF37ZNxE9AUaNJsPGdVKIQNhAZDj3+kKIMa5Lzgj0jdk+ksU
         +C6fNBRtKr//peDdPNI7l2W4wVWBXwMFEflX/lUMk53fHWcRGLXKy3vyRozs9te879A6
         KoXUwM2IE337W+ISa48E1UiLCK1xU6/guXlLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706898601; x=1707503401;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wred9oKbZUWrUWPqoPWJe75vDju4/OS5/kZYLMHwsFs=;
        b=lQh4HxtNFkEFVytk9EdyZh6QPrPIYExxC0LRsTc4mXNIX7j6QDU9akv7FK1ygwfbWv
         x08SPdSnRin7nPw/X3qciceDmmAH7LHvYhL3Ybhco3SHkw/i3W7mbGQytnupzTVdO7ls
         vC0sSwSE/KATmAri7KvhtnDQflClEAzShDmvV5kB5Jm4dB7b++D3qLn415zr4rNmMLUW
         fDWyo+bVqUc7mMCJ5bJP/lxh6VGF3XoF/inE0L+Q2+uI3JmC0UQ6wRCmH5y3wvQis/kQ
         /B9yYmOs4OI7eKqOwileCBs45URcX/UETDk/cjT1EEB4tIHyhMH+OUKHn9rxwpHVKe24
         D69w==
X-Gm-Message-State: AOJu0Yxur5i8Ys94s0zRoXnwk/njEUZic+wQT+CFW2Ka1ogKfoXVQAjL
	O8IWK3fw6z+9NSc9Aw02zo9lAMZSDhAH8VCK0xwjqtX5LzBAvQ7/0k/KKr/o3cEJCQ2q69n6EVB
	wopcW+A==
X-Google-Smtp-Source: AGHT+IHlQkoulto1rbt2BLE7KLuRIEGoGMzCCytPggmIWL7h56oXpW8+ZRKulP+0Z4QeDpxMcScgQA==
X-Received: by 2002:a17:907:788b:b0:a37:1ffe:8a2b with SMTP id ku11-20020a170907788b00b00a371ffe8a2bmr1182481ejc.31.1706898601170;
        Fri, 02 Feb 2024 10:30:01 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXZrs+iZZsbRh/eOyB+ZPMoofM5jxWQKXGzu3BdMpfWr1AZ/17jL5lxkZKXWTUg35lLDsvGNSaHBGPlJHZw4IJkPDI4DFWVyNaUXGbv2otq
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id qo4-20020a170907874400b00a3701b05115sm933132ejc.29.2024.02.02.10.30.00
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 10:30:00 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5600f79607eso238809a12.0
        for <linux-hardening@vger.kernel.org>; Fri, 02 Feb 2024 10:30:00 -0800 (PST)
X-Received: by 2002:aa7:c718:0:b0:55f:e682:9720 with SMTP id
 i24-20020aa7c718000000b0055fe6829720mr317170edq.25.1706898600270; Fri, 02 Feb
 2024 10:30:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Za6JwRpknVIlfhPF@work> <CAHk-=wjG4jdE19-vWWhAX3ByfbNr4DJS-pwiN9oY38WkhMZ57g@mail.gmail.com>
 <34210a52-f4b3-46a1-b301-c76fb24adc42@app.fastmail.com>
In-Reply-To: <34210a52-f4b3-46a1-b301-c76fb24adc42@app.fastmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 2 Feb 2024 10:29:43 -0800
X-Gmail-Original-Message-ID: <CAHk-=whzBDLC024NXgJEsFOOpJ9BO2BkuxHXr4h5wOSYK9AwbQ@mail.gmail.com>
Message-ID: <CAHk-=whzBDLC024NXgJEsFOOpJ9BO2BkuxHXr4h5wOSYK9AwbQ@mail.gmail.com>
Subject: Re: [GIT PULL] Enable -Wstringop-overflow globally
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Kees Cook <keescook@chromium.org>, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 1 Feb 2024 at 23:53, Arnd Bergmann <arnd@arndb.de> wrote:
>
> I did a creduce pass on this warning when it first showed up
> and opened a gcc bug report as well as a driver workaround:
>
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=113214
> https://lore.kernel.org/lkml/20240103114819.2913937-1-arnd@kernel.org/#r

Ugh. The fact that *that* patch to the Xe driver makes a difference to
the compiler actually only makes me even less happy about this.

The "&a[b]" -> "a+b" transformation is _literally_ just syntactic.
They are EXACTLY the same expression, and any compiler person or
sanitizer person who treats them differently is just completely
incompetent and bonkers.

That transformation should have been done fairly early in the
compiler, later passes shouldn't see any kind of difference. At most
you might have a sanity check at that point to say that "a" should be
a pointer (because _technically_ it could be 'b' that is the pointer
expression, but at that point I understand why a compiler would say
"you're doing some silly sh*t" and give a warning)

So while I think your driver workaround is fine - and I personally
actually generally prefer the simpler pointer addition syntax - I do
not think it's fine at all that the compiler then warns for one and
not the other.

It's just a sign of some serious confusion in some part of the
compiler. And yes, I suspect Pinski is right in that bugzilla entry
that it's a sanitizer that causes this, and that's mainly because I
hope to $DEITY that no _core_ C compiler person would ever make that
mistake.

             Linus
