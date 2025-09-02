Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07868205E25;
	Tue,  2 Sep 2025 23:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756856040; cv=none; b=RrV0NuU8bwBj2kxqfzcJRdXhIR+wlhoO9aYHh4gOYZMSt3toljfsyrFJzNokX08lvyvOwmIo9AUaXYHgfmsoypPSKeIIR2n5HWa2SO5fZb+QqPzbHCHegxUJ1j7eGQ/MmrV4gMuqyufX0WOFQBv1DpNCilpo2GX2aQf+snlgSag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756856040; c=relaxed/simple;
	bh=yW9w6vRtrpU9Evv7gLXIbiVMJouFZmAUYRkWdYh8tpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UwpJgl5vQkl+a6HD9S4yWgD+Tj8YHLazjlZfe6AgLlGkCAl0oiHYE6c8LXZUKDZJO7YhleTmjB+FJnx2OYKAM+13NF042ovNIRwE/jQsV7ix4woCJ4wxws3doepWM5YqeKjWvZr8XzaC/sIDvCB26lUS1iuWpQUZzgup4sKIWjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/RvA9YK; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/RvA9YK"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7724cacc32bso2406898b3a.0;
        Tue, 02 Sep 2025 16:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756856038; x=1757460838; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gAzJ/mYc64utzpgd4HFHI/h/o1xEjnEqOHUAiimbwZc=;
        b=l/RvA9YKrNhXQj7SbEthra79k2CkuOhqoAUeicSkGFdPwjW/YT5YY8i3hfJpQMrus0
         xffx58OVk+Tcj/0rjucO2DOgcU/oQ+jQh/W1czQqRpGh/+da0OAEMeSIW57haac45Smz
         eK6iz4ltpaArhEWuYOdsA0Z6ngrg0B4mr0JusC1JikbFtPDD/q3ETJNvB/yPOhcrXJXi
         ROVmVuP1JOiHLBm4Apxt43XqJoCl0xNbbTbcDiU3tN9Eu/GcamSFDOL2Na4PRvoxLu+v
         Vbv02F64qjjSu6nOqyALOJIzlFtkLW5P6+bObFioO0PbPS8wrquvkjL4d29CE2ZDTrgu
         vroA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756856038; x=1757460838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gAzJ/mYc64utzpgd4HFHI/h/o1xEjnEqOHUAiimbwZc=;
        b=Tqwpr0Ienb1hbawCsg5wFv+1nRKILq4M0VrNxkyYxUB4EtpJdOffpDBfYVYTCtL9ob
         jV2nd+4Ct9O/IAo9kFu9l827TtAfpet8+07zJDDmwMLLihkO+cOmdQbP72B/NVg13Yy5
         mvjcC8Ft1zS/XRaiUpzBxYxq7PPmkqa5vMbjI5cmK1xyky8yLSnmNZO9h0mwDH6YtDMY
         b69RRxndXNBRN8Pd/tN74jU0bjH9jk3Wm43eMD++kbnpJAxju1lhUtjz/CFmSIj1Pjl5
         sJ1swwmXXqmWWJGKvLNZb0aT4SPIzrHoM4LLdrdbLgvwdlgQ1MZUFlipfo9r31CV2Nj+
         8LCw==
X-Forwarded-Encrypted: i=1; AJvYcCWzdeQ8nSIuXXS2UXsRsQ/Bxl4/AcDZDUiFWwNJvIwTvcTBab2YiqICK+C4jBzuwkNrkipNACq7NWe8RL5y@vger.kernel.org, AJvYcCXvI5oTtl1whkMoDNHVUxjch6FSC3tfReVM7daK1bU/+GUoKvG7CqeBxFhcjblAdhOE5v4G8G99ieZPARBfESg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKys5ukDtoNHt7W2XsrbOqbVjkqvNddmYslR0gqKGKI82kAo+n
	Z537xlr/FzAvOebtI2lGwv0TzL0DntiB02lGLZ+cZJLwKTSPDJ5iC1iQ
X-Gm-Gg: ASbGnctpcqgDE9YCn19RHb5xvuL6oMcoJskKo82cvbe6/tL3kEqswz7p9aFyMmQoHVH
	82MpB1aawNv9vqHbbjTFz2zMjK0WhMza3VMyDqLrhNM+P+VlQAo4PciMVrbRICG8a8nh+BBTw9+
	AZN1XWM5lZYgnolw377xyd3no4gtS0reFNSVbuOp+YtFi7uYS2Zmdrs1arISu7SB6dUq/hnUBoU
	tpNNzE2JXwWJGof1PSG24fXaNek7a9M0XSvzl9lAM3ffWJ7cPgZYBX0AKftZw1Uon5kRkEqba9Z
	ClYXqoTxGJdK7diUWXvki3kvJyrfO1PYQjx+3ZnjwAb2/WU73HPAmmAezOU8VQlFwnChkSRnve2
	JDW8p/1J8BPjO1SdWwKiPpBLoS5Lu3ytzyAzO91dkL68=
X-Google-Smtp-Source: AGHT+IFCHMJgNxwzVBuhDPUnqfnXtX/OwqNEFGPPrk3w9dx8T8LeDIovgdyFLLPhOdAAuEUOE8aTtw==
X-Received: by 2002:a17:902:f60a:b0:234:f4da:7eeb with SMTP id d9443c01a7336-249448709abmr175164745ad.7.1756856038045;
        Tue, 02 Sep 2025 16:33:58 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2490374412bsm142070755ad.51.2025.09.02.16.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 16:33:57 -0700 (PDT)
Date: Tue, 2 Sep 2025 19:33:55 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Kees Cook <kees@kernel.org>
Cc: kernel test robot <lkp@intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Vineet Gupta <vgupta@kernel.org>, linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] arc: Fix __fls() const-foldability via
 __builtin_clzl()
Message-ID: <aLd-40v-epEd1mi5@yury>
References: <20250831022352.it.055-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250831022352.it.055-kees@kernel.org>

On Sat, Aug 30, 2025 at 07:23:53PM -0700, Kees Cook wrote:
> While tracking down a problem where constant expressions used by
> BUILD_BUG_ON() suddenly stopped working[1], we found that an added static
> initializer was convincing the compiler that it couldn't track the state
> of the prior statically initialized value. Tracing this down found that
> ffs() was used in the initializer macro, but since it wasn't marked with
> __attribute__const__, the compiler had to assume the function might
> change variable states as a side-effect (which is not true for ffs(),
> which provides deterministic math results).
> 
> For arc architecture with CONFIG_ISA_ARCV2=y, the __fls() function
> uses __builtin_arc_fls() which lacks GCC's const attribute, preventing
> compile-time constant folding, and KUnit testing of ffs/fls fails on
> arc[3]. A patch[2] to GCC to solve this has been sent.
> 
> Add a fix for this by handling compile-time constants with the standard
> __builtin_clzl() builtin (which has const attribute) while preserving
> the optimized arc-specific builtin for runtime cases. This has the added
> benefit of skipping runtime calculation of compile-time constant values.
> Even with the GCC bug fixed (which is about "attribute const") this is a
> good change to avoid needless runtime costs, and should be done
> regardless of the state of GCC's bug.
> 
> Build tested ARCH=arc allyesconfig with GCC arc-linux 15.2.0.
> 
> Link: https://github.com/KSPP/linux/issues/364 [1]
> Link: https://gcc.gnu.org/pipermail/gcc-patches/2025-August/693273.html
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202508031025.doWxtzzc-lkp@intel.com/ [3]
> Signed-off-by: Kees Cook <kees@kernel.org>

Applied in bitmap-for-next, thanks!
