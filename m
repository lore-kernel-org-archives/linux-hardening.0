Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842DC1607A1
	for <linux-hardening@vger.kernel.org>; Fri,  9 Aug 2024 23:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723247604; cv=none; b=oipY88B0LVETKAPFh0OlShjm9PAbSoxX/0auMIRanjoowzgGEqcOWzwQZPaT0ZcNC6v0zRQ/CzMrZ+cmYhX0tPoHkbC6EJGg7oDxwOfcnsgCjysDeBEQrp5tWYpOL+h2FsXeEND+fVI8jdrN4Lw+I7Yd9HBZg/qRWyyluBV8I8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723247604; c=relaxed/simple;
	bh=SVsRI4FZnpWKAafD7zdNZOTprC5QK7spQWfc1pujgJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k4uz0xCzKLbmTjeC3GgxXrd8e1wpuH4SS1xc4szADAuh7Z8WOSv5NcEIazRUbJ2UEsolVi1a5/u1qVnBYWmO1tVv9sXzNopCeBkOrT71LJAPHn7FHUG7+gfo9VbI8scNbjMnMbU9kwAaPJ+8RaF9ghYhcmFqaF3KoXV+heXPBUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OZ+71quX; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OZ+71quX"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-81fd925287eso94096339f.3
        for <linux-hardening@vger.kernel.org>; Fri, 09 Aug 2024 16:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723247601; x=1723852401; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HXq30+qqrGod7UMvtMZ4HXDcZmyjb07duezfSROQDkY=;
        b=OZ+71quXJ9+MppH4Y08mxWiOrZmNA9Pmktey2t+rF91pz0p55Tp06IKjhvbEzhluMo
         aEL3WkPnPV1qz4EgGEyouVg7WZePafVdnEkCZ9cX8LN1kWoAshse43rxHk9fQ9xh9KKy
         PZrQrSyV+P5iH58CkITmJGU0tNsOUKhZiBghtBn+pyycVWLLmMMcipmh94AsFcA/Qk/G
         6ZgOQ/qk6uYbs/I07yOzcUOasYydzebJLfeTfT5779iOjceUdeKZfesRm4hkAOLCVtbx
         oPmo7XnnHXyXnCLiBD6N5QGoxekE8I9T4mBQN14Yrx737NxUtjZyH8RUGI9bo3N4+j9E
         X3NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723247601; x=1723852401;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HXq30+qqrGod7UMvtMZ4HXDcZmyjb07duezfSROQDkY=;
        b=JCeHxcEmMbWshS25CTCDcEKa5J0qTs74Mqx8hahCKOOyPjRL1l9QZjP1brJ8O3E6BZ
         nkLmcQHg8+dFQzbAzhQ5pzrs5YdXF9RPPO2R0duvjKLLDtG0AbOSxyNtPDry1IpCJiOI
         xPskag+hstzsDAvpxw7aUYLYcgpVuduOIS9/0fdM3weXaA8se125VBCeT29e2oxMkfc6
         FElEbVtKF2611Smw6+gpq9RTeQwy/kHnIwBBrmbIJdHEQA7zL0YUtLye/InKdBQSVU+m
         UZCzS+H5Kmv89nSrMNMJiyJ5OC7b1cpcWMMZ4OLaL27LuNuTbyPn3os9DwqzVhB4hfFz
         NJJg==
X-Forwarded-Encrypted: i=1; AJvYcCW2Rq0vJgdCxuecnkrNzAcuxxBj6dG531S39szmXmFXPrB+d6bT97YhpmEtFKkT14je70eYXySkKe8FbhzPVg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBEXJa0yn2BpdSOq8oTwzRQxzMRK3/hlLMmF/PvWA98VSvRnAu
	JiMVjmOSkA+Qa8q5JVKDAAnC/izgvfQun94n+jjWC7Cvb7xCGan8MZtwjdPpLw==
X-Google-Smtp-Source: AGHT+IEt1122BVWzRU/Fdnx9ErHZzG/ziyc35/f/6K4zyR9rH9XW7MgNnZCs/mdNOK5r3s+QQAhjyA==
X-Received: by 2002:a05:6602:3d2:b0:7fa:56f0:ad87 with SMTP id ca18e2360f4ac-8225ee84692mr469625739f.10.1723247601487;
        Fri, 09 Aug 2024 16:53:21 -0700 (PDT)
Received: from google.com (194.225.68.34.bc.googleusercontent.com. [34.68.225.194])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ca7695b7f7sm236213173.80.2024.08.09.16.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 16:53:20 -0700 (PDT)
Date: Fri, 9 Aug 2024 16:53:15 -0700
From: Justin Stitt <justinstitt@google.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] lib/string_helpers: rework overflow-dependent code
Message-ID: <dyigpya2tb7obniv3g2rzhtahvjhximzjlvoi42c45fqkb7hx5@tw3loxvglexa>
References: <20240808-b4-string_helpers_caa133-v1-1-686a455167c4@google.com>
 <CAHp75VfBjKLf3LqDXvAehW5sxGzYnU4sS3fr=JoaM-6p_gR34w@mail.gmail.com>
 <202408081609.D08D11C@keescook>
 <CAHp75Vd3wKyq2XE2UPoW_q3KjmncSeaEebL4ff5Gpx8Lz+dB9A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vd3wKyq2XE2UPoW_q3KjmncSeaEebL4ff5Gpx8Lz+dB9A@mail.gmail.com>

On Fri, Aug 09, 2024 at 02:07:57PM GMT, Andy Shevchenko wrote:
> On Fri, Aug 9, 2024 at 2:11 AM Kees Cook <kees@kernel.org> wrote:
> >
> > On Fri, Aug 09, 2024 at 01:07:21AM +0300, Andy Shevchenko wrote:
> > > On Fri, Aug 9, 2024 at 12:44 AM Justin Stitt <justinstitt@google.com> wrote:
> > > >
> > > > When @size is 0, the desired behavior is to allow unlimited bytes to be
> > > > parsed. Currently, this relies on some intentional arithmetic overflow
> > > > where --size gives us SIZE_MAX when size is 0.
> > > >
> > > > Explicitly spell out the desired behavior without relying on intentional
> > > > overflow/underflow.
> > >
> > > Hmm... but why? Overflow for the _unsigned_ types is okay. No?
> >
> > Yes, it's well defined, but in trying to find a place to start making a
> > meaningful impact on unexpected wrap-around, after discussions with
> > Linus and Peter Zijlstra, we're going taking a stab at defining size_t
> > as not expecting to wrap. Justin has been collecting false positive
> > fixes while working on the compiler side of this, and I had asked him to
> > send this one now since I think it additionally helps with readability.
> 
> Okay, but the patch has an off-by-one error (which has no impact on
> the behavior as it's close to unrealistic to have the SIZE_MAX array).
> I prefer that patch can be reconsidered to keep original behaviour,
> otherwise it might be not so clear why 0 is SIZE_MAX - 1 in _this_
> case.

Right, it is technically different but still functionally provides the
"unlimited" behavior.

But, we could  do this too:

diff --git a/lib/string_helpers.c b/lib/string_helpers.c
index 69ba49b853c7..0f76b5288833 100644
--- a/lib/string_helpers.c
+++ b/lib/string_helpers.c
@@ -320,11 +320,13 @@ static bool unescape_special(char **src, char **dst)
 int string_unescape(char *src, char *dst, size_t size, unsigned int flags)
 {
 	char *out = dst;
+	bool unlimited = !size;
 
-	while (*src && --size) {
-		if (src[0] == '\\' && src[1] != '\0' && size > 1) {
+	while (*src && (unlimited || --size)) {
+		if (src[0] == '\\' && src[1] != '\0' &&
+		    (unlimited || size > 1)) {
 			src++;
-			size--;
+			size -= !unlimited;
 
 			if (flags & UNESCAPE_SPACE &&
 					unescape_space(&src, &out))



Really, I am fine with either.

Thanks
Justin
