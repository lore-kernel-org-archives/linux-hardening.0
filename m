Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661C319478
	for <linux-hardening@vger.kernel.org>; Thu, 22 Feb 2024 16:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708619433; cv=none; b=Cvzx4XDuIbZJVeJHSLv1yE1FKnjlQ54iUw3YITouYXrzuucZRngoj9XHviRKkkkyQMtBDfU8JYmqiHcd7Jhyw6elmzAGb+zpFvN0YhOM1/09U5UNsOAqgtUP2zfaif6rFSct5ZaxGdLjrEBpbl/63PS6cJNIqxoSDU+tYOanL6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708619433; c=relaxed/simple;
	bh=tvTl6cnHeh0Or/x0EM0sozIzmPcHql0YQqUY+KLj/s4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e/mHTBED0bu+eBoLXm1Y/QfbYuYQ7cgH+8wwX34sXUx/AOH8mAq3aI0+J6ETJWUufaX10ukdGwH/xI5JUazR2rPZF7Ns35W7iKIabvOYCx5PRDSgl8ivXIS4SaMjHrvA6gRcnGQVFvNphEwpZZ0zrgXalBVqaLZj9fWA/xmnN30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=k8esdzsz; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k8esdzsz"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e43ee3f6fbso5078788b3a.3
        for <linux-hardening@vger.kernel.org>; Thu, 22 Feb 2024 08:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708619431; x=1709224231; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L4tXYxptIN6sn70Hbug773/ZkZ9SuuIE2T60bhUM/kc=;
        b=k8esdzszxQFATStzvHAcezhrRrI67Z6cpCAWdwsXfbOjj9IWeNiuB8aMb8Ce3NSBbT
         Y5NCISUI947O/knCZDDKlh4hiMD1IRE/XHv1xKD6Zccq2EnTyy4cwUknqJ/jHWDRIl3U
         yU1fPJdOV1pqpax4s5eydZaAle8hBhK19vlrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708619431; x=1709224231;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L4tXYxptIN6sn70Hbug773/ZkZ9SuuIE2T60bhUM/kc=;
        b=v/olvR2w+AejN9gvkx5m0/XG1riMz39+5ixeru4xm+a/yMSKnS/GZrgBlHNJpTKbAl
         3J3hZy3rF7JM1+EAi1PyGE62dU8/bnvhE1ZshykODiQbpSuacy5txpQC9EbYe0gFo6ou
         pBCtQktVddpA6vZZxPyabX9Z30Qy4wF26B+BfIOyI6TXCE1awJwaXYQqeIhPUBMW1V0J
         ei+oEsUiFFYq2WlDApqQ/E80ZdfrCvrZj7UqQ8y5jw8vXsWlFxF+lWHctofowrVOdoRY
         PoweW4vg8lWPH9WvARR+w/YUnPwPr7MFcXklI9W4p3rUEKDwDbeTxW44YKiu9p4oBz96
         5/Hw==
X-Forwarded-Encrypted: i=1; AJvYcCVN5PBhhrLGgarae5fYwMn5qVfH9AE2i25c6bXjOsTr7ND+grpTtBFRfEFSNypfvnB+GKo0G48inXmOrqUJBYUx9t1zpE8xwrLr8EjAx8pz
X-Gm-Message-State: AOJu0YwN+lfV/INP5ZyI482BH1mHe5bblXEtrUTauZ0njhn2O7bL+Hbi
	zYVtQ34RjGAiHdMFU9Xb1WPb1zhu8+M5TP6mT/vsLA00TqQqv8y7CwY6g7+YNg==
X-Google-Smtp-Source: AGHT+IF+SlttyWkoW2fWR8cBn7Swso3loSheNnjJ5MidjvOtmykg6loZB+iLagMLSSGm57scJMtnAg==
X-Received: by 2002:aa7:9833:0:b0:6e4:6dcd:8d88 with SMTP id q19-20020aa79833000000b006e46dcd8d88mr10571629pfl.24.1708619431651;
        Thu, 22 Feb 2024 08:30:31 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y5-20020a056a00180500b006e45daf9e89sm8874736pfa.131.2024.02.22.08.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 08:30:31 -0800 (PST)
Date: Thu, 22 Feb 2024 08:30:30 -0800
From: Kees Cook <keescook@chromium.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: kernel test robot <lkp@intel.com>, linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Andy Shevchenko <andy@kernel.org>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Puyou Lu <puyou.lu@gmail.com>, Mark Brown <broonie@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	"Liam R. Howlett" <liam.howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Dan Williams <dan.j.williams@intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Yury Norov <yury.norov@gmail.com>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Sander Vanheule <sander@svanheule.net>,
	Eric Biggers <ebiggers@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 6/9] fortify: Split reporting and avoid passing string
 pointer
Message-ID: <202402220829.10C6C7C@keescook>
References: <20230406000212.3442647-6-keescook@chromium.org>
 <202304061930.4Au0PASm-lkp@intel.com>
 <19930c5a-f1ed-4b04-b69a-d7259966f020@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19930c5a-f1ed-4b04-b69a-d7259966f020@app.fastmail.com>

On Thu, Feb 22, 2024 at 02:00:26PM +0100, Arnd Bergmann wrote:
> On Thu, Apr 6, 2023, at 13:19, kernel test robot wrote:
> 
> > If you fix the issue, kindly add following tag where applicable
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Link: 
> > https://lore.kernel.org/oe-kbuild-all/202304061930.4Au0PASm-lkp@intel.com/
> >
> > All errors (new ones prefixed by >>):
> >
> >>> ld.lld: error: undefined symbol: __fortify_panic
> >    >>> referenced by fortify-string.h:208 (include/linux/fortify-string.h:208)
> >    >>>               arch/arm/boot/compressed/fdt_ro.o:(fdt_stringlist_count)
> >    >>> referenced by fortify-string.h:208 (include/linux/fortify-string.h:208)
> >    >>>               arch/arm/boot/compressed/fdt_ro.o:(fdt_stringlist_search)
> >    >>> referenced by fortify-string.h:208 (include/linux/fortify-string.h:208)
> >    >>>               arch/arm/boot/compressed/fdt_ro.o:(fdt_stringlist_get)
> 
> I get a related build failure from the same commit:
> 
> arch/arm/boot/compressed/misc.c:157:6: error: no previous prototype for '__fortify_panic' [-Werror=missing-prototypes]
>   157 | void __fortify_panic(const u8 reason, size_t avail, size_t size)

Whoops, thank you! This series got a refresh after you did the
missing-prototypes work and I missed this one. I've fixed it and
double-checked for any others. Hopefully this will be clean in the next
-next. :)

-Kees

-- 
Kees Cook
