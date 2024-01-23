Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B917F7CC
	for <linux-hardening@vger.kernel.org>; Tue, 23 Jan 2024 19:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706036428; cv=none; b=N6q6hU9eIFnCVyib6kzvZwKqEKiuSO/9Bkj2prASlb4ZrI/hqoJ5m7Sm3SPh+7MIFBNt20UKTNGQgyrWMe2yuyJpjb9bLEB51L2U1EHZ/vYjuD65QDVU2wOWVvukyYPVhQCFHJLZmMWJp85i+LgHSVuy1Zj8ieeSyAZsmks0Pl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706036428; c=relaxed/simple;
	bh=QA2id3LqrmzYn8QBWvElp2X+uoIvf8x5U798DnB4uyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kXk+8IshQhQDD8YWXZ05fWvOaPnC3JNPu/LUg8yFsvzKuHdhXG5OKNUDNFah5/5ln1vYDiKYGCujaBcjoP4qb9CwYgczhZ2F5ExD7lgAhjx+ND6ApSnKvGT99kjFKCsZPOyYo67A+QE39es9w91YD77Femh9hnopeuEadpe2NbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GIoAAIw0; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GIoAAIw0"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d71cb97937so27932025ad.3
        for <linux-hardening@vger.kernel.org>; Tue, 23 Jan 2024 11:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706036413; x=1706641213; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/9FKmxWiB2vAaSsWA6W2r8jqoqGItDODorFRWTWYx3M=;
        b=GIoAAIw05UWSdUYUcUatVeO4/MxIT2iTCSbCVHD6OubrG91JqJiPuDMggzxlFyy4qx
         bd7vuTTEBRrsyydNn+Xe36GcZlHdHVS2MpRb1u5BDGgMakhyd/3eK54yQ8K6luDW3wXl
         JB3GS7XcXCt2r3IP/O5Rz4esZlvgk0YoNrHcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706036413; x=1706641213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/9FKmxWiB2vAaSsWA6W2r8jqoqGItDODorFRWTWYx3M=;
        b=Saene//kB5Ygg0Kz5KTadqZBAMG+W17sI0CqukRmwDS6rVE3Z28qnB0Vs68z5fWfOq
         b1Gauz86YZZlBtatXEM0VBKaDz4vORsijuYjJxHM/YeDQoX5oHnxVBj9vhw6eI/MDolX
         Wq7EbxdpII7zZzxiCiHd20Pzo/9BljSPuUeAWeqPj1XnBcnaUeSlGLsmoAVbegDj6hSs
         vTC3/I1zB6CZ1Aijbf/FnO36Y/wFIw5pwOXe8b2USb4xnZN+WVq0awNiwMujebTFeKfr
         1uyUg73IkMe3dlAll0cejzeCMGsG4bdnEVH2DDtxWrrXiiFlUloyfZZOh2ktD9QbNxB/
         diPw==
X-Gm-Message-State: AOJu0Yyq1wGFn+aCiXLpx5TX0Gqn3jpuCkI6cALxG/GPxc/oyPF1tR0Q
	QFMQTlsq7C9Ioi0R8eN03FQRkRv4JXgmsStSPylPgPzIPXORt3RANAlDlK7erQ==
X-Google-Smtp-Source: AGHT+IFYzOSitLgL/rGq5zi5+lqRnkbBRykkzfae4VthDo4FdSuOL5OnOrjVVJKPwbxtn27UKcZ0FA==
X-Received: by 2002:a17:902:ea0a:b0:1d7:2bd6:23e3 with SMTP id s10-20020a170902ea0a00b001d72bd623e3mr4394412plg.5.1706036413360;
        Tue, 23 Jan 2024 11:00:13 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id mp11-20020a170902fd0b00b001d75ea44323sm2836158plb.21.2024.01.23.11.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 11:00:13 -0800 (PST)
Date: Tue, 23 Jan 2024 11:00:12 -0800
From: Kees Cook <keescook@chromium.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-hardening@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mark Brown <broonie@kernel.org>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Vasily Averin <vasily.averin@linux.dev>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 34/82] ipc: Refactor intentional wrap-around calculation
Message-ID: <202401231058.5C5248DC3@keescook>
References: <20240122235208.work.748-kees@kernel.org>
 <20240123002814.1396804-34-keescook@chromium.org>
 <CAHk-=whS7FSbBoo1gxe+83twO2JeGNsUKMhAcfWymw9auqBvjg@mail.gmail.com>
 <202401221713.3FCABC9290@keescook>
 <CAHk-=wgMPVv-mDxA2qcywpLCRLojtaKmP13h7bVo4m=XN202xA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgMPVv-mDxA2qcywpLCRLojtaKmP13h7bVo4m=XN202xA@mail.gmail.com>

On Tue, Jan 23, 2024 at 10:06:12AM -0800, Linus Torvalds wrote:
> So:
> 
>  - get rid of that commit message that is lying garbage
> 
>  - fix the so-called "sanitizer".
> 
>  - stop calling the unsigned wrap-around a "sanitizer" and talking
> about "undefined behavior" in the same sentence, since it's neither.
> 
> Do you really not see why I think that thing is actively *WRONG*?

Yes -- I was trying to head off the confusion about what the larger goal
is (trapping unexpected wrap-around) so that people don't assume I'm
talking about Undefined Behavior (we don't have any UB arithmetic in the
kernel, very intentionally). I did not succeed! I'll rewrite it all.

-- 
Kees Cook
