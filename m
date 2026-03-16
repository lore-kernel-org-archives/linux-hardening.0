Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77426340A6F
	for <linux-hardening@vger.kernel.org>; Mon, 16 Mar 2026 19:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773688622; cv=none; b=p9+YRXAu4FG9GbA1AI/01ABtNqsxtHEbAB0LZtIdqtY6jBosDctgnCCrLwWULIfgrrc+n6m6ebzPKausafP8hTBZr9Ud7Ak5E+C0i07gbxDpisQ0Nz3y+bC9gv/ecTY0Dp5e+H5+L0zhJJSFCmKKSUNQQ/GLwRmnezjLB3JSmDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773688622; c=relaxed/simple;
	bh=PlGPZoglXUuh1dfeukJH/LeqqwBMJABO0C248s1v9As=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TwGpY/jadoVy1Q7FSmas+YgEfPrWRXiSr7isQP613l8aP1xS8baioiuX1A/19NUSjKAIyCm8BzNchQ8YkwVJTWG1C1D493e1pysAkUAN9PbVZSj7kRdVn0sspGC8qV/pxXvTuuOFteZSmaooWWv2MWpnAjw4f0PHPITXsR73IxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HD4WVQWy; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HD4WVQWy"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1279eced0b9so6626399c88.0
        for <linux-hardening@vger.kernel.org>; Mon, 16 Mar 2026 12:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773688620; x=1774293420; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Hk2XaBHC8Qa6dgUkCoPcN4E9YBKjMdtHqI5bOd6Xjw=;
        b=HD4WVQWyGgPLd3jJ1GHewURwI2RV136um/ZLg30U6PJAfKIrEqj+6n+G4wRMMjiuBl
         jOxtr/KhWksLAsVS2bUzx7O6V6pv2zcXY67mVAUKWmNpVsdYM/xTg/D72dHrQYovLI3e
         Xc8zwrB5H1BzBnHy+qvpqtBiBgv7kMIt97ICOkMTyBnip7Gh6YTYwW9UYg3ibW+J2y9f
         /HB7uMi6w/jcLl4tLvaMxt2zIkHv/P+3r1jA5hdpi8F2ivOmWTcMm8h/IRIlZF+z3+iq
         i+e0FdXRJGvD+P5ZsiY4Oe4t1L0iVnud09QWF6I1zhXuuCuhc9u69FUMELRjdH6sZJY3
         6nWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773688620; x=1774293420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7Hk2XaBHC8Qa6dgUkCoPcN4E9YBKjMdtHqI5bOd6Xjw=;
        b=jMpD6tIiG+T2/abgCYluc/evdjwaZ2BFnoJXnXdoHb13nS+7GLQ+5Nn94Dda2y3LbS
         LOH5XoLpXME2MnR/JpTm0QJpPhVbuxBHYfiltbvXTgwHn8DYW4hcff2QR3XjYPD+/zfz
         X1DRYZoO7SFy6YVFhKEYSBTfDCohK7qXivdVl77zP0egLIHm9C3RHeZz3fx4jC+Xtnvf
         JtOBhbYpIXxXU+/itTVcJKE4ZbqtULM/fyK7iSQRQ8Jzytv67UbywhDa0gfwQFTxUSWy
         /yemXHjtUIaL/vT6w6ku6aGq7FDpyFdOGx4/8ce02M74cnFFpBLAWJz5j0m7+i16uoDH
         kJJw==
X-Forwarded-Encrypted: i=1; AJvYcCW3wDLrjLVKbGiBcO01gkwtLiy0K9MyJsAxn2X1Buft+UUNzN/291CzVotBo+DE5gWoX9envbDiCe6cMZH65kM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj0RhM+TgZE1d2x5dDZMPoodRJKAO6l0fvpzPQEgH9sB/6Yzjd
	2v9BOSGUKXTvpXR+cWS9pXqf9UoyLH70Q7XeTwYKn+58LE1jUcomigSb
X-Gm-Gg: ATEYQzyZg+Wpp/YVNNFgeUNmY3/JVq0+r6JWbxaBwsKm1HvdgnKIVCEIkZNiDgtQbAZ
	EF16mxT4hV/HDHRud2LW2RPEY3V3fbSh6AeE6zUrxBtYzgGMqLuy1j/2OOj0oc19COAczDFkHYr
	RYZSv77GiyKLUoPtuZrznpZQSX1WPx2BqAFcYYAClPXS4+rWgVInaUQe8qlpF/ie6gpnKgW2gEA
	keVlZjg9M6r+LR3wv1250L2pJdQLB69dCNJffnh5BYcC6twKlbErVBM/N1Mo4EzULGFW50tYrOO
	jKEcAjV2g5fc5rQ7AI2evj4uLctvrNCse3JFrJVYVGN1Omw+3CpfSVc66sgcCyqTenWNFaWmviM
	hPnoTmn1HpPP++/xbCe/+1ibYwt3pXjl3UXdbMK97rIx1+5s+vKl/z4Fr5jp4DfXWpMVNK3hCdE
	60YocPUu2Sc1ZTVMAgnU5cohEjWVUpsHQSFfp6
X-Received: by 2002:a05:7022:925:b0:128:bbad:9a52 with SMTP id a92af1059eb24-128f3e52ca3mr5874419c88.39.1773688620362;
        Mon, 16 Mar 2026 12:17:00 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128f62837ccsm17035721c88.3.2026.03.16.12.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 12:16:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 16 Mar 2026 12:16:58 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Kees Cook <keescook@chromium.org>
Cc: Eric Biederman <ebiederm@xmission.com>,
	Justin Stitt <justinstitt@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/2] exec: Add KUnit test for bprm_stack_limits()
Message-ID: <a3e9b1c2-40c1-45df-9fa2-14ee6a7b3fe2@roeck-us.net>
References: <20240520021337.work.198-kees@kernel.org>
 <20240520021615.741800-1-keescook@chromium.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520021615.741800-1-keescook@chromium.org>

Hi,

On Sun, May 19, 2024 at 07:16:11PM -0700, Kees Cook wrote:
> Since bprm_stack_limits() operates with very limited side-effects, add
> it as the first exec.c KUnit test. Add to Kconfig and adjust MAINTAINERS
> file to include it.
> 
> Tested on 64-bit UML:
> $ tools/testing/kunit/kunit.py run exec
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Justin Stitt <justinstitt@google.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-mm@kvack.org
> ---
...
> +++ b/fs/exec.c
...
> +	  .expected_argmin = ULONG_MAX - (_STK_LIM / 4 * 3) + sizeof(void *) },
> +	{ { .p = ULONG_MAX, .rlim_stack.rlim_cur = 4 * (_STK_LIM / 4 *  + sizeof(void *)),
                                                                   ^^^^^^

Google's experimental AI review agent tagged the above change as syntactically wrong.
How does this even compile ?

Thanks,
Guenter
